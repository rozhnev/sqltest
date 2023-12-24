<?php
require 'vendor/autoload.php';
$smarty = new Smarty();

$lang = 'en';
$question;

function getQueryHash(str $query, str $format) : str {
    return '';
}

function runQuery(str $query, str $format) : str {
    $queryHash = getQueryHash($query);
    return '';
}

switch ($action) {
    case 'query-help':
        $template = "$lang/query_help/$question.tpl";
        break;
    case 'query-run':
        $json_result = runQuery($query, 'text');
        $template = "$lang/query_result.tpl";
        break;
    case 'query-test':
        require_once("query_test/$question.php");
        $json_result = runQuery($query, 'json');
        test_result($json_result);
        $template = "$lang/query_test_result.tpl";
        break;
    default:
       $template = "$lang/index.tpl";
}

$smarty->display($template);