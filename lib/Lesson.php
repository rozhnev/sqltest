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
        $this->moduleSlug = $lesson['module_slug'];
        $this->id = $lesson['id'];
        if (!$this->id) {
            throw new Exception("Lesson not found");
        }
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
        $stmt = $this->dbh->prepare("SELECT
                title,
                content,
                description
            FROM lessons_localization
            WHERE lessons_localization.lesson_id = :id AND lessons_localization.language = :lang");
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
                and not lessons.deleted;
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
        // echo "<pre>";
        // var_export($menu);
        return $menu;
    }
}