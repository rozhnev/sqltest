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
     * @var uuid
     */
    private $id;

    /**
     * Test user_id
     *
     * @var uuid
     */
    private $user_id;

    public function __construct(PDO $dbh, User $user)
    {
        $this->dbh  = $dbh;
        $this->user = $user;
    }

    public function create(): bool
    {
        $this->id = vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex(random_bytes(16)), 4));

        $this->dbh->beginTransaction();
        $stmt = $this->dbh->prepare("INSERT INTO tests (id, user_id) VALUES (?, ?)");
        $stmt->execute([$this->id, $this->user->getId()]);

        $stmt = $this->dbh->prepare("INSERT INTO test_questionss (test_id, question_id) SELECT ?, id FROM questions WHERE rate = 1 ORDER BY RAND() LIMIT 5");
        $stmt->execute([$this->id]);

        $stmt = $this->dbh->prepare("INSERT INTO test_questionss (test_id, question_id) SELECT ?, id FROM questions WHERE rate = 2 ORDER BY RAND() LIMIT 4");
        $stmt->execute([$this->id]);

        $stmt = $this->dbh->prepare("INSERT INTO test_questionss (test_id, question_id) SELECT ?, id FROM questions WHERE rate = 3 ORDER BY RAND() LIMIT 3");
        $stmt->execute([$this->id]);

        $stmt = $this->dbh->prepare("INSERT INTO test_questionss (test_id, question_id) SELECT ?, id FROM questions WHERE rate = 4 ORDER BY RAND() LIMIT 2");
        $stmt->execute([$this->id]);

        $stmt = $this->dbh->prepare("INSERT INTO test_questionss (test_id, question_id) SELECT ?, id FROM questions WHERE rate = 5 ORDER BY RAND() LIMIT 1");
        $stmt->execute([$this->id]);
        $this->dbh->commit();
    }
}