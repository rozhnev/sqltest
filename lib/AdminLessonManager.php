<?php

class AdminLessonManager extends AdminContentManager
{
    public function __construct(PDO $dbh)
    {
        parent::__construct($dbh);
    }

    public function list(string $lang = 'en'): array
    {
        $modules = $this->fetchModules($lang);
        $lessons = $this->fetchLessons();
        return [
            'modules' => array_values($modules),
            'lessons' => array_values($lessons)
        ];
    }

    public function get(int $lessonId): array
    {
        $stmt = $this->dbh->prepare('SELECT id, slug, module_id, deleted FROM lessons WHERE id = :id');
        $stmt->execute([':id' => $lessonId]);
        $lesson = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$lesson) {
            throw new Exception('Lesson not found');
        }

        $lesson['id'] = (int)$lesson['id'];
        $lesson['module_id'] = (int)$lesson['module_id'];
        $lesson['deleted'] = (bool)$lesson['deleted'];
        $lesson['localizations'] = $this->getLocalizations($lessonId);
        return $lesson;
    }

    public function save(array $payload): array
    {
        $lessonId = isset($payload['id']) ? (int)$payload['id'] : 0;
        $data = $this->normalizeLessonPayload($payload);
        if ($lessonId > 0) {
            return $this->update($lessonId, $data, $payload['localizations'] ?? []);
        }
        return $this->create($data, $payload['localizations'] ?? []);
    }

    public function delete(int $lessonId): bool
    {
        $stmt = $this->dbh->prepare('UPDATE lessons SET deleted = true WHERE id = :id');
        return $stmt->execute([':id' => $lessonId]);
    }

    private function fetchModules(string $lang): array
    {
        $stmt = $this->dbh->prepare('SELECT m.id, m.slug, ml.title FROM modules m
            JOIN modules_localization ml ON ml.module_id = m.id AND ml.language = :lang
            WHERE NOT m.deleted
            ORDER BY m.id');
        $stmt->execute([':lang' => $lang]);
        $modules = [];
        foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $row) {
            $modules[$row['id']] = [
                'id' => (int)$row['id'],
                'slug' => $row['slug'],
                'title' => $row['title']
            ];
        }
        return $modules;
    }

    private function fetchLessons(): array
    {
        $stmt = $this->dbh->prepare('SELECT
                l.id as lesson_id,
                l.slug as lesson_slug,
                l.module_id,
                l.deleted,
                ll.language,
                ll.title,
                ll.content,
                ll.description
            FROM lessons l
            LEFT JOIN lessons_localization ll ON ll.lesson_id = l.id AND ll.language IN (\'en\', \'ru\')
            WHERE NOT l.deleted
            ORDER BY l.id');
        $stmt->execute();

        $lessons = [];
        foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $row) {
            $lessonId = (int)$row['lesson_id'];
            if (!isset($lessons[$lessonId])) {
                $lessons[$lessonId] = [
                    'id' => $lessonId,
                    'slug' => $row['lesson_slug'],
                    'module_id' => (int)$row['module_id'],
                    'deleted' => (bool)$row['deleted'],
                    'localizations' => []
                ];
            }
            $language = $row['language'];
            if ($language) {
                $lessons[$lessonId]['localizations'][$language] = [
                    'title' => $row['title'],
                    'content' => $row['content'],
                    'description' => $row['description']
                ];
            }
        }
        return $lessons;
    }

    private function getLocalizations(int $lessonId): array
    {
        $stmt = $this->dbh->prepare('SELECT language, title, content, description FROM lessons_localization WHERE lesson_id = :id');
        $stmt->execute([':id' => $lessonId]);
        $localizations = [];
        foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $row) {
            $localizations[$row['language']] = [
                'title' => $row['title'],
                'content' => $row['content'],
                'description' => $row['description']
            ];
        }
        return $localizations;
    }

    private function normalizeLessonPayload(array $payload): array
    {
        $localizations = $payload['localizations'] ?? [];
        $englishTitle = $localizations['en']['title'] ?? '';
        $result = [
            'slug' => $this->slugify($englishTitle ?: ($payload['slug'] ?? 'lesson')),
            'module_id' => (int)($payload['module_id'] ?? 0),
            'sequence_position' => (int)($payload['sequence_position'] ?? 0)
        ];
        if ($result['module_id'] <= 0) {
            throw new Exception('Module ID is required for a lesson');
        }
        return $result;
    }

    private function create(array $data, array $localizations): array
    {
        $sequencePosition = $this->calculateSequencePosition($data['module_id']);
        $stmt = $this->dbh->prepare('INSERT INTO lessons (module_id, slug, sequence_position, deleted)
            VALUES (:module_id, :slug, :sequence_position, false)
            RETURNING id');
        $stmt->execute([
            ':module_id' => $data['module_id'],
            ':slug' => $data['slug'],
            ':sequence_position' => $sequencePosition
        ]);
        $lessonId = (int)$stmt->fetchColumn();
        $this->upsertLocalizations($lessonId, $localizations);
        return $this->get($lessonId);
    }

    private function update(int $lessonId, array $data, array $localizations): array
    {
        $stmt = $this->dbh->prepare('UPDATE lessons SET module_id = :module_id, slug = :slug WHERE id = :id');
        $stmt->execute([
            ':module_id' => $data['module_id'],
            ':slug' => $data['slug'],
            ':id' => $lessonId
        ]);
        $this->upsertLocalizations($lessonId, $localizations);
        return $this->get($lessonId);
    }

    private function calculateSequencePosition(int $moduleId): int
    {
        $stmt = $this->dbh->prepare('SELECT COALESCE(MAX(sequence_position), 0) FROM lessons WHERE module_id = :module_id');
        $stmt->execute([':module_id' => $moduleId]);
        return (int)$stmt->fetchColumn() + 1;
    }

    private function slugify(string $value): string
    {
        $value = mb_strtolower($value, 'UTF-8');
        $value = preg_replace('/[^\p{L}\p{Nd}]+/u', '-', $value);
        $value = trim($value, '-');
        return $value !== '' ? $value : uniqid('lesson-');
    }

    private function upsertLocalizations(int $lessonId, array $localizations): void
    {
        $stmt = $this->dbh->prepare('INSERT INTO lessons_localization (lesson_id, language, title, content, description)
            VALUES (:lesson_id, :language, :title, :content, :description)
            ON CONFLICT (lesson_id, language) DO UPDATE SET
                title = EXCLUDED.title,
                content = EXCLUDED.content,
                description = EXCLUDED.description');

        foreach ($localizations as $language => $fields) {
            if (!is_array($fields) || !in_array($language, $this->supportedLanguages, true)) {
                continue;
            }
            $stmt->execute([
                ':lesson_id' => $lessonId,
                ':language' => $language,
                ':title' => $fields['title'] ?? '',
                ':content' => $fields['content'] ?? '',
                ':description' => $fields['description'] ?? ''
            ]);
        }
    }
}
