<?php

class LocalizationAutoTranslator
{
    private PDO $dbh;
    private string $apiKey;
    private string $model;

    // Target languages this translator knows how to name in a prompt. 'en' is
    // deliberately absent — it's always the source language, never a translation target.
    private const LANGUAGE_NAMES = [
        'ru' => 'Russian',
        'pt' => 'Portuguese',
        'fr' => 'French',
        'zh' => 'Simplified Chinese',
    ];

    public function __construct(PDO $dbh, string $apiKey, string $model = 'gpt-4o-mini')
    {
        $this->dbh = $dbh;
        $this->apiKey = trim($apiKey);
        $this->model = $model;
    }

    public function ensureQuestionLocalized(int $questionId, string $lang): void
    {
        if ($lang === 'en' || $this->apiKey === '') {
            return;
        }

        if ($this->hasRow('questions_localization', 'question_id', $questionId, $lang)) {
            return;
        }

        $source = $this->getQuestionSource($questionId);
        if ($source === null) {
            return;
        }

        $languageName = self::LANGUAGE_NAMES[$lang] ?? $lang;
        $translated = $this->translateStructured(
            "Translate SQL exercise fields to {$languageName}.",
            [
                'title' => (string)$source['title'],
                'task' => (string)$source['task'],
                'hint' => (string)$source['hint'],
            ],
            "Return strict JSON with keys: title, task, hint. Keep HTML tags, placeholders, and SQL/table/column identifiers intact."
        );

        if ($translated === null) {
            return;
        }

        $stmt = $this->dbh->prepare("INSERT INTO questions_localization (question_id, language, title, task, hint, tutorial_link)
            VALUES (:question_id, :language, :title, :task, :hint, :tutorial_link)
            ON CONFLICT (question_id, language) DO UPDATE SET
                title = EXCLUDED.title,
                task = EXCLUDED.task,
                hint = EXCLUDED.hint,
                tutorial_link = EXCLUDED.tutorial_link");
        $stmt->execute([
            ':question_id' => $questionId,
            ':language' => $lang,
            ':title' => trim((string)($translated['title'] ?? $source['title'])),
            ':task' => trim((string)($translated['task'] ?? $source['task'])),
            ':hint' => trim((string)($translated['hint'] ?? $source['hint'])),
            ':tutorial_link' => (string)($source['tutorial_link'] ?? ''),
        ]);

        $this->ensureAnswerLocalizations($questionId, $lang);
        $this->ensureCategoryLocalizations($questionId, $lang);
        $this->ensureRateLocalization($questionId, $lang);
        $this->ensureQueryCheckLocalizations($questionId, $lang);
    }

    public function ensureLessonLocalized(int $lessonId, string $lang): void
    {
        if ($lang === 'en' || $this->apiKey === '') {
            return;
        }

        if ($this->hasRow('lessons_localization', 'lesson_id', $lessonId, $lang)) {
            return;
        }

        $source = $this->getLessonSource($lessonId);
        if ($source === null) {
            return;
        }

        $languageName = self::LANGUAGE_NAMES[$lang] ?? $lang;
        $translated = $this->translateStructured(
            "Translate SQL lesson content to {$languageName}.",
            [
                'title' => (string)$source['title'],
                'content' => (string)$source['content'],
            ],
            "Return strict JSON with keys: title, content. Preserve markdown structure, fenced code blocks, YAML frontmatter, links, placeholders, and SQL identifiers."
        );

        if ($translated === null) {
            return;
        }

        $stmt = $this->dbh->prepare('INSERT INTO lessons_localization (lesson_id, language, title, content)
            VALUES (:lesson_id, :language, :title, :content)
            ON CONFLICT (lesson_id, language) DO UPDATE SET
                title = EXCLUDED.title,
                content = EXCLUDED.content');
        $stmt->execute([
            ':lesson_id' => $lessonId,
            ':language' => $lang,
            ':title' => trim((string)($translated['title'] ?? $source['title'])),
            ':content' => (string)($translated['content'] ?? $source['content']),
        ]);

        $this->ensureLessonModuleLocalization($lessonId, $lang);
    }

    private function getQuestionSource(int $questionId): ?array
    {
        $stmt = $this->dbh->prepare("SELECT title, task, hint, tutorial_link
            FROM questions_localization
            WHERE question_id = :id AND language IN ('en', 'ru')
            ORDER BY CASE language WHEN 'en' THEN 0 ELSE 1 END
            LIMIT 1");
        $stmt->execute([':id' => $questionId]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        return $row ?: null;
    }

    private function getLessonSource(int $lessonId): ?array
    {
        $stmt = $this->dbh->prepare("SELECT title, content
            FROM lessons_localization
            WHERE lesson_id = :id AND language IN ('en', 'ru')
            ORDER BY CASE language WHEN 'en' THEN 0 ELSE 1 END
            LIMIT 1");
        $stmt->execute([':id' => $lessonId]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        return $row ?: null;
    }

    private function ensureAnswerLocalizations(int $questionId, string $lang): void
    {
        $stmt = $this->dbh->prepare("SELECT a.id,
                al_lang.title AS localized_title,
                COALESCE(al_en.title, al_ru.title) AS source_title
            FROM answers a
            LEFT JOIN answers_localization al_lang ON al_lang.answer_id = a.id AND al_lang.language = :lang
            LEFT JOIN answers_localization al_en ON al_en.answer_id = a.id AND al_en.language = 'en'
            LEFT JOIN answers_localization al_ru ON al_ru.answer_id = a.id AND al_ru.language = 'ru'
            WHERE a.question_id = :question_id");
        $stmt->execute([':question_id' => $questionId, ':lang' => $lang]);
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $upsert = $this->dbh->prepare("INSERT INTO answers_localization (answer_id, language, title)
            VALUES (:answer_id, :language, :title)
            ON CONFLICT (answer_id, language) DO UPDATE SET title = EXCLUDED.title");

        foreach ($rows as $row) {
            if (!empty($row['localized_title']) || empty($row['source_title'])) {
                continue;
            }
            $translated = $this->translateText((string)$row['source_title'], $lang);
            if ($translated === '') {
                continue;
            }
            $upsert->execute([
                ':answer_id' => (int)$row['id'],
                ':language' => $lang,
                ':title' => $translated,
            ]);
        }
    }

    private function ensureCategoryLocalizations(int $questionId, string $lang): void
    {
        $stmt = $this->dbh->prepare("SELECT DISTINCT c.id,
                cl_lang.title AS localized_title,
                COALESCE(cl_en.title, cl_ru.title, c.title_sef) AS source_title
            FROM question_categories qc
            JOIN categories c ON c.id = qc.category_id
            LEFT JOIN categories_localization cl_lang ON cl_lang.category_id = c.id AND cl_lang.language = :lang
            LEFT JOIN categories_localization cl_en ON cl_en.category_id = c.id AND cl_en.language = 'en'
            LEFT JOIN categories_localization cl_ru ON cl_ru.category_id = c.id AND cl_ru.language = 'ru'
            WHERE qc.question_id = :question_id");
        $stmt->execute([':question_id' => $questionId, ':lang' => $lang]);
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $upsert = $this->dbh->prepare("INSERT INTO categories_localization (category_id, language, title)
            VALUES (:category_id, :language, :title)
            ON CONFLICT (category_id, language) DO UPDATE SET title = EXCLUDED.title");

        foreach ($rows as $row) {
            if (!empty($row['localized_title']) || empty($row['source_title'])) {
                continue;
            }
            $translated = $this->translateText((string)$row['source_title'], $lang);
            if ($translated === '') {
                continue;
            }
            $upsert->execute([
                ':category_id' => (int)$row['id'],
                ':language' => $lang,
                ':title' => $translated,
            ]);
        }
    }

    private function ensureRateLocalization(int $questionId, string $lang): void
    {
        $stmt = $this->dbh->prepare("SELECT q.rate AS id,
                qrl_lang.rate AS localized_rate,
                COALESCE(qrl_en.rate, qrl_ru.rate) AS source_rate
            FROM questions q
            LEFT JOIN question_rates_localization qrl_lang ON qrl_lang.id = q.rate AND qrl_lang.language = :lang
            LEFT JOIN question_rates_localization qrl_en ON qrl_en.id = q.rate AND qrl_en.language = 'en'
            LEFT JOIN question_rates_localization qrl_ru ON qrl_ru.id = q.rate AND qrl_ru.language = 'ru'
            WHERE q.id = :question_id
            LIMIT 1");
        $stmt->execute([':question_id' => $questionId, ':lang' => $lang]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$row || !empty($row['localized_rate']) || empty($row['source_rate'])) {
            return;
        }

        $translated = $this->translateText((string)$row['source_rate'], $lang);
        if ($translated === '') {
            return;
        }

        $upsert = $this->dbh->prepare("INSERT INTO question_rates_localization (id, language, rate)
            VALUES (:id, :language, :rate)
            ON CONFLICT (id, language) DO UPDATE SET rate = EXCLUDED.rate");
        $upsert->execute([
            ':id' => (int)$row['id'],
            ':language' => $lang,
            ':rate' => $translated,
        ]);
    }

    private function ensureQueryCheckLocalizations(int $questionId, string $lang): void
    {
        $stmt = $this->dbh->prepare("SELECT qc.id,
                qcl_lang.hint AS localized_hint,
                COALESCE(qcl_en.hint, qcl_ru.hint) AS source_hint
            FROM question_query_checks qqc
            JOIN query_checks qc ON qc.id = qqc.query_check_id
            LEFT JOIN query_checks_localization qcl_lang ON qcl_lang.query_check_id = qc.id AND qcl_lang.language = :lang
            LEFT JOIN query_checks_localization qcl_en ON qcl_en.query_check_id = qc.id AND qcl_en.language = 'en'
            LEFT JOIN query_checks_localization qcl_ru ON qcl_ru.query_check_id = qc.id AND qcl_ru.language = 'ru'
            WHERE qqc.question_id = :question_id");
        $stmt->execute([':question_id' => $questionId, ':lang' => $lang]);
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $upsert = $this->dbh->prepare("INSERT INTO query_checks_localization (query_check_id, language, hint)
            VALUES (:query_check_id, :language, :hint)
            ON CONFLICT (query_check_id, language) DO UPDATE SET hint = EXCLUDED.hint");

        foreach ($rows as $row) {
            if (!empty($row['localized_hint']) || empty($row['source_hint'])) {
                continue;
            }
            $translated = $this->translateText((string)$row['source_hint'], $lang);
            if ($translated === '') {
                continue;
            }
            $upsert->execute([
                ':query_check_id' => (int)$row['id'],
                ':language' => $lang,
                ':hint' => $translated,
            ]);
        }
    }

    private function ensureLessonModuleLocalization(int $lessonId, string $lang): void
    {
        $stmt = $this->dbh->prepare("SELECT m.id,
                ml_lang.title AS localized_title,
                COALESCE(ml_en.title, ml_ru.title, m.slug) AS source_title
            FROM lessons l
            JOIN modules m ON m.id = l.module_id
            LEFT JOIN modules_localization ml_lang ON ml_lang.module_id = m.id AND ml_lang.language = :lang
            LEFT JOIN modules_localization ml_en ON ml_en.module_id = m.id AND ml_en.language = 'en'
            LEFT JOIN modules_localization ml_ru ON ml_ru.module_id = m.id AND ml_ru.language = 'ru'
            WHERE l.id = :lesson_id
            LIMIT 1");
        $stmt->execute([':lesson_id' => $lessonId, ':lang' => $lang]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$row || !empty($row['localized_title']) || empty($row['source_title'])) {
            return;
        }

        $translated = $this->translateText((string)$row['source_title'], $lang);
        if ($translated === '') {
            return;
        }

        $upsert = $this->dbh->prepare("INSERT INTO modules_localization (module_id, language, title)
            VALUES (:module_id, :language, :title)
            ON CONFLICT (module_id, language) DO UPDATE SET title = EXCLUDED.title");
        $upsert->execute([
            ':module_id' => (int)$row['id'],
            ':language' => $lang,
            ':title' => $translated,
        ]);
    }

    private function hasRow(string $table, string $idColumn, int $id, string $lang): bool
    {
        $sql = "SELECT 1 FROM {$table} WHERE {$idColumn} = :id AND language = :lang LIMIT 1";
        $stmt = $this->dbh->prepare($sql);
        $stmt->execute([':id' => $id, ':lang' => $lang]);
        return (bool)$stmt->fetchColumn();
    }

    private function translateStructured(string $task, array $payload, string $rules): ?array
    {
        $content = [
            ['role' => 'system', 'content' => 'You are a precise technical translator for SQL education content.'],
            ['role' => 'user', 'content' => $task],
            ['role' => 'user', 'content' => $rules],
            ['role' => 'user', 'content' => 'Payload JSON: ' . json_encode($payload, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)],
        ];

        $raw = $this->chat($content);
        if ($raw === '') {
            return null;
        }

        $json = $this->extractJsonObject($raw);
        if ($json === null) {
            return null;
        }

        $decoded = json_decode($json, true);
        if (!is_array($decoded)) {
            return null;
        }

        return $decoded;
    }

    private function translateText(string $text, string $lang): string
    {
        $languageName = self::LANGUAGE_NAMES[$lang] ?? $lang;
        $messages = [
            ['role' => 'system', 'content' => "You are a technical translator from English/Russian to {$languageName}."],
            ['role' => 'user', 'content' => "Translate to {$languageName}. Keep SQL identifiers and placeholders unchanged. Return only the translated text."],
            ['role' => 'user', 'content' => $text],
        ];
        return trim($this->chat($messages));
    }

    private function chat(array $messages): string
    {
        $data = [
            'model' => $this->model,
            'messages' => $messages,
            'temperature' => 0.2,
            'max_tokens' => 3000,
        ];

        $crl = curl_init('https://api.openai.com/v1/chat/completions');
        curl_setopt($crl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($crl, CURLOPT_POST, true);
        curl_setopt($crl, CURLOPT_POSTFIELDS, json_encode($data));
        curl_setopt($crl, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json',
            'Authorization: Bearer ' . $this->apiKey,
        ]);

        $result = curl_exec($crl);
        if ($result === false) {
            curl_close($crl);
            return '';
        }

        $response = json_decode((string)$result, true);
        curl_close($crl);
        if (!is_array($response)) {
            return '';
        }
        if (!empty($response['error']['message'])) {
            return '';
        }

        return trim((string)($response['choices'][0]['message']['content'] ?? ''));
    }

    private function extractJsonObject(string $raw): ?string
    {
        $raw = trim($raw);
        if ($raw === '') {
            return null;
        }

        if ($raw[0] === '{' && str_ends_with($raw, '}')) {
            return $raw;
        }

        if (preg_match('/\{.*\}/s', $raw, $match)) {
            return $match[0];
        }

        return null;
    }
}
