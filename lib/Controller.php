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

    public function solution_like(PDO $dbh, User $user, array $params): void 
    {
        $this->engine->assign('Saved', false);
        if ($user->logged()) {
            $solution = new Solution($dbh, $params['solutionID']);
            $this->engine->assign('Saved', $solution->like());
        }
        $this->engine->assign('User', $user);
        $this->engine->display("rate_saved.tpl");
    }

    public function solution_dislike(PDO $dbh, User $user, array $params): void 
    {
        $this->engine->assign('Saved', false);
        if ($user->logged()) {
            $solution = new Solution($dbh, $params['solutionID']);
            $this->engine->assign('Saved', $solution->dislike());
        }
        $this->engine->assign('User', $user);
        $this->engine->display("rate_saved.tpl");
    }

    public function solution_report(PDO $dbh, User $user, array $params): void 
    {
        $this->engine->assign('Saved', false);
        if ($user->logged() && ($user->isAdmin() || $user->grade() === 'Middle' || $user->grade() === 'Senior')) {
            $solution = new Solution($dbh, $params['solutionID']);
            $questionID = $solution->report();
            $this->engine->assign('Saved', true);
            $question = new Question($dbh, $questionID);
            $question->setBestQueryCost();
        }
        $this->engine->assign('User', $user);
        $this->engine->display("rate_saved.tpl");
    }

    public function question_favorite(PDO $dbh, User $user, array $params): void 
    {
        $this->engine->assign('Saved', false);
        if ($user->logged()) {
            $question = new Question($dbh, $params['questionID']);
            $this->engine->assign('Saved', $question->favorite($user));
        }
        $this->engine->assign('User', $user);
        $this->engine->display("rate_saved.tpl");
    }
}
?>