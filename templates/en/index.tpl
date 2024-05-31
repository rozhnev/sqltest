{include file='../header.tpl'}
<body>
<div class="container">
    {include file='popups.tpl'}
    {include file='top-menu.tpl'}
    {include file='menu.tpl'}
    {include file='../splitter.tpl'}
    <div class="main">
        <div class="question-wrapper">
            <div class="question-title">
                <div class="question-level rate{$Question.rate}" title="{$Question.question_rate|default:'Not rated yet'}"></div>
                Task {$Question.number}:
                {if $LoggedAsAdmin}
                    <a href="/admin/question/{$NextQuestionId}" title="Edit" style="color:#333">&#9998;</a>
                {/if}
                <span class="question-dates">
                    {if $Question.solved_date}
                        Solved at: {$Question.solved_date}
                    {elseif $Question.last_attempt_date}
                        Last Attempt Date: {$Question.last_attempt_date}
                    {/if}
                </span>
                <span class="question-navigate">
                    {if $PreviousQuestionId}
                        <a href="/{$Lang}/question/{$Question.category_sef}/{$PreviousQuestionId}" title="Previous task"><i class="arrow arrow-left"></i></a>
                    {/if}
                    {if $NextQuestionId}
                        <a href="/{$Lang}/question/{$Question.category_sef}/{$NextQuestionId}" title="Next task"><i class="arrow arrow-right"></i></a>
                    {/if}
                </span>
            </div>
            <div class="question">
                {$Question.task}
            </div>
            <p class="question-action">
            Write your request in the field below and click the "Check it!" button.{* (If there is an error, you will have to review the ad unit) *}
            <p class="question-action">
                To write the answer, use {$Question.dbms} syntax. Descriptions of the tables are given in the right panel.
            </p>
        </div>
        <div class="code-actions">
            <button onClick="copyCode(`SQL code copied to buffer`)">Copy code</button> <button onClick="clearEditor()">Clear editor</button>
            {* <a class="clear-code" id="format_sql_btn" title="Format SQL code" href="javascript:formatCode('sql');">Format</a> *}
        </div>
        <div class="code-wrapper" id="sql-code" name="sql-code">{$Question.last_query}</div>
        <div class="code-buttons">
            <button class="button" id="getHelpBtn" onClick="getHelp('{$Lang}', {$QuestionID})">Get help</button>
            <button class="button" id="runQueryBtn" onClick="runQuery('{$Lang}', {$QuestionID})" title="CTRL+Enter">Run query</button>
            <button class="button green" id="testQueryBtn" onClick="testQuery('{$Lang}', {$QuestionID})">Check it!</button>
            {if $NextQuestionId}
                <a href="/{$Lang}/question/{$Question.category_sef}/{$NextQuestionId}" title="Следующее задание" class="button green hidden">Next</a>
            {/if}
        </div>
        <div class="code-result ace-xcode" id="code-result"></div>
    </div>

    <div class="right" id="right-panel">
        <div class="text-block user-solutions-count">
             <p>Our website contains more than <span style="font-weight:bold; color: #2EA043 !important;">{floor(($QuestionsCount - 1)/10) * 10}</span> tasks.</p>
         {if $Logged}
             <p>You {if $SolvedQuestionsCount < ($QuestionsCount/2)}have{else}already{/if} solved <span style="font-weight:bold;  color: #2EA043 !important;">{$SolvedQuestionsCount}</span> of them. </p>
         {else}
             <p>Log in to save your progress.</p>
             <button class="button blue" onClick="toggleLoginWindow()">Login</button>
         {/if}
         </div>
        {include file="{$DB}.tpl"}
    </div>
    {include file='footer.tpl'}
