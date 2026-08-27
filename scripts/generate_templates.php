<?php

declare(strict_types=1);

/**
 * Translate templates/en/*.tpl into a locale template directory while preserving Smarty tags.
 *
 * Usage:
 *   php scripts/generate_templates.php --locale=zh --dry-run
 *   php scripts/generate_templates.php --locale=es --apply
 *   php scripts/generate_templates.php --locale=es --apply --limit=10
 */

$root = dirname(__DIR__);
$enDir = $root . '/templates/en';
$options = getopt('', ['apply', 'dry-run', 'limit::', 'file::', 'force', 'locale::']);
$locale = strtolower((string)($options['locale'] ?? 'zh'));
$localeDir = $root . '/templates/' . $locale;
$envFile = $root . '/.env';

if (!preg_match('/^[a-z]{2}$/', $locale)) {
    fwrite(STDERR, "Locale must be a two-letter language code\n");
    exit(1);
}

if (!is_dir($enDir) || !is_dir($localeDir)) {
    fwrite(STDERR, "Source or target template directory is missing\n");
    exit(1);
}

$apply = isset($options['apply']);
$dryRun = isset($options['dry-run']) || !$apply;
$limit = isset($options['limit']) ? max(1, (int)$options['limit']) : 100;
$fileFilter = isset($options['file']) ? trim((string)$options['file']) : '';
$force = isset($options['force']);

$env = parseEnv($envFile);
$apiKey = (string)($env['OPENAI_API_KEY'] ?? '');
$model = (string)($env['LLM_TRANSLATION_MODEL'] ?? 'gpt-4o-mini');

if ($apiKey === '') {
    fwrite(STDERR, "OPENAI_API_KEY is not configured in .env\n");
    exit(1);
}

$files = glob($enDir . '/*.tpl') ?: [];
sort($files);

$targets = [];
foreach ($files as $enPath) {
    $name = basename($enPath);
    if ($fileFilter !== '' && $name !== $fileFilter) {
        continue;
    }

    $localePath = $localeDir . '/' . $name;
    if (!file_exists($localePath)) {
        continue;
    }

    $enContent = file_get_contents($enPath);
    $localeContent = file_get_contents($localePath);
    if (!is_string($enContent) || !is_string($localeContent)) {
        continue;
    }

    $needsTranslation = $force || trim($localeContent) === trim($enContent);
    if ($needsTranslation) {
        $targets[] = ['name' => $name, 'en' => $enContent, 'localePath' => $localePath];
    }
}

if (empty($targets)) {
    fwrite(STDOUT, "No template files need translation.\n");
    exit(0);
}

$targets = array_slice($targets, 0, $limit);
fwrite(STDOUT, "Template files in this run: " . count($targets) . "\n");

$updated = 0;
foreach ($targets as $i => $target) {
    $idx = $i + 1;
    fwrite(STDOUT, "Translating {$target['name']} ({$idx}/" . count($targets) . ")...\n");

    $error = '';
    $translated = translateTemplate($apiKey, $model, $locale, $target['en'], $error);
    if ($translated === '') {
        $suffix = $error !== '' ? " ({$error})" : '';
        fwrite(STDERR, "Failed {$target['name']}{$suffix}\n");
        continue;
    }

    if ($dryRun) {
        fwrite(STDOUT, "Dry run preview for {$target['name']}: " . preview($translated) . "\n");
        continue;
    }

    file_put_contents($target['localePath'], $translated);
    $updated++;
}

if ($dryRun) {
    fwrite(STDOUT, "Dry run complete.\n");
} else {
    fwrite(STDOUT, "Updated {$locale} templates: {$updated}\n");
}

exit(0);

function parseEnv(string $path): array
{
    if (!file_exists($path)) {
        return [];
    }

    $result = [];
    $lines = file($path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    if ($lines === false) {
        return [];
    }

    foreach ($lines as $line) {
        $line = trim($line);
        if ($line === '' || str_starts_with($line, '#')) {
            continue;
        }
        $parts = explode('=', $line, 2);
        if (count($parts) !== 2) {
            continue;
        }
        $key = trim($parts[0]);
        $val = trim($parts[1]);
        $val = trim($val, " \t\n\r\0\x0B\"'");
        $result[$key] = $val;
    }

    return $result;
}

function translateTemplate(string $apiKey, string $model, string $locale, string $source, string &$error = ''): string
{
    $language = $locale === 'es' ? 'neutral professional Spanish for Argentina' : ($locale === 'zh' ? 'Simplified Chinese' : $locale);
    $prompt = <<<'PROMPT'
Translate only user-facing natural language text in this template to TARGET_LANGUAGE.
Rules:
1) Keep all Smarty tags unchanged: {...}, {$...}, {if...}, {foreach...}, {include...}.
2) Keep HTML tags/attributes/JS/CSS unchanged.
3) Do not alter links, paths, variables, placeholders, or SQL identifiers.
4) Return the full translated template text only, with no explanations and no markdown fences.

Template:
PROMPT;
    $prompt = str_replace('TARGET_LANGUAGE', $language, $prompt);

    $messages = [
        [
            'role' => 'system',
            'content' => "You localize Smarty HTML templates to {$language}. Preserve Smarty syntax, variables, tags, URLs, CSS classes, IDs, scripts, and HTML structure exactly."
        ],
        [
            'role' => 'user',
            'content' => $prompt . "\n" . $source
        ],
    ];

    $payload = [
        'model' => $model,
        'messages' => $messages,
        'temperature' => 0.2,
        'max_tokens' => 4000,
    ];

    $ch = curl_init('https://api.openai.com/v1/chat/completions');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payload));
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Content-Type: application/json',
        'Authorization: Bearer ' . $apiKey,
    ]);

    $raw = curl_exec($ch);
    $httpCode = (int)curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError = curl_error($ch);
    curl_close($ch);

    if (!is_string($raw) || $raw === '') {
        $error = $curlError !== '' ? $curlError : 'Empty response';
        return '';
    }

    $resp = json_decode($raw, true);
    if (!is_array($resp)) {
        $error = 'Invalid JSON from API';
        return '';
    }
    if (!empty($resp['error'])) {
        $error = (string)($resp['error']['message'] ?? 'API error');
        return '';
    }
    if ($httpCode >= 400) {
        $error = 'HTTP ' . $httpCode;
        return '';
    }

    $content = trim((string)($resp['choices'][0]['message']['content'] ?? ''));
    if ($content === '') {
        $error = 'Empty model content';
        return '';
    }

    $content = stripMarkdownFence($content);
    return $content;
}

function stripMarkdownFence(string $text): string
{
    $trim = trim($text);
    if (preg_match('/^```[a-zA-Z0-9_-]*\n([\s\S]*?)\n```$/', $trim, $m)) {
        return $m[1];
    }
    return $text;
}

function preview(string $text): string
{
    $v = preg_replace('/\s+/', ' ', trim($text));
    if ($v === null) {
        return '';
    }
    if (mb_strlen($v) > 120) {
        return mb_substr($v, 0, 117) . '...';
    }
    return $v;
}
