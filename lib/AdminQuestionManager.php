<?php

class AdminQuestionManager extends AdminContentManager
{
    protected array $dbTemplates = [
        'adventureworks' => 'AdventureWorks',
        'bookings' => 'Bookings',
        'countries' => 'Countries',
        'employee' => 'Employees',
        'nyc_postgis' => 'NYC PostGIS',
        'querinomicon' => 'Querinomicon',
        'sakila' => 'Sakila', 
    ];

    protected array $databases = [
        'mysql80' => 'MySQL 8.0',
        'firebird4_employee' => 'Firebird 4 Employee',
        'mssql2022aw' => 'MSSQL 2022 AW',
        'mysql80_sakila' => 'MySQL 8.0 Sakila',
        'psql18demo' => 'PostgreSQL 18 Demo',
        'sqlite3_data' => 'SQLite 3 Data',
        'psql17postgis' => 'PostgreSQL 17 PostGIS'
    ];

    public function __construct(PDO $dbh)
    {
        parent::__construct($dbh);
    }

    public function getDbTemplates(): array
    {
        return $this->dbTemplates;
    }

    public function getDatabases(): array
    {
        return $this->databases;
    }

    public function getQueryChecks(int $questionId): array
    {
        $stmt = $this->dbh->prepare("SELECT 
                qc.id , hint, query_match, regexp, (qqc.question_id is not null) checked 
            FROM query_checks_localization qcl 
            JOIN query_checks qc ON qc.id =qcl.query_check_id 
            LEFT JOIN question_query_checks qqc ON qqc.query_check_id = qc.id AND qqc.question_id = :questionId
            WHERE qcl.language = 'en' ORDER BY hint;");

        $stmt->bindValue(':questionId', $questionId, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getQueryCategories(int $questionId): array
    {
        $stmt = $this->dbh->prepare("select 
                q.name as questionnaire,
                cl.category_id,
                cl.title,
                qc.sequence_position position,
                (qc.question_id is not null) checked
            from categories_localization cl 
            join categories c on c.id = cl.category_id 
            join questionnires q on q.id = c.questionnire_id 
            left join question_categories qc on qc.category_id = cl.category_id and qc.question_id = :questionId
            where cl.language = 'en' and not c.deleted and q.name in('category', 'database')
            order by q.id, cl.title;");

        $stmt->bindValue(':questionId', $questionId, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function list(string $lang = 'en', int $limit = 60): array
    {
        $stmt = $this->dbh->prepare("SELECT
                q.id,
                q.db_template,
                q.db,
                q.query_match,
                q.query_not_match,
                q.query_valid_result,
                q.query_pre_check,
                q.query_check,
                q.deleted,
                q.title_sef,
                ql.title,
                ql.task,
                ql.hint
            FROM questions q
            LEFT JOIN questions_localization ql ON ql.question_id = q.id AND ql.language = :lang
            WHERE q.deleted = false
            ORDER BY q.id DESC
            LIMIT :limit");
        $stmt->bindValue(':lang', $lang);
        $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
        $stmt->execute();

        return array_map(function ($row) {
            return [
                'id' => (int)$row['id'],
                'db' => $row['db'],
                'db_template' => $row['db_template'],
                'query_match' => $row['query_match'],
                'query_not_match' => $row['query_not_match'],
                'query_valid_result' => $row['query_valid_result'],
                'query_pre_check' => $row['query_pre_check'],
                'query_check' => $row['query_check'],
                'deleted' => (bool)$row['deleted'],
                'title_sef' => $row['title_sef'],
                'localized' => [
                    'language' => $lang,
                    'title' => $row['title'],
                    'task' => $row['task'],
                    'hint' => $row['hint']
                ]
            ];
        }, $stmt->fetchAll(PDO::FETCH_ASSOC));
    }

    public function get(int $questionId): array
    {
        $stmt = $this->dbh->prepare("SELECT
                id,
                db,
                solution_query,
                db_template,
                query_valid_result,
                query_pre_check,
                query_check,
                title_sef,
                deleted
            FROM questions
            WHERE id = :id");
        $stmt->execute([':id' => $questionId]);
        $question = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$question) {
            throw new Exception('Question not found');
        }

        $question['id'] = (int)$question['id'];
        $question['deleted'] = (bool)$question['deleted'];
        $question['localizations'] = $this->getLocalizations($question['id']);
        $question['query_checks'] =  $this->getQueryChecks($question['id']);
        $question['categories'] =  $this->getQueryCategories($question['id']);
        return $question;
    }

    public function save(array $payload): array
    {
        $id = isset($payload['id']) ? (int)$payload['id'] : 0;
        if ($id > 0) {
            return $this->update($id, $payload);
        }
        return $this->create($payload);
    }

    public function saveLocalization(int $questionId, string $language, array $fields): array
    {
        if ($questionId <= 0) {
            throw new Exception('Question identifier is required');
        }
        $language = trim(strtolower($language));
        if (!in_array($language, $this->supportedLanguages, true)) {
            throw new Exception('Unsupported localization language');
        }
        $this->upsertLocalizations($questionId, [$language => $fields]);
        $localizations = $this->getLocalizations($questionId);
        $saved = $localizations[$language] ?? [];
        return [
            'language' => $language,
            'title' => $saved['title'] ?? ($fields['title'] ?? ''),
            'task' => $saved['task'] ?? ($fields['task'] ?? ''),
            'hint' => $saved['hint'] ?? ($fields['hint'] ?? '')
        ];
    }
    
    public function saveQueryChecks(int $questionId, array $states): void
    {
        if ($questionId <= 0) {
            throw new Exception('Question identifier is required');
        }

        $this->dbh->beginTransaction();
        try {
            $stmtDelete = $this->dbh->prepare('DELETE FROM question_query_checks WHERE question_id = :question_id');
            $stmtDelete->execute([':question_id' => $questionId]);

            if (!empty($states)) {
                $ids = array_map('intval', $states);
                $placeholders = implode(',', array_fill(0, count($ids), '(?,?)'));
                $sql = 'INSERT INTO question_query_checks (question_id, query_check_id) VALUES ' . $placeholders;
                $stmtInsert = $this->dbh->prepare($sql);

                $params = [];
                foreach ($ids as $id) {
                    $params[] = $questionId;
                    $params[] = $id;
                }

                $stmtInsert->execute($params);
            }

            $this->dbh->commit();
        } catch (Exception $e) {
            if ($this->dbh->inTransaction()) {
                $this->dbh->rollBack();
            }
            throw $e;
        }
    }

    public function delete(int $questionId): bool
    {
        if ($questionId <= 0) {
            throw new Exception('Question identifier is required');
        }
        $stmt = $this->dbh->prepare('UPDATE questions SET deleted = true WHERE id = :id');
        return $stmt->execute([':id' => $questionId]);
    }

    private function create(array $payload): array
    {
        $fields = $this->normalizeQuestionPayload($payload);
        $stmt = $this->dbh->prepare("INSERT INTO questions (
                title_sef,
                db,
                db_template,
                query_match,
                query_not_match,
                query_valid_result,
                query_pre_check,
                query_check,
                deleted
            ) VALUES (
                :title_sef,
                :db,
                :db_template,
                :query_match,
                :query_not_match,
                :query_valid_result,
                :query_pre_check,
                :query_check,
                false
            ) RETURNING id");
        $stmt->execute([
            ':title_sef' => $fields['title_sef'],
            ':db' => $fields['db'],
            ':db_template' => $fields['db_template'],
            ':query_match' => $fields['query_match'],
            ':query_not_match' => $fields['query_not_match'],
            ':query_valid_result' => $fields['query_valid_result'],
            ':query_pre_check' => $fields['query_pre_check'],
            ':query_check' => $fields['query_check']
        ]);
        $newId = (int)$stmt->fetchColumn();
        $this->upsertLocalizations($newId, $payload['localizations'] ?? []);
        return $this->get($newId);
    }

    private function update(int $questionId, array $payload): array
    {
        $fields = $this->normalizeQuestionPayload($payload);
        $stmt = $this->dbh->prepare("UPDATE questions SET
                title_sef = :title_sef,
                db = :db,
                db_template = :db_template,
                query_match = :query_match,
                query_not_match = :query_not_match,
                query_valid_result = :query_valid_result,
                query_pre_check = :query_pre_check,
                query_check = :query_check
            WHERE id = :id");
        $stmt->execute([
            ':title_sef' => $fields['title_sef'],
            ':db' => $fields['db'],
            ':db_template' => $fields['db_template'],
            ':query_match' => $fields['query_match'],
            ':query_not_match' => $fields['query_not_match'],
            ':query_valid_result' => $fields['query_valid_result'],
            ':query_pre_check' => $fields['query_pre_check'],
            ':query_check' => $fields['query_check'],
            ':id' => $questionId
        ]);
        $this->upsertLocalizations($questionId, $payload['localizations'] ?? []);
        return $this->get($questionId);
    }

    private function normalizeQuestionPayload(array $payload): array
    {
        $localizations = $payload['localizations'] ?? [];
        $englishTitle = $localizations['en']['title'] ?? '';
        return [
            'title_sef' => $this->slugify($englishTitle ?: 'question'),
            'db' => $payload['db'] ?? 'sakila',
            'db_template' => $payload['db_template'] ?? 'sakila',
            'query_match' => $payload['query_match'] ?? '',
            'query_not_match' => $payload['query_not_match'] ?? '',
            'query_valid_result' => $payload['query_valid_result'] ?? '',
            'query_pre_check' => $payload['query_pre_check'] ?? '',
            'query_check' => $payload['query_check'] ?? ''
        ];
    }

    private function slugify(string $value): string
    {
        $value = mb_strtolower($value, 'UTF-8');
        $value = preg_replace('/[^\p{L}\p{Nd}]+/u', '-', $value);
        $value = trim($value, '-');
        return $value !== '' ? $value : uniqid('question-');
    }

    private function upsertLocalizations(int $questionId, array $localizations): void
    {
        $stmt = $this->dbh->prepare("INSERT INTO questions_localization (
                question_id,
                language,
                title,
                task,
                hint
            ) VALUES (
                :question_id,
                :language,
                :title,
                :task,
                :hint
            ) ON CONFLICT (question_id, language) DO UPDATE SET
                title = EXCLUDED.title,
                task = EXCLUDED.task,
                hint = EXCLUDED.hint");

        foreach ($localizations as $language => $fields) {
            if (!is_array($fields)) {
                continue;
            }
            if (!in_array($language, $this->supportedLanguages, true)) {
                continue;
            }
            if (empty($fields['title']) || empty($fields['task']) || empty($fields['hint'])) {
                continue;
            }
            $stmt->execute([
                ':question_id' => $questionId,
                ':language' => $language,
                ':title' => $fields['title'],
                ':task' => $fields['task'],
                ':hint' => $fields['hint']
            ]);
        }
    }

    private function getLocalizations(int $questionId): array
    {
        $stmt = $this->dbh->prepare('SELECT language, title, task, hint FROM questions_localization WHERE question_id = :id');
        $stmt->execute([':id' => $questionId]);
        $localizations = [];
        foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $row) {
            $localizations[$row['language']] = [
                'title' => $row['title'],
                'task' => $row['task'],
                'hint' => $row['hint']
            ];
        }
        return $localizations;
    }
}
