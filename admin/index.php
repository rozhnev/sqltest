<?php

$env    = parse_ini_string(file_get_contents("../.env"), 1);
require '../vendor/autoload.php';

session_start();

$dbc    = new DB($env);
$dbh    = $dbc->getInstance();
$user   = new User($dbh, $env);

$path       = isset($_SERVER['PATH_INFO']) ? trim($_SERVER['PATH_INFO'], '/') : '';
$pathParts  = array_values(array_filter(explode('/', $path), fn($segment) => $segment !== ''));
$resource   = $pathParts[0] ?? '';
$resourceId = isset($pathParts[1]) ? (int)$pathParts[1] : 0;
$method     = $_SERVER['REQUEST_METHOD'];

if ($_SESSION) {
    $user->loginSession($_SESSION);
}

if (!$user->isAdmin()) {
    if ($resource === '' && !isApiRequest()) {
        http_response_code(403);
        echo 'Admin area requires authorization. Please sign in with an administrator account.';
        exit;
    }
    respondJson(['error' => 'Admin privileges required'], 403);
}

$questionManager = new AdminQuestionManager($dbh);
$lessonManager   = new AdminLessonManager($dbh);
$openAiKey       = $env['OPENAI_API_KEY'] ?? '';

switch ($resource) {
    case '':
        renderAdminTemplate($user, $env);
        break;
    case 'questions':
        handleQuestions($questionManager, $_GET, $method);
        break;
    case 'question':
        handleQuestion($questionManager, $resourceId, $method);
        break;
    case 'question-localization':
        handleQuestionLocalization($questionManager, $method);
        break;
    case 'question-checks':
        handleQuestionChecks($questionManager, $method);
        break;
    case 'lessons':
        handleLessons($lessonManager, $_GET, $method);
        break;
    case 'lesson':
        handleLesson($lessonManager, $resourceId, $method);
        break;
    case 'llm':
        handleLLM($openAiKey, $method);
        break;
    default:
        respondJson(['error' => 'Resource not found'], 404);
        break;
}

return;

function renderAdminTemplate(User $user, array $env, int $lessonId = 0): void
{
    $smarty = new Smarty();

    $smarty->assign('Logged', $user->logged());
    $smarty->assign('Admin', $user->isAdmin());
    $smarty->assign('Lang', 'en');
    $smarty->assign('DB', $env['DB_NAME'] ?? 'sakila');
    $smarty->assign('VERSION', $env['APP_VERSION'] ?? time());
    $smarty->assign('QuestionID', 0);
    $smarty->assign('LessonID', max(0, $lessonId));
    $smarty->display('index.tpl');
}

function handleQuestions(AdminQuestionManager $manager, array $query, string $method): void
{
    // if ($method !== 'GET') {
    //     respondMethodNotAllowed();
    // }
    // $lang = $query['lang'] ?? 'en';
    // $limit = min(200, max(10, (int)($query['limit'] ?? 60)));
    // respondJson(['questions' => $manager->list($lang, $limit)]);
}

function handleQuestion(AdminQuestionManager $manager, int $questionId, string $method): void
{
    switch ($method) {
        case 'GET':
            if ($questionId <= 0) {
                respondJson(['error' => 'Question identifier is required'], 400);
            }
            $smarty = new Smarty();
            $question = $manager->get($questionId);
            $smarty->assign('Lang', 'en');
            $smarty->assign('DB', $env['DB_NAME'] ?? 'sakila');
            $smarty->assign('VERSION', $env['APP_VERSION'] ?? time());
            $smarty->assign('QuestionID', $questionId);
            $smarty->assign('LessonID', $question['lesson_id'] ?? 0);
            $smarty->assign('Question', $question);
            $smarty->assign('Languages', $manager->getSupportedLanguages());
            $smarty->assign('LanguageLabels', $manager->getLanguageLabels());
            $smarty->assign('DbTemplates', $manager->getDbTemplates());
            $smarty->assign('Databases', $manager->getDatabases());
            $smarty->display('question.tpl');
            break;
        case 'POST':
            $payload = parseJsonBody();
            respondJson(['question' => $manager->save($payload)]);
            break;
        case 'PUT':
            if ($questionId <= 0) {
                respondJson(['error' => 'Question identifier is required'], 400);
            }
            $payload = parseJsonBody();
            $payload['id'] = $questionId;
            respondJson(['question' => $manager->save($payload)]);
            break;
        case 'DELETE':
            if ($questionId <= 0) {
                respondJson(['error' => 'Question identifier is required'], 400);
            }
            $manager->delete($questionId);
            respondJson(['deleted' => true]);
            break;
        default:
            respondMethodNotAllowed();
    }
}

