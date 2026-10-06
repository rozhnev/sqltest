{* Topics with tasks on the database (database.tpl): link to the first task, difficulty range, task count.
   The count is a bare number (no plural forms here): the language template says what it is above the list. *}
<ul class="db-topics">
    {foreach $Topics as $topic}
        <li>
            <a href="{$topic.link}">{$topic.title|escape}</a>
            <span class="db-levels" aria-hidden="true">
                <span class="question-level rate{$topic.rate_min}"></span>
                {if $topic.rate_max != $topic.rate_min}<span class="question-level rate{$topic.rate_max}"></span>{/if}
            </span>
            <span class="db-count">{$topic.count}</span>
        </li>
    {/foreach}
</ul>
