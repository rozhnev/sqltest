<?php

class FirstCest
{
    public function frontpageWorks(AcceptanceTester $I)
    {
        $I->amOnPage('/');
        $I->see('place where you can test your SQL knowledge for free');
    }

    public function frontpageEnWorks(AcceptanceTester $I)
    {
        $I->amOnPage('/en');
        $I->see('place where you can test your SQL knowledge for free');
        $I->see('Get the actors');
    }

    public function frontpageRuWorks(AcceptanceTester $I)
    {
        $I->amOnPage('/ru');
        $I->see('место, где вы можете бесплатно проверить свои знания SQL');
        $I->see('Получить список актёров');
    }

    public function questionEnWorks(AcceptanceTester $I)
    {
        $I->amOnPage('/en/sakila/1');
        $I->see('Select all records from the actor table.');
        // $I->executeJS("runQuery('ru', 'sakila', 1)");
        // $I->see('Для получения всех данных из таблицы используйте');
    }

    public function questionRuWorks(AcceptanceTester $I)
    {
        $I->amOnPage('/ru/sakila/1');
        $I->see('Выберите все записи из таблицы');
        // $I->executeJS("runQuery('ru', 'sakila', 1)");
        // $I->see('Для получения всех данных из таблицы используйте');
    }

    public function privacyPolicyEnWorks(AcceptanceTester $I)
    {
        $I->amOnPage('/en/privacy-policy');
        $I->see('Privacy Policy for SQLtest');
    }

    public function privacyPolicyRuWorks(AcceptanceTester $I)
    {
        $I->amOnPage('/ru/privacy-policy');
        $I->see('Политика конфиденциальности для SQLtest');
    }
}