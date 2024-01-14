<?php

class QuestionTest extends \Codeception\Test\Unit
{
    /**
     * @var \UnitTester
     */
    protected $tester;

    private $dbh;
    
    protected function _before()
    {
        $env        = parse_ini_string(file_get_contents(".env"), 1);
        $dbc        = new DB($env);
        $this->dbh  = $dbc->getInstance();
    }

    protected function _after()
    {
    }

    // tests
    public function testSomeFeature()
    {
        $user = new Question($this->dbh, '1');
    }
}