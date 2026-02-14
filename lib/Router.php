<?php
class Router 
{
    private $controller;

    private $routes = [
        'question'          => "@(?<lang>ru|en|pt|fr)/(?<action>question)/(?<questionCategory>[a-z-]+)/(?<question>[a-z-]+)@i",
        'question-action'   => "@(?<lang>ru|en|pt|fr)/question/(?<questionID>\d+)/(?<action>query-help|query-run|query-test|rate|check-answers)@i",
        'static-page'       => "@(?<lang>ru|en|pt|fr)/(?<action>privacy-policy|logout|about|menu|books|courses|donate)/?@i",
        'register'          => "@(?<lang>ru|en|pt|fr)/(?<action>register)/?@i",
        'login'             => "@^/(?<action>login)/(?<loginProvider>[a-z]+)/(\?lang=(?<lang>ru|en|pt|fr))?@i",
        'erd'               => "@(?<lang>ru|en|pt|fr)/(?<action>erd)/(?<db>Sakila|Bookings|AdventureWorks|Employee)\?theme=(?<theme>dark|light)@i",
        'favorite'          => "@(?<lang>ru|en|pt|fr)/(?<class>question)/(?<questionID>\d+)/(?<action>favorite)@i",
        'question_solutions'=> "@(?<lang>ru|en|pt|fr)/(?<class>question)/(?<questionID>\d+)/(?<action>solutions|my-solutions)@i",
        'solution'          => "@(?<lang>ru|en|pt|fr)/(?<class>solution)/(?<solutionID>\d+)/(?<action>like|unlike|report|delete)@i",
        'tests'             => "@(?<lang>ru|en|pt|fr)/(?<class>test)/(?<action>start|create)@i",
        'challenge-mariadb-start' => "@(?<lang>ru|en|pt|fr)/challenge-mariadb/start/?@i",
        'challenge-mariadb' => "@(?<lang>ru|en|pt|fr)/(?<action>challenge-mariadb)/?@i",
        'test'              => "@(?<lang>ru|en|pt|fr)/(?<class>test)/(?<testId>[a-z0-9-]+)/(?<action>grade|result)@i",
        'test_question'     => "@(?<lang>ru|en|pt|fr)/(?<class>test)/(?<testId>[a-z0-9-]+)/(?<action>question|check)/?(?<questionID>\d+)?@i",
        'user'              => "@(?<lang>ru|en|pt|fr)/(?<class>user)/(?<action>achievements|profile|update)@i",
        'achievement_image' => "@(?<lang>ru|en|pt|fr)/achievement/(?<action>image)/(?<achievementID>[a-z0-9-]+)@i",
        'achievement'       => "@(?<lang>ru|en|pt|fr)/(?<action>achievement)/(?<achievementID>[a-z0-9-]+)@i",
        'lessons'           => "@(?<lang>ru|en|pt|fr)/(?<action>lesson)/(?<module>[a-z-]+)/(?<lesson>[a-z-]+)@i",
        'playground_run'    => "@(?<lang>ru|en|pt|fr)/(?<class>playground)/(?<database>mysql80|mariadb115|psql17|sqlite3|mssql2022|oracle23|firebird4|soqol)/(?<action>query-run)@i",
        'playground'        => "@(?<lang>ru|en|pt|fr)/(?<action>playground)/@i",
        'sitemap'           => "@(?<action>sitemap)\.xml@i",
    ];

    private $supportedLangs = ['ru', 'en', 'pt', 'fr'];

    public function __construct(Controller $controller)
    {
        $this->controller = $controller;
    }

    private function parseAcceptLanguageHeader(): ?string
    {
        if (empty($_SERVER['HTTP_ACCEPT_LANGUAGE'])) {
            return DEFAULT_LANGUAGE;
        }

        $header = $_SERVER['HTTP_ACCEPT_LANGUAGE'];
        $entries = array_map('trim', explode(',', $header));

        foreach ($entries as $entry) {
            $parts = explode(';', $entry);
            $tag = strtolower(trim($parts[0]));
            $primary = explode('-', $tag)[0]; // e.g. pt-BR -> pt
            if (in_array($primary, $this->supportedLangs, true)) {
                return $primary;
            }
        }
        return DEFAULT_LANGUAGE;
    }

    public function route(string $path)
    {
        $this->controller->setCanonicalLink($path);
        foreach ($this->routes as $route => $pattern) {
            // echo "Route: $route, $path\n";
            if (preg_match($pattern, $path, $params)) {
                $params['path'] = $path;
                if ($route === 'challenge-mariadb-start') {
                    $params['action'] = 'challenge-mariadb_start';
                }
                $action = str_replace('-', '_', strtolower($params['action']));
                $method = isset($params['class']) ? $params['class'] . '_' . $action : $action;
                // echo "Method: $method\n";
                $this->controller->setLanguge($params['lang'] ?? $this->parseAcceptLanguageHeader());

                return $this->controller->{$method}($params);

            }
        }
        // die();
        // redirect old routes to new ones
        if (preg_match("@(?<lang>ru|en|pt|fr)/(?<action>question)/(?<questionCategoryId>\d+)/(?<questionId>\d+)@i", $path, $params)) {
            return $this->controller->redirect($params);
        }
        if (preg_match("@(?<lang>ru|en|pt|fr)/(?<questionCategory>sakila)/(?<questionId>\d+)@i", $path, $params)) {
            $params['questionCategoryId'] = 1; // for sakila
            return $this->controller->redirect($params);
        }
        if (preg_match("@(?<lang>ru|en|pt|fr)/@i", $path, $params)) {
            $this->controller->setLanguge($params['lang'] ?? $this->parseAcceptLanguageHeader());
        } else {
            $this->controller->setLanguge($this->parseAcceptLanguageHeader());
        }

        // Show welcome page by default unless user previously chose to hide it (HideWelcome cookie)
        $showWelcome = true;
        if (!isset($_COOKIE['HideWelcome']) || $_COOKIE['HideWelcome'] !== '1') {
            return $this->controller->welcome([
                'questionID'        => 1,
                'questionCategory'  => $env['DEFAULT_QUESTIONS_CATEGORY'] ?? 'sql-basics',
                'path'              => $path,
            ]);
        }

        return $this->controller->question([
            'questionID'            => 1,
            'questionCategory'      => $env['DEFAULT_QUESTIONS_CATEGORY'] ?? 'sql-basics',
            'path'                  => $path,
        ]);
    }    
}
?>