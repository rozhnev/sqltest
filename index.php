<?php
$env    = parse_ini_string(file_get_contents(".env"), 1);

defined('DEFAULT_LANGUAGE') or define('DEFAULT_LANGUAGE', $env['DEFAULT_LANGUAGE'] ?? 'en');
defined('SESSION_LIFETIME') or define('SESSION_LIFETIME', $env['SESSION_LIFETIME'] ?? 86400);

if (isset($env['MAINTENANCE'])) {
    include 'templates/maintainance.tpl';
    die();
}

require 'vendor/autoload.php';

$smarty = new Smarty();
$dbc    = new DB($env);
$dbh    = $dbc->getInstance();
$user   = new User($dbh, $env);
$languages = ['ru' => 'Русский', 'en' => 'English', 'pt' => 'Português'/*, 'es' => 'Español'*/];    
$languge_codes = array_keys($languages);
$languge_codes_regexp = implode('|', $languge_codes);

$mobileView =  (
    (isset($_SERVER['SERVER_NAME']) && $_SERVER['SERVER_NAME'] === 'm.sqltest.online') 
    // for local use
    //|| parse_url($_SERVER['HTTP_HOST'])['host'] === 'm.sqltest.local' 
);

$path = $_SERVER['REQUEST_URI'];

$pathParts = explode('/', $path);
$db         = '';
$questionID = '';
$QuestionnireName = $_COOKIE['Questionnire'] ?? 'category';


session_start([
    'cookie_lifetime' => SESSION_LIFETIME,
    'gc_maxlifetime' => SESSION_LIFETIME
]);

if (isset($_COOKIE[session_name()])) {
    setcookie(session_name(), $_COOKIE[session_name()], [
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

$controller = new Controller($dbh, $smarty, $user, $mobileView);
$router = (new Router($controller))->route($path);
