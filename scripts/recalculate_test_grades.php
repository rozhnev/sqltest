<?php

declare(strict_types=1);

if (PHP_SAPI !== 'cli') {
    fwrite(STDERR, "This script can only be run from CLI.\n");
    exit(1);
}

$isDryRun = in_array('--dry-run', $argv, true);

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

try {
    $dbc = new DB($env);
    $dbh = $dbc->getInstance();
    $user = new User($dbh, $env);
    $lang = (string) ($env['DEFAULT_LANGUAGE'] ?? 'en');

    $stmt = $dbh->query("SELECT id FROM tests WHERE grade IS NULL ORDER BY created_at DESC");
    $testIds = $stmt->fetchAll(PDO::FETCH_COLUMN);

    $total = count($testIds);
    if ($total === 0) {
        fwrite(STDOUT, "No tests with NULL grade found.\n");
        exit(0);
    }

    if ($isDryRun) {
        fwrite(STDOUT, "Dry run mode enabled. Grades will be calculated but not saved.\n");
    }

    fwrite(STDOUT, "Found {$total} test(s) with NULL grade.\n");

    $updated = 0;
    $calculated = 0;
    $skipped = 0;
    $failed = 0;

    foreach ($testIds as $testId) {
        try {
            $test = new Test($dbh, $lang, $user);
            $test->setId((string) $testId);

            $result = $test->calculateResult();
            $grade = (int) ($result['grade'] ?? 0);

            if ($grade <= 0) {
                $skipped++;
                fwrite(STDOUT, "[SKIP] {$testId} -> grade {$grade}\n");
                continue;
            }

            if ($isDryRun) {
                $calculated++;
                fwrite(STDOUT, "[DRY-RUN] {$testId} -> grade {$grade}\n");
            } else {
                $test->saveGrade($grade);
                $updated++;
                fwrite(STDOUT, "[OK] {$testId} -> grade {$grade}\n");
            }
        } catch (Throwable $e) {
            $failed++;
            fwrite(STDERR, "[ERROR] {$testId}: {$e->getMessage()}\n");
        }
    }

    if ($isDryRun) {
        fwrite(STDOUT, "Done. Calculated: {$calculated}, Skipped: {$skipped}, Failed: {$failed}.\n");
    } else {
        fwrite(STDOUT, "Done. Updated: {$updated}, Skipped: {$skipped}, Failed: {$failed}.\n");
    }

    exit($failed > 0 ? 2 : 0);
} catch (Throwable $e) {
    fwrite(STDERR, "Fatal error: {$e->getMessage()}\n");
    exit(1);
}
