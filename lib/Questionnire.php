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
    public function get(string $name, ?string $userId): array
    {
        $stmt = $this->dbh->prepare("
            SELECT 
                categories.id,
                categories.title_sef sef,
                categories.title_{$this->lang} questions_category,
                questions.id question_id,
                questions.title_sef question_sef,
                questions.db_template,
                questions.title_{$this->lang} question_title,
                (solved_at IS NOT NULL) solved
            FROM categories
            JOIN questionnires ON questionnires.id = categories.questionnire_id
            JOIN question_categories ON question_categories.category_id = categories.id
            JOIN questions ON question_categories.question_id = questions.id
            LEFT JOIN user_questions ON user_questions.question_id = questions.id and user_questions.user_id = :userId
            WHERE not categories.deleted AND not questions.deleted AND
                questionnires.name = :questionnire
            ORDER BY categories.sequence_position, question_categories.sequence_position
        ");
        try {
            $stmt->execute([':userId' => $userId, ':questionnire' => $name]);
        } catch (Exception $e) {
            var_dump($e);
        }
        $questionnire = $stmt->fetchAll(PDO::FETCH_ASSOC);
        if ($questionnire) {
            $menu = array_reduce(
                $questionnire,
                function($acc, $el) {
                    if (!isset($acc[$el['id']])) $acc[$el['id']] = [
                        'title'     => $el['questions_category'],
                        'db'        => $el['db_template'],
                        'sef'       => $el['sef'],
                        'questions' => []
                    ];
                    $acc[$el['id']]['questions'][] = [$el['question_title'], $el['question_id'], $el['solved'], $el['question_sef']];
                    return $acc;
                },
                []
            );
        } else {
            $menu = [];
        }
        return [
            'name' => $name,
            'menu' => $menu
        ];
    }

    public function getCategoriesCount(): int
    {
        $stmt = $this->dbh->prepare("SELECT COUNT(id) FROM categories WHERE not deleted;");
        $stmt->execute();
        return $stmt->fetchColumn(0);
    }

    public function getQuestionsCount(): int
    {
        $stmt = $this->dbh->prepare("SELECT COUNT(id) FROM questions WHERE not deleted;");
        $stmt->execute();
        return $stmt->fetchColumn(0);
    }

    public function getCategoryId(string $sef): int
    {
        $stmt = $this->dbh->prepare("SELECT id FROM categories WHERE title_sef = :sef ;");
        $stmt->execute([':sef' => $sef]);
        return $stmt->fetchColumn(0);
    }
    
    public function getQuestionId(string $sef): int
    {
        $stmt = $this->dbh->prepare("SELECT id FROM questions WHERE title_sef = :sef ;");
        $stmt->execute([':sef' => $sef]);
        var_dump($sef);
        var_dump($stmt->fetchColumn(0));
        return $stmt->fetchColumn(0);
    }
}