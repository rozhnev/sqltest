<?php

declare(strict_types=1);

/*
 * Tags interview questions and lessons with skills from interview_skill_tags
 * (sql/interview_skill_tags_ddl.sql, INTERVIEW_SIMULATION_PLAN.md п. 3.7), so the
 * interview result can report strengths/weaknesses by skill and recommend lessons
 * for weak skills.
 *
 *   php scripts/build_interview_skill_tags.php [--dry-run] [--llm=<profile>]
 *       [--only=questions|lessons] [--ids=1,2,3] [--limit=N] [--missing-only]
 *
 * Questions: every question in interview_questions gets 1-2 skills, the first one
 * primary (the skill the question mainly tests). Soft-skills questions get
 * "professional-skills" without an LLM call. Lessons get 0-3 skills with
 * confidence. Each question/lesson is fully re-tagged on every run (idempotent);
 * --missing-only skips ones that already have tags.
 */

if (PHP_SAPI !== 'cli') {
    fwrite(STDERR, "This script can only be run from CLI.\n");
    exit(1);
}

$isDryRun = in_array('--dry-run', $argv, true);
$missingOnly = in_array('--missing-only', $argv, true);
$llmProfile = 'openai-gpt-4o-mini';
$only = null;
$ids = [];
$limit = null;
foreach ($argv as $arg) {
    if (str_starts_with($arg, '--llm=')) {
        $llmProfile = substr($arg, strlen('--llm='));
    } elseif (str_starts_with($arg, '--only=')) {
        $only = substr($arg, strlen('--only='));
    } elseif (str_starts_with($arg, '--ids=')) {
        $ids = array_values(array_filter(array_map('intval', explode(',', substr($arg, strlen('--ids='))))));
    } elseif (str_starts_with($arg, '--limit=')) {
        $limit = max(1, (int) substr($arg, strlen('--limit=')));
    }
}
if ($only !== null && !in_array($only, ['questions', 'lessons'], true)) {
    fwrite(STDERR, "--only must be 'questions' or 'lessons'.\n");
    exit(1);
}
if ($ids && $only === null) {
    fwrite(STDERR, "--ids needs --only=questions or --only=lessons (ids of which table?).\n");
    exit(1);
}

const MAX_TASK_LENGTH = 2000;
const MAX_SOLUTION_LENGTH = 1500;
const MAX_LESSON_CONTENT_LENGTH = 6000;
const MAX_SKILLS_PER_QUESTION = 2;
const MAX_SKILLS_PER_LESSON = 3;
const SOFT_SKILLS_CODE = 'professional-skills';

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

function truncateText(string $text, int $limit): string
{
    $text = trim($text);
    if (mb_strlen($text) <= $limit) {
        return $text;
    }
    return mb_substr($text, 0, $limit) . "\n...(truncated)";
}

function plainText(string $html): string
{
    return trim(preg_replace('/\s+/u', ' ', html_entity_decode(strip_tags($html), ENT_QUOTES | ENT_HTML5, 'UTF-8')));
}

function skillList(array $skills): string
{
    return implode("\n", array_map(
        static fn(array $s): string => "{$s['code']}: {$s['title']}",
        $skills
    ));
}

function buildQuestionPrompt(array $question, array $skills): array
{
    $system = <<<SYS
You tag questions of a SQL job-interview simulation with the skills they test, so the
interview result can show the candidate's strengths and weaknesses by skill. Pick 1-2
skills from the provided list. The FIRST one is the main skill: the most advanced
construct the question cannot be solved without -- the one a wrong answer shows the
candidate is weak in. Use "select-basics" as the main skill ONLY when nothing beyond
SELECT / WHERE / ORDER BY / LIMIT / DISTINCT is needed; if a JOIN, an aggregate, a
subquery, a window function etc. is required, that is the main skill, and
"select-basics" may at most be the second one. ORDER BY and LIMIT alone are not
aggregation. Add a second skill only if the question clearly also depends on it.
Judge by what solving the question actually requires, not by the database it runs on
or by incidental keywords. Only use codes from the list.

Respond as strict JSON: {"skills": [{"code": string, "confidence": number between 0 and 1}, ...]}
SYS;

    $details = "Question type: {$question['question_type']}\n"
        . "Title: {$question['title']}\n"
        . "Task:\n{$question['task']}\n";
    if ($question['solution_query'] !== '') {
        $details .= "\nReference solution:\n{$question['solution_query']}\n";
    }
    if ($question['options']) {
        $details .= "\nAnswer options:\n" . implode("\n", array_map(
            static fn(array $o): string => '- ' . $o['answer'] . ($o['is_valid'] ? ' [correct]' : ''),
            $question['options']
        )) . "\n";
    }

    return [
        ['role' => 'system', 'content' => $system],
        ['role' => 'user', 'content' => "Skills (code: title):\n" . skillList($skills) . "\n\n" . $details],
    ];
}

