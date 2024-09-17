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
    private $questions;

    public function __construct(PDO $dbh, User $user)
    {
        $this->dbh  = $dbh;
        $this->user = $user;
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

        $stmt = $this->dbh->prepare("SELECT * FROM tests JOIN test_questions ON test_questions.test_id = tests.id WHERE tests.id = :test_id;");
        $stmt->execute([':test_id' => $this->id]);

        $this->questions = $stmt->fetchAll(PDO::FETCH_ASSOC);
    }


    public function getQuestionnire(): array
    {
        return [
            "menu"=>["questions"=>$this->questions]
        ];
    }
}