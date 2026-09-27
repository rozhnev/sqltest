<?php
/**
 * Add AI tokens to a user's balance by hand (see TOKEN_PURCHASE_PLAN.md): a genuine
 * payment the webhook couldn't match, or a goodwill grant. A negative --tokens
 * deducts, e.g. after a refund or chargeback.
 *
 * Usage: php scripts/grant_tokens.php --user=<email|uuid> --tokens=<n>
 */

declare(strict_types=1);

if (PHP_SAPI !== 'cli') {
    fwrite(STDERR, "This script can only be run from CLI.\n");
    exit(1);
}

$usage = "Usage: php scripts/grant_tokens.php --user=<email|uuid> --tokens=<n>  (negative deducts)\n";
$options = getopt('', ['user:', 'tokens:']);
$userRef = trim((string)($options['user'] ?? ''));
$tokensArg = trim((string)($options['tokens'] ?? ''));
if ($userRef === '' || !preg_match('/^-?[1-9][0-9]{0,8}$/', $tokensArg)) {
    fwrite(STDERR, $usage);
    exit(1);
}
$tokens = (int)$tokensArg;

$projectRoot = dirname(__DIR__);
chdir($projectRoot);
require_once $projectRoot . '/vendor/autoload.php';

// Same .env parsing as index.php, so DB sees the same keys as the site
$env = parse_ini_string((string)file_get_contents($projectRoot . '/.env'), true);
$dbh = (new DB($env))->getInstance();

$isUuid = (bool)preg_match('/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i', $userRef);
$stmt = $dbh->prepare($isUuid
    ? "SELECT id, login, email, llm_tokens FROM users WHERE id = :ref"
    : "SELECT id, login, email, llm_tokens FROM users WHERE LOWER(email) = LOWER(:ref)");
$stmt->execute([':ref' => $userRef]);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
if (count($rows) !== 1) {
    fwrite(STDERR, count($rows) === 0
        ? "User not found: {$userRef}\n"
        : "Several users have email {$userRef}; pass the uuid instead.\n");
    exit(1);
}
$row = $rows[0];

// Atomic, like TokenQuota::charge(): a concurrent charge must not be overwritten
$stmt = $dbh->prepare("UPDATE users SET llm_tokens = llm_tokens + :tokens WHERE id = :id RETURNING llm_tokens");
$stmt->execute([':tokens' => $tokens, ':id' => $row['id']]);
$balance = (int)$stmt->fetchColumn();

echo "User:    {$row['id']} ({$row['login']}, {$row['email']})\n";
echo "Tokens:  " . ($tokens > 0 ? '+' : '') . "{$tokens}\n";
echo "Balance: {$row['llm_tokens']} -> {$balance}\n";
