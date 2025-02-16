<?php

use Codeception\Test\Unit;

class QueryTest extends Unit
{
    /**
     * @var \UnitTester
     */
    protected $tester;

    public function testConstructor()
    {
        $sql = "SELECT * FROM users";
        $query = new Query($sql);
        $this->assertInstanceOf(Query::class, $query);
    }

    public function testCleanComments()
    {
        $sql = "SELECT id, '-- comment within string' as str FROM my_table /*where id > 0*/;";
        $query = new Query($sql);
        $cleanedSql = $query->cleanComments($sql);
        $expectedSql = "SELECT id, '-- comment within string' as str FROM my_table ;";
        $this->assertEquals($expectedSql, $cleanedSql);
    }
}