<?php
require 'vendor/autoload.php';
$smarty = new Smarty();
$db     = new DB();
$dbh    = $db->getInstance();

$question;

function testQuery(array $queryRegexValidator, string $query) : array {
    if (empty($query)) {
        $hints['emptyQuery'] = true;
        return [
            'ok' => false,
            'hints' => $hints
        ];
    }
    if (
        (isset($queryRegexValidator['queryMatch']) && !preg_match($queryRegexValidator['queryMatch'], $query)) ||
        (isset($queryRegexValidator['queryNotMatch']) && preg_match($queryRegexValidator['queryNotMatch'], $query))
    ) {
        $hints['wrongQuery'] = true;
        return [
            'ok' => false,
            'hints' => $hints
        ];
    }
    return [
        'ok' => true
    ];
}

function queryTestResult(string $validJsonResult, string $jsonResult) : array {
    try {
        $resultObject = json_decode($jsonResult);
        if (!$resultObject) {
            return [
                'ok' => false
            ];
        }
        $validResultObject = json_decode($validJsonResult);
        // $result = $resultObject == $validResultObject;
        // $hints = [];
        // if (!$result) {
        // }
        //check columns count
        if (count($resultObject[0]->headers) !== count($validResultObject[0]->headers)) {
            $hints['columnsCount'] = count($validResultObject[0]->headers);
            return [
                'ok' => false,
                'hints' => $hints
            ];
        }

        //check columns order
        $diff = array_udiff($resultObject[0]->headers, $validResultObject[0]->headers,
            function ($obj_a, $obj_b) {
                return strcmp($obj_a->header, $obj_b->header);
            }
        );
        if (count($diff) > 0) {
            $hints['columnsList'] = "`" . implode('`, `',array_column($validResultObject[0]->headers, 'header')) . "`";
            return [
                'ok' => false,
                'hints' => $hints
            ];
        }

        // check rows count 
        if (count($resultObject[0]->data) !== count($validResultObject[0]->data)) {
            $hints['rowsCount'] = count($validResultObject[0]->data);
            return [
                'ok' => false,
                'hints' => $hints
            ];
        }

        // check rows order
        foreach ($validResultObject[0]->data as $i => $row) {
            if ($row !== $resultObject[0]->data[$i]) {
                $hints['rowsData'] = ['rowNumber' => $i + 1, 'rowData' => "'" . implode("', '", $row) . "'" ];
                return [
                    'ok' => false,
                    'hints' => $hints
                ];
            }
        }
        return [
            'ok' => true
        ];
    } catch(Exception $e) {
        // var_dump($e);
        return [
            'ok' => false
        ];
    }
}

$path = isset($_SERVER['PATH_INFO']) ? trim($_SERVER['PATH_INFO'], '/') : trim($_SERVER['PHP_SELF'], '/');
$pathParts = explode('/', $path);

$lang       = $pathParts[0] ?? 'en';
$db         = $pathParts[1] ?? 'about';
$questionID = $pathParts[2] ?? '1';
$action     = $pathParts[3] ?? '';

if ($lang == 'ru') {
    $smarty->setTemplateDir('./templates/ru');
} else {
    $lang = 'en';
    $smarty->setTemplateDir('./templates/en');
}
$questionnire = new Questionnire($lang);

$smarty->assign('Lang', $lang);
$smarty->assign('DB', $db);
$smarty->assign('QuestionID', $questionID);

switch ($action) {
    case 'query-help':
        $template = file_exists("templates/$lang/query_help/$questionID.tpl") 
            ? "query_help/$questionID.tpl" 
            : "query_help/default.tpl";
        break;
    case 'query-run':
        // var_dump($_POST);
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
        $queryRegexValidator = [];
        require_once("query_test/$questionID.php");
        $query = $_POST["query"] ?? '';

        $queryTestResult = testQuery($queryRegexValidator, $query);
        $smarty->assign('QeryTestResult', $queryTestResult);
        if ($queryTestResult['ok']) {
            $jsonResult = runQuery($query, 'json');
            // echo $jsonResult;
            $smarty->assign('QeryTestResult', queryTestResult($validJsonResult, $jsonResult));
        }

        $template = "query_test_result.tpl";
        break;
    default:
        $smarty->assign('Questionnire', $questionnire->get());
        $template = "index.tpl";
}

$smarty->display($template);