{include file='header.tpl'}
{include file='interview-dialog-styles.tpl'}
<style>
    .interview-page .interview-dialog { margin-bottom: 1rem; }
    /* Theme variables, not fixed colors: the site's light theme sets --regular-text-color to white. */
    .interview-page { max-width: 960px; margin: 2rem auto; padding: 0 1rem; box-sizing: border-box; width: 100%; color: var(--question-text); }
    .interview-progress { display: flex; justify-content: space-between; align-items: center; gap: 1rem; flex-wrap: wrap; margin-bottom: 0.5rem; color: var(--question-date-color); font-size: 0.95em; }
    .interview-progress-bar { height: 6px; border-radius: 3px; background: var(--text-block-border-color); overflow: hidden; margin-bottom: 1.25rem; }
    .interview-progress-bar span { display: block; height: 100%; background: #2563EB; }
    .interview-page .question-wrapper { margin-bottom: 1rem; }
    .interview-page #sql-code { height: 260px; }
    .interview-page .free-answer-textarea { width: 100%; min-height: 180px; box-sizing: border-box; }
    .interview-page .code-buttons { display: flex; gap: 0.75rem; flex-wrap: wrap; margin-top: 0.75rem; }
    /* style.css declares .button { display: flex } after .hidden { display: none } with the same specificity,
       so .hidden alone doesn't hide a button -- the Submit/Run buttons stayed visible after the final answer. */
    .interview-page .hidden { display: none; }
    .interview-feedback { padding: 1rem 1.25rem; border-radius: 12px; border: 1px solid var(--text-block-border-color); background: var(--code-result-background-color); color: var(--question-text); }
    .interview-feedback.correct { border-color: #16A34A; background: rgba(22, 163, 74, 0.12); }
    .interview-feedback.wrong { border-color: #DC2626; background: rgba(220, 38, 38, 0.10); }
    .interview-feedback.retry { border-color: #D97706; background: rgba(217, 119, 6, 0.12); }
    .interview-reaction { margin-top: 1rem; }
    .interview-next { margin-top: 1rem; }
    #interview-answer-feedback:empty { display: none; }
    .interview-feedback .verdict { font-weight: 700; font-size: 1.1em; margin: 0 0 0.5rem; }
    .interview-feedback p { margin: 0.35rem 0; }
    /* style.css forces links inside #code-result to blue (.code-result a { color: ... !important }),
       which turns the "next question" button's text blue on blue. */
    .interview-feedback a.button, .interview-feedback a.button:visited,
    .interview-next a.button, .interview-next a.button:visited { color: white !important; text-decoration: none; }
    /* SQL tasks: the database description sits in a right-hand panel that stays in view while the query
       is written. <main> is the page's scroll container, so the panel sticks relative to it. */
    .interview-page.with-db-panel {
        max-width: 1440px; display: grid; grid-template-columns: minmax(0, 1fr) minmax(300px, 0.55fr);
        gap: 1rem; align-items: start;
    }
    .interview-main { min-width: 0; }
    .interview-db-panel { position: sticky; top: 1rem; max-height: 80vh; overflow-y: auto; margin: 0; }
    /* style.css caps DB tables at 24vw for the 3-column test layout; the panel sets its own width. */
    .interview-db-panel .db-description .table-wrapper { max-width: none; }
    @media (max-width: 960px) {
        .interview-page.with-db-panel { grid-template-columns: minmax(0, 1fr); }
        .interview-db-panel { position: static; max-height: none; }
    }
</style>
<body>
<div class="container">
    {include file='popups.tpl'}
    <header>
        {if $MobileView}
            {include file='m.top-menu.tpl' path="/interview/{$InterviewSession.id}/question"}
        {else}
            {include file='top-menu.tpl' path="/interview/{$InterviewSession.id}/question"}
        {/if}
    </header>
    <main>
        {assign var="showDbPanel" value=$DBDescription && $InterviewQuestion.question_type == 'query'}
        <div class="interview-page{if $showDbPanel} with-db-panel{/if}">
            <div class="interview-main">
                {include file=$InterviewContentTemplate}
            </div>
            {if $showDbPanel}
                <aside class="interview-db-panel question-wrapper" id="right-panel">
                    {include file=$DBDescription}
                </aside>
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
<script>
{literal}
function submitInterviewAnswer(button) {
    // The interviewer's reaction has its own block: #code-result is overwritten by "Run query".
    const result = document.getElementById('interview-answer-feedback');
    const answersList = document.getElementById('answers-list');
    const freeAnswer = document.getElementById('free-answer-input');

    const formData = new FormData();
    formData.append('question_id', button.dataset.questionId);
    if (window.sql_editor) {
        formData.append('query', window.sql_editor.getValue());
    }
    if (answersList) {
        const answers = [...answersList.querySelectorAll('input[name=answers]:checked')]
            .map(el => parseInt(el.value, 10))
            .sort((a, b) => a - b);
        formData.append('answers', JSON.stringify(answers));
    }
    if (freeAnswer) {
        formData.append('free-answer', freeAnswer.value);
    }

    button.disabled = true;
    // The interviewer "typing" while the answer is checked -- the site's generic loader has page-sized margins.
    const typing = document.getElementById('interviewer-typing');
    result.innerHTML = typing ? typing.innerHTML : '';
    result.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    fetch(button.dataset.url, {
        method: 'POST',
        credentials: 'same-origin',
        body: formData,
    })
    .then(response => response.json())
    .then(data => {
        result.innerHTML = data.html;
        result.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        if (!data.saved || !data.final) {
            // Not saved (e.g. empty answer), or a "close" answer: the question stays open for another attempt.
            button.disabled = false;
            return;
        }
        // The answer is final: lock the inputs, the feedback fragment carries the "next" link.
        button.classList.add('hidden');
        const runButton = document.getElementById('runQueryBtn');
        if (runButton) runButton.classList.add('hidden');
        if (window.sql_editor) window.sql_editor.setReadOnly(true);
        if (freeAnswer) freeAnswer.readOnly = true;
        if (answersList) answersList.querySelectorAll('input').forEach(el => { el.disabled = true; });
    })
    .catch(() => {
        result.textContent = button.dataset.errorText;
        button.disabled = false;
    });
}
{/literal}
</script>
{include file='counters.tpl'}
</body>
</html>
