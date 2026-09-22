{include file='short-header.tpl'}
<style>
    .interview-session-box { max-width: 640px; margin: 10vh auto; padding: 0 1rem; }
    .interview-session-box textarea {
        width: 100%; min-height: 160px; box-sizing: border-box; padding: 0.75rem;
        border-radius: 10px; border: 1px solid #CBD5E1; font: inherit; resize: vertical;
    }
    .interview-session-box .error-text { color: #B91C1C; margin: 0.5rem 0; }
    .interview-analysis { text-align: left; background: #F8FAFC; border: 1px solid #E2E8F0; border-radius: 14px; padding: 1.25rem 1.5rem; margin-top: 1rem; }
    .interview-analysis h4 { margin: 0.75rem 0 0.35rem; color: #1E3A8A; }
    .interview-analysis ul { margin: 0; padding-left: 1.2rem; }
</style>
<body>
    <div class="container">
        <header>
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/interview-start"}
            {else}
                {include file='top-menu.tpl' path="/interview-start"}
            {/if}
        </header>
        <main>
            <div class="interview-session-box" style="text-align: center;">
                {if $InterviewSession.status === 'intro'}
                    {if $Lang === 'ru'}
                        <h2>Расскажите о себе</h2>
                        <p>Прежде чем начать вопросы, коротко расскажите о своём опыте и подходе к работе с SQL.</p>
                    {else}
                        <h2>Tell us about yourself</h2>
                        <p>Before the questions start, briefly describe your experience and how you approach working with SQL.</p>
                    {/if}
                    {if $SelfIntroError}
                        <p class="error-text">{$SelfIntroError|escape}</p>
                    {/if}
                    <form method="post">
                        <textarea name="self_intro" required maxlength="4000" placeholder="{if $Lang === 'ru'}Например: работаю с SQL 2 года, чаще всего пишу отчёты и оптимизирую медленные запросы...{else}E.g.: I've worked with SQL for 2 years, mostly writing reports and optimizing slow queries...{/if}"></textarea>
                        <p><button type="submit" class="button blue">{if $Lang === 'ru'}Продолжить{else}Continue{/if}</button></p>
                    </form>
                {elseif $InterviewSession.status === 'in_progress'}
                    {if $Lang === 'ru'}
                        <h2>{if $InterviewJustSubmitted}Спасибо!{else}Собеседование продолжается{/if}</h2>
                    {else}
                        <h2>{if $InterviewJustSubmitted}Thank you!{else}Interview in progress{/if}</h2>
                    {/if}
                    <div class="interview-analysis">
                        <p><strong>{if $Lang === 'ru'}Ваша самопрезентация:{else}Your self-presentation:{/if}</strong></p>
                        <p style="white-space: pre-wrap;">{$InterviewSession.self_intro|escape}</p>
                        {if $InterviewSession.self_intro_analysis.interviewer_message|default:''}
                            <h4>{if $Lang === 'ru'}Интервьюер отвечает{else}The interviewer responds{/if}</h4>
                            <p style="white-space: pre-wrap; font-style: italic;">&ldquo;{$InterviewSession.self_intro_analysis.interviewer_message|escape}&rdquo;</p>
                        {else}
                            <p style="color: #64748B;">
                                {if $Lang === 'ru'}Автоматическая оценка сейчас недоступна — это не помешает продолжить интервью.{else}Automated feedback isn't available right now -- this won't stop the interview.{/if}
                            </p>
                        {/if}
                    </div>
                    <p style="font-size: 0.9em; color: #64748B; margin-top: 1.5rem;">
                        {if $Lang === 'ru'}Экран вопросов ещё в разработке — вернитесь позже, чтобы продолжить эту сессию.{else}The question screen is still under construction -- check back later to continue this session.{/if}
                    </p>
                {else}
                    {if $Lang === 'ru'}
                        <h2>Статус сессии: {$InterviewSession.status|escape}</h2>
                        <p>Позиция: {$InterviewSession.position|escape}, грейд: {$InterviewSession.grade|escape}</p>
                    {else}
                        <h2>Session status: {$InterviewSession.status|escape}</h2>
                        <p>Position: {$InterviewSession.position|escape}, grade: {$InterviewSession.grade|escape}</p>
                    {/if}
                {/if}
            </div>
        </main>
        <footer>
            {if $MobileView}
                {include file='m.footer.tpl'}
            {else}
                {include file='footer.tpl'}
            {/if}
        </footer>
    </div>
</body>
</html>
