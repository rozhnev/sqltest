<?php

class UserTaskSubmissionManager
{
    private PDO $dbh;

    public function __construct(PDO $dbh)
    {
        $this->dbh = $dbh;
    }

    public function listForUser(string $userId): array
    {
        $stmt = $this->dbh->prepare("SELECT
                id,
                status,
                title,
                task,
                hint,
                solution_query,
                db_template,
                db,
                moderation_note,
                approved_question_id,
                created_at,
                updated_at,
                approved_at,
                rejected_at
            FROM user_task_submissions
            WHERE user_id = :user_id
            ORDER BY id DESC");
        $stmt->execute([':user_id' => $userId]);

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function createForUser(string $userId, array $payload): array
    {
        $this->assertFirstSubmissionRequirements($userId);
        $fields = $this->normalizePayload($payload, false);

        $stmt = $this->dbh->prepare("INSERT INTO user_task_submissions (
                user_id,
                status,
                title,
                task,
                hint,
                solution_query,
                db_template,
                db
            ) VALUES (
                :user_id,
                'pending',
                :title,
                :task,
                :hint,
                :solution_query,
                :db_template,
                :db
            ) RETURNING id");

        $stmt->execute([
            ':user_id' => $userId,
            ':title' => $fields['title'],
            ':task' => $fields['task'],
            ':hint' => $fields['hint'],
            ':solution_query' => $fields['solution_query'],
            ':db_template' => $fields['db_template'],
            ':db' => $fields['db']
        ]);

        $submissionId = (int)$stmt->fetchColumn();
        return $this->getOwnedSubmission($submissionId, $userId);
    }

    private function assertFirstSubmissionRequirements(string $userId): void
    {
        $countStmt = $this->dbh->prepare("SELECT COUNT(1) FROM user_task_submissions WHERE user_id = :user_id");
        $countStmt->execute([':user_id' => $userId]);
        $submissionCount = (int)$countStmt->fetchColumn();
        if ($submissionCount > 0) {
            return;
        }

        $userStmt = $this->dbh->prepare("SELECT
                COALESCE(email, '') AS email,
                email_verified_at IS NOT NULL AS email_verified,
                user_agreement_accepted_at IS NOT NULL AS agreement_accepted
            FROM users
            WHERE id = :user_id");
        $userStmt->execute([':user_id' => $userId]);
        $user = $userStmt->fetch(PDO::FETCH_ASSOC);

        if (!$user) {
            throw new Exception('User not found');
        }
        if (trim((string)$user['email']) === '') {
            throw new Exception('Email is required before first task submission');
        }
        if (!(bool)$user['email_verified']) {
            throw new Exception('Email must be verified before first task submission');
        }
        if (!(bool)$user['agreement_accepted']) {
            throw new Exception('User agreement must be accepted before first task submission');
        }
    }

    public function updatePendingForUser(int $submissionId, string $userId, array $payload): array
    {
        $current = $this->getOwnedSubmission($submissionId, $userId);
        if (($current['status'] ?? '') !== 'pending') {
            throw new Exception('Only pending submissions can be edited');
        }

        $fields = $this->normalizePayload($payload, true);

        $stmt = $this->dbh->prepare("UPDATE user_task_submissions
            SET
                title = :title,
                task = :task,
                hint = :hint,
                solution_query = :solution_query,
                db_template = :db_template,
                db = :db,
                updated_at = CURRENT_TIMESTAMP
            WHERE id = :id AND user_id = :user_id");

        $stmt->execute([
            ':id' => $submissionId,
            ':user_id' => $userId,
            ':title' => $fields['title'] ?? $current['title'],
            ':task' => $fields['task'] ?? $current['task'],
            ':hint' => $fields['hint'] ?? $current['hint'],
            ':solution_query' => $fields['solution_query'] ?? $current['solution_query'],
            ':db_template' => $fields['db_template'] ?? $current['db_template'],
            ':db' => $fields['db'] ?? $current['db']
        ]);

        return $this->getOwnedSubmission($submissionId, $userId);
    }

    public function deletePendingForUser(int $submissionId, string $userId): bool
    {
        $current = $this->getOwnedSubmission($submissionId, $userId);
        if (($current['status'] ?? '') !== 'pending') {
            throw new Exception('Only pending submissions can be deleted');
        }

        $stmt = $this->dbh->prepare("DELETE FROM user_task_submissions WHERE id = :id AND user_id = :user_id");
        $stmt->execute([':id' => $submissionId, ':user_id' => $userId]);

        return $stmt->rowCount() > 0;
    }

    public function listPending(int $limit = 100): array
    {
        $stmt = $this->dbh->prepare("SELECT
                uts.id,
                uts.user_id,
                u.nickname,
                uts.status,
                uts.title,
                uts.task,
                uts.hint,
                uts.solution_query,
                uts.db_template,
                uts.db,
                uts.moderation_note,
                uts.approved_question_id,
                uts.created_at,
                uts.updated_at
            FROM user_task_submissions uts
            LEFT JOIN users u ON u.id = uts.user_id
            WHERE uts.status = 'pending'
            ORDER BY uts.id ASC
            LIMIT :limit");
        $stmt->bindValue(':limit', max(1, min(500, $limit)), PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function approve(int $submissionId, int $categoryId, AdminQuestionManager $questionManager, ?string $adminUserId = null): array
    {
        $submission = $this->getById($submissionId);
        if (!$submission) {
            throw new Exception('Submission not found');
        }
        if (($submission['status'] ?? '') !== 'pending') {
            throw new Exception('Only pending submissions can be approved');
        }

        $this->ensureCategoryExists($categoryId);

        $this->dbh->beginTransaction();
        try {
            $questionPayload = [
                'db' => $submission['db'] ?: 'sakila',
                'db_template' => $submission['db_template'] ?: 'sakila',
                'query_valid_result' => '',
                'query_pre_check' => '',
                'query_check' => '',
                'localizations' => [
                    'en' => [
                        'title' => $submission['title'],
                        'task' => $submission['task'],
                        'hint' => $submission['hint']
                    ]
                ]
            ];

            $question = $questionManager->save($questionPayload);
            $questionId = (int)($question['id'] ?? 0);
            if ($questionId <= 0) {
                throw new Exception('Failed to create question from submission');
            }

            $sequenceStmt = $this->dbh->prepare("SELECT COALESCE(MAX(sequence_position), 0) + 1 FROM question_categories WHERE category_id = :category_id");
            $sequenceStmt->execute([':category_id' => $categoryId]);
            $nextPosition = (int)$sequenceStmt->fetchColumn();

            $insertCategoryStmt = $this->dbh->prepare("INSERT INTO question_categories (question_id, category_id, sequence_position) VALUES (:question_id, :category_id, :sequence_position)");
            $insertCategoryStmt->execute([
                ':question_id' => $questionId,
                ':category_id' => $categoryId,
                ':sequence_position' => $nextPosition
            ]);

            $approvalStmt = $this->dbh->prepare("UPDATE user_task_submissions
                SET
                    status = 'approved',
                    approved_question_id = :approved_question_id,
                    approved_at = CURRENT_TIMESTAMP,
                    approved_by_user_id = :approved_by_user_id,
                    updated_at = CURRENT_TIMESTAMP
                WHERE id = :id");
            $approvalStmt->execute([
                ':id' => $submissionId,
                ':approved_question_id' => $questionId,
                ':approved_by_user_id' => $adminUserId
            ]);

            $this->dbh->commit();

            return $this->getById($submissionId) ?: [];
        } catch (Exception $error) {
            if ($this->dbh->inTransaction()) {
                $this->dbh->rollBack();
            }
            throw $error;
        }
    }

    public function reject(int $submissionId, string $note, ?string $adminUserId = null): array
    {
        $submission = $this->getById($submissionId);
        if (!$submission) {
            throw new Exception('Submission not found');
        }
        if (($submission['status'] ?? '') !== 'pending') {
            throw new Exception('Only pending submissions can be rejected');
        }

        $normalizedNote = trim($note);
        if ($normalizedNote === '') {
            throw new Exception('Moderation note is required for rejection');
        }
        if (mb_strlen($normalizedNote) > 1000) {
            throw new Exception('Moderation note is too long');
        }

        $stmt = $this->dbh->prepare("UPDATE user_task_submissions
            SET
                status = 'rejected',
                moderation_note = :moderation_note,
                rejected_at = CURRENT_TIMESTAMP,
                approved_by_user_id = :approved_by_user_id,
                updated_at = CURRENT_TIMESTAMP
            WHERE id = :id");
        $stmt->execute([
            ':id' => $submissionId,
            ':moderation_note' => $normalizedNote,
            ':approved_by_user_id' => $adminUserId
        ]);

        return $this->getById($submissionId) ?: [];
    }

    private function getOwnedSubmission(int $submissionId, string $userId): array
    {
        $stmt = $this->dbh->prepare("SELECT
                id,
                status,
                title,
                task,
                hint,
                solution_query,
                db_template,
                db,
                moderation_note,
                approved_question_id,
                created_at,
                updated_at,
                approved_at,
                rejected_at
            FROM user_task_submissions
            WHERE id = :id AND user_id = :user_id");
        $stmt->execute([
            ':id' => $submissionId,
            ':user_id' => $userId
        ]);

        $submission = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$submission) {
            throw new Exception('Submission not found');
        }

        return $submission;
    }

    private function getById(int $submissionId): ?array
    {
        $stmt = $this->dbh->prepare("SELECT
                id,
                user_id,
                status,
                title,
                task,
                hint,
                solution_query,
                db_template,
                db,
                moderation_note,
                approved_question_id,
                approved_by_user_id,
                created_at,
                updated_at,
                approved_at,
                rejected_at
            FROM user_task_submissions
            WHERE id = :id");
        $stmt->execute([':id' => $submissionId]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        return $row ?: null;
    }

    private function ensureCategoryExists(int $categoryId): void
    {
        if ($categoryId <= 0) {
            throw new Exception('Category identifier is required');
        }
        $stmt = $this->dbh->prepare("SELECT 1 FROM categories WHERE id = :id LIMIT 1");
        $stmt->execute([':id' => $categoryId]);
        if (!$stmt->fetchColumn()) {
            throw new Exception('Category not found');
        }
    }

    private function normalizePayload(array $payload, bool $allowPartial): array
    {
        $fields = [];

        $definitions = [
            'title' => 160,
            'task' => 5000,
            'hint' => 2000,
            'solution_query' => 15000,
            'db_template' => 50,
            'db' => 50
        ];

        foreach ($definitions as $name => $maxLength) {
            if (!array_key_exists($name, $payload)) {
                continue;
            }
            $value = trim((string)$payload[$name]);
            if (mb_strlen($value) > $maxLength) {
                throw new Exception(sprintf('%s is too long', str_replace('_', ' ', $name)));
            }
            $this->assertPlainText($value, $name);
            $fields[$name] = $value;
        }

        if (!$allowPartial) {
            foreach (['title', 'task', 'hint', 'solution_query'] as $requiredField) {
                if (($fields[$requiredField] ?? '') === '') {
                    throw new Exception(sprintf('%s is required', str_replace('_', ' ', $requiredField)));
                }
            }
            if (($fields['db_template'] ?? '') === '') {
                $fields['db_template'] = 'sakila';
            }
            if (($fields['db'] ?? '') === '') {
                $fields['db'] = 'sakila';
            }
        }

        return $fields;
    }

    private function assertPlainText(string $value, string $fieldName): void
    {
        if ($value === '') {
            return;
        }
        if ($value !== strip_tags($value)) {
            throw new Exception(sprintf('%s must be plain text', str_replace('_', ' ', $fieldName)));
        }
    }
}
