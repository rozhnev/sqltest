{include file='short-header.tpl'}
{include file='interview-dialog-styles.tpl'}
<style>
    /* Look (background, border, text color) comes from the global .lesson-wrapper; this only sizes the box.
       Use theme variables, not fixed colors: the site's light theme sets --regular-text-color to white. */
    .interview-session-box { max-width: 760px; width: 100%; box-sizing: border-box; margin: 6vh auto; padding: 1.5rem; }
    .interview-session-box h2 { margin: 0 0 1.25rem; text-align: center; }
    /* .lesson-wrapper a (text-link look) outranks .button -- keep buttons looking like buttons. */
    .interview-session-box a.button, .interview-session-box a.button:visited { color: white; text-decoration: none; }
    .interview-session-box .error-text { color: var(--danger-text-color); margin: 0.5rem 0 0; }
    .interview-muted { color: var(--question-date-color); }

    .dialog-next { text-align: center; margin-top: 1.75rem; }

    @media (max-width: 640px) {
        .interview-session-box { padding: 1rem; margin: 2vh auto; }
    }
</style>
<body>
    <div class="container">
        <header>
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/interview/{$InterviewSession.id}"}
            {else}
                {include file='top-menu.tpl' path="/interview/{$InterviewSession.id}"}
            {/if}
        </header>
        <main>
            {include file=$InterviewContentTemplate}
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
