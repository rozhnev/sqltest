<?php

class LoginCest
{
    public function _before(FunctionalTester $I)
    {
        $I->amOnPage('/en');
        $I->click('.login-button');
        $I->see('Choose login method');
    }

    // tests
    public function tryToTest(FunctionalTester $I)
    {
        $I->amOnPage('/ru');
        $I->click('.login-button');
        $I->see('Выберите способ авторизации');
    }
}
