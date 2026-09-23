{capture name="interviewer_question"}
    <p>Hello! I'm Elena Cho, Head of Data &amp; Engineering at Meridian Logistics. Thank you for applying for the {$InterviewSession.grade_label|escape} {$InterviewSession.position_label|escape} position.</p>
    <p>Before we get to the questions, tell me a bit about yourself: what is your experience with SQL, what kinds of tasks and databases have you worked with, and what do you enjoy most about this work?</p>
{/capture}
<div class="interview-session-box lesson-wrapper">
    {if $InterviewSession.status === 'intro' || $InterviewSession.status === 'in_progress'}
        <h2>Interview at Meridian Logistics</h2>
        <div class="interview-dialog">
            <div class="dialog-row">
                <img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">
                <div class="dialog-message">
                    <p class="dialog-author">Elena Cho, Head of Data &amp; Engineering</p>
                    <div class="dialog-bubble">{$smarty.capture.interviewer_question}</div>
                </div>
            </div>
            <div class="dialog-row candidate">
                <div class="dialog-avatar candidate-avatar">You</div>
                <div class="dialog-message">
                    <p class="dialog-author">Your answer</p>
                    {if $InterviewSession.status === 'intro'}
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
            {if $InterviewSession.status === 'intro'}
                {* Shown on submit while Elena's reply is being prepared (interview-session.tpl script). *}
                <div class="dialog-row" id="interviewer-typing" hidden>
                    <img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">
                    <div class="dialog-message">
                        <p class="dialog-author">Elena Cho is typing…</p>
                        <div class="dialog-bubble"><span class="typing-dots" aria-label="Elena is typing a reply"><span></span><span></span><span></span></span></div>
                    </div>
                </div>
            {/if}
            {if $InterviewSession.status === 'in_progress'}
                <div class="dialog-row">
                    <img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">
                    <div class="dialog-message">
                        <p class="dialog-author">Elena Cho</p>
                        <div class="dialog-bubble">
                            {if $InterviewSession.self_intro_analysis.interviewer_message|default:''}
                                <p class="pre-wrap">{$InterviewSession.self_intro_analysis.interviewer_message|escape}</p>
                            {else}
                                <p>Thanks for telling me about yourself! Let's move on to the questions.</p>
                            {/if}
                        </div>
                    </div>
                </div>
            {/if}
        </div>
        {if $InterviewSession.status === 'in_progress'}
            <p class="dialog-next">
                <a class="button blue" href="/{$Lang}/interview/{$InterviewSession.id}/question">Go to the questions</a>
            </p>
        {/if}
    {else}
        <h2>Session status: {$InterviewSession.status|escape}</h2>
        <p>Position: {$InterviewSession.position_label|escape}, grade: {$InterviewSession.grade_label|escape}</p>
    {/if}
</div>
