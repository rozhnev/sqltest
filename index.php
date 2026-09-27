<?php
$env    = parse_ini_string(file_get_contents(".env"), 1);

defined('DEFAULT_LANGUAGE') or define('DEFAULT_LANGUAGE', $env['DEFAULT_LANGUAGE'] ?? 'en');
defined('SESSION_LIFETIME') or define('SESSION_LIFETIME', $env['SESSION_LIFETIME'] ?? 86400);

if (isset($env['MAINTENANCE'])) {
    include 'templates/maintainance.tpl';
    die();
}
include_once 'config.php';
require 'vendor/autoload.php';

$smarty = new Smarty();
$dbc    = new DB($env);
$dbh    = $dbc->getInstance();
$user   = new User($dbh, $env);
$languge_codes = array_keys($config['languages']);

$path = $_SERVER['REQUEST_URI'];

$pathParts = explode('/', $path);
$db         = '';
$questionID = '';
$QuestionnireName = $_COOKIE['Questionnire'] ?? 'category';


// Session cookie: HTTPS-only, hidden from JavaScript, not sent with cross-site POSTs;
// strict mode refuses session ids the server didn't issue
ini_set('session.cookie_secure', '1');
ini_set('session.cookie_httponly', '1');
ini_set('session.cookie_samesite', 'Lax');
ini_set('session.use_strict_mode', '1');
// Framing is limited to this site (clickjacking); Controller::embed() lifts it
header('Strict-Transport-Security: max-age=31536000');
header('X-Content-Type-Options: nosniff');
header('Referrer-Policy: strict-origin-when-cross-origin');
header('X-Frame-Options: SAMEORIGIN');
header("Content-Security-Policy: frame-ancestors 'self'");
session_start([
    'cookie_lifetime' => SESSION_LIFETIME,
    'gc_maxlifetime' => SESSION_LIFETIME
]);

if (isset($_COOKIE[session_name()])) {
    // session_id(), not the cookie: strict mode may have replaced an unknown id
    setcookie(session_name(), session_id(), [
        'expires' => time() + SESSION_LIFETIME,
        'path' => '/',
        'secure' => true,
        'httponly' => true,
        'samesite' => 'Lax'
    ]);
}

if ($_SESSION) {
    $user->loginSession($_SESSION);
}

$controller = new Controller($dbh, $smarty, $user, $env, $config);
$router = (new Router($controller, $languge_codes))->route($path);
