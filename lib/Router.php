<?php
class Router 
{
    private $controller;
    private array $routes;
    private array $supportedLangs;

    public function __construct(Controller $controller, array $supportedLangs)
    {
        $this->controller = $controller;
        $this->supportedLangs = array_values($supportedLangs);
        $this->langPattern = implode('|', $this->supportedLangs);

        $this->routes = [
            'question'          => "@(?<lang>{$this->langPattern})/(?<action>question)/(?<questionCategory>[a-z-]+)/(?<question>[a-z-]+)@i",
            'question-action'   => "@(?<lang>{$this->langPattern})/question/(?<questionID>\d+)/(?<action>query-help|query-run|query-test|rate|check-answers)@i",
            'static-page'       => "@(?<lang>{$this->langPattern})/(?<action>privacy-policy|logout|about|menu|books|courses|donate)/?@i",
            'register'          => "@(?<lang>{$this->langPattern})/(?<action>register)/?@i",
            'login'             => "@^/(?<action>login)/(?<loginProvider>[a-z]+)/(\?lang=(?<lang>{$this->langPattern}))?@i",
            'erd'               => "@(?<lang>{$this->langPattern})/(?<action>erd)/(?<db>Sakila|Bookings|AdventureWorks|Employee)\?theme=(?<theme>dark|light)@i",
            'favorite'          => "@(?<lang>{$this->langPattern})/(?<class>question)/(?<questionID>\d+)/(?<action>favorite)@i",
            'question_solutions'=> "@(?<lang>{$this->langPattern})/(?<class>question)/(?<questionID>\d+)/(?<action>solutions|my-solutions)@i",
            'solution'          => "@(?<lang>{$this->langPattern})/(?<class>solution)/(?<solutionID>\d+)/(?<action>like|unlike|report|delete)@i",
            'tests'             => "@(?<lang>{$this->langPattern})/(?<class>test)/(?<action>start|create)@i",
            'challenge-mariadb-start' => "@(?<lang>{$this->langPattern})/challenge-mariadb/start/?@i",
            'challenge-mariadb' => "@(?<lang>{$this->langPattern})/(?<action>challenge-mariadb)/?@i",
            'test'              => "@(?<lang>{$this->langPattern})/(?<class>test)/(?<testId>[a-z0-9-]+)/(?<action>grade|result)@i",
            'test_question'     => "@(?<lang>{$this->langPattern})/(?<class>test)/(?<testId>[a-z0-9-]+)/(?<action>question|check)/?(?<questionID>\d+)?@i",
            'user'              => "@(?<lang>{$this->langPattern})/(?<class>user)/(?<action>achievements|profile|update)@i",
            'achievement_image' => "@(?<lang>{$this->langPattern})/achievement/(?<action>image)/(?<achievementID>[a-z0-9-]+)@i",
            'achievement'       => "@(?<lang>{$this->langPattern})/(?<action>achievement)/(?<achievementID>[a-z0-9-]+)@i",
            // Accepts with both module and lesson
            'lessons'           => "@(?<lang>{$this->langPattern})/(?<action>lesson)(?:/(?<module>[a-z-]+))?(?:/(?<lesson>[a-z-]+))?@i",
            'playground_run'    => "@(?<lang>{$this->langPattern})/(?<class>playground)/(?<database>mysql80|mariadb118|psql17|sqlite3|mssql2022|oracle23|firebird4|soqol)/(?<action>query-run)@i",
            'playground'        => "@(?<lang>{$this->langPattern})/(?<action>playground)/@i",
            'sitemap'           => "@(?<action>sitemap)\.xml@i",
        ];
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
        if (preg_match("@(?<lang>{$this->langPattern})/(?<action>question)/(?<questionCategoryId>\d+)/(?<questionId>\d+)@i", $path, $params)) {
            return $this->controller->redirect($params);
        }
        if (preg_match("@(?<lang>{$this->langPattern})/(?<questionCategory>sakila)/(?<questionId>\d+)@i", $path, $params)) {
            $params['questionCategoryId'] = 1; // for sakila
            return $this->controller->redirect($params);
        }
        if (preg_match("@(?<lang>{$this->langPattern})/@i", $path, $params)) {
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