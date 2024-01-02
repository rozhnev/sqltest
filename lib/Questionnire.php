<?php
class Questionnire 
{
    private $dbh;
    private $lang;

    public function __construct(PDO $dbh, string $lang)
    {
        $this->dbh  = $dbh;
        $this->lang = $lang;
    }

    public function get() {
        $stmt = $this->dbh->prepare("
            SELECT 
                question_categories.title_{$this->lang} question_category,
                questions.id question_id,
                questions.db_template,
                questions.title_{$this->lang} question_title
            FROM question_categories 
            LEFT JOIN questions ON question_categories.id = questions.category_id
            ORDER BY question_categories.sequence_position, questions.sequence_position
        ");
        $stmt->execute();
        $questionnire = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return array_reduce(
            $questionnire,
            function($acc, $el) {
                if (!isset($acc[$el['question_category']])) $acc[$el['question_category']] = [
                    'title'     => $el['question_category'],
                    'db'        => $el['db_template'],
                    'questions' => []
                ];
                $acc[$el['question_category']]['questions'][] = [$el['question_title'], $el['question_id']];
                return $acc;
            },
            []
        );
    }
}