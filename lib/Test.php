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
        $stmt = $this->dbh->prepare("INSERT INTO tests (id, user_id) VALUES (?, ?)");
        $stmt->execute([$this->id, $this->user->getId()]);

        $stmt = $this->dbh->prepare("INSERT INTO test_questions (test_id, question_id) SELECT ?, id FROM questions WHERE rate = 1 ORDER BY random() LIMIT 5");
        $stmt->execute([$this->id]);

        $stmt = $this->dbh->prepare("INSERT INTO test_questions (test_id, question_id) SELECT ?, id FROM questions WHERE rate = 2 ORDER BY random() LIMIT 4");
        $stmt->execute([$this->id]);

        $stmt = $this->dbh->prepare("INSERT INTO test_questions (test_id, question_id) SELECT ?, id FROM questions WHERE rate = 3 ORDER BY random() LIMIT 3");
        $stmt->execute([$this->id]);

        $stmt = $this->dbh->prepare("INSERT INTO test_questions (test_id, question_id) SELECT ?, id FROM questions WHERE rate = 4 ORDER BY random() LIMIT 2");
        $stmt->execute([$this->id]);

        $stmt = $this->dbh->prepare("INSERT INTO test_questions (test_id, question_id) SELECT ?, id FROM questions WHERE rate = 5 ORDER BY random() LIMIT 1");
        $stmt->execute([$this->id]);
        $this->dbh->commit();

        return $this->id;
    }

    public function load(string $id): void
    {
        $this->id = $id;

        $stmt = $this->dbh->prepare("SELECT 
                categories.id,
                categories.title_sef sef,
                categories.title_{$this->lang} questions_category,
                questions.id question_id,
                questions.title_sef question_sef,
                questions.db_template,
                questions.title_{$this->lang} question_title,
                (test_questions.solved_at IS NOT NULL) solved
        FROM tests 
        JOIN test_questions ON test_questions.test_id = tests.id 
        JOIN questions on questions.id = test_questions.question_id
        JOIN question_categories ON question_categories.question_id = questions.id
        JOIN categories ON categories.id = question_categories.category_id and categories.questionnire_id = 2
        WHERE tests.id = :test_id;");
        $stmt->execute([':test_id' => $this->id]);

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
                    $acc[$el['id']]['questions'][] = [$el['question_title'], $el['question_id'], $el['solved'], $el['question_sef']];
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
        return $this->questionnire;
    }

    public function getFirstUnsolvedQuestionId()
    {
        $stmt = $this->dbh->prepare("SELECT questions.id
            FROM test_questions
            JOIN questions ON questions.id = test_questions.question_id 
            WHERE test_id = :test_id AND test_questions.solved_at is null 
            ORDER BY questions.rate 
            LIMIT 1;");
        $stmt->execute([':test_id' => $this->id]);
        return $stmt->fetchColumn(0);
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
                questions.id question_id,
                questions.rate,
                question_rates.rate_{$this->lang} question_rate,
                questions.task_{$this->lang} task,
                categories.title_{$this->lang} title,
                dbms,
                db_template,
                ROW_NUMBER() OVER (PARTITION BY question_categories.category_id ORDER BY question_categories.sequence_position) number,
                LAG(test_questions.question_id) OVER (ORDER BY questions.rate) previous_question_id,
                LEAD(test_questions.question_id) OVER (ORDER BY questions.rate) next_question_id,
                solved_at solved_date,
                last_attempt_date,
                categories.title_sef category_sef,
                solution last_query,
                category_id 
            FROM questions
            LEFT JOIN question_rates ON question_rates.id = questions.rate
            JOIN question_categories ON questions.id = question_categories.question_id
            JOIN categories on categories.id = category_id AND questionnire_id = :questionnire_id
            JOIN test_questions ON test_questions.question_id = questions.id AND test_id = :test_id
            ) SELECT 
                question_data.*,
                (exists (select true from answers where answers.question_id = question_data.question_id)) have_answers
            FROM question_data WHERE question_id = :question_id;");

        $stmt->execute([':test_id' =>  $this->id, ':question_id' =>  $qusestionId, ':questionnire_id' => 2]);
        return $stmt->fetch(PDO::FETCH_ASSOC);;
    }
}