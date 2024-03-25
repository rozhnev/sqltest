<?php
$env    = parse_ini_string(file_get_contents(".env"), 1);

require 'vendor/autoload.php';
$smarty = new Smarty();
$dbc    = new DB($env);
$dbh    = $dbc->getInstance();
$user   = new User($dbh, $env);

$mobileView =  (
    (isset($_SERVER['SERVER_NAME']) && $_SERVER['SERVER_NAME'] === 'm.sqltest.online') 
    // for local use
    //|| parse_url($_SERVER['HTTP_HOST'])['host'] === 'm.sqltest.local' 
);


$path = isset($_SERVER['PATH_INFO']) ? trim($_SERVER['PATH_INFO'], '/') : trim($_SERVER['PHP_SELF'], '/');
$pathParts = explode('/', $path);
$db         = '';
$questionID = '';

if (isset($pathParts[0]) && $pathParts[0] === 'login') {
    $action     = 'login';
    $loginProvider = $pathParts[1];
// privacy-policy, logout actions
} elseif (preg_match('@(?<lang>ru|en)/(?<action>privacy-policy|logout|about|menu)/?@i', $path, $params)) {
    $lang       = $params['lang'];
    $action     = $params['action'];
} elseif (preg_match('@(?<lang>ru|en)/question/(?<questionCategoryID>\d+)/(?<questionID>\d+)@i', $path, $params)) {
    $lang       = $params['lang'];
    $action     = 'question';
    $questionCategoryID = $params['questionCategoryID'];
    $questionID = $params['questionID'];
} elseif (preg_match('@(?<lang>ru|en)/question/(?<questionID>\d+)/(?<action>query-help|query-run|query-test|rate)@i', $path, $params)) {
    $lang       = $params['lang'];
    $action     = $params['action'];
    $questionID = $params['questionID'];
} elseif (preg_match('@(?<lang>ru|en)/(?<action>donate)@i', $path, $params)) {
    $lang       = $params['lang'];
    $action     = $params['action'];
} elseif (preg_match('@(?<lang>ru|en)/(?<questionCategory>sakila|employee)/(?<questionID>\d+)@i', $path, $params)) {
    $lang       = $params['lang'];
    $action     = 'question';
    $questionCategoryID = $params['questionCategory'] == 'employee' ? 2 : 1;
    $questionID = $params['questionID'];
} else {
    $lang       = isset($pathParts[0]) && $pathParts[0] === 'ru' ? 'ru' : 'en';
    $questionID = $pathParts[2] ?? 1;
    $action     = $pathParts[3] ?? 'question';
    $questionCategoryID = 1;
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
    case 'menu':
        $groupBy = $_GET['group_by'] ?? 'category';
        $questionnire = new Questionnire($dbh, $lang);
        $smarty->assign('Questionnire', $questionnire->get($user->getId()));
        $smarty->assign('Lang', $lang);
        $smarty->assign('GroupBy', $groupBy);
        $template = "menu.tpl";
        break;      
    case 'about':
        $questionnire = new Questionnire($dbh, $lang);
        $smarty->assign('Lang', $lang);
        $smarty->assign('CategoriesCount', $questionnire->getCategoriesCount());
        $smarty->assign('QuestionsCount',  $questionnire->getQuestionsCount());
        $template = "about.tpl";
        break;        
    case 'privacy-policy':
        $smarty->assign('Lang', $lang);
        $template = "privacy_policy.tpl";
        break;
    case 'donate':
        $smarty->assign('Lang', $lang);
        $template = "donate.tpl";
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
            $smarty->assign('QeryBestCost', $question->getBestCost());
        }
        if ($user->logged()) {
            $user->saveQuestionAttempt($questionID, $queryTestResult, $sql);
        }
        if (!$queryTestResult['ok']) header( 'HTTP/1.1 418 BAD REQUEST' );
        $template = "query_test_result.tpl";
        break;
    case 'rate':
        if ($user->logged()) {
            $rate = intval($_REQUEST['rate']);
            $user->saveQuestionRate($questionID, $rate);
        }
        $template = "rate_saved.tpl";
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
        header("location:/$lang/");
        die();
    case 'welcome':
        $questionnire = new Questionnire($dbh, $lang);
        $smarty->assign('Questionnire', $questionnire->get());
        $template = "welcome.tpl";
        break;
    case 'question':
        if ($user->logged()) {
            $user->setPath($path);
            $user->save();
        }
        try {
            $questionnire = new Questionnire($dbh, $lang);
            $question = new Question($dbh, $questionID);
            $smarty->assign('Questionnire', $questionnire->get($user->getId()));
            $questionData = $question->get($questionCategoryID, $lang, $user->getId());
            $smarty->assign('QuestionCategoryID', $questionCategoryID);
            $smarty->assign('Question', $questionData);
            $smarty->assign('NextQuestionId', $question->getNextId($questionCategoryID));
            $smarty->assign('PreviousQuestionId', $question->getPreviousId($questionCategoryID));
            $template = $mobileView ? "m.index.tpl" : "index.tpl";
            $db = $questionData['db_template'];
        } catch(Exception $e) {
            $template = $mobileView ? "m.error.tpl" : "error.tpl";
        }

        break;
    default:
        // stored for back compatibility
        if ($user->logged()) {
            $user->setPath($path);
            $user->save();
        }

        $questionnire = new Questionnire($dbh, $lang);
        $question = new Question($dbh, $questionID);
        $smarty->assign('Questionnire', $questionnire->get($user->getId()));
        $questionData = $question->get($questionCategoryID, $lang, $user->getId());
        $smarty->assign('QuestionCategoryID', $questionData['category_id']);
        $smarty->assign('Question', $questionData);
        $smarty->assign('NextQuestionId', $question->getNextId($questionCategoryID));
        $smarty->assign('PreviousQuestionId', $question->getPreviousId($questionCategoryID));
        $template = $mobileView ? "m.index.tpl" : "index.tpl";
}

if ($lang == 'ru') {
    $smarty->setTemplateDir('./templates/ru');
} else {
    $lang = 'en';
    $smarty->setTemplateDir('./templates/en');
}

$smarty->assign('MobileView', $mobileView);
$smarty->assign('Logged', $user->logged());
$smarty->assign('LoggedAsAdmin', $user->isAdmin());
$smarty->assign('Lang', $lang);
$smarty->assign('DB', $db);
$smarty->assign('QuestionID', $questionID);

$smarty->display($template);