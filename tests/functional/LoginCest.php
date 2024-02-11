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
        $I->click('.login-button');
        $I->see('Choose login method');
    }
    public function tryRuLogin(FunctionalTester $I)
    {
        $I->amOnPage('/ru');
        $I->click('.login-button');
        $I->see('Выберите способ авторизации');
    }
}