function handleQuestionLocalization(AdminQuestionManager $manager, string $method): void
{
    if ($method !== 'POST') {
        respondMethodNotAllowed();
    }
    $payload = parseJsonBody();
    $questionId = isset($payload['question_id']) ? (int)$payload['question_id'] : 0;
    $language = trim(strtolower($payload['language'] ?? ''));

    if ($questionId <= 0) {
        respondJson(['error' => 'Question identifier is required'], 400);
    }
    if ($language === '') {
        respondJson(['error' => 'Language is required'], 400);
    }

    $fields = [
        'title' => $payload['title'] ?? '',
        'task' => $payload['task'] ?? '',
        'hint' => $payload['hint'] ?? ''
    ];
    
    try {
        $localization = $manager->saveLocalization($questionId, $language, $fields);
        respondJson(['localization' => $localization]);
    } catch (Exception $error) {
        respondJson(['error' => $error->getMessage()], 400);
    }
}

function handleQuestionChecks(AdminQuestionManager $manager, string $method): void
{
    if ($method !== 'POST') {
        respondMethodNotAllowed();
    }
    $payload = parseJsonBody();
    $questionId = isset($payload['question_id']) ? (int)$payload['question_id'] : 0;
    $checks = isset($payload['checks']) && is_array($payload['checks']) ? $payload['checks'] : [];

    if ($questionId <= 0) {
        respondJson(['error' => 'Question identifier is required'], 400);
    }

    try {
        $result = $manager->saveQueryChecks($questionId, $checks);
        respondJson(['checks' => $result]);
    } catch (Exception $error) {
        respondJson(['error' => $error->getMessage()], 400);
    }
}

function handleLessons(AdminLessonManager $manager, array $query, string $method): void
{
    if ($method !== 'GET') {
        respondMethodNotAllowed();
    }
    $lang = $query['lang'] ?? 'en';
    respondJson($manager->list($lang));
}

function handleLesson(AdminLessonManager $manager, int $lessonId, string $method): void
{
    global $env;

    switch ($method) {
        case 'GET':
            if ($lessonId <= 0) {
                respondJson(['error' => 'Lesson identifier is required'], 400);
            }
            $smarty = new Smarty();
            $lesson = $manager->get($lessonId);
            $smarty->assign('Lang', 'en');
            $smarty->assign('DB', $env['DB_NAME'] ?? 'sakila');
            $smarty->assign('VERSION', $env['APP_VERSION'] ?? time());
            $smarty->assign('QuestionID', 0);
            $smarty->assign('LessonID', $lessonId);
            $smarty->assign('Lesson', $lesson);
            $smarty->assign('Languages', $manager->getSupportedLanguages());
            $smarty->assign('LanguageLabels', $manager->getLanguageLabels());
            $smarty->display('lesson.tpl');
            break;
        case 'POST':
            $payload = parseJsonBody();
            respondJson(['lesson' => $manager->save($payload)]);
            break;
        case 'PUT':
            if ($lessonId <= 0) {
                respondJson(['error' => 'Lesson identifier is required'], 400);
            }
            $payload = parseJsonBody();
            $payload['id'] = $lessonId;
            respondJson(['lesson' => $manager->save($payload)]);
            break;
        case 'DELETE':
            if ($lessonId <= 0) {
                respondJson(['error' => 'Lesson identifier is required'], 400);
            }
            $manager->delete($lessonId);
            respondJson(['deleted' => true]);
            break;
        default:
            respondMethodNotAllowed();
    }
}

