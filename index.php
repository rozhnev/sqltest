<?php
require 'vendor/autoload.php';
$smarty = new Smarty();
$db     = new DB();
$dbh    = $db->getInstance();

$path = isset($_SERVER['PATH_INFO']) ? trim($_SERVER['PATH_INFO'], '/') : trim($_SERVER['PHP_SELF'], '/');
$pathParts = explode('/', $path);

$lang       = $pathParts[0] ?? 'en';
$db         = $pathParts[1] ?? 'about';
$questionID = $pathParts[2] ?? '1';
$action     = $pathParts[3] ?? '';

switch ($action) {
    case 'query-help':
        $question = new Question($questionID);
        $smarty->assign('Hint', $question->getHint($lang));
        $template = "../hint.tpl";
        break;
    case 'query-run':
        $sql = $_POST["query"] ?? '';
        if (empty($sql)) {
            $template = "empty_query_result.tpl";
            break;
        }
        $query = new Query($sql);
        $smarty->assign('QeryResult', $query->getResult('mysql80_sakila', 'json'));
        $template = "query_result.tpl";
        break;
    case 'query-test':
        $sql = $_POST["query"] ?? '';
        $question = new Question($questionID);
        $queryTestResult = $question->checkQuery($sql);
        $smarty->assign('QeryTestResult', $queryTestResult);
        if ($queryTestResult['ok']) {
            $query = new Query($sql);
            $jsonResult = $query->getResult('mysql80_sakila', 'json');
            $smarty->assign('QeryTestResult', $question->checkQueryResult($jsonResult));
        }

        $template = "query_test_result.tpl";
        break;
    default:
        $questionnire = new Questionnire($lang);
        $question = new Question($questionID);
        $smarty->assign('PreviousQuestionId', $question->getPreviousId());
        $smarty->assign('NextQuestionId', $question->getNextId());
        $smarty->assign('Questionnire', $questionnire->get());
        $template = "index.tpl";
}

if ($lang == 'ru') {
    $smarty->setTemplateDir('./templates/ru');
} else {
    $lang = 'en';
    $smarty->setTemplateDir('./templates/en');
}
$smarty->assign('Lang', $lang);
$smarty->assign('DB', $db);
$smarty->assign('QuestionID', $questionID);

$smarty->display($template);