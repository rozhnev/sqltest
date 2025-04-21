{assign var="PageTitle" value="{translate}test_page_title{/translate}"}
{assign var="PageDescription" value="{translate}test_page_description{/translate}"}
{include file='short-header.tpl'}
    <body>
        {include file='popups.tpl'}
        {if $MobileView}
            <header>
                {include file='m.top-menu.tpl' path="/donate"}
            </header>
            <main>
                {include file="{$Lang}/test_start.tpl"}
            </main>
            <footer>               
                {include file='m.footer.tpl'}
            </footer>
        {else}
            <div class="container">
                <header>
                    {include file='top-menu.tpl' path="/donate"}
                </header>
                <main>
                    {include file="{$Lang}/test_start.tpl"}
                </main>
                <footer>               
                    {include file='footer.tpl'}
                </footer>
            </div>
        {/if}
        {include file='counters.tpl'}
    </body>
</html>