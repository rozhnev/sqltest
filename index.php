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
// print_r($_SERVER);
$path = $_SERVER['PATH_INFO'] ? trim($_SERVER['PATH_INFO'], '/') : 'ru/sakila/1';
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
        $queryResult = runQuery($query, 'text');
        $smarty->assign('QeryResult', $queryResult);
        $template = "query_result.tpl";
        break;
    case 'query-test':
        require_once("query_test/$questionID.php");
        $query = $_POST["query"] ?? '';
        $jsonResult = runQuery($query, 'json');
        // echo $jsonResult;
        $smarty->assign('QeryTestResult', testQueryResult($jsonResult));
        $template = "query_test_result.tpl";
        break;
    default:
        $template = "index.tpl";
}

$smarty->display($template);