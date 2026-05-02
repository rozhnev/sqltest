    {assign var="PageTitle" value="{translate}embed_page_title{/translate}"}
    {assign var="PageDescription" value="{translate}embed_page_description{/translate}"}
    {include file='short-header.tpl'}
    <body>
        {if $MobileView}
            <header>
                {include file='m.top-menu.tpl' path="/embed"}
            </header>
            <main>
                {include file="{$Lang}/embed.tpl"}
            </main>
            <footer>               
                {include file='m.footer.tpl'}
            </footer>
        {else}
            <div class="container">
                <header>
                    {include file='top-menu.tpl' path="/embed"}
                </header>
                <main>
                    {include file="{$Lang}/embed.tpl"}
                </main>
                <footer>
                    <script src="/js/sql-embed.js?v={$VERSION}"></script>          
                    {include file='footer.tpl'}
                </footer>
            </div>
        {/if}
    </body>
</html>