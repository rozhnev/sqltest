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
                return $this->loginVK($_GET['code']);            
            default:
                throw new Exception('Not supported login provider'); 
        }
    }
    /**
     * Proceed VK login with code
     *
     * @param string $code
     * @return bool
     */
    public function loginVK(string $code): bool
    {
    //   -d "v=5.131&token=silent_token&access_token=service_token&uuid=uuid"
    //   https://sqltest.online/login/vk/?payload=%7B%22type%22%3A%22silent_token%22%2C%22auth%22%3A1%2C%22user%22%3A%7B%22id%22%3A776757%2C%22first_name%22%3A%22%D0%A1%D0%BB%D0%B0%D0%B2%D0%B0%22%2C%22last_name%22%3A%22%D0%A0.%22%2C%22avatar%22%3A%22https%3A%2F%2Fsun9-74.userapi.com%2Fc16%2Fu776757%2Fd_5fe989cc.jpg%22%2C%22avatar_base%22%3Anull%2C%22phone%22%3A%22%2B972%20**%20***%20**%2002%22%7D%2C%22token%22%3A%22O6o633AmSh_1SUiRlMDGBZCRPBfQkiy1mzbh9yxFWTQ3RnDGvicJU7boVuPDZAtsaYQFnNxUg5lBN4oqPTdeq5POYu8-73ttmUSY78srW9zskzdM94IXOzyJuIdpTOytL3pQ4gEGqwTtcgITTAV--AzSJBU_2goe_WIYQO0CwGksKBDsuuyU-Ikd5ulWWIHpQwwOZ6kZdGvXQLWTGibxtSv3_kekx7_MwWksXYfV8fyLzZR87BkOnQhqT0cxCrfHkMeYAF5qYImuGCrTDiZxF1Iwj-jXRvD3PbOo0X4_IiYJiVOsZxSo9NNaWK6Shdpes8an5l1Kb_qoY-EaZzs4wkJKEAPJyJY63MWVsnyzyBdx7kXZhIbuA5TDvmU2fQpydlq9RpoKVFiNf7Z1PWjdkJbQoAbAnEiIumYrT_3tRSOs6n8Rz3ZJRu-2Tdef6cAM%22%2C%22ttl%22%3A600%2C%22uuid%22%3A%2229890eb2-6a16-0613-190f-250e54537e18%22%2C%22hash%22%3A%22SIuh2e5gZZmReAq8fnnXaxErfSJDUqTht5HvZpXDyeP%22%2C%22loadExternalUsers%22%3Afalse%7D&state=login
        // Exchange the authorization code for an access token
        $payload = $_GET['payload'];
        die($payload);
        $ch = curl_init('https://api.vk.com/method/auth.exchangeSilentAuthToken');
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

    public function getSolvedQuestionsCount(): int 
    {
        $stmt = $this->dbh->prepare("SELECT COUNT(question_id) FROM user_questions WHERE user_id = :user_id and solved_at is not null;");
        $stmt->execute([':user_id' => $this->id]);
        return $stmt->fetchColumn(0);
    }
}