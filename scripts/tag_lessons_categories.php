<?php

declare(strict_types=1);

if (PHP_SAPI !== 'cli') {
    fwrite(STDERR, "This script can only be run from CLI.\n");
    exit(1);
}

$isDryRun = in_array('--dry-run', $argv, true);

$llmProfile = 'openai-gpt-4o-mini';
foreach ($argv as $arg) {
    if (str_starts_with($arg, '--llm=')) {
        $llmProfile = substr($arg, strlen('--llm='));
    }
}

const MAX_LESSON_CONTENT_LENGTH = 6000;
const MAX_CATEGORIES_PER_LESSON = 3;

$projectRoot = dirname(__DIR__);

require_once $projectRoot . '/vendor/autoload.php';

$envFile = $projectRoot . '/.env';
$envContent = @file_get_contents($envFile);
if ($envContent === false) {
    fwrite(STDERR, "Unable to read .env file at {$envFile}.\n");
    exit(1);
}

$parsedEnv = parse_ini_string($envContent, true, INI_SCANNER_TYPED);
if ($parsedEnv === false) {
    fwrite(STDERR, "Failed to parse .env file.\n");
    exit(1);
}

$env = [];
foreach ($parsedEnv as $key => $value) {
    if (is_array($value)) {
        $env = array_merge($env, $value);
        continue;
    }

    $env[$key] = $value;
}

function truncateLessonContent(string $text, int $limit): string
{
    if (mb_strlen($text) <= $limit) {
        return $text;
    }
    return mb_substr($text, 0, $limit) . "\n...(truncated)";
}

function buildClassificationPrompt(string $lessonTitle, string $lessonContent, array $categories): array
{
    $categoryList = implode("\n", array_map(
        static fn(array $c): string => "{$c['id']}: {$c['title']}",
        $categories
    ));

    $system = <<<SYS
You classify SQL course lessons into a fixed list of topic categories, so a
struggling candidate in a mock job interview can be pointed to the right
lesson. Pick 1-3 categories that best match what the lesson actually teaches.
Only use ids from the provided list, never invent new ones. If nothing fits
well, return an empty list rather than guessing.

Respond as strict JSON: {"categories": [{"category_id": number, "confidence": number between 0 and 1}, ...]}
SYS;

    $user = "Available categories (id: title):\n{$categoryList}\n\n"
        . "Lesson title: {$lessonTitle}\n\n"
        . "Lesson content (Markdown, possibly truncated):\n{$lessonContent}";

    return [
        ['role' => 'system', 'content' => $system],
        ['role' => 'user', 'content' => $user],
    ];
}

