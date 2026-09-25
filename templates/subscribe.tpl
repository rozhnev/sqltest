{include file='short-header.tpl'}
<style>
    /* The site's light theme sets --regular-text-color to white; text on the plain page background needs --question-text. */
    .subscribe-page { color: var(--question-text); max-width: 640px; margin: 10vh auto; padding: 0 16px; }
    .subscribe-page h2 { text-align: center; }
    .subscribe-page ul { line-height: 1.7; }
    .subscribe-status { margin: 1.5rem 0; padding: 1rem; border: 1px solid var(--border-color, #888); border-radius: 6px; }
    .subscribe-meter { height: 8px; margin-top: 0.5rem; border-radius: 4px; background: rgba(128, 128, 128, 0.3); overflow: hidden; }
    .subscribe-meter > div { height: 100%; background: #2EA043; }
    .subscribe-actions { text-align: center; margin-top: 1.5rem; }
    .subscribe-note { font-size: 0.9em; }
</style>
<body>
    <div class="container">
        <header>
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/subscribe"}
            {else}
                {include file='top-menu.tpl' path="/subscribe"}
            {/if}
        </header>
        <main>
            <div class="subscribe-page">
                {include file=$SubscribeContentTemplate}
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
