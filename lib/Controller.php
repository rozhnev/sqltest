<?php
class Controller 
{
    private $dbh;
    private $user;
    private $engine;
    private $mobileView;

    private $lang;

    private $languages = ['ru' => 'Русский', 'en' => 'English', 'pt' => 'Português'/*, 'es' => 'Español'*/];

    private function registerModifiers(array $mods): void
    {
        foreach ($mods as $mod) {
            $this->engine->registerPlugin("modifier", $mod, $mod);
        }
    }

    private function assignVariables(array $vars): void
    {
        foreach ($vars as $key => $value) {
            $this->engine->assign($key, $value);
        }
    }

    public function setLanguge(string $lang='en'): void
    {
        $this->lang = $lang;
        $this->assignVariables(['Lang' => $lang]);
        Localizer::init($lang);
    }

    public function setCanonicalLink(string $path): void
    {
        $this->assignVariables([
            'CanonicalLink' => $this->isMmobileView() ? "https://sqltest.online/{$path}" : null
        ]);
    }

    public function __construct(PDO $dbh, Smarty $engine, User $user, bool $mobileView)
    {
        $this->dbh      = $dbh;
        $this->user     = $user;
        $this->engine   = $engine;
        $this->mobileView = $mobileView;

        $this->registerModifiers(["array_key_exists", "mt_rand"]);
        $this->engine->registerPlugin('block', 'translate', array('Localizer', 'translate'), true);
        $this->assignVariables([
            'VERSION'       => $env['VERSION'] ?? 0,
            'MobileView'    => $this->isMmobileView(),
            'Languages'     => $this->languages,
            'User'          => $this->user,
        ]);
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
    /**
     * Show about page
     * @param array $params
     */
    public function about(array $params): void
    {
        $this->setLanguge($params['lang']);
        $this->assignVariables(['Action' => 'about']);
        $this->engine->display("about.tpl");
    }
    /**
     * Show privacy policy page
     * @param array $params
     */
    public function privacy_policy(array $params): void
    {
        $this->setLanguge($params['lang']);
        $this->assignVariables(['Action' => 'privacy-policy']);
        $this->engine->display("privacy_policy.tpl");
    }
    /**
     * Show donate page
     * @param array $params
     */
    public function donate($params): void
    {
        $this->setLanguge($params['lang']);
        $this->engine->assign('Action', 'donate');
        $this->engine->display("donate.tpl");
    }
    public function solution_like(PDO $dbh, User $user, array $params): void 
    {
        $this->engine->assign('Saved', false);
        if ($user->logged()) {
            $this->engine->assign('Saved', $user->likeSolution($params['solutionID']));
        }
        $this->engine->assign('User', $user);
        $this->engine->display("rate_saved.tpl");
    }

    public function solution_unlike(PDO $dbh, User $user, array $params): void 
    {
        $this->engine->assign('Saved', false);
        if ($user->logged()) {
            $this->engine->assign('Saved', $user->unlikeSolution($params['solutionID']));
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
        if (!$user->logged()) {
            $message = 'login_needed';
        } elseif ($user->toggleFavorite($params['questionID']))  {
            $message = 'done';
        } else {
            $message = 'something_went_wrong';
        }

        $this->engine->assign('Message', Localizer::translateString($message));
        $this->engine->display("user_message.tpl");
    }
    public function solution_delete(PDO $dbh, User $user, array $params): void 
    {
        if ($user->logged()) {
            $questionID = $user->deleteSolution($params['solutionID']);
            $this->engine->assign('Saved', true);
            $question = new Question($dbh, $questionID);
            $question->setBestQueryCost();
            $this->engine->assign('Message', Localizer::translateString('done'));
        } else {
            $this->engine->assign('Message', Localizer::translateString('login_needed'));
        }
        $this->engine->assign('User', $user);
        $this->engine->display("user_message.tpl");
    }
    
    public function solutions(PDO $dbh, User $user, array $params): void 
    {
        if ($user->logged()) {
            $questionSolved = $user->solvedQuestion($params['questionID']);
            $this->engine->assign('QuestionSolved', $questionSolved);
            if ($questionSolved) {
                $this->engine->assign('QuestionSolutions', $user->getOthersSolutions($params['questionID']));
            }
        }
        $this->engine->assign('User', $user);
        $this->engine->assign('QuestionID', $params['questionID']);
        $this->engine->display("solutions.tpl");
    }

    public function my_solutions(PDO $dbh, User $user, array $params): void 
    {
        if ($user->logged()) {
            $solutions = $user->getSolutions($params['questionID']);
            $this->engine->assign('QuestionSolutions', $solutions);
        }
        $this->engine->assign('User', $user);
        $this->engine->assign('QuestionID', $params['questionID']);
        $this->engine->display("user_solutions.tpl");
    }

    public function question(array $params): void 
    {
        $questionnire = new Questionnire($this->dbh, $this->lang);
        $question = new Question($this->dbh, $params['questionID']);
        $questionData = $question->get($params['questionCategoryID'], $this->lang, $this->user->getId());

        $this->registerModifiers(['floor', 'in_array']);
        $this->assignVariables([
            'QuestionID'            => $params['questionID'],
            'Questionnire'          => $questionnire->get($params['QuestionnireName'], $this->user->getId()),
            'QuestionCategoryID'    => $questionData['category_id'],
            'Question'              => $questionData,
            'NextQuestionId'        => $question->getNextSefId($params['questionCategoryID']),
            'PreviousQuestionId'    => $question->getPreviousSefId($params['questionCategoryID']),
            'DB'                    => $questionData['db_template'],
            'Action'                => 'question',
            'QuestionsCount'        =>  $questionnire->getQuestionsCount(),
        ]);
        $this->engine->display($this->mobileView ? "m.index.tpl" : "index.tpl");
    }
}
?>