{capture name="interviewer_question"}
    <p>您好！我是 Elena Cho，Meridian Logistics 数据与工程部负责人。感谢您申请 {$InterviewSession.position_label|escape}（{$InterviewSession.grade_label|escape}）职位。</p>
    <p>在开始提问之前，请简单介绍一下您自己：您的 SQL 经验如何？做过哪些类型的任务、用过哪些数据库？这份工作中您最喜欢的是什么？</p>
{/capture}
{capture name="elena_avatar"}<img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">{/capture}
{capture name="typing_row"}
    {* Shown on submit while the page waits for the reply (interview-session.tpl script). *}
    <div class="dialog-row" id="interviewer-typing" hidden>
        {$smarty.capture.elena_avatar}
        <div class="dialog-message">
            <p class="dialog-author">Elena Cho 正在输入…</p>
            <div class="dialog-bubble"><span class="typing-dots" aria-label="Elena 正在输入回复"><span></span><span></span><span></span></span></div>
        </div>
    </div>
{/capture}
{assign var="status" value=$InterviewSession.status}
{assign var="analysis" value=$InterviewSession.self_intro_analysis|default:[]}
{assign var="followupQuestion" value=$analysis.followup_question|default:''}
<div class="interview-session-box lesson-wrapper">
    {if $status === 'intro' || $status === 'intro_followup' || $status === 'in_progress'}
        <h2>Meridian Logistics 面试</h2>
        <div class="interview-dialog">
            <div class="dialog-row">
                {$smarty.capture.elena_avatar}
                <div class="dialog-message">
                    <p class="dialog-author">Elena Cho，数据与工程部负责人</p>
                    <div class="dialog-bubble">{$smarty.capture.interviewer_question}</div>
                </div>
            </div>
            <div class="dialog-row candidate">
                <div class="dialog-avatar candidate-avatar">您</div>
                <div class="dialog-message">
                    <p class="dialog-author">您的回答</p>
                    {if $status === 'intro'}
                        <form method="post" class="dialog-bubble">
                            <textarea name="self_intro" required maxlength="4000" aria-label="介绍一下您自己" placeholder="例如：我使用 SQL 两年了，主要编写报表并优化慢查询……"></textarea>
                            {if $SelfIntroError}
                                <p class="error-text">{$SelfIntroError|escape}</p>
                            {/if}
                            <div class="dialog-actions">
                                <button type="submit" class="button blue">发送</button>
                            </div>
                        </form>
                    {else}
                        <div class="dialog-bubble"><p class="pre-wrap">{$InterviewSession.self_intro|escape}</p></div>
                    {/if}
                </div>
            </div>
            {if $status === 'intro'}
                {$smarty.capture.typing_row}
            {else}
                <div class="dialog-row">
                    {$smarty.capture.elena_avatar}
                    <div class="dialog-message">
                        <p class="dialog-author">Elena Cho</p>
                        <div class="dialog-bubble">
                            {if $analysis.interviewer_message|default:''}
                                <p class="pre-wrap">{$analysis.interviewer_message|escape}</p>
                            {elseif !$followupQuestion}
                                <p>谢谢您的自我介绍！我们开始提问吧。</p>
                            {/if}
                            {if $followupQuestion}
                                <p class="followup-question">{$followupQuestion|escape}</p>
                            {/if}
                        </div>
                    </div>
                </div>
                {if $followupQuestion}
                    <div class="dialog-row candidate">
                        <div class="dialog-avatar candidate-avatar">您</div>
                        <div class="dialog-message">
                            <p class="dialog-author">您的回答</p>
                            {if $status === 'intro_followup'}
                                <form method="post" class="dialog-bubble">
                                    <textarea name="followup_answer" required maxlength="4000" aria-label="回答 Elena 的问题" placeholder="您的回答……"></textarea>
                                    {if $SelfIntroError}
                                        <p class="error-text">{$SelfIntroError|escape}</p>
                                    {/if}
                                    <div class="dialog-actions">
                                        <button type="submit" class="button blue">发送</button>
                                    </div>
                                </form>
                            {else}
                                <div class="dialog-bubble"><p class="pre-wrap">{$analysis.followup.answer|default:''|escape}</p></div>
                            {/if}
                        </div>
                    </div>
                    {if $status === 'intro_followup'}
                        {$smarty.capture.typing_row}
                    {else}
                        <div class="dialog-row">
                            {$smarty.capture.elena_avatar}
                            <div class="dialog-message">
                                <p class="dialog-author">Elena Cho</p>
                                <div class="dialog-bubble"><p>谢谢，这让我更好地了解了您的经验。现在我们开始提问吧。</p></div>
                            </div>
                        </div>
                    {/if}
                {/if}
            {/if}
        </div>
        {if $status === 'in_progress'}
            <p class="dialog-next">
                <a class="button blue" href="/{$Lang}/interview/{$InterviewSession.id}/question">开始答题</a>
            </p>
        {/if}
    {else}
        <h2>会话状态：{$status|escape}</h2>
        <p>职位：{$InterviewSession.position_label|escape}，等级：{$InterviewSession.grade_label|escape}</p>
    {/if}
</div>