function handleLLM(string $openAiKey, string $method): void
{
    if ($method !== 'POST') {
        respondMethodNotAllowed();
    }
    if (empty($openAiKey)) {
        respondJson(['error' => 'OpenAI API key is not configured'], 500);
    }
    $payload = parseJsonBody();

    if (isset($payload['task']) && !empty($payload['task'])) {
        $task = $payload['task'];
    } else {
        respondJson(['error' => 'LLM task is required'], 400);
    }

    $llm = new LLM($openAiKey);

    try {
        switch ($task) {
            case 'question-review':
                respondJson(['result' => doQuestionReview($llm, $payload)]);
                break;            
            case 'translate':
                respondJson(['result' => doTranslate($llm, $payload)]);
                break;
            case 'edit':
                respondJson(['result' => doEdit($llm, $payload)]);
                break;
            default:
                respondJson(['error' => 'Unknown LLM task'], 400);
                break;
        }
    } catch (Exception $error) {
        respondJson(['error' => $error->getMessage()], 500);
    }
}

function doTranslate(LLM $llm, array $payload): string
{
    $from = $payload['from_lang'] ?? 'English';
    $to = $payload['to_lang'] ?? 'Russian';
    $text = trim($payload['text'] ?? '');

    if ($text === '') {
        throw new Exception('Text to translate is required');
    }

    $messages = [
        ['role' => 'system', 'content' => 'You act as a professional technical editor experienced in SQL content localization.'],
        ['role' => 'user', 'content' => "Translate the following text from {$from} to {$to} in a clear and concise tone:"],
        ['role' => 'user', 'content' => $text]
    ];

    return $llm->parseMarkdown($llm->ask($messages));
}

function doQuestionReview(LLM $llm, array $payload): string
{
    $context = $payload['context'] ?? [];
    $language = $payload['language'] ?? 'English';
    $sections = contextSections($context);

    if (empty($sections)) {
        throw new Exception('At least one field is required for the review');
    }

    $messages = [
        ['role' => 'system', 'content' => 'You act as a senior SQL instructor who proofreads questions for clarity, fairness, and accuracy.'],
        ['role' => 'user', 'content' => "Review the following SQL question in {$language}. Provide short feedback on clarity, correctness, and polish. The title must be short as possible. Use bullet points if possible. Use <span class='sql'><</span> for wrap reserved keywords and database objects names in task and hint."],
        ['role' => 'user', 'content' => implode("\n\n", $sections)],
        ['role' => 'user', 'content' => 'Provide improved versions of the title, question, and hint if applicable, but keep the original meaning and technical content intact.']
    ];
    return $llm->parseMarkdown($llm->ask($messages));
}

function doEdit(LLM $llm, array $payload): string
{
    $context = $payload['context'] ?? [];
    $style = $payload['style'] ?? 'clear, friendly, and concise';
    $sections = contextSections($context);

    if (empty($sections)) {
        throw new Exception('At least one field is required for the edit');
    }

    $messages = [
        ['role' => 'system', 'content' => 'You rewrite educational content to sound polished and learner-friendly while keeping technical accuracy.'],
        ['role' => 'user', 'content' => "Rewrite the following text to be {$style} while keeping the SQL meaning intact:"],
        ['role' => 'user', 'content' => implode("\n\n", $sections)]
    ];

    return $llm->cleanupResult($llm->ask($messages));
}

function contextSections(array $context): array
{
    $sections = [];
    foreach (['title', 'question', 'hint', 'match', 'not_match', 'result'] as $field) {
        if (!empty($context[$field])) {
            $sections[] = ucfirst($field) . ": " . $context[$field];
        }
    }
    return $sections;
}


function isApiRequest(): bool
{
    $accept = $_SERVER['HTTP_ACCEPT'] ?? '';
    $requestedWith = strtolower($_SERVER['HTTP_X_REQUESTED_WITH'] ?? '');
    return stripos($accept, 'application/json') !== false || $requestedWith === 'xmlhttprequest';
}

function respondJson(array $payload, int $status = 200): void
{
    http_response_code($status);
    header('Content-Type: application/json');
    echo json_encode($payload, JSON_UNESCAPED_UNICODE);
    exit;
}

function respondMethodNotAllowed(): void
{
    respondJson(['error' => 'Method not allowed'], 405);
}

function parseJsonBody(): array
{
    $payload = json_decode(file_get_contents('php://input'), true);
    if (json_last_error() !== JSON_ERROR_NONE) {
        return [];
    }
    return $payload ?? [];
}
