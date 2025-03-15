<?php
class Router 
{
    private $controller;

    private $routes = [
        'question'          => "@(?<lang>ru|en|pt)/(?<action>question)/(?<questionCategory>[a-z-]+)/(?<question>[a-z-]+)@i",
        'question-action'   => "@(?<lang>ru|en|pt)/question/(?<questionID>\d+)/(?<action>query-help|query-run|query-test|rate|check-answers)@i",
        'static-page'       => "@(?<lang>ru|en|pt)/(?<action>privacy-policy|logout|about|menu|books|courses|donate)/?@i",
        'login'             => "@^/(?<action>login)/(?<loginProvider>[a-z]+)/\?lang=(?<lang>ru|en|pt)@i",
        'erd'               => "@(?<lang>ru|en|pt)/(?<action>erd)/(?<db>Sakila|Bookings|AdventureWorks|Employee)\?theme=(?<theme>dark|light)@i",
        'favorite'          => "@(?<lang>ru|en|pt)/(?<class>question)/(?<questionID>\d+)/(?<action>favorite)@i",
        'question_solutions'=> "@(?<lang>ru|en|pt)/(?<class>question)/(?<questionID>\d+)/(?<action>solutions|my-solutions)@i",
        'solution'          => "@(?<lang>ru|en|pt)/(?<class>solution)/(?<solutionID>\d+)/(?<action>like|unlike|report|delete)@i",
        'tests'             => "@(?<lang>ru|en|pt)/(?<class>test)/(?<action>start|create)@i",
        'test'              => "@(?<lang>ru|en|pt)/(?<class>test)/(?<testId>[a-z0-9-]+)/(?<action>grade|result)@i",
        'test_question'     => "@(?<lang>ru|en|pt)/(?<class>test)/(?<testId>[a-z0-9-]+)/(?<action>question|check)/?(?<questionID>\d+)?@i",
        'user'              => "@(?<lang>ru|en|pt)/(?<class>user)/(?<action>achievements)@i",
    ];

    public function __construct(Controller $controller)
    {
        $this->controller = $controller;
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
                $this->controller->setLanguge($params['lang']);

                return $this->controller->{$method}($params);

            }
        }
        $this->controller->setLanguge(DEFAULT_LANGUAGE);
        return $this->controller->question([
            'questionID'            => 1,
            'questionCategory'      => $env['DEFAULT_QUESTIONS_CATEGORY'] ?? 'sql-basics',
            'path'                  => $path,
        ]);
    }    
}
?>