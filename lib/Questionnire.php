<?php
class Questionnire 
{
    /**
     * DB hahdler 
     *
     * @var PDO
     */
    private $dbh;
    
    /**
     * Questionnire supported language
     *
     * @var array<string>
     */
    private $supportedlanguages = ['en', 'ru'];

    /**
     * Questionnire language
     *
     * @var string
     */
    private $lang;

    public function __construct(PDO $dbh, string $lang)
    {
        if(!in_array($lang, $this->supportedlanguages)) {
            throw new Exception("The {$lang} language does not supported");
        }

        $this->dbh  = $dbh;
        $this->lang = $lang;
    }
    /**
     * Returns Questionnire data
     *
     * @param string|null $userId
     * @return array
     */
    public function get(?string $userId): array
    {
        $stmt = $this->dbh->prepare("
            SELECT 
                categories.id,
                categories.title_{$this->lang} questions_category,
                questions.id question_id,
                questions.db_template,
                questions.title_{$this->lang} question_title,
                (solved_at IS NOT NULL) solved
            FROM categories
            JOIN question_categories ON question_categories.category_id = categories.id
            JOIN questions ON question_categories.question_id = questions.id
            LEFT JOIN user_questions ON user_questions.question_id = questions.id and user_questions.user_id = ?
            ORDER BY categories.sequence_position, question_categories.sequence_position
        ");
        $stmt->execute([$userId]);
        $questionnire = $stmt->fetchAll(PDO::FETCH_ASSOC);
        if ($questionnire) {
            return array_reduce(
                $questionnire,
                function($acc, $el) {
                    if (!isset($acc[$el['id']])) $acc[$el['id']] = [
                        'title'     => $el['questions_category'],
                        'db'        => $el['db_template'],
                        'questions' => []
                    ];
                    $acc[$el['id']]['questions'][] = [$el['question_title'], $el['question_id'], $el['solved']];
                    return $acc;
                },
                []
            );
        }
        return [];
    }
}