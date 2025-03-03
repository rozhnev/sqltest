<?php
class Router 
{
    private $controller;

    private $routes = [
        'static-page' => "@(?<lang>ru|en|pt)/(?<action>privacy-policy|logout|about|menu|books|courses|donate)/?@i"
        /*'login' => [
            'pattern' => "@^(?<lang>$languge_codes_regexp)/login/(?<loginProvider>[a-z]+)$@i",
            'handler' => function ($params) use ($user, &$template) {
                $user->login($params['loginProvider'], $_REQUEST);
                $_SESSION["user_id"] = $user->getId();
                $_SESSION["admin"] = $user->isAdmin();
                $template = "login_result.tpl";
            },
        ],
        'privacy-policy' => [
            'pattern' => "@(?<lang>$languge_codes_regexp)/(?<action>privacy-policy|logout|about|menu|books|courses|donate)/?@i",
            'handler' => function ($params) use ($smarty, &$lang, &$template) {
                $lang = $params['lang'];
                $template = "{$params['action']}.tpl";
            },
        ],
        'erd' => [
            'pattern' => "@(?<lang>$languge_codes_regexp)/(?<action>erd)/(?<db>Sakila|Bookings|AdventureWorks|Employee)\?theme=(?<theme>dark|light)@i",
            'handler' => function ($params) use ($smarty, &$lang) {
                $lang = $params['lang'];
                return (new Controller($smarty, $lang))->{$params['action']}($params);
            },
        ],
        'question_category_id' => [
            'pattern' => "@(?<lang>$languge_codes_regexp)/question/(?<questionCategoryID>\d+)/(?<questionID>\d+)@i",
            'handler' => function ($params) use ($dbh, &$lang) {
                $lang = $params['lang'];
                $questionnire = new Questionnire($dbh, $lang);
                $redirectLink = $questionnire->getQuestionLink($params['questionCategoryID'], $params['questionID']);
                header("HTTP/1.1 301 Moved Permanently");
                header("Location: $redirectLink");
                exit();
            },
        ],
        'question_category_name' => [
            'pattern' => "@(?<lang>$languge_codes_regexp)/question/(?<questionCategory>[a-z-]+)/(?<question>[a-z-]+)@i",
            'handler' => function ($params) use ($dbh, &$lang, &$QuestionnireName, &$questionCategoryID, &$questionID) {
                $lang = $params['lang'];
                $questionnire = new Questionnire($dbh, $lang);
                $questionCategoryID = $questionnire->getCategoryId($params['questionCategory']);
                $QuestionnireName = $questionnire->getNameByCategory($params['questionCategory']) ?? 'category';
                $questionID = $questionnire->getQuestionId($params['question']);
            },
        ],
        'question_actions' => [
            'pattern' => "@(?<lang>$languge_codes_regexp)/question/(?<questionID>\d+)/(?<action>query-help|query-run|query-test|rate|check-answers)@i",
            'handler' => function ($params) use (&$lang, &$questionID) {
                $lang = $params['lang'];
                $questionID = $params['questionID'];
            },
        ],
        'question_favorite' => [
            'pattern' => "@(?<lang>$languge_codes_regexp)/question/(?<questionID>\d+)/(?<action>favorite)@i",
            'handler' => function ($params) use ($smarty, &$lang, $dbh, $user) {
                $action = 'question_' . $params['action'];
                return (new Controller($smarty, $lang))->$action($dbh, $user, $params);
            },
        ],
        'question_solutions' => [
            'pattern' => "@(?<lang>$languge_codes_regexp)/question/(?<questionID>\d+)/(?<action>solutions|my-solutions)@i",
            'handler' => function ($params) use ($smarty, &$lang, $dbh, $user) {
                $action = str_replace('-', '_', strtolower($params['action']));
                return (new Controller($smarty, $lang))->$action($dbh, $user, $params);
            },
        ],
        'solution_actions' => [
            'pattern' => "@(?<lang>$languge_codes_regexp)/solution/(?<solutionID>\d+)/(?<action>like|unlike|report|delete)@i",
            'handler' => function ($params) use ($smarty, &$lang, $dbh, $user) {
                $action = 'solution_' . $params['action'];
                return (new Controller($smarty, $lang))->$action($dbh, $user, $params);
            },
        ],
        'donate' => [
            'pattern' => "@(?<lang>$languge_codes_regexp)/(?<action>donate)@i",
            'handler' => function ($params) use (&$lang) {
                $lang = $params['lang'];
            },
        ],
        'test_start' => [
            'pattern' => "@(?<lang>$languge_codes_regexp)/test/start@i",
            'handler' => function (&$lang) {
            },
        ],
        'test_create' => [
            'pattern' => "@(?<lang>$languge_codes_regexp)/test/create@i",
            'handler' => function ($params) use ($user, $lang, $dbh) {
                if (!$user->logged()) {
                    header("Location: /$lang/test/start");
                    exit();
                }
                $test = new Test($dbh, $lang, $user);
                $userTestId = $test->create();
                header("Location: /$lang/test/$userTestId");
                exit();
            },
        ],
        'test_grade' => [
            'pattern' => "@(?<lang>$languge_codes_regexp)/test/(?<testId>[a-z0-9-]+)/grade@i",
            'handler' => function ($params) use ($smarty, &$lang, $dbh, $user, &$template) {
                $lang = $params['lang'];
                $test = new Test($dbh, $lang, $user);
                $test->setId($params['testId']);
                if (!$test->belongsToUser($user)) {
                    header("HTTP/1.1 404 Moved Permanently");
                    $smarty->assign('ErrorMessage', 'You are not permiited to do this action.');
                    $template = "error.tpl";
                    return;
                }
                $testResult = $test->calculateResult();
                if ($testResult['ok']) {
                    $user->saveGrade($testResult['grade']);
                }
                $smarty->assign('TestResult', $testResult);
                $template = "user_grade.tpl";
            },
        ],
        'test_result' => [
            'pattern' => "@(?<lang>$languge_codes_regexp)/test/(?<testId>[a-z0-9-]+)/result@i",
            'handler' => function ($params) use ($smarty, &$lang, $dbh, $user, &$template) {
                $lang = $params['lang'];
                $test = new Test($dbh, $lang, $user);
                $test->setId($params['testId']);
                if (!$test->belongsToUser($user)) {
                    header("HTTP/1.1 404 Moved Permanently");
                    $smarty->assign('ErrorMessage', 'You are not permiited to do this action.');
                    $template = "error.tpl";
                    return;
                }
                $testData = $test->getData();
                $testEnd = new DateTime($testData['closed_at']);
                $testEnd->add(new DateInterval('P1M0D'));
                $testData['next_test_in'] = $testEnd->diff(new DateTime())->days;
    
                $testResult = $test->calculateResult();
                $smarty->assign('TestData', $testData);
                $smarty->assign('TestResult', $testResult);
    
                $template = "test_result.tpl";
            },
        ],
        'test_check' => [
            'pattern' => "@(?<lang>$languge_codes_regexp)/test/(?<testId>[a-z0-9-]+)/check/(?<questionID>\d+)@i",
            'handler' => function ($params) use ($smarty, &$lang, $dbh, $user, &$template) {
                $lang = $params['lang'];
                $test = new Test($dbh, $lang, $user);
                $test->setId($params['testId']);
                $smarty->assign('TestId', $params['testId']);
                if (!$test->belongsToUser($user)) {
                    header("HTTP/1.1 404 Moved Permanently");
                    $smarty->assign('ErrorMessage', 'You are not permiited to do this action.');
                    $template = "error.tpl";
                    return;
                }
                $template = "check_test_solution.tpl";
    
                $attemptStatus = $test->getQuestionAttemptStatus($params['questionID']);
                if (!$attemptStatus['ok']) {
                    $smarty->assign('QueryTestResult', $attemptStatus);
                    return;
                }
    
                $question = new Question($dbh, $params['questionID']);
    
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
                    $test->saveQuestionAttempt($params['questionID'], $checkResult, $sql);
                }
    
                if (isset($_POST["answers"])) {
                    $answers = $_POST["answers"] ?? '[]';
    
                    $question = new Question($dbh, $params['questionID']);
                    $checkResult = $question->checkAnswers($answers);
                    $smarty->assign('QueryTestResult', $checkResult);
                    $test->saveQuestionAttempt($params['questionID'], $checkResult, $answers);
                }
    
                if (!$checkResult['ok']) header('HTTP/1.1 418 BAD REQUEST');
            },
        ],
        'test' => [
            'pattern' => "@(?<lang>$languge_codes_regexp)/test/(?<testId>[a-z0-9-]+)/?(?<questionID>\d+)?@i",
            'handler' => function ($params) use ($smarty, &$lang, $dbh, $user, &$template, &$questionCategoryID, &$db) {
                $lang = $params['lang'];
                $test = new Test($dbh, $lang, $user);
                $test->setId($params['testId']);
                if (!$test->belongsToUser($user)) {
                    header("HTTP/1.1 404 Moved Permanently");
                    $smarty->assign('ErrorMessage', 'You are not permiited to do this action.');
                    $template = "error.tpl";
                    return;
                }
                $questionID = $params['questionID'] ?? $test->getFirstUnsolvedQuestionId();
    
                $question = new Question($dbh, $questionID);
    
                $questionData = $test->getQuestionData($questionID);
                $questionCategoryID = $questionData['category_id'];
                if ($questionData['have_answers']) {
                    $questionData['answers'] = $question->getAnswers($questionCategoryID, $lang, $user->getId());
                    $questionData['last_query'] = json_decode($questionData['last_query'] ?? '[]', true);
                }
                $smarty->assign('TestData', $test->getData());
                $smarty->assign('TestId', $params['testId']);
                $smarty->assign('Question', $questionData);
                $smarty->assign('NextQuestionId', $questionData['next_question_id']);
                $smarty->assign('PreviousQuestionId', $questionData['previous_question_id']);
                $smarty->assign('QuestionCategoryID', $questionCategoryID);
                $db = $questionData['db_template'];
                $smarty->assign('DBMS', $questionData['dbms']);
                $smarty->assign('Questionnire', $test->getQuestionnire());
                $template = "test.tpl";
            },
        ],
        'question_category_db' => [
            'pattern' => "@(?<lang>$languge_codes_regexp)/question/(?<questionCategory>sakila|employee)/(?<questionID>\d+)@i",
            'handler' => function ($params) use ($dbh, &$lang) {
                $lang = $params['lang'];
                $questionnire = new Questionnire($dbh, $lang);
                $redirectLink = $questionnire->getQuestionLink($params['questionCategory'] == 'employee' ? 2 : 1, $params['questionID']);
                header("HTTP/1.1 301 Moved Permanently");
                header("Location: $redirectLink");
                exit();
            },
        ],
        'sitemap' => [
            'pattern' => '@sitemap@i',
            'handler' => function ($params) use ($smarty, &$lang, $dbh, &$template) {
                header('Content-Type: application/xml');
    
                $questionnire = new Questionnire($dbh, $lang);
                $smarty->assign("Today", date('Y-m-d'));
                $smarty->assign("Questionnire", $questionnire->getMap());
                $template = "../sitemap.tpl";
            },
        ],
        'robots' => [
            'pattern' => '@robots@i',
            'handler' => function () {
                include 'robots.txt';
                die();
            },
        ],
        'default' => [
            'pattern' => null,
            'handler' => function ($pathParts, &$lang) use ($languge_codes) {
                if (isset($pathParts[0]) && in_array($pathParts[0], $languge_codes)) {
                    $lang = $pathParts[0];
                } else {
                    $lang = Helper::getUserOSLanguage($_SERVER);
                }
            },
        ],*/
    ];
    public function __construct(Controller $controller)
    {
        $this->controller = $controller;
    }
    public function route( string $path)
    {
        $this->controller->setCanonicalLink($path);
        foreach ($this->routes as $route => $pattern) {
        //     // if ($routeName === 'default') {
        //     //     continue;
        //     // }
            if (preg_match($pattern, $path, $params)) {
        //         $action = $routeName;
        //         $lang = $params['action']
                $action     = str_replace('-', '_', strtolower($params['action']));
                
                return $this->controller->{$action}($params);
        //         // if (isset($route['handler'])) {
        //         //     try {
        //         //         $result = $route['handler']($params);
        //         //         if ($result !== null) {
        //         //             return $result;
        //         //         }
        //         //     } catch (Exception $e) {
        //         //         $log->error("Route handler exception: " . $e->getMessage(), ['route' => $routeName, 'params' => $params]);
        //         //         $template = "error.tpl";
        //         //     }
        //         // }
        //         // break;
            }
        }

        return $this->controller->question([
            'questionID' => 1,
            'questionCategoryID' => 1,
            'QuestionnireName' => 'category',
        ]);
    }    
}
?>