{include file='short-header.tpl'}
<style>
    /* The site's light theme sets --regular-text-color to white; text on the plain page background needs --question-text. */
    .interview-page { color: var(--question-text); }
</style>
<body>
    <div class="container">
        <header>
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/interview/payment"}
            {else}
                {include file='top-menu.tpl' path="/interview/payment"}
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
