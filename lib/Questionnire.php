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
    private $supportedlanguages = ['en', 'ru', 'pt'];

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
                ROW_NUMBER() OVER (PARTITION BY categories.id ORDER BY question_categories.sequence_position) question_number,
                categories.id,
                categories.title_sef sef,
                categories_localization.title questions_category,
                questions.id question_id,
                questions.title_sef question_sef,
                questions.db_template,
                questions_localization.title question_title,
                (solved_at IS NOT NULL) solved,
                (favorites.question_id is not null) favored
            FROM categories
            JOIN categories_localization ON categories_localization.category_id = categories.id AND categories_localization.language =  :lang
            JOIN questionnires ON questionnires.id = categories.questionnire_id
            JOIN question_categories ON question_categories.category_id = categories.id
            JOIN questions ON question_categories.question_id = questions.id
            JOIN questions_localization on questions_localization.question_id = questions.id AND questions_localization.language = :lang
            LEFT JOIN user_questions ON user_questions.question_id = questions.id AND user_questions.user_id = :userId
            LEFT JOIN favorites ON favorites.question_id = questions.id AND favorites.user_id = :userId
            WHERE not categories.deleted AND not questions.deleted AND
                questionnires.name = :questionnire
            ORDER BY categories.sequence_position, question_categories.sequence_position
        ");
        try {
            $stmt->execute([':userId' => $userId, ':questionnire' => $name, ':lang' => $this->lang]);
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
                    $acc[$el['id']]['questions'][] = [$el['question_title'], $el['question_id'], $el['solved'], $el['question_sef'], $el['favored'], $el['question_number']];
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

    public function getMap(): array
    {
        $stmt = $this->dbh->prepare("SELECT min(c.title_sef) category, q.title_sef question
            FROM questions q 
            JOIN question_categories qc ON qc.question_id = q.id 
            JOIN categories c ON c.id = qc.category_id 
            WHERE not c.deleted AND not q.deleted
            GROUP BY q.title_sef;");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
    
    public function getNameByCategory(string $category): string
    {
        $stmt = $this->dbh->prepare("SELECT questionnires.name 
            FROM categories JOIN questionnires ON questionnires.id = categories.questionnire_id 
            WHERE categories.title_sef = :category_sef;");
        $stmt->execute([':category_sef' => $category]);
        return $stmt->fetchColumn(0);
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
        return $stmt->fetchColumn(0);
    }
     
    public function getQuestionLink(int $categoryId, int $questionId): string
    {
        $stmt = $this->dbh->prepare("SELECT CONCAT(
                '/{$this->lang}/question', 
                (SELECT CONCAT('/', title_sef) FROM categories WHERE id = :categoryId), 
                (SELECT CONCAT('/', title_sef) FROM questions WHERE id = :questionId)
            );"
        );
        $stmt->execute([':categoryId' => $categoryId, ':questionId' => $questionId]);
        return $stmt->fetchColumn(0);
    }
}