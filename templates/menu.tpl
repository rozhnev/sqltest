<div class="menu">
    {foreach $Questionnire as $panel}
    <button class="accordion">{$panel.title}</button>
    <div class="panel">
        <ol>
        {foreach $panel.questions as $question}
        <li><a class="question-link {if $QuestionID == $question[1]} current-question{/if}" href="/{$Lang}/{$panel.db}/{$question[1]}">{$question[0]}</a></li>
        {/foreach}
        </ol>
    </div>
    {/foreach}
    <div class="menu-ad">
        <div id="yandex_rtb_R-A-4716552-2"></div>
    </div>
</div>