<?php
class Question 
{
    private $id;

    private $queryRegexValidator = [];

    private $validJsonResult;

    public function __construct(string $id)
    {
        require_once("query_test/$id.php");
        $this->id = $id;
        $this->queryRegexValidator = $queryRegexValidator ?? [];
        $this->validResultObject = json_decode($validJsonResult);

    }
    public function getDBTemplate (): string {
        return 'sakila';
    }
    public function getHint (): string {
        return 'sakila';
    }
    public function getPreviousId (): string {
        return '1';
    }
    public function getNextId (): string {
        return '3';
    }
    public function checkQuery(string $query)
    {
        if (empty($query)) {
            $hints['emptyQuery'] = true;
            return [
                'ok' => false,
                'hints' => $hints
            ];
        }
        if (
            (isset($this->queryRegexValidator['queryMatch']) && !preg_match($this->queryRegexValidator['queryMatch'], $query)) ||
            (isset($this->queryRegexValidator['queryNotMatch']) && preg_match($this->queryRegexValidator['queryNotMatch'], $query))
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

    public function checkQueryResult(string $queryResult)
    {
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
}