<?php
class Lesson
{
    /**
     * Language
     *
     * @var string
     */
    private $lang;

    /**
     * DB hahdler 
     *
     * @var PDO
     */
    private $dbh;
    private $id;
    private $slug;
    private $moduleSlug;

    public function __construct(PDO $dbh, string $slug)
    {
        $this->dbh  = $dbh;
        $this->slug = $slug;
        $stmt = $this->dbh->prepare("SELECT
                lessons.id AS id,
                modules.slug AS module_slug
            FROM lessons 
            JOIN modules ON lessons.module_id = modules.id
            WHERE lessons.slug = :slug 
                and not lessons.deleted and not modules.deleted");
        $stmt->execute([':slug' => $this->slug]);
        $lesson = $stmt->fetch(PDO::FETCH_ASSOC);
        if (!$lesson) {
            throw new Exception("Lesson not found");
        }
        $this->moduleSlug = $lesson['module_slug'];
        $this->id = $lesson['id'];
    }

    public function slug(): string
    {
        return $this->slug;
    }

    public function moduleSlug(): string
    {
        return $this->moduleSlug;
    }

    public function get(string $lang): array
    {
        $stmt = $this->dbh->prepare("
            with lessons as (
                select 
                    lessons.id,
                    lag(modules.slug) over(order by modules.sequence_position, lessons.sequence_position) prev_module_slug,
                    lag(lessons.slug) over(order by modules.sequence_position, lessons.sequence_position) prev_lesson_slug,
                    lead(modules.slug) over(order by modules.sequence_position, lessons.sequence_position) next_module_slug,
                    lead(lessons.slug) over(order by modules.sequence_position, lessons.sequence_position) next_lesson_slug
                from lessons
                join modules on modules.id = lessons.module_id
                where not lessons.deleted and not modules.deleted
            ) select 
                lessons_localization.title,
                lessons_localization.content,
                lessons_localization.updated_at,
                lessons.* 
            from lessons 
            join lessons_localization on lessons_localization.lesson_id = lessons.id AND lessons_localization.language = :lang
            where lessons.id = :id;
        ");
        $stmt->execute([':id' => $this->id, ':lang' => $lang]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getList(string $lang): array
    {
        $stmt = $this->dbh->prepare("SELECT
                modules.id,
                modules.slug AS module_slug,
                modules_localization.title AS module_title,
                lessons.id AS lesson_id,
                lessons.slug AS lesson_slug,
                ll.title lesson_title,
                ROW_NUMBER() OVER (PARTITION BY modules.id ORDER BY lessons.sequence_position) AS lesson_number
            FROM modules
            JOIN modules_localization ON modules.id = modules_localization.module_id and modules_localization.language =  :lang
            join lessons on lessons.module_id = modules.id
            join lessons_localization ll on ll.lesson_id = lessons.id and ll.language  = :lang
            WHERE modules_localization.language = :lang
                and not modules.deleted 
                and not lessons.deleted
            ORDER BY modules.sequence_position, lessons.sequence_position;
        ");

        $stmt->execute([':lang' => $lang]);
        $lessonsList =  $stmt->fetchAll(PDO::FETCH_ASSOC);

        $menu = array_reduce(
            $lessonsList,
            function($acc, $el) {
                if (!isset($acc[$el['module_slug']])) {
                    $acc[$el['module_slug']] = [
                        'title'     => $el['module_title'],
                        'module_slug'       => $el['module_slug'],
                        'lessons' => []
                    ];
                }
                $acc[$el['module_slug']]['lessons'][] = ['title' => $el['lesson_title'], 'slug' => $el['lesson_slug'], 'number' => $el['lesson_number']];
                return $acc;
            },
            []
        );
        return $menu;
    }

    public function getMap(): array
    {
        $stmt = $this->dbh->prepare("SELECT
                modules.id,
                modules.slug AS module,
                lessons.id AS lesson_id,
                lessons.slug AS slug
            FROM modules
            JOIN lessons on lessons.module_id = modules.id
            WHERE not modules.deleted and not lessons.deleted
            ORDER BY modules.sequence_position, lessons.sequence_position;
        ");

        $stmt->execute();
        return  $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getRelevantTasks(string $lang, ?string $userId, int $limit = 5): array
    {
        $tutorialLink = "/{$lang}/lesson/{$this->moduleSlug}/{$this->slug}";

        $stmt = $this->dbh->prepare("WITH primary_category AS (
                SELECT
                    question_categories.question_id,
                    categories.title_sef AS category_sef,
                    categories.sequence_position AS category_order,
                    question_categories.sequence_position AS question_order,
                    ROW_NUMBER() OVER (
                        PARTITION BY question_categories.question_id
                        ORDER BY categories.sequence_position, question_categories.sequence_position
                    ) AS row_num
                FROM question_categories
                JOIN categories ON categories.id = question_categories.category_id
                WHERE NOT categories.deleted
            )
            SELECT
                questions.id,
                questions.title_sef AS question_sef,
                questions.rate,
                questions_localization.title,
                primary_category.category_sef,
                (user_questions.solved_at IS NOT NULL) AS solved
            FROM questions
            JOIN questions_localization ON questions_localization.question_id = questions.id
                AND questions_localization.language = :lang
            JOIN primary_category ON primary_category.question_id = questions.id
                AND primary_category.row_num = 1
            LEFT JOIN user_questions ON user_questions.question_id = questions.id
                AND user_questions.user_id = :user_id
            WHERE NOT questions.deleted
                AND questions_localization.tutorial_link = :tutorial_link
            ORDER BY
                CASE WHEN (:prefer_unsolved = 1 AND user_questions.solved_at IS NOT NULL) THEN 1 ELSE 0 END,
                questions.rate ASC,
                primary_category.category_order ASC,
                primary_category.question_order ASC,
                questions.id ASC
            LIMIT :limit
        ");

        $stmt->bindValue(':lang', $lang, PDO::PARAM_STR);
        $stmt->bindValue(':tutorial_link', $tutorialLink, PDO::PARAM_STR);
        $stmt->bindValue(':user_id', $userId, $userId === null ? PDO::PARAM_NULL : PDO::PARAM_STR);
        $stmt->bindValue(':prefer_unsolved', $userId === null ? 0 : 1, PDO::PARAM_INT);
        $stmt->bindValue(':limit', $limit, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC) ?: [];
    }

    public function parseMedadata(string &$content): array
    {
        $meta = [
            'teaches' => [
                'What a database is',
                'What a DBMS does',
                'Core SQL concepts',
                'Relational database fundamentals',
            ],
            'about' => ['Database', 'DBMS', 'SQL', 'Relational database'],
        ];

        if (!preg_match('/^\s*---\r?\n(.*?)\r?\n---\r?\n/s', $content, $matches)) {
            return $meta;
        }
        $content = substr($content, strlen($matches[0]));
        foreach (explode("\n", $matches[1]) as $line) {
            if (!preg_match('/^(\w+)\s*:\s*(.+)$/', trim($line), $kv)) {
                continue;
            }
            $key = $kv[1];
            $val = trim($kv[2], '"\'');
            if (str_starts_with($val, '[')) {
                preg_match_all('/"([^"]+)"|\'([^\']+)\'|([^,\[\]\s]+)/', $val, $items);
                $meta[$key] = array_values(array_filter(array_map(
                    fn($a, $b, $c) => $a ?: $b ?: $c,
                    $items[1], $items[2], $items[3]
                )));
            } else {
                $meta[$key] = $val;
            }
        }

        if (!is_array($meta['teaches'])) {
            $meta['teaches'] = [$meta['teaches']];
        }
        if (!is_array($meta['about'])) {
            $meta['about'] = [$meta['about']];
        }

        $meta['teaches'] = array_values(array_filter(array_map('strval', $meta['teaches']), static fn($v) => trim($v) !== ''));
        $meta['about']   = array_values(array_filter(array_map('strval', $meta['about']),   static fn($v) => trim($v) !== ''));

        return $meta;
    }
}