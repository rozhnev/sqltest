<?php
$env    = parse_ini_string(file_get_contents("../.env"), 1);

require '../vendor/autoload.php';
$smarty = new Smarty();
$dbc    = new DB($env);
$dbh    = $dbc->getInstance();
$user   = new User($dbh, $env);

session_start();

if (($_SESSION && $_SESSION['user_id'])) {
    $user->setId($_SESSION['user_id']);
}

// var_dump($user);
$smarty->assign('Logged', $user->logged());
$smarty->assign('Admin', $user->isAdmin());
$smarty->setTemplateDir('../templates/admin');
$smarty->assign('Lang', 'en');
$smarty->assign('DB', 'sakila');
$smarty->assign('QuestionID', '0');
$smarty->display('index.tpl');