<?php
$env    = parse_ini_string(file_get_contents(".env"), 1);
if (isset($env['MAINTENANCE'])) {
    include 'templates/maintainance.tpl';
    die();
}

require 'vendor/autoload.php';
$lang   = 'en';
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

$path = isset($_SERVER['PATH_INFO']) ? trim($_SERVER['PATH_INFO'], '/') : trim($_SERVER['PHP_SELF'], '/');
$pathParts = explode('/', $path);
$db         = '';
$questionID = '';
$QuestionnireName = $_COOKIE['Questionnire'] ?? 'category';
$smarty->assign('CanonicalLink', null);
$smarty->registerPlugin("modifier", "mt_rand", "mt_rand");

if ($mobileView) {
    $smarty->assign('CanonicalLink', "https://sqltest.online/{$path}");
}
session_start([
    'cookie_lifetime' => 86400,
    'gc_maxlifetime' => 86400
]);
if (isset($_COOKIE[session_name()])) {
    setcookie(session_name(), $_COOKIE[session_name()], [
        'expires' => time() + 86400,
        'path' => '/',
        'secure' => true,
        'httponly' => true,
        'samesite' => 'Lax'
    ]);
}
if ($_SESSION) {
    $user->loginSession($_SESSION);
}

if (isset($pathParts[0]) && $pathParts[0] === 'login') {
    $action     = 'login';
    $loginProvider = $pathParts[1];
// privacy-policy, logout actions
} elseif (preg_match("@(?<lang>$languge_codes_regexp)/(?<action>privacy-policy|logout|about|menu|books|courses|donate)/\d+@i", $path, $params)) {
    $lang       = $params['lang'];
    $action     = $params['action'];
    header("HTTP/1.1 301 Moved Permanently");
    header("Location: /{$lang}/{$action}");
    exit();
} elseif (preg_match("@(?<lang>$languge_codes_regexp)/(?<action>erd)/(?<db>Sakila|Bookings|AdventureWorks|Employee)\?theme=(?<theme>dark|light)@i", $_SERVER['REQUEST_URI'], $params)) {
    $action     = $params['action'];
    return (new Controller($smarty, $params['lang']))->$action($params);
} elseif (preg_match("@(?<lang>$languge_codes_regexp)/(?<action>privacy-policy|logout|about|menu|books|courses|donate)/?@i", $path, $params)) {
    $lang       = $params['lang'];
    $action     = $params['action'];
} elseif (preg_match("@(?<lang>$languge_codes_regexp)/question/(?<questionCategoryID>\d+)/(?<questionID>\d+)@i", $path, $params)) {
    $lang       = $params['lang'];
    $action     = 'question';
    $questionCategoryID = $params['questionCategoryID'];
    $questionID = $params['questionID'];
    // old URL format - redirect
    $questionnire = new Questionnire($dbh, $lang);
    $redirectLink = $questionnire->getQuestionLink($questionCategoryID, $questionID);
    header("HTTP/1.1 301 Moved Permanently");
    header("Location: $redirectLink");
    exit();
} elseif (preg_match("@(?<lang>$languge_codes_regexp)/question/(?<questionCategory>[a-z-]+)/(?<question>[a-z-]+)@i", $path, $params)) {
    $lang       = $params['lang'];
    $questionnire = new Questionnire($dbh, $lang);
    $action     = 'question';
    $questionCategoryID = $questionnire->getCategoryId($params['questionCategory']);
    $QuestionnireName = $questionnire->getNameByCategory($params['questionCategory']) ?? 'category';
    $questionID = $questionnire->getQuestionId($params['question']);
} elseif (preg_match("@(?<lang>$languge_codes_regexp)/question/(?<questionID>\d+)/(?<action>query-help|query-run|query-test|rate|solutions|check-answers)@i", $path, $params)) {
    $lang       = $params['lang'];
    $action     = $params['action'];
    $questionID = $params['questionID'];
} elseif (preg_match("@(?<lang>$languge_codes_regexp)/solution/(?<solutionID>\d+)/(?<action>like|dislike|report)@i", $path, $params)) {
    $action     = 'solution_' . $params['action'];
    return (new Controller($smarty, $params['lang']))->$action($dbh, $user, $params);
} elseif (preg_match("@(?<lang>$languge_codes_regexp)/(?<action>donate)@i", $path, $params)) {
    $lang       = $params['lang'];
    $action     = $params['action'];
} elseif (preg_match("@(?<lang>$languge_codes_regexp)/test/start@i", $path, $params)) {
    $lang       = $params['lang'];
    $action     = 'test_start';
} elseif (preg_match("@(?<lang>$languge_codes_regexp)/test/create@i", $path, $params)) {
    $lang       = $params['lang'];
    $action     = 'test_create';
} elseif (preg_match("@(?<lang>$languge_codes_regexp)/test/(?<testId>[a-z0-9-]+)/grade@i", $path, $params)) {
    $lang       = $params['lang'];
    $action     = 'user_grade';
    $testId = $params['testId'];    
} elseif (preg_match("@(?<lang>$languge_codes_regexp)/test/(?<testId>[a-z0-9-]+)/result@i", $path, $params)) {
    $lang       = $params['lang'];
    $action     = 'test_result';
    $testId = $params['testId'];
} elseif (preg_match("@(?<lang>$languge_codes_regexp)/test/(?<testId>[a-z0-9-]+)/check/(?<questionID>\d+)@i", $path, $params)) {
    // MUST BE BEFORE test action
    $lang       = $params['lang'];
    $action     = 'test-check';
    $testId = $params['testId'];
    $questionID = $params['questionID'];
} elseif (preg_match("@(?<lang>$languge_codes_regexp)/test/(?<testId>[a-z0-9-]+)/?(?<questionID>\d+)?@i", $path, $params)) {
    $lang       = $params['lang'];
    $action     = 'test';
    $testId = $params['testId'];
    $questionID = $params['questionID'] ?? 0;
} elseif (
    preg_match("@(?<lang>$languge_codes_regexp)/question/(?<questionCategory>sakila|employee)/(?<questionID>\d+)@i", $path, $params) ||
    preg_match("@(?<lang>$languge_codes_regexp)/(?<questionCategory>sakila|employee)/(?<questionID>\d+)@i", $path, $params)
) {
    $lang       = $params['lang'];
    $action     = 'question';
    $questionCategoryID = $params['questionCategory'] == 'employee' ? 2 : 1;
    $questionID = $params['questionID'];
    // old URL format - redirect
    $questionnire = new Questionnire($dbh, $lang);
    $redirectLink = $questionnire->getQuestionLink($questionCategoryID, $questionID);
    header("HTTP/1.1 301 Moved Permanently");
    header("Location: $redirectLink");
    exit();
} elseif (preg_match('@sitemap@i', $path, $params)) {
    $action     = 'sitemap';
} elseif (preg_match('@robots@i', $path, $params)) {
    include 'robots.txt';
    die();
} else {
    if (isset($pathParts[0]) && in_array($pathParts[0], $languge_codes)) {
        $lang = $pathParts[0];
    } else {
        $lang = Helper::getUserOSLanguage($_SERVER);
    }
    $questionID = $pathParts[2] ?? 1;
    $action     = $pathParts[3] ?? 'question';
    $questionCategoryID = 1;
}

