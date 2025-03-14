<?php

class LoginCest
{
    public function _before(FunctionalTester $I)
    {
    }

    // tests
    public function tryEnLogin(FunctionalTester $I)
    {
        $I->amOnPage('/en');
        $I->click('#showLoginWindowBtn');
        $I->see('Choose login method');
        // $I->waitForText('Choose login method', 5);
    }
    public function tryRuLogin(FunctionalTester $I)
    {
        $I->amOnPage('/ru');
        $I->click('#showLoginWindowBtn');
        $I->see('Выберите способ авторизации');
    }
    public function tryPtLogin(FunctionalTester $I)
    {
        $I->amOnPage('/pt');
        $I->click('#showLoginWindowBtn');
        $I->see('Escolha o método de login');
    }
}
