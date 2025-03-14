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

    /**
     * Show books page
     * @param array $params
     */
    public function books(): void
    {
        $this->engine->assign('Books', Helper::getBooks($this->dbh, $this->lang));
        $this->assignVariables(['Action' => 'books']);
        $this->engine->display("books.tpl");
    }

    /**
     * Show ERD page for the selected database
     * @param array $params
     */
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
        $this->assignVariables(['Action' => 'about']);
        $this->engine->display("about.tpl");
    }
    /**
     * Show privacy policy page
     * @param array $params
     */
    public function privacy_policy(array $params): void
    {
        $this->assignVariables(['Action' => 'privacy-policy']);
        $this->engine->display("privacy_policy.tpl");
    }
    /**
     * Show donate page
     * @param array $params
     */
    public function donate(array $params): void
    {
        $this->engine->assign('Action', 'donate');
        $this->engine->display("donate.tpl");
    }

    /**
     * Show login result page
     * @param array $params
     */
    public function login(array $params): void
    {
        $this->user->login($params['loginProvider'], $_REQUEST);
        $_SESSION["user_id"] = $this->user->getId();
        $_SESSION["admin"] = $this->user->isAdmin();
        $this->engine->display("login_result.tpl");
    }

    public function logout(array $params): void
    {
        // Unset all of the session variables.
        $_SESSION = array();

        // If it's desired to kill the session, also delete the session cookie.
        // Note: This will destroy the session, and not just the session data!
        if (ini_get("session.use_cookies")) {
            $params = session_get_cookie_params();
            setcookie(session_name(), '', time() - 42000,
                $params["path"], $params["domain"],
                $params["secure"], $params["httponly"]
            );
        }

        // Finally, destroy the session.
        session_destroy();
        header("location:/" . $this->lang);
        die();
    }

    public function solution_like(array $params): void 
    {
        $this->engine->assign('Saved', false);
        if ($this->user->logged()) {
            $this->engine->assign('Saved', $this->user->likeSolution($params['solutionID']));
        }
        $this->engine->assign('User', $this->user);
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

    public function solution_report(array $params): void 
    {
        $this->engine->assign('Saved', false);
        if (
            $this->user->logged() && 
            ($this->user->isAdmin() || $this->user->grade() === 'Middle' || $this->user->grade() === 'Senior')
        ) {
            $solution = new Solution($this->dbh, $params['solutionID']);
            $questionID = $solution->report();
            $this->engine->assign('Saved', true);
            $question = new Question($this->dbh, $questionID);
            $question->setBestQueryCost();
        }
        $this->engine->assign('User', $this->user);
        $this->engine->display("rate_saved.tpl");
    }

    public function solution_delete(array $params): void 
    {
        if ($this->user->logged()) {
            $questionID = $this->user->deleteSolution($params['solutionID']);
            $this->engine->assign('Saved', true);
            $question = new Question($this->dbh, $questionID);
            $question->setBestQueryCost();
            $this->engine->assign('Message', Localizer::translateString('done'));
        } else {
            $this->engine->assign('Message', Localizer::translateString('login_needed'));
        }
        $this->engine->assign('User', $this->user);
        $this->engine->display("user_message.tpl");
    }

    public function question_favorite(array $params): void 
    {
        if (!$this->user->logged()) {
            $message = 'login_needed';
        } elseif ($this->user->toggleFavorite($params['questionID']))  {
            $message = 'done';
        } else {
            $message = 'something_went_wrong';
        }

        $this->engine->assign('Message', Localizer::translateString($message));
        $this->engine->display("user_message.tpl");
    }

    
    public function question_solutions(array $params): void 
    {
        if ($user->logged()) {
            $questionSolved = $this->user->solvedQuestion($params['questionID']);
            $this->engine->assign('QuestionSolved', $questionSolved);
            if ($questionSolved) {
                $this->engine->assign('QuestionSolutions', $this->user->getOthersSolutions($params['questionID']));
            }
        }
        $this->engine->assign('User', $this->user);
        $this->engine->assign('QuestionID', $params['questionID']);
        $this->engine->display("solutions.tpl");
    }

    public function question_my_solutions(array $params): void 
    {
        if ($user->logged()) {
            $solutions = $this->user->getSolutions($params['questionID']);
            $this->engine->assign('QuestionSolutions', $solutions);
        }
        $this->engine->assign('User', $this->user);
        $this->engine->assign('QuestionID', $params['questionID']);
        $this->engine->display("user_solutions.tpl");
    }

    /**
     * Show question page
     * @param array $params
     */
    public function question(array $params): void 
    {
        $questionnire = new Questionnire($this->dbh, $this->lang);

        $questionID = $params['questionID'] ?? $questionnire->getQuestionId($params['question']);
        $questionCategoryID = $params['questionCategoryID'] ?? $questionnire->getCategoryId($params['questionCategory']);
        $questionnireName   = $questionnire->getNameByCategory($params['questionCategory']);

        $question = new Question($this->dbh, $questionID);
        $questionData = $question->get($questionCategoryID, $this->lang, $this->user->getId());
        if ($questionData['have_answers']) {
            $questionData['answers'] = $question->getAnswers($questionCategoryID, $this->lang, $this->user->getId());
            $questionData['last_query'] = json_decode($questionData['last_query']??'[]', true);
        }

        if ($this->user->logged()) {
            $this->user->setPath($params['path']);
            $this->user->save();
        }

        $this->registerModifiers(['floor', 'in_array']);
        $this->assignVariables([
            'QuestionID'            => $questionID,
            'Questionnire'          => $questionnire->get($questionnireName, $this->user->getId()),
            'QuestionCategoryID'    => $questionCategoryID,
            'Question'              => $questionData,
            'NextQuestionId'        => $question->getNextSefId($questionCategoryID),
            'PreviousQuestionId'    => $question->getPreviousSefId($questionCategoryID),
            'DB'                    => $questionData['db_template'],
            'DBMS'                  => $questionData['dbms'],
            'Action'                => 'question',
            'QuestionsCount'        => $questionnire->getQuestionsCount(),
            'SolvedQuestionsCount'  => $this->user->getSolvedQuestionsCount(),
            'Book'                  => Helper::getBook($this->dbh, $this->lang, $questionData['dbms']),
            'Favorites'             => $this->user->getFavorites($this->lang)
        ]);
        $this->engine->display($this->mobileView ? "m.index.tpl" : "index.tpl");
    }

    public function query_help(array $params): void 
    {
        $question = new Question($this->dbh, $params['questionID']);
        $this->engine->assign('Hint', $question->getHint($this->lang));
        $this->engine->display("hint.tpl");
    }

    public function query_run(array $params): void 
    {
        $sql = $_POST["query"] ?? '';
        if (!empty($sql)) {
            $question = new Question($this->dbh, $params['questionID']);
            $queryPreCheck = $question->getQueryPreCheck();
            $query = new Query($queryPreCheck . $sql);
            $this->engine->assign('QeryResult', $query->getResult($question->getDB(), 'json'));
        }

        $this->engine->display("query_result.tpl");
    }

    public function query_test(array $params): void 
    {
        $sql = $_POST["query"] ?? '';
        $question = new Question($this->dbh, $params['questionID']);
        $queryTestResult = $question->checkQuery($sql);
        $this->assignVariables([
            'QuestionID'        => $params['questionID'],
            'QueryTestResult'   => $queryTestResult
        ]);
        if ($queryTestResult['ok']) {
            $preparedQuery = $question->prepareQuery($sql);
            $query = new Query($preparedQuery);
            $jsonResult = $query->getResult($question->getDB(), 'json');
            $queryTestResult = $question->checkQueryResult($jsonResult);
            $this->assignVariables([
                'QueryTestResult' => $queryTestResult,
                'QueryBestCost' => $question->getBestCost()
            ]);
        }
        if ($this->user->logged()) {
            $this->user->saveQuestionAttempt($params['questionID'], $queryTestResult, $sql);
            if ($queryTestResult['ok']) {
                $this->user->saveSolution($params['questionID'], $queryTestResult, $sql);
            }
        }
        if (!$queryTestResult['ok']) header( 'HTTP/1.1 418 BAD REQUEST' );
        if ($this->user->showAd()) {
            $this->engine->assign('ReferralLink', Helper::getReferralLink($this->dbh, $this->lang, $this->isMmobileView() ? 'mobile' : 'desktop'));
        }

        $this->engine->display($this->lang . "/query_test_result.tpl");
    }

    public function check_answers(array $params): void 
    {
        $answers = $_POST["answers"] ?? '[]';
        $question = new Question($this->dbh, $params['questionID']);
        $answerResult = $question->checkAnswers($answers);
        $this->engine->assign('AnswerResult', $answerResult);

        if ($this->user->logged()) {
            $this->user->saveQuestionAttempt($params['questionID'], $answerResult, $answers);
        }

        if (!$answerResult['ok']) header( 'HTTP/1.1 418 BAD REQUEST' );
        if ($this->user->showAd()) {
            $this->engine->assign('ReferralLink', Helper::getReferralLink($this->dbh, $this->lang, $this->isMmobileView() ? 'mobile' : 'desktop'));
        }
        $this->engine->display($this->lang . "/check_answer_result.tpl");
    }

    public function rate(array $params): void 
    {
        if ($this->user->logged()) {
            $rate = intval($_REQUEST['rate']);
            $this->engine->assign('Saved', $this->user->saveQuestionRate($params['questionID'], $rate));
        }
        $this->engine->display("rate_saved.tpl");
    }

    public function test_start(array $params): void 
    {
        if ($this->user->logged()) {
            $this->engine->assign('LastTest', $this->user->getLastTest());
        }
        $this->engine->display("test_start.tpl");
    }

    public function test_create(array $params): void 
    {
        if (!$this->user->logged()) {
            header("Location: /" . $this->lang . "/test/start");
            exit();
        }
        $test = new Test($this->dbh, $this->lang, $this->user);

        $userTestId = $test->create();
        header("Location: /" . $this->lang . "/test/$userTestId");
    }

    public function test_result(array $params): void 
    {
        if (!$this->user->logged()) {
            header("Location: /" . $this->lang . "/test/start");
            exit();
        }
        $test = new Test($this->dbh, $this->lang, $this->user);
        $test->setId($testId);

        if(!$test->belongsToUser($this->user)) {
            header("HTTP/1.1 404 Moved Permanently");
            $this->engine->assign('ErrorMessage', Localizer::translateString('action_not_permiited'));
            $this->engine->display("error.tpl");
            exit();
        }
        $testData = $test->getData();
        $testEnd   = new DateTime($testData['closed_at']);
        $testEnd -> add(new DateInterval('P1M0D'));
        $testData['next_test_in'] = $testEnd->diff(new DateTime())->days;

        $testResult = $test->calculateResult();
        $this->assignVariables([
            'Test'          => $testData,
            'TestResult'    => $testResult
        ]);

        $this->engine->display("test_result.tpl");
    }

    public function test_grade(array $params): void 
    {
        if (!$this->user->logged()) {
            header("Location: /" . $this->lang . "/test/start");
            exit();
        }
        $test = new Test($this->dbh, $this->lang, $this->user);
        $test->setId($testId);

        if(!$test->belongsToUser($this->user)) {
            header("HTTP/1.1 404 Moved Permanently");
            $this->engine->assign('ErrorMessage', Localizer::translateString('action_not_permiited'));
            $this->engine->display("error.tpl");
            exit();
        }
        $testResult = $test->calculateResult();
        if ($testResult['ok']) {
            $this->user->saveGrade($testResult['grade']);
        }
        $this->engine->assign('TestResult', $testResult);
        $this->engine->display("user_grade.tpl");
    }

    public function test_question(array $params): void 
    {
        if (!$this->user->logged()) {
            header("Location: /" . $this->lang . "/test/start");
            exit();
        }
        $test = new Test($this->dbh, $this->lang, $this->user);
        $test->setId($testId);

        if(!$test->belongsToUser($this->user)) {
            header("HTTP/1.1 404 Moved Permanently");
            $this->engine->assign('ErrorMessage', Localizer::translateString('action_not_permiited'));
            $this->engine->display("error.tpl");
            exit();
        }
        $questionID = $params['questionID'] ?? $test->getFirstUnsolvedQuestionId();

        $question = new Question($this->dbh, $questionID);

        $questionData = $test->getQuestionData($questionID);
        $questionCategoryID = $questionData['category_id'];
        if ($questionData['have_answers']) {
            $questionData['answers'] = $question->getAnswers($questionCategoryID, $this->lang, $this->user->getId());
            $questionData['last_query'] = json_decode($questionData['last_query']??'[]', true);
        }


        $this->assignVariables([
            'QuestionID'            => $questionID,
            'TestId'                => $testId,
            'Question'              => $questionData,
            'NextQuestionId'        => $questionData['next_question_id'],
            'PreviousQuestionId'    => $questionData['previous_question_id'],
            'QuestionCategoryID'    => $questionCategoryID,
            'DBMS'                  => $questionData['dbms'],
            'DB'                    => $questionData['db_template'],
            'Questionnire'          => $test->getQuestionnire(),
        ]);
        $this->engine->display("test.tpl");
    }

    public function user_achievements(): void 
    {
        $achievements = [];
        if ($this->user->logged()) {
            $achievements = $this->user->achievements();
        }
        $this->engine->assign('User', $this->user);
        $this->engine->assign('Achievements', $achievements);
        $this->engine->display("achievements.tpl");
    }
}
?>