if (!in_array($lang, $languge_codes)) {
    $lang = 'en';
}

switch ($action) {
    case 'login':
        $user->login($loginProvider, $_REQUEST);
        $_SESSION["user_id"] = $user->getId();
        $_SESSION["admin"] = $user->isAdmin();
        //TODO: last path should be restored on login
        $template = "login_result.tpl";
        break;
    case 'menu':
        $QuestionnireName = $_GET['questionnire'] ?? 'category';
        setcookie("Questionnire", $QuestionnireName, time() + 86400 * 365, "/" );
        $questionnire = new Questionnire($dbh, $lang);
        $smarty->assign('Questionnire', $questionnire->get($QuestionnireName, $user->getId()));
        $smarty->assign('Lang', $lang);
        // var_dump($questionnire->get($QuestionnireName, $user->getId()));
        $template = "menu.tpl";
        break;
    case 'sitemap':
        header('Content-Type: application/xml');

        $questionnire = new Questionnire($dbh, $lang);
        $smarty->assign("Today", date('Y-m-d'));
        $smarty->assign("Questionnire", $questionnire->getMap());
        $template = "../sitemap.tpl";
        break;  
    case 'about':
        $questionnire = new Questionnire($dbh, $lang);
        $smarty->assign('Lang', $lang);
        $smarty->assign('CategoriesCount', $questionnire->getCategoriesCount());
        $smarty->assign('QuestionsCount',  $questionnire->getQuestionsCount());
        //$smarty->assign('QuestionnaireCategoriesLinks',  $questionnire->getQuestionnaireCategoriesLinks(3));

        $smarty->registerPlugin("modifier", "floor", "floor");
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
        $question = new Question($dbh, $questionID);
        $queryPreCheck = $question->getQueryPreCheck();
        $query = new Query($queryPreCheck . $sql);

        $smarty->assign('QeryResult', $query->getResult($question->getDB(), 'json'));
        $template = "query_result.tpl";
        break;
    case 'query-test':
        $sql = $_POST["query"] ?? '';
        $question = new Question($dbh, $questionID);
        $queryTestResult = $question->checkQuery($sql);
        $smarty->assign('QueryTestResult', $queryTestResult);
        if ($queryTestResult['ok']) {
            $preparedQuery = $question->prepareQuery($sql);
            $query = new Query($preparedQuery);
            $jsonResult = $query->getResult($question->getDB(), 'json');
            $queryTestResult = $question->checkQueryResult($jsonResult);
            $smarty->assign('QueryTestResult', $queryTestResult);
            $smarty->assign('QueryBestCost', $question->getBestCost());
        }
        if ($user->logged()) {
            $user->saveQuestionAttempt($questionID, $queryTestResult, $sql);
            if ($queryTestResult['ok']) {
                $user->saveSolution($questionID, $queryTestResult, $sql);
            }
        }
        if (!$queryTestResult['ok']) header( 'HTTP/1.1 418 BAD REQUEST' );
        if ($user->show_ad) {
            $smarty->assign('ReferralLink', Helper::getReferralLink($dbh, $lang, $mobileView ? 'mobile' : 'desktop'));
        }
        $template = "$lang/query_test_result.tpl";
        break;
    case 'check-answers':
        $answers = $_POST["answers"] ?? '[]';
        $question = new Question($dbh, $questionID);
        $answerResult = $question->checkAnswers($answers);
        $smarty->assign('AnswerResult', $answerResult);
        if ($user->logged()) {
            $user->saveQuestionAttempt($questionID, $answerResult, $answers);
        }
        if (!$answerResult['ok']) header( 'HTTP/1.1 418 BAD REQUEST' );
        if ($user->show_ad) {
            $smarty->assign('ReferralLink', Helper::getReferralLink($dbh, $lang, $mobileView ? 'mobile' : 'desktop'));
        }
        $template = "$lang/check_answer_result.tpl";
        break;
    case 'rate':
        if ($user->logged()) {
            $rate = intval($_REQUEST['rate']);
            $smarty->assign('Saved', $user->saveQuestionRate($questionID, $rate));
        }
        $template = "rate_saved.tpl";
        break;
    case 'solutions':
        if ($user->logged()) {
            $questionSolved = $user->solvedQuestion($questionID);
            $smarty->assign('QuestionSolved', $questionSolved);
            if ($questionSolved) {
                $question = new Question($dbh, $questionID);
                $smarty->assign('QuestionSolutions', $question->getSolutions());
            }
        }
        $template = "solutions.tpl";
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
    case 'test_start':
        if ($user->logged()) {
            $userLastTest = $user->getLastTest();
            $smarty->assign('LastTest', $userLastTest);
        }
        $template = "test_start.tpl";
        break;
    case 'test_create':
        if (!$user->logged()) {
            header("Location: /$lang/test/start");
            exit();
        }
        $test = new Test($dbh, $lang, $user);

        $userTestId = $test->create();
        header("Location: /$lang/test/$userTestId");
        exit();
    case 'user_grade':
        if (!$user->logged()) {
            header("Location: /$lang/test/start");
            exit();
        }
        $test = new Test($dbh, $lang, $user);
        $test->setId($testId);
        if(!$test->belongsToUser($user)) {
            header("HTTP/1.1 404 Moved Permanently");
            $smarty->assign('ErrorMessage', 'You are not permiited to do this action.');
            $template = "error.tpl";
            break;
        }
        $testResult = $test->calculateResult();
        if ($testResult['ok']) {
            $user->saveGrade($testResult['grade']);
        }
        $smarty->assign('TestResult', $testResult);
        $template = "user_grade.tpl";
        break;
    case 'test_result':
        if (!$user->logged()) {
            header("Location: /$lang/test/start");
            exit();
        }
        $test = new Test($dbh, $lang, $user);
        $test->setId($testId);
        if(!$test->belongsToUser($user)) {
            header("HTTP/1.1 404 Moved Permanently");
            $smarty->assign('ErrorMessage', 'You are not permiited to do this action.');
            $template = "error.tpl";
            break;
        }
        $testData = $test->getData();
        $testEnd   = new DateTime($testData['closed_at']);
        $testEnd -> add(new DateInterval('P1M0D'));
        $testData['next_test_in'] = $testEnd->diff(new DateTime())->days;

        $testResult = $test->calculateResult();
        $smarty->assign('TestData', $testData);
        $smarty->assign('TestResult', $testResult);

        $template = "test_result.tpl";
        break;
    case 'test':
        if (!$user->logged()) {
            header("Location: /$lang/test/start");
            exit();
        }
        $test = new Test($dbh, $lang, $user);
        $test->setId($testId);
        if(!$test->belongsToUser($user)) {
            header("HTTP/1.1 404 Moved Permanently");
            $smarty->assign('ErrorMessage', 'You are not permiited to do this action.');
            $template = "error.tpl";
            break;
        }
        if (!$questionID) $questionID = $test->getFirstUnsolvedQuestionId();

        $question = new Question($dbh, $questionID);

        $questionData = $test->getQuestionData($questionID);
        $questionCategoryID = $questionData['category_id'];
        if ($questionData['have_answers']) {
            $questionData['answers'] = $question->getAnswers($questionCategoryID, $lang, $user->getId());
            $questionData['last_query'] = json_decode($questionData['last_query']??'[]', true);
        }
        $smarty->assign('TestData', $test->getData());
        $smarty->assign('TestId', $testId);
        $smarty->assign('Question', $questionData);
        $smarty->assign('NextQuestionId', $questionData['next_question_id']);
        $smarty->assign('PreviousQuestionId', $questionData['previous_question_id']);
        $smarty->assign('QuestionCategoryID', $questionCategoryID);
        $db = $questionData['db_template'];
        $smarty->assign('DBMS', $questionData['dbms']);
        $smarty->assign('Questionnire', $test->getQuestionnire());
        $template = "test.tpl";
        break;
    case 'test-check':
        if (!$user->logged()) {
            header("Location: /$lang/test/start");
            exit();
        }
        $test = new Test($dbh, $lang, $user);
        $test->setId($testId);
        $smarty->assign('TestId', $testId);
        if(!$test->belongsToUser($user)) {
            header("HTTP/1.1 404 Moved Permanently");
            $smarty->assign('ErrorMessage', 'You are not permiited to do this action.');
            $template = "error.tpl";
            break;
        }
        $template = "check_test_solution.tpl";

        $attemptStatus = $test->getQuestionAttemptStatus($questionID);
        if (!$attemptStatus['ok']) {
            $smarty->assign('QueryTestResult', $attemptStatus);
            break;
        }

        $question = new Question($dbh, $questionID);

        if (isset($_POST["query"])) {
            $sql = $_POST["query"] ?? '';
            $checkResult = $question->checkQuery($sql);
            $smarty->assign('QueryTestResult', $checkResult);
            if ($checkResult['ok']) {
                $preparedQuery = $question->prepareQuery($sql);
                $query = new Query($preparedQuery);
                $jsonResult = $query->getResult($question->getDB(), 'json');
                $checkResult = $question->checkQueryResult($jsonResult);
                $smarty->assign('QueryTestResult', $checkResult);
                $smarty->assign('QueryBestCost', $question->getBestCost());
            }
            $test->saveQuestionAttempt($questionID, $checkResult, $sql);
        }

        if (isset($_POST["answers"])) {
            $answers = $_POST["answers"] ?? '[]';

            $question = new Question($dbh, $questionID);
            $checkResult = $question->checkAnswers($answers);
            $smarty->assign('QueryTestResult', $checkResult);
            $test->saveQuestionAttempt($questionID, $checkResult, $answers);
        }

        if (!$checkResult['ok']) header( 'HTTP/1.1 418 BAD REQUEST' );     
        break;
    case 'question':
        try {
            $questionnire = new Questionnire($dbh, $lang);
            $question = new Question($dbh, $questionID);
            $smarty->assign('QuestionsCount',  $questionnire->getQuestionsCount());
            $smarty->assign('SolvedQuestionsCount',  $user->logged() ? $user->getSolvedQuestionsCount() : 0);
            if ($user->logged()) {
                $user->setPath($path);
                $user->save();
            }
            $smarty->assign('Questionnire', $questionnire->get($QuestionnireName, $user->getId()));
            $questionData = $question->get($questionCategoryID, $lang, $user->getId());
            if ($questionData['have_answers']) {
                $questionData['answers'] = $question->getAnswers($questionCategoryID, $lang, $user->getId());
                $questionData['last_query'] = json_decode($questionData['last_query']??'[]', true);
            }
            $smarty->assign('QuestionCategoryID', $questionCategoryID);
            $smarty->assign('Question', $questionData);
            $smarty->assign('DBMS', $questionData['dbms']);
            $smarty->assign('NextQuestionId', $question->getNextSefId($questionCategoryID));
            $smarty->assign('PreviousQuestionId', $question->getPreviousSefId($questionCategoryID));
            $smarty->assign('Book', Helper::getBook($dbh, $lang, $questionData['dbms']));

            $smarty->registerPlugin("modifier", "floor", "floor");
            $smarty->registerPlugin("modifier", "in_array", "in_array");
            $template = $mobileView ? "m.index.tpl" : "index.tpl";
            $db = $questionData['db_template'];
        } catch(Exception $e) {
            $template = $mobileView ? "m.error.tpl" : "error.tpl";
        }

        break;
    case 'books':
        $smarty->assign('Books', Helper::getBooks($dbh, $lang));
        $template = "books.tpl";
        break;
    default:
        // stored for back compatibility
        if ($user->logged()) {
            $user->setPath($path);
            $user->save();
        }

        $questionnire = new Questionnire($dbh, $lang);
        $question = new Question($dbh, $questionID);
        $smarty->assign('Questionnire', $questionnire->get($QuestionnireName, $user->getId()));
        $questionData = $question->get($questionCategoryID, $lang, $user->getId());
        $smarty->assign('QuestionCategoryID', $questionData['category_id']);
        $smarty->assign('Question', $questionData);
        $smarty->assign('NextQuestionId', $question->getNextSefId($questionCategoryID));
        $smarty->assign('PreviousQuestionId', $question->getPreviousSefId($questionCategoryID));
        $smarty->registerPlugin("modifier", "floor", "floor");
        $smarty->registerPlugin("modifier", "in_array", "in_array");
        $template = $mobileView ? "m.index.tpl" : "index.tpl";
}

Localizer::init($lang);
$smarty->registerPlugin("modifier", "array_key_exists", "array_key_exists");
$smarty->registerPlugin('block', 'translate', array('Localizer', 'translate'), true);

$smarty->assign('VERSION', $env['VERSION'] ?? 0);
$smarty->assign('MobileView', $mobileView);
$smarty->assign('Action', $action);
$smarty->assign('User', $user);
$smarty->assign('LoggedAsAdmin', $user->isAdmin());
$smarty->assign('Lang', $lang);
$smarty->assign('Languages', $languages);
$smarty->assign('DB', $db);
$smarty->assign('QuestionID', $questionID);

$smarty->display($template);