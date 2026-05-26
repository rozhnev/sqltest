<?php
class Controller 
{
    private $dbh;
    private $user;
    private $engine;
    private $env;
    private $domain;
    private $host;
    private $lang;
    private array $languages;

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

    public function __construct(PDO $dbh, Smarty $engine, User $user, array $env, array $config)
    {
        $this->dbh          = $dbh;
        $this->user         = $user;
        $this->engine       = $engine;
        $this->env          = $env;
        $this->domain       = $config['domain'] ?? 'localhost';
        $this->languages    = $config['languages'] ?? [];

        // Build absolute domain safely (works with proxies)
        $host = (string)($_SERVER['HTTP_HOST'] ?? $this->domain);

        $scheme = 'http';
        if (!empty($_SERVER['HTTP_X_FORWARDED_PROTO'])) {
            $scheme = strtolower(trim(explode(',', (string)$_SERVER['HTTP_X_FORWARDED_PROTO'])[0]));
        } elseif (!empty($_SERVER['REQUEST_SCHEME'])) {
            $scheme = strtolower((string)$_SERVER['REQUEST_SCHEME']);
        } elseif (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') {
            $scheme = 'https';
        }

        if ($scheme !== 'https' && $scheme !== 'http') {
            $scheme = 'https';
        }

        $this->host = $scheme . '://' . $host;

        $this->registerModifiers(["array_key_exists", "mt_rand", "array_rand"]);
        $this->engine->registerPlugin('block', 'translate', array('Localizer', 'translate'), true);
        $this->assignVariables([
            'VERSION'       => $env['VERSION'] ?? 0,
            'YANDEX_METRIKA_ID' => $env['YANDEX_METRIKA_ID'] ?? '',
            'GOOGLE_TAG_MANAGER_ID' => $env['GOOGLE_TAG_MANAGER_ID'] ?? '',
            'GOOGLE_CLIENT_ID' => $env['GOOGLE_CLIENT_ID'] ?? '',
            'GITHUB_CLIENT_ID' => $env['GITHUB_CLIENT_ID'] ?? '',
            'DONATION_MONTHLY_GOAL' => (float)($env['DONATION_MONTHLY_GOAL'] ?? 50),
            'DONATION_RECEIVED_CURRENT_MONTH' => (float)($env['DONATION_RECEIVED_CURRENT_MONTH'] ?? 0),
            'MobileView'    => $this->isMobileView(),
            'Languages'     => $this->languages,
            'User'          => $this->user,
        ]);
    }

