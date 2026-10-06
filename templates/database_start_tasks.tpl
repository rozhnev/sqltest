{* The first tasks of the database's own task list (database.tpl), easiest first in the menu order *}
<ol class="db-start-tasks">
    {foreach $StartTasks as $task}
        <li>
            <span class="question-level rate{$task.rate}" aria-hidden="true"></span>
            <a href="{$task.link}">{$task.title|escape}</a>
        </li>
    {/foreach}
</ol>
