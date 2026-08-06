{include file='../header.tpl'}
<body>
<div class="container">
    {include file='popups.tpl'}
    {include file='top-menu.tpl'}
    <div class="menu" id="menu">
        <div id="test-timer" style="padding:5px 15px; border: 1px solid white; margin: 5px;"><span style="font-size:small;">完成此测试的时间为</span> <span id="test-timer-time"></span></div>
        <script>
            const showTimer = ()=>{ldelim}
                const time = Math.floor((new Date('{$Question.closed_at}') - new Date())/60000);
                if (time > 0) {
                    document.getElementById('test-timer-time').innerText = time + ' ' + (time>1 ? '分钟': '分钟');
                } else {
                    document.getElementById('test-timer').innerText = '测试时间已结束！'
                }
            {rdelim};
            showTimer();
            setInterval(showTimer,  60000);
        </script>
        <div id="menu-content" class="menu-content">
            {foreach $Questionnire.menu as $categoryId => $panel}
            <button class="accordion {if $categoryId eq $QuestionCategoryID}active{/if}">
                {$panel.title}
            </button>
            <div class="panel {if $categoryId eq $QuestionCategoryID}active{/if}">
                <ol>
                {foreach $panel.questions as $question}
                <li>
                    <a class="question-link {if $QuestionID == $question[1]} current-question{/if}{if $question[2]} solved{/if}" href="/{$Lang}/test/{$TestId}/{$question[1]}">
                        {$question[0]}
                    </a>
                </li>
                {/foreach}
                </ol>
            </div>
            {/foreach}
        </div>
        <div style="display: flex;   align-items: center; justify-content: center; margin-top: 1em;">
            <button class="button green" id="doneTest" onClick="doneTest('{$TestId}')">我完成了！显示我的评分</button>
        </div>
    </div>
    {include file='../splitter.tpl'}
    <div class="main">
        <div class="question-wrapper">
            <div class="question-title-bar" style="display: flex;">
                <div class="question-title">
                    <div class="question-level rate{$Question.rate}" title="{$Question.question_rate|default:'尚未评分'}"></div>
                    任务&nbsp;{$Question.number}:
                    {if $User->isAdmin()}
                        <a href="/admin/question/{$NextQuestionId}" title="编辑" style="color:#333">&#9998;</a>
                    {/if}
                    <span class="question-dates">
                        {if $Question.solved_date}
                            解决于: {$Question.solved_date}
                        {elseif $Question.last_attempt_date}
                            最后尝试日期: {$Question.last_attempt_date}
                        {/if}
                    </span>
                </div>
                {if $Question.previous_question_id}
                    <div class="question-navigate" style="border-right: 1px solid var(--text-block-border-color);">
                        <a href="/{$Lang}/test/{$TestId}/{$Question.previous_question_id}" title="上一任务"><i class="arrow arrow-left"></i></a>
                    </div>
                {/if}
                {if $Question.next_question_id}
                    <div class="question-navigate">
                        <a href="/{$Lang}/test/{$TestId}/{$Question.next_question_id}" title="下一任务"><i class="arrow arrow-right"></i></a>
                    </div>
                {/if}
            </div>
            <div class="question">
                {$Question.task}
            </div>
            {if isset($Question.answers)}
                <div class="answers" id="answers-list">
                {foreach $Question.answers as $answer}
                    <div class="answer">
                        <input type="checkbox" id="answer-{$answer.id}" name="answers" value="{$answer.id}" {if $answer.id|in_array:$Question.last_query} checked{/if}>
                        <label for="answer-{$answer.id}"> {$answer.answer}</label>
                    </div>
                {/foreach}
                </div>
                <p class="question-action">
                    标记所有正确答案并点击“检查！”按钮
                </p>
            {else}
                <p class="question-action">
                    在下面的字段中写下您的请求并点击“检查！”按钮。
                </p>
                <p class="question-action">
                    要写答案，请使用 {$Question.dbms} 语法。表的描述在右侧面板中给出。
                </p>
            {/if}
        </div>
        {if !isset($Question.answers)}
        <div class="code-actions">
            <button onClick="copyCode(`SQL 代码已复制到缓冲区`)">复制代码</button> <button onClick="clearEditor()">清除编辑器</button>
        </div>
        <div class="code-wrapper" id="sql-code" name="sql-code">{$Question.last_query}</div>
        {/if}
        <div class="code-buttons">
            {if !isset($Question.answers)}
                <button class="button" id="runQueryBtn" onClick="runQuery('{$Lang}', {$QuestionID})" title="CTRL+Enter">运行查询</button>
            {/if}
            {if {$Question.possible_attempts} > 0}
                <button class="button green" id="checkSolutionBtn" onClick="checkSolution('/{$Lang}/test/{$TestId}/check/{$QuestionID}')">检查！ ({$Question.possible_attempts})</button>
            {/if}
            {if $Question.next_question_id}
                <a href="/{$Lang}/test/{$TestId}/{$Question.next_question_id}" title="下一任务" class="button green hidden">下一步</a>
            {/if}
        </div>
        <div class="code-result ace-xcode" id="code-result"></div>
    </div>

    <div class="right" id="right-panel">
        {include file="{$DB}.tpl"}
    </div> 
    {include file='footer.tpl'}