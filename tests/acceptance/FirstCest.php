<?php

class FirstCest
{
    public function frontpageWorks(AcceptanceTester $I)
    {
        $I->amOnPage('/');
        $I->see('interactive SQL practice');
    }

    public function frontpageEnWorks(AcceptanceTester $I)
    {
        $I->amOnPage('/en');
        $I->see('Sharpen your SQL skills with our interactive exercises and assessments!');
        $I->see('Get the actors');
    }

    public function frontpageRuWorks(AcceptanceTester $I)
    {
        $I->amOnPage('/ru');
        $I->see('Отточите свои навыки SQL с помощью наших интерактивных упражнений!');
        $I->see('Получить список актёров');
        $I->see('База данных Sakila (MySQL)');
    }

    public function frontpagePtWorks(AcceptanceTester $I)
    {
        $I->amOnPage('/ru');
        $I->see('Отточите свои навыки SQL с помощью наших интерактивных упражнений!');
        $I->see('Получить список актёров');
        $I->see('База данных Sakila (MySQL)');
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
        $I->see('Политика конфиденциальности');
    }

    public function privacyPolicyPtWorks(AcceptanceTester $I)
    {
        $I->amOnPage('/pt/privacy-policy');
        $I->see('Política de Privacidade para SQLtest');
    }
}