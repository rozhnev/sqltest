<?php

class QuestionCest
{
    public function _before(FunctionalTester $I)
    {
    }

    // tests
    public function tryEnQueryHelpTest(FunctionalTester $I)
    {
        $I->amOnPage('/en/sakila/1');
        $I->click('#getHelpBtn');
        // $I->waitForText('When you need to get all data from table use', 20, '#code-result');
    }
    public function tryRuQueryHelpTest(FunctionalTester $I)
    {
        $I->amOnPage('/ru/sakila/1');
        $I->click('#getHelpBtn');
        // $I->waitForText('Для получения всех данных из таблицы используйте', 20, '#code-result');
    }
}
