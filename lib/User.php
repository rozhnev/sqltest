<?php
class User 
{
    /**
     * DB hahdler 
     *
     * @var PDO
     */
    private $dbh;

    private string $login;

    public function __construct(PDO $dbh, array $env)
    {
        $this->env  = $env;
        $this->dbh  = $dbh;
    }

    public function login(string $provider, $request)
    {
        switch ($provider) {
            case 'yandex':
                return $this->loginYandex($_GET['code']);
                break;
            default:
                throw new Exception('Not supported login provider'); 
        }
    }

    public function loginYandex(string $code)
    {
        $params = array(
            'grant_type'    => 'authorization_code',
            'code'          => $code,
            'client_id'     => $this->env['YANDEX_CLIENT_ID'],
            'client_secret' => $this->env['YANDEX_SECRET'],
        );
        
        $ch = curl_init('https://oauth.yandex.ru/token');
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params); 
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_HEADER, false);
        $data = curl_exec($ch);
        curl_close($ch);	
                 
        $data = json_decode($data, true);
        if (!empty($data['access_token'])) {
            // Токен получили, получаем данные пользователя.
            $ch = curl_init('https://login.yandex.ru/info');
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS, array('format' => 'json')); 
            curl_setopt($ch, CURLOPT_HTTPHEADER, array('Authorization: OAuth ' . $data['access_token']));
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_HEADER, false);
            $info = curl_exec($ch);
            curl_close($ch);
     
            $info = json_decode($info, true);

            $this->login = $info['login'];
            // print_r($info);
            return true;
        }

        return false;
    }

    public function createSession()
    {

    }
}