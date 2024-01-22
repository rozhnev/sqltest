<?php

class QuestionCest
{
    public function _before(AcceptanceTester $I)
    {
    }

    // tests
    public function tryEnQueryHelpTest(AcceptanceTester $I)
    {
        $I->amOnPage('/en/sakila/1');
        $I->click('#getHelpBtn');
        $I->waitForText('When you need to get all data from table use', 20, '#code-result');
    }
    public function tryRuQueryHelpTest(AcceptanceTester $I)
    {
        $I->amOnPage('/en/sakila/1');
        $I->click('#getHelpBtn');
        $I->waitForText('Для получения всех данных из таблицы используйте', 20, '#code-result');
    }
}
