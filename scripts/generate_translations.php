<?php

declare(strict_types=1);

/**
 * Generate/refresh translations from en translations using OpenAI API.
 *
 * Usage:
 *   php scripts/generate_translations.php --locale=zh --dry-run
 *   php scripts/generate_translations.php --locale=es --apply
 *   php scripts/generate_translations.php --locale=es --apply --limit=120
 */

$root = dirname(__DIR__);
$enFile = $root . '/translations/en.php';
$options = getopt('', ['apply', 'dry-run', 'limit::', 'locale::']);
$locale = strtolower((string)($options['locale'] ?? 'zh'));
$localeFile = $root . '/translations/' . $locale . '.php';
$envFile = $root . '/.env';

if (!preg_match('/^[a-z]{2}$/', $locale)) {
    fwrite(STDERR, "Locale must be a two-letter language code\n");
    exit(1);
}

if (!file_exists($enFile)) {
    fwrite(STDERR, "Missing translations/en.php\n");
    exit(1);
}

$apply = isset($options['apply']);
$dryRun = isset($options['dry-run']) || !$apply;
$limit = isset($options['limit']) ? max(1, (int)$options['limit']) : 200;

$env = parseEnv($envFile);
$apiKey = (string)($env['OPENAI_API_KEY'] ?? '');
$model = (string)($env['LLM_TRANSLATION_MODEL'] ?? 'gpt-4o-mini');

if ($apiKey === '') {
    fwrite(STDERR, "OPENAI_API_KEY is not configured in .env\n");
    exit(1);
}

$en = loadTranslations($enFile);
$target = file_exists($localeFile) ? loadTranslations($localeFile) : [];

$pending = [];
foreach ($en as $key => $value) {
    $enValue = (string)$value;
    $targetValue = array_key_exists($key, $target) ? (string)$target[$key] : '';

    // Translate when zh value is missing or still equals English source.
    if ($targetValue === '' || $targetValue === $enValue) {
        $pending[$key] = $enValue;
    }
}

if (empty($pending)) {
    fwrite(STDOUT, "No pending keys to translate.\n");
    exit(0);
}

$pending = array_slice($pending, 0, $limit, true);
fwrite(STDOUT, "Pending keys in this run: " . count($pending) . "\n");

$batchSize = 20;
$translated = [];
$chunks = array_chunk($pending, $batchSize, true);

foreach ($chunks as $index => $chunk) {
    $chunkNo = $index + 1;
    fwrite(STDOUT, "Translating chunk {$chunkNo}/" . count($chunks) . "...\n");
    $errorMessage = '';
    $result = translateChunk($apiKey, $model, $locale, $chunk, $errorMessage);
    if (empty($result)) {
        $suffix = $errorMessage !== '' ? " ({$errorMessage})" : '';
        fwrite(STDERR, "Chunk {$chunkNo} failed; skipping{$suffix}.\n");
        continue;
    }

    foreach ($chunk as $key => $sourceText) {
        if (!isset($result[$key]) || !is_string($result[$key]) || trim($result[$key]) === '') {
            continue;
        }
        $translated[$key] = $result[$key];
    }
}

if (empty($translated)) {
    fwrite(STDERR, "No translated keys received.\n");
    exit(1);
}

foreach ($translated as $key => $value) {
    $target[$key] = $value;
}

if ($dryRun) {
    fwrite(STDOUT, "Dry run complete. Sample translated keys:\n");
    $preview = array_slice($translated, 0, 15, true);
    foreach ($preview as $k => $v) {
        fwrite(STDOUT, "- {$k}: " . preview($v) . "\n");
    }
    fwrite(STDOUT, "Run with --locale={$locale} --apply to write translations/{$locale}.php\n");
    exit(0);
}

ksort($target);
writeTranslations($localeFile, $target);
fwrite(STDOUT, "Updated {$localeFile} with " . count($translated) . " translated keys.\n");
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

function loadTranslations(string $path): array
{
    $translations = [];
    require $path;
    if (!is_array($translations)) {
        throw new RuntimeException("Invalid translation file: {$path}");
    }
    return $translations;
}

function writeTranslations(string $path, array $translations): void
{
    $lines = ["<?php", "\$translations = ["];

    foreach ($translations as $key => $value) {
        $k = var_export((string)$key, true);
        $v = var_export((string)$value, true);
        $lines[] = "    {$k} => {$v},";
    }

    $lines[] = "];";
    $lines[] = "";
    file_put_contents($path, implode(PHP_EOL, $lines));
}

function translateChunk(string $apiKey, string $model, string $locale, array $chunk, string &$errorMessage = ''): array
{
    $messages = [
        [
            'role' => 'system',
            'content' => translationSystemPrompt($locale)
        ],
        [
            'role' => 'user',
            'content' => "Translate the JSON object values from English to {$locale} while preserving placeholders, tags, links, and SQL identifiers exactly. Keep keys unchanged and return a JSON object only.\n\n" . json_encode($chunk, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)
        ],
    ];

    $payload = [
        'model' => $model,
        'messages' => $messages,
        'temperature' => 0.2,
        'max_tokens' => 3000,
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
        $errorMessage = $curlError !== '' ? $curlError : 'Empty API response';
        return [];
    }

    $resp = json_decode($raw, true);
    if (!is_array($resp)) {
        $errorMessage = 'Invalid JSON from API';
        return [];
    }
    if (!empty($resp['error'])) {
        $errorMessage = (string)($resp['error']['message'] ?? 'API error');
        return [];
    }
    if ($httpCode >= 400) {
        $errorMessage = 'HTTP ' . $httpCode;
        return [];
    }

    $content = trim((string)($resp['choices'][0]['message']['content'] ?? ''));
    if ($content === '') {
        return [];
    }

    $json = extractJsonObject($content);
    if ($json === null) {
        $errorMessage = 'Model did not return a JSON object';
        return [];
    }

    $decoded = json_decode($json, true);
    if (!is_array($decoded)) {
        $errorMessage = 'Extracted JSON is invalid';
        return [];
    }
    return $decoded;
}

function translationSystemPrompt(string $locale): string
{
    if ($locale === 'es') {
        return 'You translate SQL education UI strings to neutral professional Spanish for Argentina. Use consistent Rioplatense terminology without slang. Preserve placeholders like ##Lang##, HTML tags, URLs, and SQL identifiers exactly. Return valid JSON only.';
    }

    if ($locale === 'zh') {
        return 'You translate SQL education UI strings to Simplified Chinese. Preserve placeholders like ##Lang##, HTML tags, URLs, and SQL identifiers exactly. Return valid JSON only.';
    }

    return "You translate SQL education UI strings to {$locale}. Preserve placeholders like ##Lang##, HTML tags, URLs, and SQL identifiers exactly. Return valid JSON only.";
}

function extractJsonObject(string $text): ?string
{
    $text = trim($text);
    if ($text === '') {
        return null;
    }

    if ($text[0] === '{' && str_ends_with($text, '}')) {
        return $text;
    }

    if (preg_match('/```json\s*(\{.*\})\s*```/is', $text, $m)) {
        return $m[1];
    }

    if (preg_match('/```\s*(\{.*\})\s*```/is', $text, $m)) {
        return $m[1];
    }

    if (preg_match('/(\{.*\})/s', $text, $m)) {
        return $m[1];
    }

    return null;
}

function preview(string $value): string
{
    $value = preg_replace('/\s+/', ' ', trim($value));
    if ($value === null) {
        return '';
    }
    if (mb_strlen($value) > 80) {
        return mb_substr($value, 0, 77) . '...';
    }
    return $value;
}
