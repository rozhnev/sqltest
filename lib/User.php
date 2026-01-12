<?php
class User 
{
    /**
     * DB hahdler 
     *
     * @var PDO
     */
    private $dbh;

    /**
     * Application environment
     *
     * @var array
     */
    private $env;
    /**
     * User login
     *
     * @var string
     */
    private $login;

    /**
     * User id
     *
     * @var string|null
     */
    private $id;
    private $grade;
    private $graded_at;
    private $show_ad = true;
    private $admin = false;
    private $nickname;

    private $grades = [ 1 => 'Intern', 2 => 'Junior', 3 => 'Middle', 4 => 'Senior'];
    /**
     * User current path
     *
     * @var string
     */
    private $path;

    public function __construct(PDO $dbh, array $env)
    {
        $this->env  = $env;
        $this->dbh  = $dbh;
    }

    /**
     * Undocumented function
     *
     * @param string $provider
     * @param array $request
     * @return bool
     */
    public function login(string $provider, $request): bool
    {
        switch ($provider) {
            case 'yandex':
                return $this->loginYandex($_GET['code']);
            case 'github':
                return $this->loginGithub($_GET['code']);
            case 'google':
                return $this->loginGoogle($_GET['code']);
            case 'vk':
                return $this->loginVK($_GET['payload']);
            case 'linkedin':
                return $this->loginLinkedin($_GET['code']);
            case 'session':
                return $this->loginSession($_SESSION);
            default:
                throw new Exception('Not supported login provider'); 
        }
    }
    public function loginSession(array $session): bool
    {
        if (($session && isset($session['user_id']))) {
            $stmt = $this->dbh->prepare("SELECT 
                    id, grade, graded_at, (hide_ad_till is null or hide_ad_till < current_date) show_ad, admin, nickname
                FROM users WHERE id = :user_id;");
            $stmt->execute([':user_id' => $session['user_id']]);
            $user = $stmt->fetch(PDO::FETCH_ASSOC);
            if ($user) {
                $this->id = $user['id'];
                $this->grade = $user['grade'];
                $this->graded_at = $user['graded_at'];
                $this->show_ad = $user['show_ad'];
                $this->admin = $user['admin'];
                $this->nickname = $user['nickname'];
                return true;
            }
        }
        return false;
    }
    /**
     * Proceed Linkedin login with code
     *
     * @param string $code
     * @return bool
     */
    public function loginLinkedin(string $code): bool
    {
        $ch = curl_init('https://www.linkedin.com/oauth/v2/accessToken');
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/x-www-form-urlencoded'));

        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query([
            'grant_type'    => 'authorization_code',
            'code'          => $code,
            'redirect_uri'  => 'https://sqltest.online/login/linkedin/',
            'client_id'     => $this->env['LINKEDIN_CLIENT_ID'],
            'client_secret' => $this->env['LINKEDIN_SECRET']
        ]));

        $response = curl_exec($ch);
        curl_close($ch);
        $json = json_decode($response);

        $accessToken = $json->access_token;

        if ($accessToken) {
            $crl = curl_init('https://api.linkedin.com/v2/userinfo');

            curl_setopt($crl, CURLOPT_FRESH_CONNECT, true);
            curl_setopt($crl, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($crl, CURLOPT_HTTPHEADER, array("Authorization: Bearer ".$accessToken));

            $userData = curl_exec($crl);
            curl_close($ch);
            $info = json_decode($userData, true);
            if (!$info['email'])  return false;

            $this->login = $info['email'] . '@linkedin';
            $this->upsert();
            return true;
        }

        return false;
    }

    /**
     * Proceed VK login with code
     *
     * @param string $code
     * @return bool
     */
    public function loginVK(string $payload): bool
    {
        $data = json_decode($payload, true);

        if (isset($data['auth']) && $data['auth'] == 1) {

            $ch = curl_init('https://api.vk.com/method/auth.exchangeSilentAuthToken');
            if ($ch) {
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query([
                    'v'             => '5.131',
                    'token'         => $data['token'],
                    'access_token'  => $this->env['VK_ACCESS_TOKEN'],
                    'uuid'          => $data['uuid'],
                ]));
                curl_setopt($ch, CURLOPT_HEADER, false);
                $info = curl_exec($ch);
                curl_close($ch);
        
                $info = json_decode($info, true);
                
                if (!$info['response']['user_id'])  return false;

                $this->login = $info['response']['user_id'] . '@vk';
                $this->upsert();
                return true;
            }
            return false;
        }
        return false;
    }
    /**
     * Proceed Google login with code
     *
     * @param string $code
     * @return bool
     */
    public function loginGoogle(string $code): bool
    {
        // Exchange the authorization code for an access token
        $ch = curl_init('https://www.googleapis.com/oauth2/v4/token');
        $baseURL = 'https://' . $_SERVER['SERVER_NAME'] . $_SERVER['PHP_SELF'];
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query([
            'grant_type'    => 'authorization_code',
            'client_id'     => $this->env['GOOGLE_CLIENT_ID'],
            'client_secret' => $this->env['GOOGLE_SECRET'],
            'redirect_uri'  => $baseURL,
            'code' => $code
        ]));
        $data = json_decode(curl_exec($ch), true);
        if (!empty($data['access_token'])) {
            // Токен получили, получаем данные пользователя.
            $ch = curl_init('https://www.googleapis.com/oauth2/v3/userinfo');
            if ($ch) {
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                curl_setopt($ch, CURLOPT_HTTPHEADER,  [
                    'Authorization: Bearer ' . $data['access_token'],
                ]);
                curl_setopt($ch, CURLOPT_HEADER, false);
                $info = curl_exec($ch);
                curl_close($ch);
        
                $info = json_decode($info, true);
    
                $this->login = $info['email'] . '@google';
                $this->upsert();
                return true;
            }
            return false;
        }
        return false;
    }
    /**
     * Proceed GitHub login with code
     *
     * @param string $code
     * @return bool
     */
    public function loginGithub(string $code): bool
    {
        $params = array(
            'grant_type'    => 'authorization_code',
            'code'          => $code,
            'client_id'     => $this->env['GITHUB_CLIENT_ID'],
            'client_secret' => $this->env['GITHUB_SECRET'],
        );
        
        $ch = curl_init('https://github.com/login/oauth/access_token');
        if ($ch) {
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $params); 
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_HTTPHEADER,  ['Accept: application/json']);
            curl_setopt($ch, CURLOPT_HEADER, false);
            
            $data = curl_exec($ch);
            curl_close($ch);
            if (empty($data)) return false;
                     
            $data = json_decode($data, true);
            if (!empty($data['access_token'])) {
                // Токен получили, получаем данные пользователя.
                $ch = curl_init('https://api.github.com/user');
                if ($ch) {
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                    curl_setopt($ch, CURLOPT_HTTPHEADER,  [
                        'Authorization: Bearer ' . $data['access_token'],
                        'Accept: application/vnd.github+json',
                        'X-GitHub-Api-Version: 2022-11-28',
                        'User-Agent: SQLtest.online'
                    ]);
                    curl_setopt($ch, CURLOPT_HEADER, false);
                    $info = curl_exec($ch);
                    curl_close($ch);
            
                    $info = json_decode($info, true);
        
                    $this->login = $info['login'] . '@github';
                    $this->upsert();
                    return true;
                }
                return false;
            }
        }

        return false;
    }

    /**
     * Proceed Yandex login with code
     *
     * @param string $code
     * @return bool
     */
    public function loginYandex(string $code): bool
    {
        $params = array(
            'grant_type'    => 'authorization_code',
            'code'          => $code,
            'client_id'     => $this->env['YANDEX_CLIENT_ID'],
            'client_secret' => $this->env['YANDEX_SECRET'],
        );
        
        $ch = curl_init('https://oauth.yandex.ru/token');
        if ($ch) {
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $params); 
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_HEADER, false);
            $data = curl_exec($ch);
            curl_close($ch);
            if (empty($data)) return false;
                     
            $data = json_decode($data, true);
            if (!empty($data['access_token'])) {
                // Токен получили, получаем данные пользователя.
                $ch = curl_init('https://login.yandex.ru/info');
                if ($ch) {
                    curl_setopt($ch, CURLOPT_POST, 1);
                    curl_setopt($ch, CURLOPT_POSTFIELDS, array('format' => 'json')); 
                    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Authorization: OAuth ' . $data['access_token']));
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                    curl_setopt($ch, CURLOPT_HEADER, false);
                    $info = curl_exec($ch);
                    curl_close($ch);
            
                    $info = json_decode($info, true);
        
                    $this->login = $info['login'] . '@yandex';
                    $this->upsert();
                    return true;
                }
                return false;
            }
        }

        return false;
    }

    /**
     * Return User logged status
     *
     * @return bool
     */
    public function logged(): bool
    {
        return isset($this->id);
    }

    /**
     * Return User's grade
     *
     * @return string
     */
    public function grade(): ?string
    {
        return $this->grade ? $this->grades[$this->grade] : null;
    }

    /**
     * Return User's grade
     *
     * @return string
     */
    public function nickname(): ?string
    {
        return $this->nickname;
    }

    /**
     * Return User admin status
     *
     * @return bool
     */
    public function isAdmin(): bool
    {
        return $this->admin;
    }

    /**
     * Return User show advertising status
     *
     * @return bool
     */
    public function showAd(): bool
    {
        return $this->show_ad;
    }

    /**
     * Set User's id and admin status
     *
     * @param string $id
     * @param bool $admin
     * @return void
     */
    public function set(string $id, bool $admin): void
    {
        $this->id = $id;
        $this->admin = $admin;
    }

    /**
     * Set User's id
     *
     * @param string $id
     * @return void
     */
    public function setId(string $id): void
    {
        $this->id = $id;
    }

    /**
     * Returns User id
     *
     * @return string|null
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Store new user in DB update id
     *
     * @return void
     */
    public function upsert(): void
    {
        $this->id = vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex(random_bytes(16)), 4));

        $stmt = $this->dbh->prepare("
            INSERT INTO users (id, login) VALUES (?, ?) 
            ON CONFLICT (login) DO 
               UPDATE SET last_login_at = CURRENT_TIMESTAMP 
            RETURNING id");
        if ($stmt->execute([$this->id, $this->login])) {
            $this->id = (string)$stmt->fetchColumn();
        }
    }

    /**
     * Set User's current path
     *
     * @param string $path
     * @return void
     */
    public function setPath(string $path): void
    {
        $this->path = $path;
    }

    /**
     * Save user state in DB
     *
     * @return void
     */
    public function save(): void
    {
        $stmt = $this->dbh->prepare("UPDATE users SET last_path = ? WHERE id = ?");
        $stmt->execute([$this->path, $this->id]);
    }

    /**
     * Save Questoin attepmt in DB
     *
     * @param integer $questionID
     * @param array $result
     * @param string $query
     * @return void
     */
    public function saveQuestionAttempt(int $questionID, array $result, string $query): void
    {
        try {
            $stmt = $this->dbh->prepare("
                INSERT INTO user_questions (
                    user_id, question_id, last_attempt_at, solved_at, last_query, query_cost
                ) VALUES (
                    ?, ?, CURRENT_TIMESTAMP, CASE WHEN ".($result['ok'] ? 'true' : 'false')." THEN CURRENT_TIMESTAMP END, ?, ?
                ) 
                ON CONFLICT (user_id, question_id) DO UPDATE SET
                    last_attempt_at = CURRENT_TIMESTAMP, 
                    solved_at = LEAST(user_questions.solved_at, EXCLUDED.solved_at),
                    last_query = EXCLUDED.last_query,
                    query_cost = EXCLUDED.query_cost
            ");
            $stmt->execute([$this->id, $questionID, $query, floatval($result['cost'])]);
        }
        catch (\Throwable $error) {
            throw new Exception($error->getMessage());
        }
    }

    /**
     * Save Questoin attepmt in DB
     *
     * @param integer $questionID
     * @param array $result
     * @param string $query
     * @return void
     */
    public function saveSolution(int $questionID, array $result, string $query): void
    {
        try {
            $stmt = $this->dbh->prepare("
                INSERT INTO user_solutions (
                    user_id, question_id, query, query_cost, created_at
                ) VALUES (
                    ?, ?, ?, ?, CURRENT_TIMESTAMP
                ) 
                ON CONFLICT (question_id, user_id, query) DO NOTHING
            ");
            $stmt->execute([$this->id, $questionID, $query, floatval($result['cost'])]);
        }
        catch (\Throwable $error) {
            throw new Exception($error->getMessage());
        }
    }

    /**
     * Returns the user's solutions for the specified question.
     * 
     * @param int $questionID The ID of the question.
     * @return array The user's solutions for the specified question.
     */
    public function getSolutions(int $questionID): array
    {
        $stmt = $this->dbh->prepare("SELECT 
                id, query, query_cost, created_at::date, likes, dislikes, reported 
            FROM user_solutions 
            WHERE user_id = ? AND question_id = ?
            ORDER BY created_at DESC;");
        $stmt->execute([$this->id, $questionID]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
    
    /**
     * Returns the other users solutions for the specified question.
     * 
     * @param int $questionID The ID of the question.
     * @param int $limit The maximum number of solutions to return.
     * @return array The other users solutions for the specified question.
     */
    public function getOthersSolutions(int $questionID, $limit = 3): array 
    {
        $stmt = $this->dbh->prepare("
            SELECT 
                id, question_id, query, query_cost, user_solutions.created_at::date created_at, 
                likes, dislikes, 
                solution_likes.solution_id is not null liked
            FROM user_solutions 
            LEFT JOIN solution_likes ON solution_id = id AND solution_likes.user_id = :user_id
            WHERE question_id = :question_id AND NOT reported
            ORDER BY query_cost ASC, (likes - dislikes) DESC, RANDOM()
            LIMIT " . $limit);

        $stmt->execute([':question_id' => $questionID, ':user_id' => $this->id]);
        return  $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    /**
     * Deletes a solution by its ID for the current user.
     *
     * @param int $solutionID The ID of the solution to delete.
     * @return int The ID of the question associated with the deleted solution.
     */
    public function deleteSolution(int $solutionID): int
    {
        $stmt = $this->dbh->prepare("DELETE
            FROM user_solutions 
            WHERE user_id = ? AND id = ? RETURNING question_id;");
        $stmt->execute([$this->id, $solutionID]);
        return $stmt->fetchColumn(0);
    }

    /**
     * Likes a solution by its ID for the current user.
     *
     * @param int $solutionID The ID of the solution to like.
     * @return bool True on success, false on failure.
     */
    public function likeSolution(int $solutionID): bool
    {
        $stmt = $this->dbh->prepare("WITH solution AS (
	        INSERT INTO solution_likes (user_id, solution_id, created_at) 
            VALUES (:user_id, :solution_id, current_timestamp) 
	        ON CONFLICT (user_id, solution_id) DO NOTHING
            RETURNING solution_id
        ) UPDATE user_solutions SET likes = likes + 1 WHERE id IN (SELECT solution.solution_id FROM solution);");

        return $stmt->execute([':user_id' => $this->id, ':solution_id' => $solutionID]);
    }

    /**
     * Unlikes a solution by its ID for the current user.
     *
     * @param int $solutionID The ID of the solution to unlike.
     * @return bool True on success, false on failure.
     */
    public function unlikeSolution(int $solutionID): bool 
    {
        $stmt = $this->dbh->prepare("WITH solution AS (
	        DELETE FROM solution_likes WHERE user_id = :user_id AND solution_id = :solution_id
	        RETURNING solution_id
        ) UPDATE user_solutions SET likes = likes - 1 WHERE id IN (SELECT solution.solution_id FROM solution);");

        return $stmt->execute([':user_id' => $this->id, ':solution_id' => $solutionID]);
    }

    /**
     * Saves the rating for a question in the database.
     *
     * @param int $questionID The ID of the question.
     * @param int $rate The rating to save.
     * @return bool True on success, false on failure.
     */
    public function saveQuestionRate(int $questionID, int $rate): bool
    {
        try {
            $stmt = $this->dbh->prepare("
                UPDATE user_questions 
                SET rate = :rate
                WHERE user_id = :user_id AND question_id = :question_id
            ");
            return $stmt->execute([':user_id' => $this->id, ':question_id' => $questionID, ':rate' => $rate]);
        }
        catch (\Throwable $error) {
            throw new Exception($error->getMessage());
        }
    }

    /**
     * Returnt the statust of user's solution for the specified question.
     * 
     * @param int $questionID The ID of the question.
     * @return bool True if the user has solved the question, false otherwise.
     */
    public function solvedQuestion(int $questionID): bool
    {
        $stmt = $this->dbh->prepare("SELECT true FROM user_questions WHERE user_id = :user_id and question_id = :question_id and solved_at is not null;");
        $stmt->execute([':user_id' => $this->id, ':question_id' => $questionID]);
        return $stmt->fetchColumn(0);
    }

    /**
     * Returns the number of questions solved by the user.
     * 
     * @return int The number of questions solved by the user.
     */
    public function getSolvedQuestionsCount(): int 
    {
        if (!$this->logged()) return 0;
        $stmt = $this->dbh->prepare("SELECT COUNT(question_id) FROM user_questions WHERE user_id = :user_id and solved_at is not null;");
        $stmt->execute([':user_id' => $this->id]);
        return $stmt->fetchColumn(0);
    }

    public function getSolvedQuestionsCountByRate(): array 
    {
        if (!$this->logged()) return 0;
        $stmt = $this->dbh->prepare("WITH 
            quizes as (
                select distinct question_id from answers
            ),
            stats AS (
                SELECT
                    question_rates.id rate_id, 
                    LOWER(question_rates.rate_en) rate, 
                    COUNT(questions.id) questions_count, 
                    COUNT(quizes.question_id) quizzes_count, 
                    COUNT(user_questions.question_id) solved_count,
                    COUNT(user_questions.question_id) filter (where quizes.question_id is not null) quizzes_solved_count
                FROM questions
                JOIN question_rates ON questions.rate = question_rates.id
                LEFT JOIN user_questions ON user_questions.question_id = questions.id AND user_id = :user_id AND solved_at is not null 
                left join quizes on quizes.question_id = questions.id
                WHERE questions.deleted = false
                GROUP BY question_rates.id, question_rates.rate_en
            )
            SELECT 
                rate_id,
                rate,
                questions_count,
                solved_count,
                SUM(questions_count) OVER () as total_questions,
                SUM(quizzes_count) OVER () as total_quizzes,
                SUM(solved_count) OVER () as total_solved,
                SUM(quizzes_solved_count) OVER () as quizzes_solved_count
            FROM stats
            ORDER BY rate_id;");

        $stmt->execute([':user_id' => $this->id]);
        return  $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    /**
     * Returns last user's test data.
     * 
     * @return array|null The last user's test data ot null in case never test taken.
     */
    public function getLastTest(): ?array
    {
        $stmt = $this->dbh->prepare("
            SELECT id, created_at, closed_at, (closed_at is not null and closed_at <= current_timestamp) closed, rate 
            FROM tests 
            WHERE user_id = :user_id order by created_at desc limit 1;
        ");
        $stmt->execute([':user_id' => $this->id]);
        return $stmt->fetch(PDO::FETCH_ASSOC) ?: null;
    }

    /**
     * Save user's grade in DB
     * 
     * @param int $grade The grade to save.
     * @return void
     */
    public function saveGrade(int $grade): void
    {
        $stmt = $this->dbh->prepare("UPDATE users SET grade = :grade, graded_at = CURRENT_TIMESTAMP WHERE id = :user_id;");
        $stmt->execute([':user_id' => $this->id, ':grade' => $grade]);
    }
    public function haveNewAchievement(): bool
    {
        $stmt = $this->dbh->prepare("SELECT EXISTS (
            SELECT true FROM user_achievements WHERE user_id = :user_id and viewed_at is null
        );");
        $stmt->execute([':user_id' => $this->id]);
        return $stmt->fetchColumn(0);
    }

    public function achievements(string $lang): array
    {
        $stmt = $this->dbh->prepare("SELECT user_achievements.achievement_id,
                user_achievements.user_achievement_id,
                achievements_localization.title,
                user_achievements.earned_at::date earned_at,
                to_char((user_achievements.earned_at AT TIME ZONE 'UTC'), 'YYYY-MM-DD\"T\"HH24:MI:SS\"Z\"') AS earned_at_iso,
                viewed_at
            FROM user_achievements
            JOIN achievements ON user_achievements.achievement_id = achievements.id
            JOIN achievements_localization ON achievements.id = achievements_localization.achievement_id AND achievements_localization.language = :lang
            WHERE user_id = :user_id and not achievements.deleted
            ORDER BY user_achievements.earned_at DESC;");

        $stmt->execute([':lang' => $lang, ':user_id' => $this->id]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];
    }

    public function recommendedAchievement(string $lang): ?string
    {
        $stmt = $this->dbh->prepare("WITH user_completed_achievements AS (
                SELECT ua.achievement_id
                FROM user_achievements ua
                WHERE ua.user_id = :user_id
            )
            SELECT al.recommended
            FROM achievements a
            JOIN achievements_localization al ON a.id = al.achievement_id AND al.language = :lang
            WHERE not a.deleted 
            AND NOT EXISTS (
                SELECT 1 FROM user_completed_achievements WHERE achievement_id = a.id
            )
            AND NOT (
                (a.id = 10 AND EXISTS (SELECT 1 FROM user_completed_achievements WHERE achievement_id = 12)) OR
                (a.id IN (10, 12) AND EXISTS (SELECT 1 FROM user_completed_achievements WHERE achievement_id = 14)) OR
                (a.id IN (10, 12, 14) AND EXISTS (SELECT 1 FROM user_completed_achievements WHERE achievement_id = 18))
            )
            ORDER BY a.sequence_position ASC
            LIMIT 1;");

        $stmt->execute([':lang' => $lang, ':user_id' => $this->id]);
        return $stmt->fetchColumn(0);
    }

    public function saveAchievement(string $achievement): void
    {
        $userAchievementID = vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex(random_bytes(16)), 4));

        $stmt = $this->dbh->prepare("INSERT INTO user_achievements ( user_id, achievement_id, earned_at, user_achievement_id)
            SELECT :user_id, achievements.id, CURRENT_TIMESTAMP, :user_achievement_id FROM achievements WHERE title = :achievement
            ON CONFLICT (user_id, achievement_id) DO NOTHING;");

        $stmt->execute([':user_id' => $this->id, ':achievement' => $achievement, ':user_achievement_id' => $userAchievementID]);
    }


    public function markAchievementViewed(string $userAchievementID): void
    {
        $stmt = $this->dbh->prepare("UPDATE user_achievements 
            SET viewed_at = CURRENT_TIMESTAMP 
            WHERE user_id = :user_id AND user_achievement_id = :user_achievement_id AND viewed_at IS NULL;");

        $stmt->execute([
            ':user_id' => $this->id, 
            ':user_achievement_id' => $userAchievementID
        ]);
    }

    public function updateAchievements(): void
    {
        $userSolvedQuestions = $this->getSolvedQuestionsCountByRate();
        foreach ($userSolvedQuestions as $count) {
            if ($count['solved_count'] > 0) {
                $this->saveAchievement("first_".$count['rate']."_task_solved");
            }
            if ($count['questions_count'] === $count['solved_count']) {
                $this->saveAchievement("all_".$count['rate']."_tasks_solved");
            }
            if ($count['total_questions'] === $count['total_solved']) {
                $this->saveAchievement("all_tasks_solved");
            }
            if ($count['total_quizzes'] === $count['quizzes_solved_count']) {
                $this->saveAchievement("theory_done");
            }
            if ($count['total_solved'] === 5) {
                $this->saveAchievement("five_tasks_completed");
            }
            if ($count['total_solved'] === 100) {
                $this->saveAchievement("100_tasks_done");
            }
        }
    }

    public function toggleFavorite(int $question_id): bool
    {
        $stmt = $this->dbh->prepare("
            WITH t AS (
                SELECT * FROM (VALUES (:user_id::uuid, :question_id::int)) AS t (user_id, question_id)
            )
            MERGE INTO favorites 
            USING t ON favorites.user_id = t.user_id and favorites.question_id = t.question_id
            WHEN NOT MATCHED THEN
                INSERT VALUES(t.user_id, t.question_id)
             WHEN MATCHED THEN DELETE;"
        );

        return $stmt->execute([':user_id' => $this->id, ':question_id' => $question_id]);
    }

    public function getFavorites($lang): array
    {
        if (!$this->logged()) return [];
        $stmt = $this->dbh->prepare("
            SELECT 
                questions_localization.title, 
                questions_localization.question_id, 
                null as solved_at, 
                questions.title_sef, 
                true as favored,
                ROW_NUMBER() OVER (ORDER BY questions_localization.title) question_number
            FROM favorites 
            JOIN questions ON favorites.question_id = questions.id 
            JOIN questions_localization ON questions.id = questions_localization.question_id AND questions_localization.language = :lang
            WHERE user_id = :user_id
            ORDER BY questions_localization.title;
        ");
        $stmt->execute([':lang' => $lang, ':user_id' => $this->id]);
        // var_dump( $stmt->fetchAll(PDO::FETCH_NUM));
        // die();
        return $stmt->fetchAll(PDO::FETCH_NUM);
    }

    /**
     * Get user's nickname
     *
     * @return string
     */
    public function getNickname(): string
    {
        if (!$this->logged()) {
            return '';
        }

        $stmt = $this->dbh->prepare("SELECT nickname FROM users WHERE id = ?");
        $stmt->execute([$this->id]);
        return $stmt->fetchColumn() ?: '';
    }

    /**
     * Set user's nickname
     *
     * @param string $nickname
     * @return bool
     * @throws Exception if nickname is invalid or update fails
     */
    public function setNickname(string $nickname): bool
    {
        if (!$this->logged()) {
            throw new Exception(Localizer::translateString('login_needed'));
        }

        if (strlen($nickname) < 3 || strlen($nickname) > 50) {
            throw new Exception(Localizer::translateString('nickname_length_error'));
        }

        // Only allow letters, numbers, and some special characters
        if (!preg_match('/^[a-zA-Z0-9_\-.@ ]+$/', $nickname)) {
            throw new Exception(Localizer::translateString('nickname_invalid_chars'));
        }

        $stmt = $this->dbh->prepare("UPDATE users SET nickname = ? WHERE id = ?");
        if (!$stmt->execute([$nickname, $this->id])) {
            throw new Exception(Localizer::translateString('update_failed'));
        }
        $this->saveAchievement("set_nickname");
        return true;
    }

    public function getAuthProvider(): string
    {
        if (!$this->logged()) {
            return '';
        }

        $stmt = $this->dbh->prepare("SELECT login FROM users WHERE id = ?");
        $stmt->execute([$this->id]);
        $login = $stmt->fetchColumn() ?: '';
        if (preg_match('/@(github|google|yandex|vk|linkedin)$/', $login, $m)) {
            return $m[1];
        } else {
            return 'unknown';
        }
    }

    public function getEmail(): string
    {
        if (!$this->logged()) {
            return '';
        }

        $stmt = $this->dbh->prepare("SELECT email FROM users WHERE id = ?");
        $stmt->execute([$this->id]);
        return $stmt->fetchColumn() ?: '';
    }

    public function setEmail(string $email): bool
    {
        if (!$this->logged()) {
            throw new Exception(Localizer::translateString('login_needed'));
        }

        $email = trim($email);
        if ($email === '') {
            throw new Exception(Localizer::translateString('email_required'));
        }

        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            throw new Exception(Localizer::translateString('email_invalid'));
        }

        $stmt = $this->dbh->prepare("SELECT 1 FROM users WHERE email = ? AND id <> ?");
        $stmt->execute([$email, $this->id]);
        if ($stmt->fetch()) {
            throw new Exception(Localizer::translateString('email_taken'));
        }

        $stmt = $this->dbh->prepare("UPDATE users SET email = ? WHERE id = ?");
        if (!$stmt->execute([$email, $this->id])) {
            throw new Exception(Localizer::translateString('update_failed'));
        }
        return true;
    }

    public function setPassword(string $password): bool
    {
        if (!$this->logged()) {
            throw new Exception(Localizer::translateString('login_needed'));
        }

        if (strlen($password) < 8) {
            throw new Exception(Localizer::translateString('password_length_error'));
        }

        $hash = password_hash($password, PASSWORD_DEFAULT);
        $stmt = $this->dbh->prepare("UPDATE users SET password_hash = ? WHERE id = ?");
        if (!$stmt->execute([$hash, $this->id])) {
            throw new Exception(Localizer::translateString('update_failed'));
        }
        return true;
    }
    public function getQuestions(string $lang): array
    {
            // Fetch questions data
            $stmt = $this->dbh->prepare("
            SELECT 
                q.id,
                ql.title,
                q.dbms,
                -- q.rate,
                qrl.rate rate,
                c.title_sef as category,
                q.title_sef slug,
                uq.solved_at::date solved_at,
                (f.question_id IS NOT NULL) as favorite
            FROM user_questions uq
            JOIN questions q ON q.id = uq.question_id
            JOIN questions_localization ql ON q.id = ql.question_id AND ql.language = :lang
            JOIN question_categories qc ON qc.question_id = q.id
            JOIN categories c ON qc.category_id = c.id AND c.questionnire_id = 3
            LEFT JOIN question_rates qr ON q.rate = qr.id
            LEFT JOIN favorites f ON q.id = f.question_id AND f.user_id = :user_id
            LEFT JOIN question_rates_localization qrl ON q.rate = qrl.id AND qrl.language = :lang
            WHERE uq.user_id = :user_id AND q.deleted = false
            ORDER BY q.id
        ");
        
        $stmt->execute([':lang' => $lang, ':user_id' => $this->id]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
    public function getTests(string $lang): array
    {
            // Fetch questions data
            $stmt = $this->dbh->prepare("
            SELECT 
                tests.id,
                created_at::date created_at,
                closed_at::date closed_at,
                (closed_at is not null and closed_at <= current_timestamp) closed,
                COUNT(tq.question_id) tasks_count,
                COUNT(tq.solved_at) tasks_solved_count,
                g.title_en grade
            FROM tests
            JOIN test_questions tq ON tests.id = tq.test_id
            LEFT JOIN grades g ON tests.rate = g.id
            WHERE tests.user_id = :user_id
            GROUP BY tests.id, created_at, closed_at, g.title_en
            ORDER BY created_at
        ");
        
        $stmt->execute([':user_id' => $this->id]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}