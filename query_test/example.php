<?php
$valid_json_result = 'Query result in JSON format';


function test_result(str $json_result) : boolval {
    return json_decode($obj1) == json_decode($valid_json_result);
}