function buildLessonPrompt(string $title, string $content, array $skills): array
{
    $system = <<<SYS
You map lessons of an SQL course to the interview skills they help improve, so a
candidate who was weak in a skill during a mock interview can be pointed to the right
lessons. Pick 0-3 skills from the provided list that the lesson substantially teaches
(not ones it only mentions in passing). If nothing fits, return an empty list rather
than guessing. Only use codes from the list.

Respond as strict JSON: {"skills": [{"code": string, "confidence": number between 0 and 1}, ...]}
SYS;

    return [
        ['role' => 'system', 'content' => $system],
        ['role' => 'user', 'content' => "Skills (code: title):\n" . skillList($skills) . "\n\n"
            . "Lesson title: {$title}\n\nLesson content (Markdown, possibly truncated):\n{$content}"],
    ];
}

/**
 * Valid skills from an LLM response, in the order returned, as [skill_id => confidence].
 */
function pickSkills(?array $response, array $skillIdsByCode, int $max): ?array
{
    if ($response === null || !isset($response['skills']) || !is_array($response['skills'])) {
        return null;
    }
    $picked = [];
    foreach ($response['skills'] as $entry) {
        $code = is_array($entry) ? (string) ($entry['code'] ?? '') : '';
        if (!isset($skillIdsByCode[$code]) || isset($picked[$skillIdsByCode[$code]])) {
            continue;
        }
        $confidence = isset($entry['confidence']) ? (float) $entry['confidence'] : 0.5;
        $picked[$skillIdsByCode[$code]] = max(0.0, min(1.0, $confidence));
    }
    return array_slice($picked, 0, $max, true);
}

function describe(array $picked, array $codesById): string
{
    $labels = [];
    foreach ($picked as $skillId => $confidence) {
        $labels[] = $codesById[$skillId] . '(' . number_format($confidence, 2) . ')';
    }
    return implode(', ', $labels);
}

