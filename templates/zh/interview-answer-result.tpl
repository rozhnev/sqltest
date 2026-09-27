{if !$AnswerResult.saved}
    <div class="interview-feedback">
        <p>
        {if $AnswerResult.error === 'empty'}
            您的回答为空——提交前请先填写内容。
        {elseif $AnswerResult.error === 'no_option'}
            请至少选择一个选项。
        {elseif $AnswerResult.error === 'llm_unavailable'}
            暂时无法评估您的回答。请一分钟后重新提交——本次尝试不计入次数。
        {else}
            该题目已不再有效。
            <a href="/{$Lang}/interview/{$SessionId}/question">前往当前题目</a>
        {/if}
        </p>
    </div>
{else}
    {assign var="check" value=$AnswerResult.check}
    {assign var="feedback" value=$AnswerResult.feedback}
    <div class="interview-feedback {if $AnswerResult.correct}correct{elseif !$AnswerResult.final}retry{else}wrong{/if}">
        <p class="verdict">
            {if $AnswerResult.correct}✓ 回答正确{if $AnswerResult.questionType === 'free_answer'} — {$check.score}/100{/if}
            {elseif !$AnswerResult.final}差一点！第 {$AnswerResult.attempt} 次尝试，共 {$AnswerResult.maxAttempts} 次
            {else}✗ 回答错误{if $AnswerResult.questionType === 'free_answer'} — {$check.score}/100{/if}
            {/if}
        </p>
        {if isset($check.hints)}
            {if isset($check.hints.emptyQuery)}
                <p>查询为空。</p>
            {/if}
            {if isset($check.hints.queryError)}
                <p>查询返回了错误： <span class="sql_error">{$check.hints.queryError|escape}</span></p>
            {/if}
            {* Detailed diagnostics would give the answer away while a retry is still open. *}
            {if $AnswerResult.final && !$feedback}
                {if isset($check.hints.wrongQueryHints)}
                    {foreach $check.hints.wrongQueryHints as $hint}
                        {if $hint}<p>{$hint}</p>{/if}
                    {/foreach}
                {/if}
                {if isset($check.hints.multipleResults)}
                    <p>查询返回了多个结果集，预期只有一个。</p>
                {/if}
                {if isset($check.hints.columnsCount)}
                    <p>结果应包含 {$check.hints.columnsCount} 列。</p>
                {/if}
                {if isset($check.hints.columnsList)}
                    <p>预期的列：{$check.hints.columnsList}。</p>
                {/if}
                {if isset($check.hints.rowsCount)}
                    <p>结果应包含 {$check.hints.rowsCount} 行。</p>
                {/if}
                {if isset($check.hints.rowsData)}
                    <p>第 {$check.hints.rowsData.rowNumber} 行应为：</p>
                    {$check.hints.rowsData.rowTable}
                    <p>您的结果：</p>
                    {$check.hints.rowsData.resultTable}
                {/if}
            {/if}
        {/if}
    </div>

    {if $feedback && ($feedback.comment || $feedback.hint)}
        <div class="interview-dialog interview-reaction">
            <div class="dialog-row">
                {if $AnswerResult.questionType === 'query'}
                    <img class="dialog-avatar" src="/images/interview/meridian-logistics-sql-lead.jpg" alt="Daniel Park">
                {else}
                    <img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">
                {/if}
                <div class="dialog-message">
                    <p class="dialog-author">{if $AnswerResult.questionType === 'query'}Daniel Park{else}Elena Cho{/if}</p>
                    <div class="dialog-bubble">
                        {if !$AnswerResult.final}
                            <p class="pre-wrap">{$feedback.hint|default:$feedback.comment|escape}</p>
                            <p><em>请修改答案后重新提交。</em></p>
                        {else}
                            <p class="pre-wrap">{$feedback.comment|default:$feedback.hint|escape}</p>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    {/if}

    {if $AnswerResult.final}
        <p class="interview-next">
            {if $AnswerResult.nextQuestionId}
                <a class="button blue" href="/{$Lang}/interview/{$SessionId}/question">下一题</a>
            {else}
                <a class="button green" href="/{$Lang}/interview/{$SessionId}/result">结束并查看结果</a>
            {/if}
        </p>
    {/if}
{/if}
