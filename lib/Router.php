<?php
class Router 
{
    private $controller;

    private $routes = [
        'question'          => "@(?<lang>ru|en|pt)/(?<action>question)/(?<questionCategory>[a-z-]+)/(?<question>[a-z-]+)@i",
        'question-action'   => "@(?<lang>ru|en|pt)/question/(?<questionID>\d+)/(?<action>query-help|query-run|query-test|rate|check-answers)@i",
        'static-page'       => "@(?<lang>ru|en|pt)/(?<action>privacy-policy|logout|about|menu|books|courses|donate)/?@i",
        'share-image'       => "@(?<lang>ru|en|pt)/(?<action>share)/(?<type>achievement)/(?<format>image)/?@i",
        'share'             => "@(?<lang>ru|en|pt)/(?<action>share)/(?<type>achievement)/?@i",
        'login'             => "@^/(?<action>login)/(?<loginProvider>[a-z]+)/(\?lang=(?<lang>ru|en|pt))?@i",
        'erd'               => "@(?<lang>ru|en|pt)/(?<action>erd)/(?<db>Sakila|Bookings|AdventureWorks|Employee)\?theme=(?<theme>dark|light)@i",
        'favorite'          => "@(?<lang>ru|en|pt)/(?<class>question)/(?<questionID>\d+)/(?<action>favorite)@i",
        'question_solutions'=> "@(?<lang>ru|en|pt)/(?<class>question)/(?<questionID>\d+)/(?<action>solutions|my-solutions)@i",
        'solution'          => "@(?<lang>ru|en|pt)/(?<class>solution)/(?<solutionID>\d+)/(?<action>like|unlike|report|delete)@i",
        'tests'             => "@(?<lang>ru|en|pt)/(?<class>test)/(?<action>start|create)@i",
        'test'              => "@(?<lang>ru|en|pt)/(?<class>test)/(?<testId>[a-z0-9-]+)/(?<action>grade|result)@i",
        'test_question'     => "@(?<lang>ru|en|pt)/(?<class>test)/(?<testId>[a-z0-9-]+)/(?<action>question|check)/?(?<questionID>\d+)?@i",
        'user'              => "@(?<lang>ru|en|pt)/(?<class>user)/(?<action>achievements|profile|update)@i",
        'lessons'           => "@(?<lang>ru|en|pt)/(?<action>lesson)/(?<module>[a-z-]+)/(?<lesson>[a-z-]+)@i",
        'playground_run'    => "@(?<lang>ru|en|pt)/(?<class>playground)/(?<database>mysql80|mariadb115|psql17|sqlite3|mssql2022|oracle23|firebird4|soqol)/(?<action>query-run)@i",
        'playground'        => "@(?<lang>ru|en|pt)/(?<action>playground)/@i",
        'sitemap'           => "@(?<action>sitemap)\.xml@i",
    ];

    private $supportedLangs = ['ru', 'en', 'pt'];

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
                $action = str_replace('-', '_', strtolower($params['action']));
                $method = isset($params['class']) ? $params['class'] . '_' . $action : $action;
                // echo "Method: $method\n";
                $this->controller->setLanguge($params['lang'] ?? $this->parseAcceptLanguageHeader());

                return $this->controller->{$method}($params);

            }
        }
        // redirect old routes to new ones
        if (preg_match("@(?<lang>ru|en|pt)/(?<action>question)/(?<questionCategoryId>\d+)/(?<questionId>\d+)@i", $path, $params)) {
            return $this->controller->redirect($params);
        }
        if (preg_match("@(?<lang>ru|en|pt)/(?<questionCategory>sakila)/(?<questionId>\d+)@i", $path, $params)) {
            $params['questionCategoryId'] = 1; // for sakila
            return $this->controller->redirect($params);
        }
        if (preg_match("@(?<lang>ru|en|pt)/@i", $path, $params)) {
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