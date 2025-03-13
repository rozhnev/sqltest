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
        $I->see('Select all records from the actor table.');
        $I->see('Sakila Database (MySQL)');
    }

    public function frontpageRuWorks(AcceptanceTester $I)
    {
        $I->amOnPage('/ru');
        $I->see('Отточите свои навыки SQL с помощью наших интерактивных упражнений!');
        $I->see('Получить список актёров');
        $I->see('Выберите все записи из таблицы actor.');
        $I->see('База данных Sakila (MySQL)');
    }

    public function frontpagePtWorks(AcceptanceTester $I)
    {
        $I->amOnPage('/pt');
        $I->see('Aprimore suas habilidades em SQL com nossos exercícios interativos!');
        $I->see('Obtenha os atores');
        $I->see('Selecione todos os registros da tabela actor.');
        $I->see('Banco de Dados Sakila (MySQL)');
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
    public function tryEnQueryHelpTest(AcceptanceTester $I)
    {
        $I->amOnPage('/en/question/bookings/get-airports-data');
        $I->click('#getHelpBtn');
        $I->see('Use airports_data table.', '#code-result');
    }
    public function tryRuQueryHelpTest(AcceptanceTester $I)
    {
        $I->amOnPage('/ru/question/bookings/get-airports-data');
        $I->click('#getHelpBtn');
        $I->see('Используйте таблицу airports_data.', '#code-result');
    }
    public function tryPtQueryHelpTest(AcceptanceTester $I)
    {
        $I->amOnPage('/pt/question/bookings/get-airports-data');
        $I->click('#getHelpBtn');
        $I->see('Use a tabela airports_data.', '#code-result');
    }
}