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
     * User email
     *
     * @var string
     */
    private $email;

    /**
     * User id
     *
     * @var string|null
     */
    private $id;

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
            default:
                throw new Exception('Not supported login provider'); 
        }
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
            curl_setopt($ch, CURLOPT_HEADER, ['Accept: application/json']);
            
            $data = curl_exec($ch);
            curl_close($ch);
            if (empty($data)) return false;
                     
            $data = json_decode($data, true);
            if (!empty($data['access_token'])) {
                // Токен получили, получаем данные пользователя.
                $ch = curl_init('https://api.github.com/user');
                if ($ch) {
                    curl_setopt($ch, CURLOPT_POST, 1);
                    curl_setopt($ch, CURLOPT_POSTFIELDS, array('format' => 'json')); 
                    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Authorization: Bearer ' . $data['access_token']));
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                    curl_setopt($ch, CURLOPT_HEADER, ['Accept: application/json']);
                    $info = curl_exec($ch);
                    curl_close($ch);
            
                    $info = json_decode($info, true);
        
                    $this->email = $info['login'];
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
        
                    $this->email = $info['login'];
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
            INSERT INTO users (id, email) VALUES (?, ?) 
            ON CONFLICT (email) DO 
               UPDATE SET last_login_at = CURRENT_TIMESTAMP 
            RETURNING id");
        if ($stmt->execute([$this->id, $this->email])) {
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
     * @param boolean $solved
     * @return void
     */
    public function saveQuestionAttempt(int $questionID, bool $solved, string $query): void
    {
        try {
            $stmt = $this->dbh->prepare("
                INSERT INTO user_questions (
                    user_id, question_id, last_attempt_at, solved_at, last_query
                ) VALUES (
                    ?, ?, CURRENT_TIMESTAMP, CASE WHEN ".($solved ? 'true' : 'false')." THEN CURRENT_TIMESTAMP END, ?
                ) 
                ON CONFLICT (user_id, question_id) DO UPDATE SET
                    last_attempt_at = CURRENT_TIMESTAMP, 
                    solved_at = LEAST(user_questions.solved_at, EXCLUDED.solved_at),
                    last_query = EXCLUDED.last_query
                ");
            $stmt->execute([$this->id, $questionID, $query]);
        }
        catch (\Throwable $error) {
            throw new Exception($error->getMessage());
        }
    }
}