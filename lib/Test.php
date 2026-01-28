<?php
class Test 
{
    /**
     * DB hahdler 
     *
     * @var PDO
     */
    private $dbh;

    /**
     * Test id
     *
     * @var string
     */
    private $id;

    /**
     * Test language
     *
     * @var string
     */
    private $lang;

    /**
     * Test user_id
     *
     * @var User
     */
    private $user;

    /**
     * Test user_id
     *
     * @var Array
     */
    private $questionnire;

    public function __construct(PDO $dbh, string $lang, User $user)
    {
        $this->dbh  = $dbh;
        $this->lang = $lang;
        $this->user = $user;
    }

    public function setId(string $id)
    {
        $this->id  = $id;
    }

    public function create(): string
    {
        $this->id = vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex(random_bytes(16)), 4));

        $this->dbh->beginTransaction();
        $stmt = $this->dbh->prepare("INSERT INTO tests (id, user_id, closed_at) VALUES (?, ?, CURRENT_TIMESTAMP + INTERVAL '3 hour')");
        $stmt->execute([$this->id, $this->user->getId()]);

        $stmt = $this->dbh->prepare("INSERT INTO test_questions (test_id, question_id) SELECT ?, id FROM questions WHERE rate = 1 ORDER BY random() LIMIT 4");
        $stmt->execute([$this->id]);

        $stmt = $this->dbh->prepare("INSERT INTO test_questions (test_id, question_id) SELECT ?, id FROM questions WHERE rate = 2 ORDER BY random() LIMIT 3");
        $stmt->execute([$this->id]);

        $stmt = $this->dbh->prepare("INSERT INTO test_questions (test_id, question_id) SELECT ?, id FROM questions WHERE rate = 3 ORDER BY random() LIMIT 2");
        $stmt->execute([$this->id]);

        $stmt = $this->dbh->prepare("INSERT INTO test_questions (test_id, question_id) SELECT ?, id FROM questions WHERE rate = 4 ORDER BY random() LIMIT 2");
        $stmt->execute([$this->id]);

        $stmt = $this->dbh->prepare("INSERT INTO test_questions (test_id, question_id) SELECT ?, id FROM questions WHERE rate = 5 ORDER BY random() LIMIT 1");
        $stmt->execute([$this->id]);
        $this->dbh->commit();

        return $this->id;
    }

    public function challenge_mariadb_create(): string
    {
        $this->id = vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex(random_bytes(16)), 4));

        $this->dbh->beginTransaction();
        $stmt = $this->dbh->prepare("INSERT INTO tests (id, user_id, closed_at, questionnire_id) VALUES (?, ?, CURRENT_TIMESTAMP + INTERVAL '3 hour')");
        $stmt->execute([$this->id, $this->user->getId()]);

        $stmt = $this->dbh->prepare("INSERT INTO test_questions (test_id, question_id) VALUES
            (:test_id, 20, 999),
            (:test_id, 43, 999),
            (:test_id, 80, 999),
            (:test_id, 81, 999),
            (:test_id, 387, 999),
            (:test_id, 388, 999),
            (:test_id, 389, 999),
            (:test_id, 390, 999);"
         );
        $stmt->execute([':test_id' => $this->id]);
        $this->dbh->commit();

        return $this->id;
    }

    public function load(): void
    {
        if (!$this->id) {
            throw new Exception('Test not found');
        }

        $stmt = $this->dbh->prepare("SELECT 
                categories.id,
                categories.title_sef sef,
                categories_localization.title questions_category,
                questions.id question_id,
                questions.title_sef question_sef,
                questions.db_template,
                questions_localization.title question_title,
                (test_questions.solved_at IS NOT NULL) solved,
                ROW_NUMBER() OVER (PARTITION BY categories.id ORDER BY test_questions.question_id) question_order
            FROM tests 
            JOIN test_questions ON test_questions.test_id = tests.id 
            JOIN questions on questions.id = test_questions.question_id
            JOIN questions_localization on questions_localization.question_id = questions.id AND questions_localization.language = :lang
            JOIN question_categories ON question_categories.question_id = questions.id
            JOIN categories ON categories.id = question_categories.category_id and categories.questionnire_id = tests.questionnire_id
            JOIN categories_localization ON categories_localization.category_id = categories.id AND categories_localization.language =  :lang
            WHERE tests.id = :test_id
            ORDER BY categories.sequence_position, question_categories.sequence_position
        ");
        $stmt->execute([':test_id' => $this->id, ':lang' => $this->lang]);
        
        $questionnire = $stmt->fetchAll(PDO::FETCH_ASSOC);
        if ($questionnire) {
            $menu = array_reduce(
                $questionnire,
                function($acc, $el) {
                    if (!isset($acc[$el['id']])) $acc[$el['id']] = [
                        'title'     => $el['questions_category'],
                        'db'        => $el['db_template'],
                        'sef'       => $el['sef'],
                        'questions' => []
                    ];
                    $acc[$el['id']]['questions'][] = [$el['question_title'], $el['question_id'], $el['solved'], $el['question_sef'], $el['question_order']];
                    return $acc;
                },
                []
            );
        } else {
            $menu = [];
        }
        $this->questionnire = [
            'name' => 'complexity',
            'menu' => $menu
        ];
    }

    public function getQuestionnire(): array
    {
        if (!$this->questionnire) $this->load();
        return $this->questionnire;
    }

    public function getData(): array
    {
        $stmt = $this->dbh->prepare("
            SELECT 
                *, 
                (tests.closed_at <= CURRENT_TIMESTAMP) timeout, 
                extract(epoch from (tests.closed_at - CURRENT_TIMESTAMP))::int/60 time_to_end,
                test_questions.questions_count,
                test_questions.solved_questions_count
            FROM tests
            JOIN (
                SELECT test_id id,
                    COUNT(test_questions.question_id) questions_count,
                    COUNT(test_questions.solved_at) solved_questions_count 
                FROM test_questions
                WHERE test_id = :test_id
                GROUP BY test_id
            ) test_questions USING(id)
            WHERE id = :test_id;
        ");
        
        $stmt->execute([':test_id' => $this->id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getFirstUnsolvedQuestionId(): ?int
    {
        $stmt = $this->dbh->prepare("SELECT questions.id
            FROM test_questions
            JOIN tests on tests.id = test_questions.test_id
            JOIN questions ON questions.id = test_questions.question_id 
            JOIN question_categories ON question_categories.question_id = questions.id
            JOIN categories ON categories.id = question_categories.category_id and categories.questionnire_id = tests.questionnire_id
            WHERE test_id = :test_id AND test_questions.solved_at is null AND attempts < max_attempts
            ORDER BY categories.sequence_position, question_categories.sequence_position
            LIMIT 1;");
        $stmt->execute([':test_id' => $this->id]);
        return $stmt->fetchColumn(0) ?: null;
    }
    /**
     * Returns Category Id by Questionnire ID
     *
     * @param int $limit
     * @return array
     */
    public function getQuestionData(int $qusestionId): array 
    {
        $stmt = $this->dbh->prepare("
            WITH question_data AS (SELECT 
                test_id,
                questions.id question_id,
                questions.rate,
                question_rates_localization.rate question_rate,
                questions_localization.task task,
                categories_localization.title title,
                dbms,
                db_template,
                ROW_NUMBER() OVER (PARTITION BY question_categories.category_id ORDER BY question_categories.sequence_position) number,
                LAG(test_questions.question_id) OVER (ORDER BY questions.rate) previous_question_id,
                LEAD(test_questions.question_id) OVER (ORDER BY questions.rate) next_question_id,
                solved_at solved_date,
                to_char(last_attempt_at, 'YYYY-MM-dd HH24:mm:ss') last_attempt_at,
                categories.title_sef category_sef,
                last_answer last_query,
                (3 - attempts) possible_attempts,
                question_categories.category_id 
            FROM questions
            JOIN test_questions ON test_questions.question_id = questions.id AND test_id = :test_id
            JOIN tests ON tests.id = test_questions.test_id
            JOIN questions_localization on questions_localization.question_id = questions.id AND questions_localization.language = :lang
            JOIN question_rates ON question_rates.id = questions.rate
            JOIN question_rates_localization ON question_rates_localization.id = question_rates.id AND question_rates_localization.language =  :lang
            JOIN question_categories ON questions.id = question_categories.question_id
            JOIN categories on categories.id = category_id AND categories.questionnire_id = tests.questionnire_id
            JOIN categories_localization ON categories_localization.category_id = categories.id AND categories_localization.language =  :lang
            ) SELECT 
                question_data.*,
                to_char(tests.closed_at, 'YYYY-MM-DD HH24:MI:SSOF') closed_at,
                (exists (select true from answers where answers.question_id = question_data.question_id)) have_answers
            FROM question_data 
            JOIN tests ON tests.id = question_data.test_id
            WHERE question_id = :question_id;");

        $stmt->execute([':test_id' =>  $this->id, ':question_id' =>  $qusestionId, ':lang' => $this->lang]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getQuestionAttemptStatus(int $qusestionId): array 
    {
        $stmt = $this->dbh->prepare("
            SELECT (tests.closed_at <= CURRENT_TIMESTAMP) timeout, (test_questions.max_attempts - test_questions.attempts) avaliable_attempts
            FROM test_questions
            JOIN tests ON tests.id = test_questions.test_id
            WHERE test_id = :test_id AND question_id = :question_id
        ");
        $stmt->execute([':test_id' => $this->id, ':question_id' => $qusestionId]);
        $res = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($res['avaliable_attempts'] < 1) {
            return [
                'ok' => false, 
                'nextQuestion' => $this->getFirstUnsolvedQuestionId(),
                'hints' => ['maxAttemptsReached' => true]
            ];
        } elseif ($res['timeout']) {
            return ['ok' => false, 'hints' => ['timeOut' => true]];
        }
        return ['ok' => true];
    }

    public function saveQuestionAttempt(int $qusestionId, array $result, string $answer): void
    {
        try {
            $stmt = $this->dbh->prepare("
                UPDATE test_questions 
                SET 
                    attempts = attempts + 1,
                    last_attempt_at = CURRENT_TIMESTAMP, 
                    solved_at = LEAST(test_questions.solved_at, CASE WHEN ".($result['ok'] ? 'true' : 'false')." THEN CURRENT_TIMESTAMP END),
                    solution = CASE WHEN ".($result['ok'] ? 'true' : 'false')." THEN :answer ELSE test_questions.solution END,
                    last_answer = :answer,
                    query_cost = :query_cost
                WHERE test_id = :test_id AND question_id = :question_id
            ");
            $stmt->execute([':test_id' => $this->id, ':question_id' => $qusestionId, ':answer' => $answer, ':query_cost' => floatval($result['cost'])]);
        }
        catch (\Throwable $error) {
            throw new Exception($error->getMessage());
        }
    }

    public function belongsToUser(user $user): bool
    {
        $stmt = $this->dbh->prepare("SELECT true
            FROM tests
            WHERE id = :test_id AND user_id = :user_id 
            LIMIT 1;");
        $stmt->execute([':test_id' => $this->id, ':user_id' => $user->getId()]);
        return $stmt->fetchColumn(0) ?? false;
    }

    public function calculateResult(): array
    {
        $stmt = $this->dbh->prepare("
            SELECT 
                test_questions.solved_at, 
                test_questions.attempts,
                questions.rate
            FROM test_questions 
            JOIN questions ON questions.id = test_questions.question_id 
            WHERE test_id = :test_id ;
        ");

        $stmt->execute([':test_id' => $this->id]);

        $testQuestions = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $testResult = array_reduce(
            $testQuestions, 
            function($res, $q) {
                $res['total_questions']++;
                $res['easy_questions']       += $q['rate']===1 ? 1 : 0;
                $res['simple_questions']     += $q['rate']===2 ? 1 : 0;
                $res['normal_questions']     += $q['rate']===3 ? 1 : 0;
                $res['difficult_questions']  += $q['rate']===4 ? 1 : 0;
                $res['hard_questions']       += $q['rate']===5 ? 1 : 0;

                if (!is_null($q['solved_at'])) {
                    $res['solved_questions']++;
                    $res['solved_easy_questions']       += $q['rate']===1 ? 1 : 0;
                    $res['solved_simple_questions']     += $q['rate']===2 ? 1 : 0;
                    $res['solved_normal_questions']     += $q['rate']===3 ? 1 : 0;
                    $res['solved_difficult_questions']  += $q['rate']===4 ? 1 : 0;
                    $res['solved_hard_questions']       += $q['rate']===5 ? 1 : 0;

                    $res['solved_attempts']             += $q['attempts'];
                    $res['solved_easy_attempts']        += $q['rate']===1 ? $q['attempts'] : 0;
                    $res['solved_simple_attempts']      += $q['rate']===2 ? $q['attempts'] : 0;
                    $res['solved_normal_attempts']      += $q['rate']===3 ? $q['attempts'] : 0;
                    $res['solved_difficult_attempts']   += $q['rate']===4 ? $q['attempts'] : 0;
                    $res['solved_hard_attempts']        += $q['rate']===5 ? $q['attempts'] : 0;
                }
                return $res;
            }, 
            [
                'ok' => false,
                'grade' => 0, 
                'total_questions' => 0,
                'easy_questions' => 0,
                'simple_questions' => 0,
                'normal_questions' => 0,
                'difficult_questions' => 0,
                'hard_questions' => 0,

                'solved_questions' => 0,
                'solved_easy_questions' => 0,
                'solved_simple_questions' => 0,
                'solved_normal_questions' => 0,
                'solved_difficult_questions' => 0,
                'solved_hard_questions' => 0,

                'solved_attempts' => 0,
                'solved_easy_attempts' => 0,
                'solved_simple_attempts' => 0,
                'solved_normal_attempts' => 0,
                'solved_difficult_attempts' => 0,
                'solved_hard_attempts' => 0,
            ]
        );
        $must_to_solve = ceil($testResult['total_questions'] * 0.5);

        if ($testResult['solved_questions'] < $must_to_solve) {
            $testResult['ok'] = false;
            $testResult['hints']['not_enought_tasks_solved'] = 'You must to solve at least ' . $must_to_solve;
            $testResult['hints']['must_to_solve'] = $must_to_solve;
        } else {
            if (
                $testResult['solved_easy_questions'] === $testResult['easy_questions'] 
            ) {
                // solved all easy - Intern
                $testResult['ok'] = true;
                $testResult['grade']++;
                $testResult['hints'][] = 'All easy tasks done';
            }

            if (
                $testResult['solved_easy_questions'] === $testResult['easy_questions'] &&
                ($testResult['solved_simple_questions'] + $testResult['solved_normal_questions'] + $testResult['solved_difficult_questions'] + $testResult['solved_hard_questions']) > ($testResult['simple_questions'] + $testResult['normal_questions'] + $testResult['difficult_questions'] + $testResult['hard_questions']) * 0.66
            ) {
                // solved all easy + 2/3 of rest questions - Junior
                $testResult['ok'] = true;
                $testResult['grade']++;
                $testResult['hints'][] = '2/3 of simple, normal, difficult & hard tasks done';
            }

            // if (
            //     $testResult['solved_easy_questions'] === $testResult['easy_questions'] &&
            //     $testResult['solved_simple_questions'] === $testResult['simple_questions'] &&
            //     ($testResult['solved_normal_questions'] + $testResult['solved_difficult_questions'] + $testResult['solved_hard_questions']) > ($testResult['normal_questions'] + $testResult['difficult_questions'] + $testResult['hard_questions']) * 0.66
            // ) {
            //     // solved all easy & simple + 2/3 of rest questions - Junior
            //     $testResult['ok'] = true;
            //     $testResult['grade']++;
            //     $testResult['hints'][] = 'All simple tasks done';
            //     $testResult['hints'][] = '2/3 of normal, difficult & hard tasks done';
            // }

            if (
                $testResult['solved_easy_questions'] === $testResult['easy_questions'] &&
                $testResult['solved_simple_questions'] === $testResult['simple_questions'] &&
                $testResult['solved_normal_questions'] === $testResult['normal_questions'] &&
                ($testResult['solved_difficult_questions'] + $testResult['solved_hard_questions']) > ($testResult['difficult_questions'] + $testResult['hard_questions']) * 0.66
            ) {
                // solved all easy, simple & nomal  + 2/3 of difficult & hard questions - Middle
                $testResult['ok'] = true;
                $testResult['grade']++;
                $testResult['hints'][] = 'All normal tasks done';
                $testResult['hints'][] = '2/3 of difficult & hard tasks done';
            }

            if ($testResult['solved_questions'] === $testResult['total_questions']) {
                // solved all
                $testResult['ok'] = true;
                $testResult['grade']++;
                $testResult['hints'][] = 'All tasks done';
            }
        }
        
        // All questions solved with 1 attempt - promotion
        if ($testResult['solved_attempts'] == $testResult['solved_questions'] && $testResult['grade'] < 4) {
            $testResult['grade']++;
            $testResult['hints'][] = 'All questions solved with 1 attempt';
        }

        // More then 2 attempt for question in average - penalty
        if ($testResult['solved_attempts'] > 2 * $testResult['solved_questions'] && $testResult['grade'] > 1) {
            $testResult['grade']--;
            $testResult['hints'][] = 'You average attempts count more then 2. Grade decreased';
        }
        if ($testResult['grade'] < 1) {
            $testResult['hints']['grade_below_the_minimum'] = 'Your grade balow the minimum';
        } 
        return $testResult;
    }
}