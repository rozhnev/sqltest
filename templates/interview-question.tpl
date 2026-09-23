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
    .interview-feedback { padding: 1rem 1.25rem; border-radius: 12px; border: 1px solid var(--text-block-border-color); background: var(--code-result-background-color); color: var(--question-text); }
    .interview-feedback.correct { border-color: #16A34A; background: rgba(22, 163, 74, 0.12); }
    .interview-feedback.wrong { border-color: #DC2626; background: rgba(220, 38, 38, 0.10); }
    .interview-feedback .verdict { font-weight: 700; font-size: 1.1em; margin: 0 0 0.5rem; }
    .interview-feedback p { margin: 0.35rem 0; }
    /* style.css forces links inside #code-result to blue (.code-result a { color: ... !important }),
       which turns the "next question" button's text blue on blue. */
    .interview-feedback a.button, .interview-feedback a.button:visited { color: white !important; text-decoration: none; }
    .interview-page details { margin-top: 1rem; }
    .interview-page details summary { cursor: pointer; font-weight: 600; }
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
        <div class="interview-page">
            {include file=$InterviewContentTemplate}
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
    const result = document.getElementById('code-result');
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
    setLoader('code-result');
    fetch(button.dataset.url, {
        method: 'POST',
        credentials: 'same-origin',
        body: formData,
    })
    .then(response => response.json())
    .then(data => {
        result.innerHTML = data.html;
        if (!data.saved) {
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
