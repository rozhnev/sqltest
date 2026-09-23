{include file='short-header.tpl'}
{include file='interview-dialog-styles.tpl'}
<style>
    /* Theme variables, not fixed colors: the site's light theme sets --regular-text-color to white. */
    .interview-page { max-width: 880px; margin: 2rem auto; padding: 0 1rem; box-sizing: border-box; width: 100%; color: var(--question-text); }
    .interview-page section { margin-bottom: 2rem; }
    .interview-score { text-align: center; padding: 1.5rem; border-radius: 16px; border: 1px solid var(--text-block-border-color); background: var(--accordion-panel-bg-color); }
    .interview-score .value { font-size: 3rem; font-weight: 800; color: var(--accordion-active); line-height: 1.1; }
    .interview-score .meta { color: var(--question-date-color); margin-top: 0.5rem; }
    .interview-topic { margin: 0.75rem 0; }
    .interview-topic-head { display: flex; justify-content: space-between; gap: 1rem; }
    .interview-topic-bar { height: 8px; border-radius: 4px; background: var(--text-block-border-color); overflow: hidden; margin-top: 0.3rem; }
    .interview-topic-bar span { display: block; height: 100%; background: #16A34A; }
    .interview-topic.weak .interview-topic-bar span { background: #DC2626; }
    .interview-topic ul { margin: 0.4rem 0 0; padding-left: 1.2rem; font-size: 0.95em; }
    .interview-transcript-item { border: 1px solid var(--text-block-border-color); border-radius: 12px; padding: 1rem 1.25rem; margin-bottom: 1rem; }
    .interview-transcript-item h4 { margin: 0 0 0.5rem; display: flex; justify-content: space-between; gap: 1rem; }
    .interview-transcript-item .verdict-ok { color: #16A34A; white-space: nowrap; }
    .interview-transcript-item .verdict-bad { color: #DC2626; white-space: nowrap; }
    .interview-transcript-item pre { white-space: pre-wrap; background: var(--sql-background-color); color: var(--question-text); padding: 0.75rem; border-radius: 8px; overflow-x: auto; }
    .interview-transcript-item .option-valid { font-weight: 600; }
    .interview-transcript-item .feedback { font-style: italic; }
    .interview-report .dialog-bubble h4 { margin: 0.9rem 0 0.35rem; color: var(--accordion-active); }
    .interview-report .dialog-bubble ul { margin: 0; padding-left: 1.2rem; }
    .interview-report .dialog-bubble li { margin-bottom: 0.3rem; }
    .interview-muted { color: var(--question-date-color); font-weight: normal; }
</style>
<body>
    <div class="container">
        <header>
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/interview/{$InterviewResult.session.id}/result"}
            {else}
                {include file='top-menu.tpl' path="/interview/{$InterviewResult.session.id}/result"}
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
</body>
</html>
