{capture name="interviewer_question"}
    <p>Здравствуйте! Меня зовут Елена Чо, я руковожу отделом данных и разработки в Meridian Logistics. Спасибо, что откликнулись на вакансию {$InterviewSession.position_label|escape} уровня {$InterviewSession.grade_label|escape}.</p>
    <p>Прежде чем перейдём к вопросам, расскажите немного о себе: какой у вас опыт работы с SQL, с какими задачами и базами данных приходилось работать и что вам в этой работе интереснее всего?</p>
{/capture}
<div class="interview-session-box lesson-wrapper">
    {if $InterviewSession.status === 'intro' || $InterviewSession.status === 'in_progress'}
        <h2>Собеседование в Meridian Logistics</h2>
        <div class="interview-dialog">
            <div class="dialog-row">
                <img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Елена Чо">
                <div class="dialog-message">
                    <p class="dialog-author">Елена Чо, руководитель отдела данных и разработки</p>
                    <div class="dialog-bubble">{$smarty.capture.interviewer_question}</div>
                </div>
            </div>
            <div class="dialog-row candidate">
                <div class="dialog-avatar candidate-avatar">Вы</div>
                <div class="dialog-message">
                    <p class="dialog-author">Ваш ответ</p>
                    {if $InterviewSession.status === 'intro'}
                        <form method="post" class="dialog-bubble">
                            <textarea name="self_intro" required maxlength="4000" aria-label="Расскажите о себе" placeholder="Например: работаю с SQL 2 года, чаще всего пишу отчёты и оптимизирую медленные запросы..."></textarea>
                            {if $SelfIntroError}
                                <p class="error-text">{$SelfIntroError|escape}</p>
                            {/if}
                            <div class="dialog-actions">
                                <button type="submit" class="button blue">Отправить</button>
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
                    <img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Елена Чо">
                    <div class="dialog-message">
                        <p class="dialog-author">Елена Чо печатает…</p>
                        <div class="dialog-bubble"><span class="typing-dots" aria-label="Елена печатает ответ"><span></span><span></span><span></span></span></div>
                    </div>
                </div>
            {/if}
            {if $InterviewSession.status === 'in_progress'}
                <div class="dialog-row">
                    <img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Елена Чо">
                    <div class="dialog-message">
                        <p class="dialog-author">Елена Чо</p>
                        <div class="dialog-bubble">
                            {if $InterviewSession.self_intro_analysis.interviewer_message|default:''}
                                <p class="pre-wrap">{$InterviewSession.self_intro_analysis.interviewer_message|escape}</p>
                            {else}
                                <p>Спасибо, что рассказали о себе! Давайте перейдём к вопросам.</p>
                            {/if}
                        </div>
                    </div>
                </div>
            {/if}
        </div>
        {if $InterviewSession.status === 'in_progress'}
            <p class="dialog-next">
                <a class="button blue" href="/{$Lang}/interview/{$InterviewSession.id}/question">Перейти к вопросам</a>
            </p>
        {/if}
    {else}
        <h2>Статус сессии: {$InterviewSession.status|escape}</h2>
        <p>Позиция: {$InterviewSession.position_label|escape}, грейд: {$InterviewSession.grade_label|escape}</p>
    {/if}
</div>
