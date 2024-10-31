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

    private $admin = false;
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
            default:
                throw new Exception('Not supported login provider'); 
        }
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
     * Set and return User admin status
     *
     * @return bool
     */
    public function autorize(): bool
    {
        $this->admin = false;
        if ($this->logged()) {
            $stmt = $this->dbh->prepare("SELECT admin FROM users WHERE id = ?;");

            if ($stmt->execute([$this->id])) {
                $row = $stmt->fetch(PDO::FETCH_ASSOC);
                $this->admin = $row['admin'];
            }
        }

        return $this->admin;
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
     * Save Questoin attepmt in DB
     *
     * @param integer $questionID
     * @param integer $rate
     * @return void
     */
    public function saveQuestionRate(int $questionID, int $rate): void
    {
        try {
            $stmt = $this->dbh->prepare("
                UPDATE user_questions 
                SET rate = :rate
                WHERE user_id = :user_id AND question_id = :question_id
            ");
            $stmt->execute([':user_id' => $this->id, ':question_id' => $questionID, ':rate' => $rate]);
        }
        catch (\Throwable $error) {
            throw new Exception($error->getMessage());
        }
    }

    public function solvedQuestion(int $questionID): bool
    {
        $stmt = $this->dbh->prepare("SELECT true FROM user_questions WHERE user_id = :user_id and question_id = :question_id and solved_at is not null;");
        $stmt->execute([':user_id' => $this->id, ':question_id' => $questionID]);
        return $stmt->fetchColumn(0);
    }

    public function getSolvedQuestionsCount(): int 
    {
        $stmt = $this->dbh->prepare("SELECT COUNT(question_id) FROM user_questions WHERE user_id = :user_id and solved_at is not null;");
        $stmt->execute([':user_id' => $this->id]);
        return $stmt->fetchColumn(0);
    }

    public function getLastTest(): array
    {
        $stmt = $this->dbh->prepare("
            SELECT id, created_at, closed_at, (closed_at is not null or closed_at <= current_timestamp) closed, rate 
            FROM tests 
            WHERE user_id = :user_id order by created_at desc limit 1;
        ");
        $stmt->execute([':user_id' => $this->id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}