{capture name="interviewer_question"}
    <p>Hello! I'm Elena Cho, Head of Data &amp; Engineering at Meridian Logistics. Thank you for applying for the {$InterviewSession.grade_label|escape} {$InterviewSession.position_label|escape} position.</p>
    <p>Before we get to the questions, tell me a bit about yourself: what is your experience with SQL, what kinds of tasks and databases have you worked with, and what do you enjoy most about this work?</p>
{/capture}
{capture name="elena_avatar"}<img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">{/capture}
{capture name="typing_row"}
    {* Shown on submit while the page waits for the reply (interview-session.tpl script). *}
    <div class="dialog-row" id="interviewer-typing" hidden>
        {$smarty.capture.elena_avatar}
        <div class="dialog-message">
            <p class="dialog-author">Elena Cho is typing…</p>
            <div class="dialog-bubble"><span class="typing-dots" aria-label="Elena is typing a reply"><span></span><span></span><span></span></span></div>
        </div>
    </div>
{/capture}
{assign var="status" value=$InterviewSession.status}
{assign var="analysis" value=$InterviewSession.self_intro_analysis|default:[]}
{assign var="followupQuestion" value=$analysis.followup_question|default:''}
<div class="interview-session-box lesson-wrapper">
    {if $status === 'intro' || $status === 'intro_followup' || $status === 'in_progress'}
        <h2>Interview at Meridian Logistics</h2>
        <div class="interview-dialog">
            <div class="dialog-row">
                {$smarty.capture.elena_avatar}
                <div class="dialog-message">
                    <p class="dialog-author">Elena Cho, Head of Data &amp; Engineering</p>
                    <div class="dialog-bubble">{$smarty.capture.interviewer_question}</div>
                </div>
            </div>
            <div class="dialog-row candidate">
                <div class="dialog-avatar candidate-avatar">You</div>
                <div class="dialog-message">
                    <p class="dialog-author">Your answer</p>
                    {if $status === 'intro'}
                        <form method="post" class="dialog-bubble">
                            <textarea name="self_intro" required maxlength="4000" aria-label="Tell us about yourself" placeholder="E.g.: I've worked with SQL for 2 years, mostly writing reports and optimizing slow queries..."></textarea>
                            {if $SelfIntroError}
                                <p class="error-text">{$SelfIntroError|escape}</p>
                            {/if}
                            <div class="dialog-actions">
                                <button type="submit" class="button blue">Send</button>
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
                                <p>Thanks for telling me about yourself! Let's move on to the questions.</p>
                            {/if}
                            {if $followupQuestion}
                                <p class="followup-question">{$followupQuestion|escape}</p>
                            {/if}
                        </div>
                    </div>
                </div>
                {if $followupQuestion}
                    <div class="dialog-row candidate">
                        <div class="dialog-avatar candidate-avatar">You</div>
                        <div class="dialog-message">
                            <p class="dialog-author">Your answer</p>
                            {if $status === 'intro_followup'}
                                <form method="post" class="dialog-bubble">
                                    <textarea name="followup_answer" required maxlength="4000" aria-label="Answer to Elena's question" placeholder="Your answer..."></textarea>
                                    {if $SelfIntroError}
                                        <p class="error-text">{$SelfIntroError|escape}</p>
                                    {/if}
                                    <div class="dialog-actions">
                                        <button type="submit" class="button blue">Send</button>
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
                                <div class="dialog-bubble"><p>Thanks, that helps me understand your experience better. Now let's move on to the questions.</p></div>
                            </div>
                        </div>
                    {/if}
                {/if}
            {/if}
        </div>
        {if $status === 'in_progress'}
            <p class="dialog-next">
                <a class="button blue" href="/{$Lang}/interview/{$InterviewSession.id}/question">Go to the questions</a>
            </p>
        {/if}
    {else}
        <h2>Session status: {$status|escape}</h2>
        <p>Position: {$InterviewSession.position_label|escape}, grade: {$InterviewSession.grade_label|escape}</p>
    {/if}
</div>
