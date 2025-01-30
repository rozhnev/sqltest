<?php
class Solution 
{
    /**
     * DB hahdler 
     *
     * @var PDO
     */
    private $dbh;

    /**
     * Solution id
     *
     * @var integer
     */
    private $id;

    public function __construct(PDO $dbh, string $id)
    {
        $this->dbh  = $dbh;
        $this->id = (int)$id;
    }

    public function report(): int 
    {
        $stmt = $this->dbh->prepare("UPDATE user_solutions SET reported = true WHERE id = ? RETURNING question_id;");
        $stmt->execute([$this->id]);
        return $stmt->fetchColumn(0);
    }
}