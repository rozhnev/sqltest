    {assign var="PageTitle" value="{translate}privacy_policy_page_title{/translate}"}
    {assign var="PageDescription" value="{translate}privacy_policy_page_description{/translate}"}
    {include file='short-header.tpl'}
    <body>
        {if $MobileView}
            <header>
                {include file='m.top-menu.tpl' path="/privacy-policy"}
            </header>
            <main>
                {include file="{$Lang}/privacy_policy.tpl"}
            </main>
            <footer>               
                {include file='m.footer.tpl'}
            </footer>
        {else}
            <div class="container">
                <header>
                    {include file='top-menu.tpl' path="/privacy-policy"}
                </header>
                <main>
                    {include file="{$Lang}/privacy_policy.tpl"}
                </main>
                <footer>               
                    {include file='footer.tpl'}
                </footer>
            </div>
        {/if}
    </body>
</html>