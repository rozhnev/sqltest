<?php
class Question 
{
    private $id;

    private $queryRegexValidator = [];
    private $validResultObject;
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
    public function getHint (string $lang): string {
        $dafaultHint = [
            'en' => 'Try to complete this task without any hints.',
            'ru' => 'Попробуйте выполнить это задание без подсказок.'
        ];
        return $dafaultHint($lang);
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
            $resultObject = json_decode($queryResult);
            if (!$resultObject) {
                return [
                    'ok' => false
                ];
            }
            //check columns count
            if (count($resultObject[0]->headers) !== count($this->validResultObject[0]->headers)) {
                $hints['columnsCount'] = count($this->validResultObject[0]->headers);
                return [
                    'ok' => false,
                    'hints' => $hints
                ];
            }
    
            //check columns order
            $diff = array_udiff($resultObject[0]->headers, $this->validResultObject[0]->headers,
                function ($obj_a, $obj_b) {
                    return strcmp($obj_a->header, $obj_b->header);
                }
            );
            if (count($diff) > 0) {
                $hints['columnsList'] = "`" . implode('`, `',array_column($this->validResultObject[0]->headers, 'header')) . "`";
                return [
                    'ok' => false,
                    'hints' => $hints
                ];
            }
    
            // check rows count 
            if (count($resultObject[0]->data) !== count($this->validResultObject[0]->data)) {
                $hints['rowsCount'] = count($this->validResultObject[0]->data);
                return [
                    'ok' => false,
                    'hints' => $hints
                ];
            }
    
            // check rows order
            foreach ($this->validResultObject[0]->data as $i => $row) {
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