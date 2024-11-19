<?php
$env    = parse_ini_string(file_get_contents("../.env"), 1);

require '../vendor/autoload.php';
$smarty = new Smarty();
$dbc    = new DB($env);
$dbh    = $dbc->getInstance();
$user   = new User($dbh, $env);

$path = isset($_SERVER['PATH_INFO']) ? trim($_SERVER['PATH_INFO'], '/') : trim($_SERVER['PHP_SELF'], '/');
$pathParts = explode('/', $path);
$db         = '';
$questionID = '';

if (isset($pathParts[1]) && $pathParts[1] === 'question') {
    $action     = 'question';
    $questionID = $pathParts[2] ?? '';
} elseif (isset($pathParts[0]) && $pathParts[0] === 'translate') {
    $action     = 'translate';
}

session_start();

if (($_SESSION && $_SESSION['user_id'])) {
    $user->set($_SESSION['user_id'], $_SESSION["admin"]);
}
switch ($action) {
    case 'question':
        $question = new Question($dbh, $questionID);
        $questionData = $question->getData();
        $smarty->assign('QuestionTitleEn',  htmlspecialchars($questionData['title_en']));
        $smarty->assign('QuestionTitleRu',  htmlspecialchars($questionData['title_ru']));
        $smarty->assign('QuestionTaskEn',   htmlspecialchars($questionData['task_en']));
        $smarty->assign('QuestionTaskRu',   htmlspecialchars($questionData['task_ru']));
        $smarty->assign('QuestionHintEn',   htmlspecialchars($questionData['hint_en']));
        $smarty->assign('QuestionHintRu',   htmlspecialchars($questionData['hint_ru']));
        $smarty->assign('SolutionMatch',    htmlspecialchars($questionData['query_match']));
        $smarty->assign('SolutionNotMatch', htmlspecialchars($questionData['query_not_match'] ?? ''));
        $smarty->assign('QuestionResult',   htmlspecialchars($questionData['query_valid_result'] ?? ''));
        break;
    case 'translate':
        $gpt = new GPT($env['OPENAI_API_KEY']);
        echo $gpt->ask(        
            [
                ["role" => "system", "content" => 'You act as a professional technical editor experienced in text translations.'],
                ["role" => "user", "content" => "Translate next text from {$_POST["from_lang"]} to {$_POST["to_lang"]}"],
                ["role" => "user", "content" => $_POST["text"] ?? '']
            ]
        );
        die(); 
    default:
        die('Wrong action');
};


Localizer::init('en');
$smarty->registerPlugin('block', 'translate', array('Localizer', 'translate'), true);
$smarty->assign('Logged', $user->logged());
$smarty->assign('Admin', $user->isAdmin());
$smarty->setTemplateDir('../templates');
$smarty->assign('Lang', 'en');
$smarty->assign('DB', 'sakila');
$smarty->assign('QuestionID', '0');
$smarty->display('admin.tpl');