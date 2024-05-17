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

    public function like(): bool
    {
        $stmt = $this->dbh->prepare("UPDATE user_solutions SET likes = likes + 1 WHERE id = ?");
        return $stmt->execute([$this->id]);
    }

    public function unlike(): bool 
    {
        $stmt = $this->dbh->prepare("UPDATE user_solutions SET dislikes = dislikes + 1 WHERE id = ?");
        return $stmt->execute([$this->id]);
    }

    public function report(): bool 
    {
        $stmt = $this->dbh->prepare("UPDATE user_solutions SET reported = true WHERE id = ?");
        return $stmt->execute([$this->id]);
    }
}