<?php
/**
 * Grant one monthly subscription cycle after a Lava.top payment is confirmed
 * (see LESSON_ASSISTANT_PLAN.md, Stage 6). Extends subscribed_till by one month
 * from the payment date (or from the current end for an early renewal) and sets
 * the AI token balance to LLM_SUBSCRIBER_CYCLE_TOKENS.
 *
 * Usage: php scripts/grant_subscription.php --user=<email|uuid> --paid-on=YYYY-MM-DD
 */

declare(strict_types=1);

if (PHP_SAPI !== 'cli') {
    fwrite(STDERR, "This script can only be run from CLI.\n");
    exit(1);
}

$options = getopt('', ['user:', 'paid-on:']);
$userRef = trim((string)($options['user'] ?? ''));
$paidOnArg = (string)($options['paid-on'] ?? '');
$paidOn = DateTimeImmutable::createFromFormat('!Y-m-d', $paidOnArg);
// Round-trip check: createFromFormat silently overflows dates like 2026-13-45
if ($userRef === '' || $paidOn === false || $paidOn->format('Y-m-d') !== $paidOnArg) {
    fwrite(STDERR, "Usage: php scripts/grant_subscription.php --user=<email|uuid> --paid-on=YYYY-MM-DD\n");
    exit(1);
}

$projectRoot = dirname(__DIR__);
chdir($projectRoot);
require_once $projectRoot . '/vendor/autoload.php';

// Same .env parsing as index.php, so User/DB see the same keys as the site
$env = parse_ini_string((string)file_get_contents($projectRoot . '/.env'), true);
$dbh = (new DB($env))->getInstance();

$isUuid = (bool)preg_match('/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i', $userRef);
$stmt = $dbh->prepare($isUuid
    ? "SELECT id, login, email, subscribed_till FROM users WHERE id = :ref"
    : "SELECT id, login, email, subscribed_till FROM users WHERE LOWER(email) = LOWER(:ref)");
$stmt->execute([':ref' => $userRef]);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
if (count($rows) !== 1) {
    fwrite(STDERR, count($rows) === 0
        ? "User not found: {$userRef}\n"
        : "Several users have email {$userRef}; pass the uuid instead.\n");
    exit(1);
}
$row = $rows[0];

$user = new User($dbh, $env);
$user->setId((string)$row['id']);
$subscribedTill = $user->grantSubscription($paidOn);

echo "User:            {$row['id']} ({$row['login']}, {$row['email']})\n";
echo "Paid on:         {$paidOn->format('Y-m-d')}\n";
echo "Subscribed till: " . ($row['subscribed_till'] ?? 'none') . " -> {$subscribedTill} (exclusive)\n";
