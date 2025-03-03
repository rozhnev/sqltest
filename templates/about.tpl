    {assign var="PageTitle" value="{translate}about_page_title{/translate}"}
    {assign var="PageDescription" value="{translate}about_page_description{/translate}"}
    {include file='short-header.tpl'}
    <body>
        {if $MobileView}
            <header>
                {include file='m.top-menu.tpl' path="/about"}
            </header>
            <main>
                {include file="{$Lang}/about.tpl"}
            </main>
            <footer>               
                {include file='m.footer.tpl'}
            </footer>
        {else}
            <div class="container">
                <header>
                    {include file='top-menu.tpl' path="/about"}
                </header>
                <main>
                    {include file="{$Lang}/about.tpl"}
                </main>
                <footer>               
                    {include file='footer.tpl'}
                </footer>
            </div>
        {/if}
    </body>
</html>