    private function isMobileView(): bool
    {
        if (isset($_SERVER['SERVER_NAME']) && $_SERVER['SERVER_NAME'] === "m.{$this->domain}") {
            return true;
        }

        $userAgent = strtolower((string)($_SERVER['HTTP_USER_AGENT'] ?? ''));
        if ($userAgent === '') {
            return false;
        }

        return (bool) preg_match(
            '/android|iphone|ipad|ipod|blackberry|bb10|iemobile|opera mini|mobile|windows phone|webos|kindle|silk/i',
            $userAgent
        );
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
            'CanonicalLink' => "{$this->host}{$path}"
        ]);
    }

    private function assignSchemaJsonLd(array $schema): void
    {
        $this->assignVariables([
            'SchemaJsonLd' => json_encode($schema, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT)
        ]);
    }

    public function setHreflangLinks(string $path, string $currentLang): void
    {
        $langCodes   = array_keys($this->languages);
        $langPattern = implode('|', array_map('preg_quote', $langCodes));
        $urls        = [];

        foreach ($langCodes as $code) {
            $localPath  = preg_replace("@^/(?:{$langPattern})(?=/|$)@i", "/{$code}", $path);
            $urls[$code] = "{$this->host}{$localPath}";
        }

        // x-default points to the English version when available, otherwise first language
        $defaultLang = in_array('en', $langCodes, true) ? 'en' : $langCodes[0];
        $defaultPath = preg_replace("@^/(?:{$langPattern})(?=/|$)@i", "/{$defaultLang}", $path);
        $urls['x-default'] = "{$this->host}{$defaultPath}";

        $this->assignVariables(['HreflangUrls' => $urls]);
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
    public function redirect(array $params): void
    {
        $questionCategoryID = $params['questionCategoryId'];
        $questionID = $params['questionId'];
        if ($questionCategoryID && $questionID) {
            $questionnire = new Questionnire($this->dbh, $params['lang']);
            $redirectLink = $questionnire->getQuestionLink($questionCategoryID, $questionID);
            header("HTTP/1.1 301 Moved Permanently");
            header("Location: $redirectLink");
            exit();
        }
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
        $latestDonations = [];

        try {
            $stmt = $this->dbh->prepare(
                "SELECT
                    d.donated_at,
                    d.amount,
                    d.currency,
                    d.amount_usd,
                    d.notes,
                    COALESCE(NULLIF(TRIM(u.nickname), ''), 'Anonymous') AS donor_name
                 FROM donations d
                 LEFT JOIN users u ON u.id = d.user_id
                  ORDER BY d.donated_at DESC NULLS LAST, d.id DESC
                 LIMIT 5"
            );
            $stmt->execute();
            $latestDonations = $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];
        } catch (Throwable $e) {
            // Donations table may be unavailable in some environments.
            $latestDonations = [];
        }

        $this->engine->assign('LatestDonations', $latestDonations);
        $this->engine->assign('Action', 'donate');
        $this->engine->display("donate.tpl");
    }
    /**
     * Show welcome page
     * @param array $params
     */
    public function welcome(array $params): void
    {
        $questionnire = new Questionnire($this->dbh, $this->lang);
        $questionnireName   = $questionnire->getNameByCategory($params['questionCategory']);

        $this->assignVariables([
            'PageTitle'             => Localizer::translateString('welcome_page_title'),
            'PageOGTitle'           => Localizer::translateString('welcome_page_title'),
            'PageDescription'       => Localizer::translateString('welcome_page_description'),
            'Questionnire'          => $questionnire->get($questionnireName, $this->user->getId()),
            'Question'              => [],
            'Action'                => 'welcome',
            'QuestionsCount'        => $questionnire->getQuestionsCount(),
            'Favorites'             => $this->user->getFavorites($this->lang)
        ]);
        
        $this->setHreflangLinks($params['path'], $this->lang);

        $this->engine->display($this->isMobileView() ? "m.welcome.tpl" : "welcome.tpl");
    }
    /**
     * Show login result page
     * @param array $params
     */
    public function login(array $params): void
    {
        $isAjax = (isset($_REQUEST['ajax']) && $_REQUEST['ajax'] === '1');
        $success = $this->user->login($this->domain, $params['loginProvider'], $_REQUEST);

        if ($success) {
            if ($params['loginProvider'] !== 'session') {
                $this->user->saveAchievement('registration');
            }
            $_SESSION["user_id"] = $this->user->getId();
            $_SESSION["admin"] = $this->user->isAdmin();
        }
        if ($isAjax) {
            header('Content-Type: application/json');
            if ($success) {
                echo json_encode(['status' => 'ok']);
            } else {
                http_response_code(401);
                echo json_encode(['status' => 'error', 'message' => Localizer::translateString('action_not_permitted')]);
            }
            exit();
        }

        if (!$success) {
            $this->engine->assign('ErrorMessage', Localizer::translateString('action_not_permitted'));
            $this->engine->display("error.tpl");
            return;
        }

        $this->engine->display("login_result.tpl");
    }

    public function register(array $params): void
    {
        header('Content-Type: application/json');
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            http_response_code(405);
            echo json_encode(['status' => 'error', 'message' => Localizer::translateString('action_not_permitted')]);
            exit();
        }

        try {
            $email = trim((string)($_POST['email'] ?? ''));
            $password = (string)($_POST['password'] ?? '');
            $fullName = trim((string)($_POST['full_name'] ?? ''));

            if ($this->user->register($email, $password, $fullName)) {
                $_SESSION["user_id"] = $this->user->getId();
                $_SESSION["admin"] = $this->user->isAdmin();
                echo json_encode(['status' => 'ok']);
                exit();
            }

            echo json_encode(['status' => 'error', 'message' => Localizer::translateString('something_went_wrong')]);
        } catch (Exception $error) {
            echo json_encode(['status' => 'error', 'message' => $error->getMessage()]);
        }
        exit();
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
    public function menu(array $params): void 
    {
        $QuestionnireName = $_GET['questionnire'] ?? 'category';
        setcookie("Questionnire", $QuestionnireName, time() + 86400 * 365, "/" );
        $questionnire = new Questionnire($this->dbh, $this->lang);
        $this->assignVariables([
            'Questionnire'      => $questionnire->get($QuestionnireName, $this->user->getId()),
            'Lang'              => $this->lang
        ]);
        if ($this->user->logged()) {
            $this->engine->assign('Favorites', $this->user->getFavorites($this->lang));
        }
        $this->engine->display("menu.tpl");
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

    public function solution_unlike(array $params): void 
    {
        $this->engine->assign('Saved', false);
        if ($this->user->logged()) {
            $this->engine->assign('Saved', $this->user->unlikeSolution($params['solutionID']));
        }
        $this->engine->assign('User', $this->user);
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
        if ($this->user->logged()) {
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
        if ($this->user->logged()) {
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
        try {
            $questionData = $question->get($questionCategoryID, $this->lang, $this->user->getId());
        } catch (Exception $e) {
            header("HTTP/1.0 404 Not Found");
            $this->engine->assign('ErrorMessage', Localizer::translateString('action_not_permitted'));
            $this->engine->display("error.tpl");
            return;
        }
        if ($questionData['have_answers']) {
            $questionData['answers'] = $question->getAnswers($questionCategoryID, $this->lang, $this->user->getId());
            $questionData['last_query'] = json_decode($questionData['last_query']??'[]', true);
        }

        if ($this->user->logged()) {
            $this->user->setPath($params['path']);
            $this->user->save();
            $this->engine->assign('NewAchievement', $this->user->haveNewAchievement($this->lang));
        }

        $this->registerModifiers(['floor', 'in_array']);

        $dbmsLabel     = $questionData['dbms'] ?? 'SQL';
        $categoryTitle = $questionData['category_title'] ?? $params['questionCategory'];

        if (isset($questionData['answers'])) {
            $pageTitle = Localizer::translateString('page_question_title');
            $pageDescription = Localizer::translateString('page_question_description');
            $sitePromo = Localizer::translateString('site_promo');
            $siteDescription = Localizer::translateString('site_description_question_quiz');
        } else {
            $pageTitle = Localizer::translateString('page_task_title');
            $pageDescription = Localizer::translateString('page_task_description');
            $sitePromo = Localizer::translateString('site_promo');
            $siteDescription = Localizer::translateString('site_description_question_task');
        }
        $totalQuestions = $questionnire->getQuestionsCount();
        $questionNumber = $questionData['number'] ?? '?';
        $richDescription = sprintf("%s: «%s» (#%s of %s). Database: %s (%s). Improve SQL skills with this practical, real-world database exercise.", $pageDescription, $questionData['title'], $questionNumber, $totalQuestions, $categoryTitle, $dbmsLabel);
        $this->assignVariables([
            'PageTitle'             => sprintf("%s #%s: %s", $pageTitle, $questionNumber, $questionData['title']),
            'PageOGTitle'           => sprintf("%s #%s: %s", $pageTitle, $questionNumber, $questionData['title']),
            'PageDescription'       => $richDescription,
            'SitePromo'             => $sitePromo,
            'SiteDescription'       => $siteDescription,
            'UseAce'                => true,
            'QuestionID'            => $questionID,
            'Questionnire'          => $questionnire->get($questionnireName, $this->user->getId()),
            'QuestionCategoryID'    => $questionCategoryID,
            'Question'              => $questionData,
            'NextQuestionId'        => $question->getNextSefId($questionCategoryID),
            'PreviousQuestionId'    => $question->getPreviousSefId($questionCategoryID),
            'DB'                    => $questionData['db_template'],
            'DBMS'                  => $questionData['dbms'],
            'Action'                => 'question',
            'QuestionsCount'        => $totalQuestions,
            'SolvedQuestionsCount'  => $this->user->getSolvedQuestionsCount(),
            'Book'                  => Helper::getBook($this->dbh, $this->lang, $questionData['dbms']),
            'Favorites'             => $this->user->getFavorites($this->lang)
        ]);
        $this->setHreflangLinks($params['path'], $this->lang);
        $schemaType = $questionData['have_answers'] ? 'Quiz' : 'LearningResource';
        
        $this->assignSchemaJsonLd([
            '@context'            => 'https://schema.org',
            '@type'               => $schemaType,
            'name'                => $questionData['title'],
            'description'         => $richDescription,
            'url'                 => "{$this->host}/{$this->lang}/question/{$questionData['category_sef']}/{$questionData['question_sef']}",
            'inLanguage'          => $this->lang,
            'learningResourceType'=> $questionData['have_answers'] ? 'Quiz' : 'Exercise',
            'about'               => ['@type' => 'Thing', 'name' => $dbmsLabel],
            'provider'            => ['@type' => 'Organization', 'name' => 'SQLtest.online', 'url' => 'https://sqltest.online'],
        ]);
        $this->engine->display($this->isMobileView() ? "m.index.tpl" : "index.tpl");
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
            $this->engine->assign('QueryResult', $query->getResult($question->getDB(), 'json'));
        }

        $this->engine->display("query_result.tpl");
    }

    public function query_test(array $params): void 
    {
        $sql = $_POST["query"] ?? '';
        $questionID = $params['questionID'];
        $question = new Question($this->dbh, $questionID);
        // Prepare query for testing and check result
        $preparedQuery = $question->prepareQuery($sql);
        $query = new Query($preparedQuery);
        $jsonResult = $query->getResult($question->getDB(), 'json');
        $queryTestResult = $question->checkQueryResult($jsonResult);
        $this->assignVariables([
            'QuestionID'        => $questionID,
            'QueryTestResult'   => $queryTestResult,
            'QueryBestCost'     => $question->getBestCost()
        ]);
        if ($queryTestResult['ok']) {
            $queryCheckResult = $question->checkQuery($sql, $this->lang);
            // If query is not ok, we will show the error message
            if (!$queryCheckResult['ok']) {
                $this->engine->assign('QueryTestResult', $queryCheckResult);
                $queryTestResult['ok'] = false; // Set overall test result to false if query check failed
            }
        }

        if ($this->user->logged()) {
            $this->user->saveQuestionAttempt($questionID, $queryTestResult, $sql);
            if ($queryTestResult['ok'] && $queryCheckResult['ok']) {
                $this->user->saveSolution($questionID, $queryTestResult, $sql);
                $this->user->saveAchievement('first_task_solved');
                $this->user->updateAchievements();
            }
        }
        if (!$queryTestResult['ok'] || !$queryCheckResult['ok']) {
            header( 'HTTP/1.1 418 BAD REQUEST' );
        }

        if ($this->user->showAd()) {
            $referralLink = Helper::getReferralLink($this->dbh, $this->lang, $this->isMobileView() ? 'mobile' : 'desktop');
            Helper::updateReferralLinkStats($this->dbh, $referralLink['id']);
            $this->engine->assign('ReferralLink', $referralLink);
        }

        $this->engine->display($this->lang . "/query_test_result.tpl");
    }

    public function check_answers(array $params): void 
    {
        $answers = $_POST["answers"] ?? '[]';
        $question = new Question($this->dbh, $params['questionID']);
        $answerResult = $question->checkAnswers($answers);
        $this->assignVariables([
            'QuestionID'     => $params['questionID'],
            'AnswerResult'   => $answerResult
        ]);
        if ($this->user->logged()) {
            $this->user->saveQuestionAttempt($params['questionID'], $answerResult, $answers);
            if ($answerResult['ok']) {
                $this->user->saveAchievement('first_quiz_passed');
                $this->user->updateAchievements();
            }
        }

        if (!$answerResult['ok']) header( 'HTTP/1.1 418 BAD REQUEST' );
        if ($this->user->showAd()) {
            $referralLink = Helper::getReferralLink($this->dbh, $this->lang, $this->isMobileView() ? 'mobile' : 'desktop');
            if ($referralLink) {
                Helper::updateReferralLinkStats($this->dbh, $referralLink['id']);
                $this->engine->assign('ReferralLink', $referralLink);
            }
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
        $this->assignVariables([
            'SitePromo' => Localizer::translateString('site_promo'),
            'SiteDescription'       => Localizer::translateString('site_description_test'),
        ]);
        $this->engine->display("test_start.tpl");
    }

    public function challenge_mariadb(array $params): void 
    {
        $meta = [
            'en' => [
                'title'       => 'SQLTest.online: MariaDB Day Brussels SQL Quiz',
                'description' => 'Ten theoretical and practical questions for MariaDB Day Brussels with prizes on the FOSDEM stage.'
            ],
            'ru' => [
                'title'       => 'SQLTest.online: SQL-челлендж MariaDB Day Брюссель',
                'description' => 'Десять теоретических и практических заданий, связанные с MariaDB Day Brussels и призами на FOSDEM.'
            ],
            'pt' => [
                'title'       => 'SQLTest.online: Quiz SQL do MariaDB Day Bruxelas',
                'description' => 'Dez questões teóricas e práticas alinhadas ao MariaDB Day Bruxelas e prémios no FOSDEM.'
            ]
        ];

        $langMeta = $meta[$this->lang] ?? $meta['en'];
        $this->assignVariables([
            'PageTitle'       => $langMeta['title'],
            'PageDescription' => $langMeta['description'],
            'Action'          => 'challenge-mariadb',
            'User'            => $this->user
        ]);
        if ($this->user->logged()) {
            $this->engine->assign('LastTest', $this->user->getLastTest());
        }
        $this->engine->display("challenge-mariadb.tpl");
    }

    public function challenge_mariadb_start(array $params): void
    {
        if (!$this->user->logged()) {
            header("Location: /" . $this->lang . "/challenge-mariadb");
            exit();
        }

        $this->challenge_mariadb_create($params);
    }

    public function challenge_mariadb_create(array $params): void 
    {
        if (!$this->user->logged()) {
            header("Location: /" . $this->lang . "/test/start");
            exit();
        }
        $test = new Test($this->dbh, $this->lang, $this->user);

        $userTestId = $test->challenge_mariadb_create();
        $this->user->saveAchievement('get_challenge_mariadb');
        header("Location: /" . $this->lang . "/test/$userTestId/question/");
    }

    public function test_create(array $params): void 
    {
        if (!$this->user->logged()) {
            header("Location: /" . $this->lang . "/test/start");
            exit();
        }
        $test = new Test($this->dbh, $this->lang, $this->user);

        $userTestId = $test->create();
        $this->user->saveAchievement('get_test');
        header("Location: /" . $this->lang . "/test/$userTestId/question/");
    }

    public function test_result(array $params): void 
    {
        if (!$this->user->logged() || !isset($params['testId'])) {
            header("Location: /" . $this->lang . "/test/start");
            exit();
        }
        $test = new Test($this->dbh, $this->lang, $this->user);
        $test->setId($params['testId']);

        if(!$test->belongsToUser($this->user)) {
            header("HTTP/1.1 404 Not Found");
            $this->engine->assign('ErrorMessage', Localizer::translateString('action_not_permitted'));
            $this->engine->display("error.tpl");
            exit();
        }
        $testData = $test->getData();
        $testEnd   = new DateTime($testData['closed_at']);
        $testEnd -> add(new DateInterval('P1M0D'));
        $testData['next_test_in'] = $testEnd->diff(new DateTime())->days;

        $testResult = $test->calculateResult();
        $this->assignVariables([
            'SitePromo' => Localizer::translateString('site_promo'),
            'SiteDescription'       => Localizer::translateString('site_description_test'),
            'TestData'      => $testData,
            'TestResult'    => $testResult
        ]);

        $this->engine->display("test_result.tpl");
    }

    public function test_grade(array $params): void 
    {
        if (!$this->user->logged() || !isset($params['testId'])) {
            header("Location: /" . $this->lang . "/test/start");
            exit();
        }
        $test = new Test($this->dbh, $this->lang, $this->user);
        $test->setId($params['testId']);

        if(!$test->belongsToUser($this->user)) {
            header("HTTP/1.1 404 Not Found");
            $this->engine->assign('ErrorMessage', Localizer::translateString('action_not_permitted'));
            $this->engine->display("error.tpl");
            exit();
        }
        $testResult = $test->calculateResult();
        if ($testResult['ok']) {
            $this->user->saveGrade($testResult['grade']);
            $achievements = [1=>'get_intern_grade', 2=>'get_junior_grade', 2=>'get_middle_grade', 4=>'get_senior_grade'];
            $this->user->saveAchievement($achievements[$testResult['grade']]);
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
        $test->setId($params['testId']);

        if(!$test->belongsToUser($this->user)) {
            header("HTTP/1.1 404 Not Found");
            $this->engine->assign('ErrorMessage', Localizer::translateString('action_not_permitted'));
            $this->engine->display("error.tpl");
            exit();
        }
        $questionID = $params['questionID'] ?? $test->getFirstUnsolvedQuestionId();

        $question = new Question($this->dbh, $questionID);
        try {
            $questionData = $test->getQuestionData($questionID);
        } catch (Exception $e) {
            header("HTTP/1.1 404 Not Found");
            $this->engine->assign('ErrorMessage', Localizer::translateString('action_not_permitted'));
            $this->engine->display("error.tpl");
            exit();
        }
        $questionCategoryID = $questionData['category_id'];
        if ($questionData['have_answers']) {
            $questionData['answers'] = $question->getAnswers($questionCategoryID, $this->lang, $this->user->getId());
            $questionData['last_query'] = json_decode($questionData['last_query']??'[]', true);
        }

        $this->assignVariables([
            'CanonicalLink'         => "https://{$this->domain}/{$this->lang}/test/start",
            'PageTitle'             => Localizer::translateString('test_page_title'),
            'PageDescription'       => Localizer::translateString('test_page_description'),
            'PageOGTitle'           => Localizer::translateString('test_og_title'),
            'PageOGDescription'     => Localizer::translateString('test_og_description'),
            'SitePromo'             => Localizer::translateString('site_promo'),
            'SiteDescription'       => Localizer::translateString('site_description_test'),
            'UseAce'                => true,
            'QuestionID'            => $questionID,
            'TestId'                => $params['testId'],
            'Question'              => $questionData,
            'NextQuestionId'        => $questionData['next_question_id'],
            'PreviousQuestionId'    => $questionData['previous_question_id'],
            'QuestionCategoryID'    => $questionCategoryID,
            'DBMS'                  => $questionData['dbms'],
            'DB'                    => $questionData['db_template'],
            'Questionnire'          => $test->getQuestionnire(),
            'TestData'              => $test->getData(),
        ]);
        $this->engine->display($this->isMobileView() ? "m.test.tpl" : "test.tpl");
    }

    public function test_check(array $params): void 
    {
        if (!$this->user->logged()) {
            header("Location: /" . $this->lang . "/test/start");
            exit();
        }
        $test = new Test($this->dbh, $this->lang, $this->user);
        $test->setId($params['testId']);
        $this->engine->assign('TestId', $params['testId']);

        if(!$test->belongsToUser($this->user) || !isset($params['questionID'])) {
            header("HTTP/1.1 404 Not found");
            $this->engine->assign('ErrorMessage', Localizer::translateString('action_not_permitted'));
            $this->engine->display("error.tpl");
            exit();
        }
        $template = $this->lang . "/check_test_solution.tpl";

        $attemptStatus = $test->getQuestionAttemptStatus($params['questionID']);
        if (!$attemptStatus['ok']) {
            $this->engine->assign('QueryTestResult', $attemptStatus);
            $this->engine->display($template);
            return;
        }

        $question = new Question($this->dbh, $params['questionID']);

        if (isset($_POST["query"])) {
            $sql = $_POST["query"] ?? '';
            $checkResult = $question->checkQuery($sql);
            $this->engine->assign('QueryTestResult', $checkResult);
            if ($checkResult['ok']) {
                $preparedQuery = $question->prepareQuery($sql);
                $query = new Query($preparedQuery);
                $jsonResult = $query->getResult($question->getDB(), 'json');
                $checkResult = $question->checkQueryResult($jsonResult);
                $this->assignVariables([
                    'QueryTestResult' => $checkResult,
                    'QueryBestCost' => $question->getBestCost()
                ]);
            }
            $test->saveQuestionAttempt($params['questionID'], $checkResult, $sql);
        }

        if (isset($_POST["answers"])) {
            $answers = $_POST["answers"] ?? '[]';

            $checkResult = $question->checkAnswers($answers);
            $this->engine->assign('QueryTestResult', $checkResult);
            $test->saveQuestionAttempt($params['questionID'], $checkResult, $answers);
        }

        if (!$checkResult['ok']) header( 'HTTP/1.1 418 BAD REQUEST' );
        $this->engine->display($template);   
    }

    public function user_achievements(): void 
    {
        $achievements = [];
        if ($this->user->logged()) {
            $achievements = $this->user->achievements($this->lang, 5);
            $this->engine->assign('RecommendedAchievement', $this->user->recommendedAchievement($this->lang));

            $userId = (string)$this->user->getId();
            foreach ($achievements as &$achievement) {
                if (!isset($achievement['achievement_id'])) {
                    continue;
                }
                $shareUrl = "{$this->host}/{$this->lang}/achievement/" .$achievement['user_achievement_id'];
                $achievement['share_url'] = $shareUrl;
                $achievement['linkedin_share_url'] = 'https://www.linkedin.com/sharing/share-offsite/?url=' . rawurlencode($shareUrl);
            }
            unset($achievement);
        }
        $this->assignVariables([
            'User'            => $this->user,
            'Achievements'    => $achievements
        ]);
        $this->engine->display("achievements.tpl");
    }

    public function achievement(array $params): void 
    {
        $format = strtolower((string)($params['format'] ?? ''));

        $achievement = new Achievement($this->dbh, $params['achievementID']);
        $achievementData = $achievement->getData($this->lang);

        if (!$achievementData) {
            header('HTTP/1.1 404 Not Found');
            if ($format !== 'image') {
                $this->engine->assign('ErrorMessage', Localizer::translateString('error_message'));
                $this->engine->display('error.tpl');
            }
            return;
        }
        
        if ($this->user->logged()) {
            $this->user->markAchievementViewed($params['achievementID']);
        }

        $imageUrl = $this->host . '/' . $this->lang . '/achievement/image/' . $params['achievementID'];
        $sharePageUrl = $this->host . (string)($params['path'] ?? '');
        $linkedinShareUrl = 'https://www.linkedin.com/sharing/share-offsite/?url=' . rawurlencode($sharePageUrl);
        $facebookShareUrl = 'https://www.facebook.com/sharer/sharer.php?u=' . rawurlencode($sharePageUrl);
        $vkShareUrl = 'https://vk.com/share.php?url=' . rawurlencode($sharePageUrl);

        $this->assignVariables([
            'Action' => 'share-achievement',
            'User' => $this->user,
            'AchievementID' => $params['achievementID'],
            'ShareUserName' => $achievementData['share_user_name'],
            'EarnedAt' => $achievementData['earned_at'],
            'AchievementTitle' => $achievementData['achievement_title'],
            'SolvedTasksRates' => $achievementData['solved_tasks_rates'] ?? [],
            'SharePageUrl' => $sharePageUrl,
            'ImageUrl' => $imageUrl,
            'LinkedinShareUrl' => $linkedinShareUrl,
            'FacebookShareUrl' => $facebookShareUrl,
            'VKShareUrl' => $vkShareUrl,
            'CanonicalLink' => $sharePageUrl,
            'ShareImageUrl' => $imageUrl,
            'PageOGPublishedTime' => $achievementData['earned_at_iso'],
            'PageOGModifiedTime'  => $achievementData['earned_at_iso'],
        ]);

        $this->engine->display('share_achievement.tpl');
    }
    
    public function image(array $params): void 
    {
        $achievement = new Achievement($this->dbh, $params['achievementID']);

        $achievementData = $achievement->getData($this->lang);
        $achievement->renderShareImage($achievementData, $this->lang);
        return;
    }
    
    /**
     * Show user profile page
     * 
     * @param array $params Route parameters
     * @return void
     */
    public function user_profile(array $params): void
    {
        if (!$this->user->logged()) {
            header("Location: /{$this->lang}/");
            exit();
        }

        $questions = $this->user->getQuestions($this->lang);
        $tests = $this->user->getTests($this->lang);

        $this->assignVariables([
            'Action' => 'profile',
            'Title' => Localizer::translateString('profile_page_title'),
            'User'  => $this->user,
            'Questions'     => $this->user->getQuestions($this->lang),
            'Tests'         => $this->user->getTests($this->lang),

            'Achievements'  => $this->user->achievements($this->lang),
            'UserEmail'     => $this->user->getEmail(),
        ]);

        $this->engine->display('user_profile.tpl');
    }

    /**
     * Update user nickname
     * 
     * @param array $params Route parameters
     * @return void
     */
    public function user_update(array $params): void
    {
        header('Content-Type: application/json');

        if (!$this->user->logged()) {
            echo json_encode([
                'ok' => false,
                'error' => Localizer::translateString('login_needed')
            ]);
            return;
        }

        $data = json_decode(file_get_contents('php://input'), true) ?: [];
        $updated = false;

        try {
            if (array_key_exists('nickname', $data)) {
                $nickname = trim((string)$data['nickname']);
                $this->user->setNickname($nickname);
                $updated = true;
            }

            if (array_key_exists('full_name', $data)) {
                $fullName = trim((string)$data['full_name']);
                $this->user->setFullName($fullName);
                $updated = true;
            }

            if (array_key_exists('email', $data)) {
                $email = trim((string)$data['email']);
                $this->user->setEmail($email);
                $updated = true;
            }

            if (array_key_exists('password', $data)) {
                $password = (string)$data['password'];
                if ($password !== '') {
                    $this->user->setPassword($password);
                    $updated = true;
                }
            }

            if (!$updated) {
                echo json_encode([
                    'ok' => false,
                    'error' => Localizer::translateString('nothing_to_update')
                ]);
                return;
            }

            echo json_encode([
                'ok' => true,
                'message' => Localizer::translateString('profile_update_success')
            ]);
        } catch (Exception $e) {
            echo json_encode([
                'ok' => false,
                'error' => $e->getMessage()
            ]);
        }
    }

    public function lesson(array $params): void
    {
        $slug = $params['lesson'] ?? 'introduction-to-databases';
        try {
            $lesson = new Lesson($this->dbh, $slug);
        } catch (Exception $e) {
            header("HTTP/1.1 404 Not Found");
            $this->engine->assign('ErrorMessage', Localizer::translateString('action_not_permitted'));
            $this->engine->display("error.tpl");
            exit();
        }
        $parser = new \cebe\markdown\GithubMarkdown();
        $lessonData = $lesson->get($this->lang);
        $meta = $lesson->parseMedadata($lessonData['content']);
        $readingMinutes = 15;
        if (preg_match('/Reading time:\s*~?(\d+)\s*min/i', $lessonData['content'], $matches)) {
            $readingMinutes = max(1, (int)$matches[1]);
        }
        $lessonData['content'] = $parser->parse($lessonData['content']);

        $pageTitle       = $meta['title']       ?? (Localizer::translateString('lessons_page_title') . ' ' . $lessonData['title']);
        $pageDescription = $meta['description'] ?? '';
        $pageKeywords    = isset($meta['keywords']) ? implode(', ', (array) $meta['keywords']) : null;
        $schemaTeaches   = $meta['teaches'];
        $schemaAbout     = $meta['about'];
        $schemaAboutEntities = array_map(
            static fn($topic) => ['@type' => 'Thing', 'name' => $topic],
            $schemaAbout
        );

        $this->assignVariables([
            'Action'            => 'lesson',
            'PageTitle'         => $pageTitle,
            'SitePromo'         => Localizer::translateString('site_promo'),
            'SiteDescription'   => $pageDescription,
            'PageDescription'   => $pageDescription,
            'PageOGTitle'       => $pageTitle,
            'PageOGDescription' => $pageDescription,
            'PageKeywords'      => $pageKeywords,
            'Lessons'           => $lesson->getList($this->lang),
            'Lesson'            => $lesson,
            'LessonData'        => $lessonData
        ]);
        $this->setHreflangLinks($params['path'], $this->lang);

        $updatedAt      = $lessonData['updated_at'] ?? null;
        $dateModified   = $updatedAt ? (new DateTimeImmutable($updatedAt))->format(DateTimeInterface::ATOM) : null;

        $schema = [
            '@context'            => 'https://schema.org',
            '@type'               => 'LearningResource',
            'name'                => $pageTitle,
            'description'         => $pageDescription,
            'url'                 => "{$this->host}/{$this->lang}/lesson/{$lesson->moduleSlug()}/{$lesson->slug()}",
            'inLanguage'          => $this->lang,
            'educationalLevel'    => 'Beginner',
            'learningResourceType'=> 'Lesson',
            'timeRequired'        => 'PT' . $readingMinutes . 'M',
            'teaches'             => $schemaTeaches,
            'isPartOf'            => [
                '@type' => 'Course',
                'name'  => 'SQL Lessons',
                'url'   => "{$this->host}/{$this->lang}/lesson"
            ],
            'about'               => $schemaAboutEntities,
            'provider'            => ['@type' => 'Organization', 'name' => 'SQLtest.online', 'url' => 'https://sqltest.online'],
        ];
        if ($dateModified) {
            $schema['dateModified']   = $dateModified;
            $schema['datePublished']  = $dateModified; // fallback until created_at is tracked separately
        }
        $this->assignSchemaJsonLd($schema);
        $this->engine->display($this->isMobileView() ? "m.lesson.tpl" : "lesson.tpl");
    }

    public function playground(array $params): void 
    {
        if (!$this->user->logged() && ($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'GET') {
            header('Cache-Control: public, max-age=300, s-maxage=900, stale-while-revalidate=60');
        }

        $pageTitle = Localizer::translateString('playground_page_title');
        $pageDescription = Localizer::translateString('playground_page_description');

        $this->assignVariables([
            'Action'            => 'playground',
            'PageTitle'         => $pageTitle,
            'PageDescription'   => $pageDescription,
            'SitePromo'         => Localizer::translateString('site_promo'),
            'SiteDescription'   => Localizer::translateString('site_description_playground'),
            'PageKeywords'      => Localizer::translateString('playground_page_keywords'),
            'PageOGTitle'       => Localizer::translateString('playground_og_title'),
            'PageOGDescription' => Localizer::translateString('playground_og_description'),
            'UseAce'            => true,
            'QuestionID'            => 1,
            'DB'                    => '',
        ]);

        $this->setHreflangLinks($params['path'], $this->lang);

        $schema = [
            '@context' => 'https://schema.org',
            '@graph' => [
                [
                    '@type' => 'WebApplication',
                    'name' => $pageTitle,
                    'description' => $pageDescription,
                    'url' => "{$this->host}/{$this->lang}/playground/",
                    'inLanguage' => $this->lang,
                    'applicationCategory' => 'DeveloperApplication',
                    'operatingSystem' => 'Web',
                    'isAccessibleForFree' => true,
                    'offers' => [
                        '@type' => 'Offer',
                        'price' => '0',
                        'priceCurrency' => 'USD'
                    ],
                    'featureList' => [
                        Localizer::translateString('playground_content_feature_1'),
                        Localizer::translateString('playground_content_feature_2'),
                        Localizer::translateString('playground_content_feature_3'),
                    ],
                    'provider' => [
                        '@type' => 'Organization',
                        'name' => 'SQLtest.online',
                        'url' => 'https://sqltest.online'
                    ]
                ],
                [
                    '@type' => 'FAQPage',
                    'mainEntity' => [
                        [
                            '@type' => 'Question',
                            'name' => Localizer::translateString('playground_content_faq_q1'),
                            'acceptedAnswer' => [
                                '@type' => 'Answer',
                                'text' => Localizer::translateString('playground_content_faq_a1')
                            ]
                        ],
                        [
                            '@type' => 'Question',
                            'name' => Localizer::translateString('playground_content_faq_q2'),
                            'acceptedAnswer' => [
                                '@type' => 'Answer',
                                'text' => Localizer::translateString('playground_content_faq_a2')
                            ]
                        ],
                        [
                            '@type' => 'Question',
                            'name' => Localizer::translateString('playground_content_faq_q3'),
                            'acceptedAnswer' => [
                                '@type' => 'Answer',
                                'text' => Localizer::translateString('playground_content_faq_a3')
                            ]
                        ]
                    ]
                ]
            ]
        ];

        $this->assignSchemaJsonLd($schema);
        $this->engine->display($this->isMobileView() ? "m.playground.tpl" : "playground.tpl");
    }

    public function playground_query_run(array $params): void 
    {
        $sql = $_POST["query"] ?? '';
        if (!empty($sql)) {
            $query = new Query($sql);
            $this->engine->assign('QueryResult', $query->getResult($params['database'], 'json'));
        }

        $this->engine->display("query_result.tpl");
    }
    public function embed(array $params): void 
    {
        $this->assignVariables([
            'Action'            => 'embed',
            'PageTitle'         => Localizer::translateString('embed_page_title'),
            'PageDescription'   => Localizer::translateString('playground_page_description'),
            'SitePromo'         => Localizer::translateString('site_promo'),
            'SiteDescription'   => Localizer::translateString('site_description_playground'),
            'PageOGTitle'       => Localizer::translateString('playground_og_title'),
            'PageOGDescription' => Localizer::translateString('playground_og_description'),
            'QuestionID'            => 1,
            'DB'                    => '',
        ]);
        $this->engine->display("embed.tpl");
    }

    public function sitemap(array $params): void 
    {
        header('Content-Type: text/xml; charset=utf-8');
        header('X-Robots-Tag: all');
        $questionnire = new Questionnire($this->dbh, $this->lang);
        $lessons = new Lesson($this->dbh, 'introduction-to-databases');

        $this->assignVariables([
            'Domain' => $this->domain,
            'Questionnire' => $questionnire->getMap(),
            'Lessons' => $lessons->getMap(),
            'Today' => date('Y-m-d'),
        ]);
        $this->engine->display("sitemap.tpl");
    }
}
?>