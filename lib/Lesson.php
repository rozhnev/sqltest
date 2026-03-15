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
        ) select 
            lessons_localization.title,
            lessons_localization.content,
            lessons_localization.description,
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
}