    {assign var="PageTitle" value="{translate}about_page_title{/translate}"}
    {assign var="PageDescription" value="{translate}about_page_description{/translate}"}
    {include file='short-header.tpl'}
    <body>
        <div class="container">

            <header>
                {if $MobileView}
                    {include file='m.top-menu.tpl' path="/about"}
                {else}
                    {include file='top-menu.tpl' path="/about"}
                {/if}
            </header>
            <main>
                {include file="{$Lang}/about.tpl"}
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