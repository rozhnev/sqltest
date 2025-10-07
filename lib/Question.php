<?php
class Question 
{
    /**
     * DB hahdler 
     *
     * @var PDO
     */
    private $dbh;

    /**
     * Question id
     *
     * @var integer
     */
    private $id;

    public function __construct(PDO $dbh, string $id)
    {
        $this->dbh  = $dbh;
        $this->id = (int)$id;
    }
    /**
     * Returns question DB template name
     *
     * @return string
     */
    public function getDBTemplate(): string 
    {
        $stmt = $this->dbh->prepare("SELECT db_template FROM questions WHERE id = ?");
        $stmt->execute([$this->id]);
        return (string)$stmt->fetchColumn();
    }
    /**
     * Returns all question fields from DB
     *
     * @return array
     */
    public function getData(): array 
    {
        $stmt = $this->dbh->prepare("SELECT * FROM questions WHERE id = ?");
        $stmt->execute([$this->id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
    /**
     * Returns question task for provided language
     *
     * @param int $questionCategoryID
     * @param string $lang
     * @return array
     */
    public function get(int $questionCategoryID, string $lang, ?string $userId): array 
    {
        $stmt = $this->dbh->prepare("
            SELECT 
                question_categories.category_id,
                COALESCE(categories.title_sef, 'favorites') category_sef,
                questions.title_sef question_sef,
                question_categories.sequence_position number, 
                questions_localization.title title,
                questions_localization.task task,
                questions_localization.tutorial_link,
                dbms,
                db_template,
                last_attempt_at::date last_attempt_date, 
                solved_at::date solved_date, 
                last_query,
                questions.rate,
                question_rates_localization.rate question_rate,
                (exists (select true from answers where question_id = questions.id)) have_answers,
                (favorites.question_id is not null) favored
            FROM questions 
            JOIN questions_localization on questions_localization.question_id = questions.id AND questions_localization.language =  :lang
            LEFT JOIN question_categories ON question_categories.question_id = questions.id AND question_categories.category_id = :category_id
            LEFT JOIN categories on categories.id = question_categories.category_id
            LEFT JOIN user_questions ON user_questions.question_id = questions.id AND user_questions.user_id = :user_id
            LEFT JOIN question_rates_localization ON questions.rate = question_rates_localization.id AND question_rates_localization.language = :lang
            LEFT JOIN favorites ON favorites.question_id = questions.id AND favorites.user_id = :user_id
            WHERE questions.id = :id");
        $stmt->execute([':category_id' => $questionCategoryID, ':user_id' => $userId, ':id' => $this->id, ':lang' => $lang]);
        $question = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($question) {
            return $question;
        } else {
            throw new Exception('Question not found');
        }
    }
    /**
     * Returns question hint for provided language
     *
     * @param string $lang
     * @return string
     */
    public function getHint(string $lang): string 
    {
        $stmt = $this->dbh->prepare("SELECT hint FROM questions_localization WHERE question_id = :id and language = :lang");
        $stmt->execute([':id' => $this->id, ':lang' => $lang]);
        return (string)$stmt->fetchColumn();
    }
    /**
     * Returns question answers for provided language
     *
     * @param string $lang
     * @return string
     */
    public function getAnswers(int $questionCategoryID, string $lang, ?string $userId): array 
    {
        $stmt = $this->dbh->prepare("
            SELECT id, title AS answer 
            FROM answers 
            JOIN answers_localization ON answers_localization.answer_id = answers.id and answers_localization.language = :lang
            WHERE question_id = :id ");
        $stmt->execute([':id' => $this->id, ':lang' => $lang]);
        $answers = $stmt->fetchAll(PDO::FETCH_ASSOC);

        if ($answers) {
            shuffle($answers);
            return $answers;
        } else {
            throw new Exception('Answers not found');
        }
    }
        /**
     * Returns question answers for provided language
     *
     * @param string $lang
     * @return string
     */
    public function checkAnswers($answers): array 
    {
        $stmt = $this->dbh->prepare("SELECT json_agg(id ORDER BY id) answers FROM answers WHERE question_id = ? and is_valid");
        $stmt->execute([$this->id]);
        $validAnswers = $stmt->fetchColumn();

        if (json_decode($answers) !== json_decode($validAnswers)) {
            return [
                'ok' => false,
                'cost' => 0
            ];
        }
        return [
            'ok' => true,
            'cost' => 0
        ];
    }
    /**
     * Returns question best cost
     *
     * @return float
     */
    public function getBestCost(): float
    {
        $stmt = $this->dbh->prepare("SELECT best_query_cost FROM questions WHERE id = ?");
        $stmt->execute([$this->id]);
        return (float)$stmt->fetchColumn();
    }
    /**
     * Returns question db name
     *
     * @return string
     */
    public function getDB(): string 
    {
        $stmt = $this->dbh->prepare("SELECT db FROM questions WHERE id = ?");
        $stmt->execute([$this->id]);
        return (string)$stmt->fetchColumn();
    }
    /**
     * Returns id of previous question in category
     *
     * @param int $questionCategoryID
     * @return string
     */
    public function getPreviousSefId (int $questionCategoryID): string 
    {
        $stmt = $this->dbh->prepare("
            select 
                title_sef
            from question_categories 
            join questions on questions.id = question_categories.question_id
            where category_id = :category_id and sequence_position < (
                select sequence_position from question_categories where category_id = :category_id and question_id = :question_id
            )
            order by sequence_position desc 
            limit 1;
        ");
        $stmt->execute(['category_id' => $questionCategoryID, ':question_id' => $this->id]);
        return (string)$stmt->fetchColumn();
    }
    /**
     * Returns id of next question in category
     *
     * @param int $questionCategoryID
     * @return string
     */
    public function getNextSefId (int $questionCategoryID): string 
    {
        $stmt = $this->dbh->prepare("
            select 
                title_sef
            from question_categories 
            join questions on questions.id = question_categories.question_id
            where category_id = :category_id and sequence_position > (
                select sequence_position from question_categories where category_id = :category_id and question_id = :question_id
            )
            order by sequence_position asc 
            limit 1;
        ");
        $stmt->execute(['category_id' => $questionCategoryID, ':question_id' => $this->id]);
        return (string)$stmt->fetchColumn();
    }
    /**
     * Returns question query pre-check condition 
     *
     * @return string
     */
    public function getQueryPreCheck(): string {
        $stmt = $this->dbh->prepare("SELECT query_pre_check FROM questions WHERE id = ?");
        $stmt->execute([$this->id]);
        $queryPreCheck = (string)$stmt->fetchColumn();
        if (!empty($queryPreCheck)) {
            $queryPreCheck = trim($queryPreCheck, "\r\n\t ;") . ';' . PHP_EOL ;
        }
        return $queryPreCheck;
    }
    /**
     * Returns question query check condition 
     *
     * @param string $query
     * @return string
     */
    public function getQueryCheck(string $query): string {
        $stmt = $this->dbh->prepare("SELECT query_check FROM questions WHERE id = ?");
        $stmt->execute([$this->id]);
        $queryCheck = (string)$stmt->fetchColumn();
        return str_replace("{{query}}", str_replace("'","''",$query) , $queryCheck);
    }
    /**
     * Returns question prepared query
     * 
     * @param string $query
     * @return string
     */
    public function prepareQuery(string $sql): string {
        $query = new Query($sql);
        $cleanedQuery = $query->cleanComments();
        $preparedQuery = $cleanedQuery;
        $stmt = $this->dbh->prepare("SELECT query_pre_check, query_check FROM questions WHERE id = ?");
        $stmt->execute([$this->id]);
        $conditions = $stmt->fetch(PDO::FETCH_ASSOC);
        // concat query_pre_check if exists
        if (isset($conditions['query_pre_check']) && !empty($conditions['query_pre_check'])) {
            $preparedQuery = $conditions['query_pre_check'] . ';' . PHP_EOL .$preparedQuery;
        }
        // concat query_check if exists
        if (isset($conditions['query_check']) && !empty($conditions['query_check'])) {
            $preparedQuery = $preparedQuery . PHP_EOL . ';' . PHP_EOL . str_replace("{{query}}", str_replace("'","''", $cleanedQuery) , $conditions['query_check']);
        }
        return $preparedQuery;
    }
    /**
     * Check query using regular expressions
     *
     * @param string $query
     * @return array
     */
    public function checkQuery(string $query)
    {
        $queryClass = new Query($query);
        $cleanedQuery = $queryClass->cleanComments($query);

        if (empty($cleanedQuery)) {
            $hints['emptyQuery'] = true;
            return [
                'ok' => false,
                'cost' => 0,
                'hints' => $hints
            ];
        }
        $stmt = $this->dbh->prepare("SELECT query_match, query_not_match FROM questions WHERE id = ?");
        $stmt->execute([$this->id]);
        $questionData = $stmt->fetch(PDO::FETCH_ASSOC);

        if (
            (isset($questionData['query_match']) && !preg_match($questionData['query_match'], $cleanedQuery)) ||
            (isset($questionData['query_not_match']) && preg_match($questionData['query_not_match'], $cleanedQuery))
        ) {
            $hints['wrongQuery'] = true;
            return [
                'ok' => false,
                'cost' => 0,
                'hints' => $hints
            ];
        }
        return [
            'ok' => true,
            'cost' => 0
        ];
    }

    private function evaluateValidResult(string $input): string
    {
        $regex = '@<\?php([^?]+)\?>@';
        return preg_replace_callback($regex, function($code) { eval("\$evaluated = $code[1];"); return $evaluated; }, $input);    
    }

    public function checkQueryResult(string $queryResult)
    {
        
        $stmt = $this->dbh->prepare("SELECT query_valid_result, pre_check_sort FROM questions WHERE id = ?");
        $stmt->execute([$this->id]);
        $questionData = $stmt->fetch(PDO::FETCH_ASSOC);
        $evaluatedResult = $this->evaluateValidResult($questionData['query_valid_result']);
        $queryValidResult = json_decode($evaluatedResult)[0];
        try {
            $resultObject = json_decode($queryResult);
            if (!$resultObject) {
                return [
                    'ok' => false,
                    'cost' => 0
                ];
            }
            if (isset($resultObject[0]->error)) {
                $hints['queryError'] = $resultObject[0]->error;
                return [
                    'ok' => false,
                    'cost' => 0,
                    'hints' => $hints
                ];
            }
            //check columns count
            if (count($resultObject[0]->headers) !== count($queryValidResult->headers)) {
                $hints['columnsCount'] = count($queryValidResult->headers);
                return [
                    'ok' => false,
                    'cost' => 0,
                    'hints' => $hints
                ];
            }
    
            //check columns order
            $diff = array_udiff($resultObject[0]->headers, $queryValidResult->headers,
                function ($obj_a, $obj_b) {
                    return strcmp($obj_a->header, $obj_b->header);
                }
            );
            if (count($diff) > 0) {
                $hints['columnsList'] = '<span class="sql">' . implode('</span>, <span class="sql">',array_column($queryValidResult->headers, 'header')) . "</span>";
                return [
                    'ok' => false,
                    'cost' => 0,
                    'hints' => $hints
                ];
            }
    
            // check rows count 
            if (count($resultObject[0]->data) !== count($queryValidResult->data)) {
                $hints['rowsCount'] = count($queryValidResult->data);
                return [
                    'ok' => false,
                    'cost' => 0,
                    'hints' => $hints
                ];
            }

            // check rows order
            if ($questionData['pre_check_sort']) {
                // sort rows before compare
                sort($resultObject[0]->data);
                sort($queryValidResult->data);
            }
            foreach ($queryValidResult->data as $i => $row) {
                if ($row !== $resultObject[0]->data[$i]) {
                    // convert numeric strings to floating numbers
                    foreach($row as $col=>$val) {
                        if (
                            is_numeric($resultObject[0]->data[$i][$col]) && is_numeric($val)
                        ) {
                            $row[$col] = floatval($val);
                            $resultObject[0]->data[$i][$col] = floatval($resultObject[0]->data[$i][$col]);
                            // patch for compare float values with limited precision
                            if(abs($row[$col]-$resultObject[0]->data[$i][$col]) < 0.0000000001) {
                                $resultObject[0]->data[$i][$col] = $row[$col];
                            }
                        } elseif (
                            // compare Postgres two numbers arrays of float with limited precision
                            preg_match('/\(([0-9.]+),([0-9.]+)\)/ims', $val, $m1) &&
                            preg_match('/\(([0-9.]+),([0-9.]+)\)/ims', $resultObject[0]->data[$i][$col], $m2)
                        ) 
                        {
                            if (
                                abs($m1[1]-$m2[1]) < 0.0000000001 && 
                                abs($m1[2]-$m2[2]) < 0.0000000001
                            ) {
                                $resultObject[0]->data[$i][$col] = $row[$col];
                            }
                        }
                    }
                    if ($row !== $resultObject[0]->data[$i]) {
                        // map NULLs to '[null]' before show
                        $resultRow = array_map(fn($el)=>(is_null($el) ? '[null]' : $el), $resultObject[0]->data[$i]);
                        $row = array_map(fn($el)=>(is_null($el) ? '[null]' : $el), $row);
                        $hints['rowsData'] = [
                            'rowNumber' => $i + 1,
                            'rowTable' => '<table class="result-table"><tr><td>' . ($i + 1) . '</td><td>' . implode("</td><td>", $row) .'</td></tr></table>',
                            'resultTable' => '<table class="result-table"><tr><td>' . ($i + 1) . '</td><td>' . implode("</td><td>", $resultRow) .'</td></tr></table>'
                        ];
                        return [
                            'ok' => false,
                            'cost' => 0,
                            'hints' => $hints
                        ];
                    }
                }
            }
            return [
                'ok' => true,
                'cost' => round(floatval(array_pop($resultObject)->data[0][1]),3)
            ];
        } catch(Exception $e) {
            // var_dump($e);
            return [
                'ok' => false,
                'cost' => 0
            ];
        }
    }

    public function setBestQueryCost(): void 
    {
        $stmt = $this->dbh->prepare("
            UPDATE questions 
		    SET best_query_cost = rating.min_cost
		    FROM (
                SELECT 
                    question_id, 
                    MIN(query_cost) min_cost
                FROM user_solutions
                WHERE question_id = :question_id and not reported
                GROUP BY question_id
            ) rating 
            WHERE questions.id = rating.question_id;");
        $stmt->execute([':question_id' => $this->id]);
    }
}