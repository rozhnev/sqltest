<div class="interview-progress">
    <span>Meridian Logistics &middot; {$InterviewSession.position_label|escape} &middot; {$InterviewSession.grade_label|escape}</span>
    <span>第 {$InterviewQuestion.sequence} 题，共 {$InterviewQuestion.questions_count} 题</span>
</div>
<div class="interview-progress-bar"><span style="width: {$InterviewProgressPercent}%;"></span></div>

{* On a retry Daniel's reaction to the previous attempt (below) replaces the intro. *}
{if $InterviewQuestion.question_type == 'query' && $InterviewQuestion.attempt_number == 1}
    <div class="interview-dialog">
        <div class="dialog-row">
            <img class="dialog-avatar" src="/images/interview/meridian-logistics-sql-lead.jpg" alt="Daniel Park">
            <div class="dialog-message">
                <p class="dialog-author">Daniel Park，首席 SQL 开发工程师</p>
                <div class="dialog-bubble">
                    {if $InterviewQuestion.query_number == 1}
                        <p>您好！我是 Daniel，负责 Meridian Logistics 的 SQL 开发团队。Elena 请我主持实操环节——现在来看看您的 SQL 实战能力吧。</p>
                        <p>这些任务在真实数据库上运行：您可以随时点击“运行”按钮执行查询并查看结果，确认无误后再提交答案。如果您的方案接近正确，我会指出错误所在并再给您一次机会。不用着急——我会等您。</p>
                    {else}
                        <p>很好，我们继续。这是下一道任务——和之前一样，先运行查询并检查结果，然后再提交。</p>
                    {/if}
                </div>
            </div>
        </div>
    </div>
{/if}

<div class="question-wrapper">
    <div class="question-title-bar" style="display: flex;">
        <div class="question-title">
            <div class="question-level rate{$InterviewQuestion.rate}" title="{$InterviewQuestion.question_rate|escape}" style="margin-top: 3px;"></div>
            <span>{$InterviewQuestion.title|escape}</span>
        </div>
    </div>
    <div class="question">{$InterviewQuestion.task}</div>
    {if $InterviewQuestion.question_type == 'answer'}
        <div class="answers" id="answers-list">
        {foreach $InterviewQuestion.answers as $answer}
            <div class="answer">
                <input type="checkbox" id="answer-{$answer.id}" name="answers" value="{$answer.id}"{if in_array($answer.id, $InterviewQuestion.selected_answers|default:[])} checked{/if}>
                <label for="answer-{$answer.id}"> {$answer.answer}</label>
            </div>
        {/foreach}
        </div>
        <p class="question-action">请选出所有正确答案。</p>
    {elseif $InterviewQuestion.question_type == 'free_answer'}
        <p class="question-action">请用自己的话作答。</p>
    {else}
        <p class="question-action">请编写能解决该任务的查询。</p>
    {/if}
</div>

<div class="question-wrapper">
    {if $InterviewQuestion.question_type == 'free_answer'}
        <textarea class="code-wrapper free-answer-textarea" id="free-answer-input" maxlength="4000" placeholder="您的回答……">{$InterviewQuestion.answer_text|escape}</textarea>
    {elseif $InterviewQuestion.question_type == 'query'}
        <div class="code-wrapper" id="sql-code">{$InterviewQuestion.last_query|escape}</div>
    {/if}
    {if $InterviewQuestion.question_type != 'query' && $InterviewQuestion.attempt_number == 1}
        <p class="question-action" style="font-size: 0.9em;">就像真实面试一样：如果您的答案接近正确，面试官会给出提示并再给一次机会。</p>
    {/if}
    <div class="code-buttons">
        {if $InterviewQuestion.question_type == 'query'}
            <button class="button" id="runQueryBtn" onClick="runQuery('{$Lang}', {$QuestionID})" title="Ctrl+Enter">
                <i class="run-query-icon"></i>
                <span>运行</span>
            </button>
        {/if}
        <button class="button green" id="interviewSubmitBtn"
                data-url="/{$Lang}/interview/{$InterviewSession.id}/answer"
                data-question-id="{$QuestionID}"
                data-error-text="出了点问题，请重试。"
                onClick="submitInterviewAnswer(this)">
            <i class="run-icon"></i>
            <span>提交答案</span>
        </button>
    </div>
    <div id="interview-answer-feedback">
        {if $InterviewQuestion.attempt_number > 1 && $InterviewQuestion.llm_feedback}
            <div class="interview-feedback retry">
                <p class="verdict">差一点！第 {$InterviewQuestion.attempt_number} 次尝试，共 {$InterviewQuestion.max_attempts} 次</p>
            </div>
            <div class="interview-dialog interview-reaction">
                <div class="dialog-row">
                    {if $InterviewQuestion.question_type == 'query'}
                        <img class="dialog-avatar" src="/images/interview/meridian-logistics-sql-lead.jpg" alt="Daniel Park">
                    {else}
                        <img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">
                    {/if}
                    <div class="dialog-message">
                        <p class="dialog-author">{if $InterviewQuestion.question_type == 'query'}Daniel Park{else}Elena Cho{/if}</p>
                        <div class="dialog-bubble">
                            <p class="pre-wrap">{$InterviewQuestion.llm_feedback|escape}</p>
                            <p><em>请修改答案后重新提交。</em></p>
                        </div>
                    </div>
                </div>
            </div>
        {/if}
    </div>
    {* Shown in #interview-answer-feedback while the answer is being checked (interview-question.tpl script). *}
    <template id="interviewer-typing">
        <div class="interview-dialog interview-reaction">
            <div class="dialog-row">
                {if $InterviewQuestion.question_type == 'query'}
                    <img class="dialog-avatar" src="/images/interview/meridian-logistics-sql-lead.jpg" alt="Daniel Park">
                {else}
                    <img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">
                {/if}
                <div class="dialog-message">
                    <p class="dialog-author">{if $InterviewQuestion.question_type == 'query'}Daniel 正在输入…{else}Elena 正在输入…{/if}</p>
                    <div class="dialog-bubble"><span class="typing-dots" aria-label="面试官正在输入回复"><span></span><span></span><span></span></span></div>
                </div>
            </div>
        </div>
    </template>
</div>

<div class="question-wrapper">
    <div class="code-result ace-xcode" id="code-result"></div>
</div>

