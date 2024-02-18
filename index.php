<?php
$env    = parse_ini_string(file_get_contents(".env"), 1);

require 'vendor/autoload.php';
$smarty = new Smarty();
$dbc    = new DB($env);
$dbh    = $dbc->getInstance();
$user   = new User($dbh, $env);

$host = parse_url($_SERVER['HTTP_HOST'])['host'];
$modileView =  ($host === 'm.sqltest.local' || $host === 'm.sqltest.online');

$path = isset($_SERVER['PATH_INFO']) ? trim($_SERVER['PATH_INFO'], '/') : trim($_SERVER['PHP_SELF'], '/');
$pathParts = explode('/', $path);
$db         = '';
$questionID = '';

if (isset($pathParts[0]) && $pathParts[0] === 'login') {
    $action     = 'login';
    $loginProvider = $pathParts[1];
} elseif (isset($pathParts[1]) && $pathParts[1] === 'privacy-policy') {
    $lang       = isset($pathParts[0]) && $pathParts[0] === 'ru' ? 'ru' : 'en';
    $action     = 'privacy-policy';
} else {
    $lang       = isset($pathParts[0]) && $pathParts[0] === 'ru' ? 'ru' : 'en';
    $db         = $pathParts[1] ?? 'about';
    $questionID = $pathParts[2] ?? '1';
    $action     = $pathParts[3] ?? '';
}

session_start();

if (($_SESSION && $_SESSION['user_id'])) {
    $user->set($_SESSION['user_id'], $_SESSION["admin"]);
}

switch ($action) {
    case 'login':
        $user->login($loginProvider, $_REQUEST);
        $_SESSION["user_id"] = $user->getId();
        $_SESSION["admin"] = $user->isAdmin();
        //TODO: last path should be restored on login
        $template = "../login_result.tpl";
        break;
    case 'privacy-policy':
        $smarty->assign('Lang', $lang);
        $smarty->assign('DB', 'sakila');
        $smarty->assign('QuestionID', '1');
        $template = $modileView ? "m.privacy_policy.tpl" : "privacy_policy.tpl";
        break;
    case 'query-help':
        $question = new Question($dbh, $questionID);
        $smarty->assign('Hint', $question->getHint($lang));
        $template = "hint.tpl";
        break;
    case 'query-run':
        $sql = $_POST["query"] ?? '';
        if (empty($sql)) {
            $template = "empty_query_result.tpl";
            break;
        }
        $query = new Query($sql);
        $question = new Question($dbh, $questionID);
        $smarty->assign('QeryResult', $query->getResult($question->getDB(), 'json'));
        $template = "query_result.tpl";
        break;
    case 'query-test':
        $sql = $_POST["query"] ?? '';
        $question = new Question($dbh, $questionID);
        $queryTestResult = $question->checkQuery($sql);
        $smarty->assign('QeryTestResult', $queryTestResult);
        if ($queryTestResult['ok']) {
            $query = new Query($sql);
            $jsonResult = $query->getResult($question->getDB(), 'json');
            $queryTestResult = $question->checkQueryResult($jsonResult);
            $smarty->assign('QeryTestResult', $queryTestResult);
        }
        if ($user->logged()) {
            $user->saveQuestionAttempt($questionID, $queryTestResult['ok'], $sql);
        }
        if (!$queryTestResult['ok']) header( 'HTTP/1.1 418 BAD REQUEST' );
        $template = "query_test_result.tpl";
        break;
    case 'logout':
        // Unset all of the session variables.
        $_SESSION = array();

        // If it's desired to kill the session, also delete the session cookie.
        // Note: This will destroy the session, and not just the session data!
        if (ini_get("session.use_cookies")) {
            $params = session_get_cookie_params();
            setcookie(session_name(), '', time() - 42000,
                $params["path"], $params["domain"],
                $params["secure"], $params["httponly"]
            );
        }

        // Finally, destroy the session.
        session_destroy();
        header("location:/");
        die();
    case 'welcome':
        $questionnire = new Questionnire($dbh, $lang);
        $smarty->assign('Questionnire', $questionnire->get());
        $template = "welcome.tpl";
        break;
    default:
        if ($user->logged()) {
            $user->setPath($path);
            $user->save();
        }

        $questionnire = new Questionnire($dbh, $lang);
        $question = new Question($dbh, $questionID);
        $smarty->assign('Questionnire', $questionnire->get($user->getId()));
        $smarty->assign('Question', $question->get($lang, $user->getId()));
        $smarty->assign('NextQuestionId', $question->getNextId());
        $smarty->assign('PreviousQuestionId', $question->getPreviousId());
        $template = $modileView ? "m.index.tpl" : "index.tpl";
}

if ($lang == 'ru') {
    $smarty->setTemplateDir('./templates/ru');
} else {
    $lang = 'en';
    $smarty->setTemplateDir('./templates/en');
}

$smarty->assign('Logged', $user->logged());
$smarty->assign('LoggedAsAdmin', $user->isAdmin());
$smarty->assign('Lang', $lang);
$smarty->assign('DB', $db);
$smarty->assign('QuestionID', $questionID);

$smarty->display($template);