try {
    $dbc = new DB($env);
    $dbh = $dbc->getInstance();
    $llm = new LLM($llmProfile);

    // category_id >= 100 is the auto-generated difficulty-tier bucket
    // (questions_rate_update(), not a real topic) -- excluded here.
    $categoriesStmt = $dbh->query("
        SELECT c.id, COALESCE(cl_ru.title, cl_en.title, c.title_sef) AS title
        FROM categories c
        LEFT JOIN categories_localization cl_ru ON cl_ru.category_id = c.id AND cl_ru.language = 'ru'
        LEFT JOIN categories_localization cl_en ON cl_en.category_id = c.id AND cl_en.language = 'en'
        WHERE NOT c.deleted AND c.id < 100
        ORDER BY c.id
    ");
    $categories = $categoriesStmt->fetchAll(PDO::FETCH_ASSOC);
    $validCategoryIds = array_map('intval', array_column($categories, 'id'));

    if (empty($categories)) {
        fwrite(STDERR, "No topic categories found (excluding difficulty-tier ids >= 100) -- nothing to classify against.\n");
        exit(1);
    }

    $lessonsStmt = $dbh->query("
        SELECT l.id, l.slug, COALESCE(ll_ru.title, ll_en.title, l.slug) AS title,
               COALESCE(ll_ru.content, ll_en.content) AS content
        FROM lessons l
        LEFT JOIN lessons_localization ll_ru ON ll_ru.lesson_id = l.id AND ll_ru.language = 'ru'
        LEFT JOIN lessons_localization ll_en ON ll_en.lesson_id = l.id AND ll_en.language = 'en'
        WHERE NOT l.deleted
        ORDER BY l.id
    ");
    $lessons = $lessonsStmt->fetchAll(PDO::FETCH_ASSOC);

    $total = count($lessons);
    if ($total === 0) {
        fwrite(STDOUT, "No lessons found.\n");
        exit(0);
    }

    if ($isDryRun) {
        fwrite(STDOUT, "Dry run mode enabled. Categories will be classified but not saved.\n");
    }
    fwrite(STDOUT, "Found {$total} lesson(s), classifying against " . count($categories) . " categories using '{$llmProfile}'.\n");

    $tagged = 0;
    $skipped = 0;
    $failed = 0;

    foreach ($lessons as $lesson) {
        $lessonId = (int) $lesson['id'];
        $slug = (string) $lesson['slug'];

        try {
            $content = (string) ($lesson['content'] ?? '');
            if (trim($content) === '') {
                $skipped++;
                fwrite(STDOUT, "[SKIP] {$slug} -> no content\n");
                continue;
            }

            $dialog = buildClassificationPrompt(
                (string) $lesson['title'],
                truncateLessonContent($content, MAX_LESSON_CONTENT_LENGTH),
                $categories
            );
            $response = $llm->askJson($dialog, 30);

            if ($response === null || !isset($response['categories']) || !is_array($response['categories'])) {
                $skipped++;
                fwrite(STDOUT, "[SKIP] {$slug} -> LLM unavailable or unparsable response\n");
                continue;
            }

            $picked = [];
            foreach ($response['categories'] as $entry) {
                if (!is_array($entry) || !isset($entry['category_id'])) {
                    continue;
                }
                $categoryId = (int) $entry['category_id'];
                if (!in_array($categoryId, $validCategoryIds, true)) {
                    continue;
                }
                $confidence = isset($entry['confidence']) ? (float) $entry['confidence'] : 0.5;
                $picked[$categoryId] = max(0.0, min(1.0, $confidence));
            }

            arsort($picked);
            $picked = array_slice($picked, 0, MAX_CATEGORIES_PER_LESSON, true);

            if (empty($picked)) {
                $skipped++;
                fwrite(STDOUT, "[SKIP] {$slug} -> no matching category\n");
                continue;
            }

            $labels = [];
            foreach ($picked as $categoryId => $confidence) {
                $labels[] = "{$categoryId}(" . number_format($confidence, 2) . ")";
            }

            if ($isDryRun) {
                $tagged++;
                fwrite(STDOUT, "[DRY-RUN] {$slug} -> " . implode(', ', $labels) . "\n");
                continue;
            }

            $dbh->beginTransaction();
            $deleteStmt = $dbh->prepare("DELETE FROM lesson_categories WHERE lesson_id = :lesson_id");
            $deleteStmt->execute([':lesson_id' => $lessonId]);

            $insertStmt = $dbh->prepare("
                INSERT INTO lesson_categories (lesson_id, category_id, confidence)
                VALUES (:lesson_id, :category_id, :confidence)
            ");
            foreach ($picked as $categoryId => $confidence) {
                $insertStmt->execute([
                    ':lesson_id' => $lessonId,
                    ':category_id' => $categoryId,
                    ':confidence' => $confidence,
                ]);
            }
            $dbh->commit();

            $tagged++;
            fwrite(STDOUT, "[OK] {$slug} -> " . implode(', ', $labels) . "\n");
        } catch (Throwable $e) {
            if ($dbh->inTransaction()) {
                $dbh->rollBack();
            }
            $failed++;
            fwrite(STDERR, "[ERROR] {$slug}: {$e->getMessage()}\n");
        }
    }

    $verb = $isDryRun ? 'Classified' : 'Tagged';
    fwrite(STDOUT, "Done. {$verb}: {$tagged}, Skipped: {$skipped}, Failed: {$failed}.\n");

    exit($failed > 0 ? 2 : 0);
} catch (Throwable $e) {
    fwrite(STDERR, "Fatal error: {$e->getMessage()}\n");
    exit(1);
}
