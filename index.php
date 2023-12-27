<?php
require 'vendor/autoload.php';
$smarty = new Smarty();

$lang = 'en';
$question;

function getQueryHash(string $query) : string {
    $ch = curl_init( "https://sqlize.online/hash.php" );
    # Setup request to send json via POST.
    $payload = json_encode( [
        "language" => "sql", 
        "code" => $query, 
        "sql_version" => "mysql80_sakila"
    ]);
    curl_setopt( $ch, CURLOPT_POSTFIELDS, $payload );
    curl_setopt( $ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
    # Return response instead of printing.
    curl_setopt( $ch, CURLOPT_RETURNTRANSFER, true );
    # Send request.
    $result = curl_exec($ch);
    curl_close($ch);
    # Print response.
    return $result;
}

function runQuery(string $query, string $format) : string {
    $queryHash = getQueryHash($query);
    $ch = curl_init( "https://sqlize.online/sqleval.php" );
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, "sqlses=$queryHash&sql_version=mysql80_sakila&format=$format");
    curl_setopt( $ch, CURLOPT_RETURNTRANSFER, true );
    # Send request.
    $result = curl_exec($ch);
    curl_close($ch);
    # Print response.
    return $result;
}

function testQuery(string $queryRegexValidator, string $query) : array {
    if (empty($query)) {
        $hints['emptyQuery'] = true;
        return [
            'ok' => false,
            'hints' => $hints
        ];
    }
    if (empty($queryRegexValidator) || preg_match($queryRegexValidator, $query)) {
        return [
            'ok' => true
        ];
    }

    $hints['wrongQuery'] = true;
    return [
        'ok' => false,
        'hints' => $hints
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
// print_r($_SERVER);

$path = isset($_SERVER['PATH_INFO']) ? trim($_SERVER['PATH_INFO'], '/') : trim($_SERVER['PHP_SELF'], '/');
$pathParts = explode('/', $path);

$lang       = $pathParts[0] ?? 'en';
$db         = $pathParts[1] ?? 'sakila';
$questionID = $pathParts[2] ?? '1';
$action     = $pathParts[3] ?? '';

if ($lang == 'ru') {
    $smarty->setTemplateDir('./templates/ru');
} else {
    $smarty->setTemplateDir('./templates/en');
}

$smarty->assign('Lang', $lang);
$smarty->assign('DB', $db);
$smarty->assign('QuestionID', $questionID);

switch ($action) {
    case 'query-help':
        $template = "query_help/$questionID.tpl";
        break;
    case 'query-run':
        // var_dump($_POST);
        $query = $_POST["query"] ?? '';
        if (empty($query)) {
            $template = "empty_query_result.tpl";
            break;
        }
        $queryResult = runQuery($query, 'json');
        $smarty->assign('QeryResult', $queryResult);
        $template = "query_result.tpl";
        break;
    case 'query-test':
        $queryRegexValidator = '';
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
        $template = "index.tpl";
}

$smarty->display($template);