try {
    $dbc = new DB($env);
    $dbh = $dbc->getInstance();
    $llm = new LLM($llmProfile);

    $skills = $dbh->query("
        SELECT t.id, t.code, COALESCE(tl_en.title, t.code) AS title
        FROM interview_skill_tags t
        LEFT JOIN interview_skill_tags_localization tl_en ON tl_en.skill_tag_id = t.id AND tl_en.language = 'en'
        ORDER BY t.sequence_position
    ")->fetchAll(PDO::FETCH_ASSOC);
    if (!$skills) {
        fwrite(STDERR, "interview_skill_tags is empty -- apply sql/interview_skill_tags_ddl.sql first.\n");
        exit(1);
    }
    $skillIdsByCode = array_column(array_map(fn($s) => ['code' => $s['code'], 'id' => (int) $s['id']], $skills), 'id', 'code');
    $codesById = array_flip($skillIdsByCode);
    // Soft-skills questions are tagged directly; don't offer this skill to the LLM for technical ones.
    $technicalSkills = array_values(array_filter($skills, fn($s) => $s['code'] !== SOFT_SKILLS_CODE));

    if ($isDryRun) {
        fwrite(STDOUT, "Dry run mode enabled. Skills will be picked but not saved.\n");
    }

    $stats = ['tagged' => 0, 'skipped' => 0, 'failed' => 0];

    // ---- Questions ------------------------------------------------------------------------------
    if ($only === null || $only === 'questions') {
        $where = ['NOT q.deleted', 'q.id IN (SELECT question_id FROM interview_questions)'];
        if ($ids) {
            $where[] = 'q.id IN (' . implode(',', $ids) . ')';
        }
        if ($missingOnly) {
            $where[] = 'NOT EXISTS (SELECT 1 FROM question_interview_tags qit WHERE qit.question_id = q.id)';
        }
        $questions = $dbh->query("
            SELECT q.id, q.question_type, q.dbms, COALESCE(q.solution_query, '') AS solution_query,
                   COALESCE(ql_en.title, ql_ru.title, q.title_sef) AS title,
                   COALESCE(ql_en.task, ql_ru.task, '') AS task
            FROM questions q
            LEFT JOIN questions_localization ql_en ON ql_en.question_id = q.id AND ql_en.language = 'en'
            LEFT JOIN questions_localization ql_ru ON ql_ru.question_id = q.id AND ql_ru.language = 'ru'
            WHERE " . implode(' AND ', $where) . "
            ORDER BY q.id" . ($limit !== null ? " LIMIT {$limit}" : '')
        )->fetchAll(PDO::FETCH_ASSOC);

        $optionsStmt = $dbh->prepare("
            SELECT a.is_valid, COALESCE(al_en.title, al_ru.title, '') AS answer
            FROM answers a
            LEFT JOIN answers_localization al_en ON al_en.answer_id = a.id AND al_en.language = 'en'
            LEFT JOIN answers_localization al_ru ON al_ru.answer_id = a.id AND al_ru.language = 'ru'
            WHERE a.question_id = :question_id AND NOT a.deleted
            ORDER BY a.id
        ");
        $deleteStmt = $dbh->prepare("DELETE FROM question_interview_tags WHERE question_id = :question_id");
        $insertStmt = $dbh->prepare("
            INSERT INTO question_interview_tags (question_id, skill_tag_id, is_primary, confidence)
            VALUES (:question_id, :skill_tag_id, :is_primary, :confidence)
        ");

        fwrite(STDOUT, "Questions: " . count($questions) . " to tag using '{$llmProfile}'.\n");
        foreach ($questions as $question) {
            $questionId = (int) $question['id'];
            try {
                if ($question['dbms'] === 'Soft Skills') {
                    $picked = [$skillIdsByCode[SOFT_SKILLS_CODE] => 1.0];
                } else {
                    $question['task'] = truncateText(plainText((string) $question['task']), MAX_TASK_LENGTH);
                    $question['solution_query'] = truncateText((string) $question['solution_query'], MAX_SOLUTION_LENGTH);
                    $optionsStmt->execute([':question_id' => $questionId]);
                    $question['options'] = array_map(function ($o) {
                        $o['answer'] = plainText((string) $o['answer']);
                        return $o;
                    }, $optionsStmt->fetchAll(PDO::FETCH_ASSOC));

                    $picked = pickSkills(
                        $llm->askJson(buildQuestionPrompt($question, $technicalSkills), 30),
                        $skillIdsByCode,
                        MAX_SKILLS_PER_QUESTION
                    );
                    if ($picked === null) {
                        $stats['skipped']++;
                        fwrite(STDOUT, "[SKIP] question {$questionId} -> LLM unavailable or unparsable response\n");
                        continue;
                    }
                    if (!$picked) {
                        $stats['skipped']++;
                        fwrite(STDOUT, "[SKIP] question {$questionId} -> no matching skill\n");
                        continue;
                    }
                }

                $label = "question {$questionId} [{$question['question_type']}] " . mb_substr((string) $question['title'], 0, 50)
                    . ' -> ' . describe($picked, $codesById);
                if ($isDryRun) {
                    $stats['tagged']++;
                    fwrite(STDOUT, "[DRY-RUN] {$label}\n");
                    continue;
                }

                $dbh->beginTransaction();
                $deleteStmt->execute([':question_id' => $questionId]);
                $isPrimary = true;
                foreach ($picked as $skillId => $confidence) {
                    $insertStmt->bindValue(':question_id', $questionId, PDO::PARAM_INT);
                    $insertStmt->bindValue(':skill_tag_id', $skillId, PDO::PARAM_INT);
                    $insertStmt->bindValue(':is_primary', $isPrimary, PDO::PARAM_BOOL);
                    $insertStmt->bindValue(':confidence', $confidence);
                    $insertStmt->execute();
                    $isPrimary = false;
                }
                $dbh->commit();

                $stats['tagged']++;
                fwrite(STDOUT, "[OK] {$label}\n");
            } catch (Throwable $e) {
                if ($dbh->inTransaction()) {
                    $dbh->rollBack();
                }
                $stats['failed']++;
                fwrite(STDERR, "[ERROR] question {$questionId}: {$e->getMessage()}\n");
            }
        }
    }

    // ---- Lessons --------------------------------------------------------------------------------
    if ($only === null || $only === 'lessons') {
        $where = ['NOT COALESCE(l.deleted, false)'];
        if ($ids) {
            $where[] = 'l.id IN (' . implode(',', $ids) . ')';
        }
        if ($missingOnly) {
            $where[] = 'NOT EXISTS (SELECT 1 FROM lesson_interview_tags lit WHERE lit.lesson_id = l.id)';
        }
        $lessons = $dbh->query("
            SELECT l.id, l.slug, COALESCE(ll_en.title, ll_ru.title, l.slug) AS title,
                   COALESCE(ll_en.content, ll_ru.content) AS content
            FROM lessons l
            LEFT JOIN lessons_localization ll_en ON ll_en.lesson_id = l.id AND ll_en.language = 'en'
            LEFT JOIN lessons_localization ll_ru ON ll_ru.lesson_id = l.id AND ll_ru.language = 'ru'
            WHERE " . implode(' AND ', $where) . "
            ORDER BY l.id" . ($limit !== null ? " LIMIT {$limit}" : '')
        )->fetchAll(PDO::FETCH_ASSOC);

        $deleteStmt = $dbh->prepare("DELETE FROM lesson_interview_tags WHERE lesson_id = :lesson_id");
        $insertStmt = $dbh->prepare("
            INSERT INTO lesson_interview_tags (lesson_id, skill_tag_id, confidence)
            VALUES (:lesson_id, :skill_tag_id, :confidence)
        ");

        fwrite(STDOUT, "Lessons: " . count($lessons) . " to tag using '{$llmProfile}'.\n");
        foreach ($lessons as $lesson) {
            $lessonId = (int) $lesson['id'];
            $slug = (string) $lesson['slug'];
            try {
                $content = (string) ($lesson['content'] ?? '');
                if (trim($content) === '') {
                    $stats['skipped']++;
                    fwrite(STDOUT, "[SKIP] lesson {$slug} -> no content\n");
                    continue;
                }

                $picked = pickSkills(
                    $llm->askJson(buildLessonPrompt((string) $lesson['title'], truncateText($content, MAX_LESSON_CONTENT_LENGTH), $technicalSkills), 30),
                    $skillIdsByCode,
                    MAX_SKILLS_PER_LESSON
                );
                if ($picked === null) {
                    $stats['skipped']++;
                    fwrite(STDOUT, "[SKIP] lesson {$slug} -> LLM unavailable or unparsable response\n");
                    continue;
                }
                arsort($picked);

                $label = "lesson {$slug} -> " . ($picked ? describe($picked, $codesById) : '(none)');
                if ($isDryRun) {
                    $stats['tagged']++;
                    fwrite(STDOUT, "[DRY-RUN] {$label}\n");
                    continue;
                }

                $dbh->beginTransaction();
                $deleteStmt->execute([':lesson_id' => $lessonId]);
                foreach ($picked as $skillId => $confidence) {
                    $insertStmt->execute([':lesson_id' => $lessonId, ':skill_tag_id' => $skillId, ':confidence' => $confidence]);
                }
                $dbh->commit();

                $stats['tagged']++;
                fwrite(STDOUT, "[OK] {$label}\n");
            } catch (Throwable $e) {
                if ($dbh->inTransaction()) {
                    $dbh->rollBack();
                }
                $stats['failed']++;
                fwrite(STDERR, "[ERROR] lesson {$slug}: {$e->getMessage()}\n");
            }
        }
    }

    $verb = $isDryRun ? 'Classified' : 'Tagged';
    fwrite(STDOUT, "Done. {$verb}: {$stats['tagged']}, Skipped: {$stats['skipped']}, Failed: {$stats['failed']}.\n");

    exit($stats['failed'] > 0 ? 2 : 0);
} catch (Throwable $e) {
    fwrite(STDERR, "Fatal error: {$e->getMessage()}\n");
    exit(1);
}
