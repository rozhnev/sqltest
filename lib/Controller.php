<?php
class Controller 
{
    private $engine;

    private $lang;

    private $languages = ['ru' => 'Русский', 'en' => 'English', 'pt' => 'Português'/*, 'es' => 'Español'*/];

    public function __construct(Smarty $engine, string $lang)
    {
        $this->lang = $lang;

        $engine->assign('Lang', $lang);
        Localizer::init($lang);
        $engine->registerPlugin("modifier", "array_key_exists", "array_key_exists");
        $engine->registerPlugin('block', 'translate', array('Localizer', 'translate'), true);

        $engine->assign('VERSION', $env['VERSION'] ?? 0);
        $engine->assign('MobileView', $this->isMmobileView());
        $engine->assign('Languages', $this->languages);
        $engine->assign('Lang', $lang);
        $this->engine = $engine;
        // $smarty->assign('User', $user);
        // $smarty->assign('LoggedAsAdmin', $user->isAdmin());


        // $smarty->assign('DB', $db);
        // $smarty->assign('QuestionID', $questionID);
    }

    private function isMmobileView(): bool
    {
        return  (isset($_SERVER['SERVER_NAME']) && $_SERVER['SERVER_NAME'] === 'm.sqltest.online');
    }

    public function books(): void
    {
        $this->engine->assign('Books', Helper::getBooks($dbh, $this->lang));
        $this->engine->display("books.tpl");
    }
    public function erd(array $params): void
    {
        $this->engine->assign('Params', $params);
        $this->engine->display("erd.tpl");
    }
    public function donate(): void
    {
        $this->engine->assign('Action', "donate");
        $this->engine->display("donate.tpl");
    }
}
?>