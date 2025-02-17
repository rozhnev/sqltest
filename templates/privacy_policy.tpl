    {assign var="PageTitle" value="{translate}privacy_policy_page_title{/translate}"}
    {assign var="PageDescription" value="{translate}privacy_policy_page_description{/translate}"}
    {include file='short-header.tpl'}
    <body>
        <div class="container">
            <header>
                {if $MobileView}
                    {include file='m.top-menu.tpl' path="/privacy-policy"}
                {else}
                    {include file='top-menu.tpl' path="/privacy-policy"}
                {/if}
            </header>
            <main>
                {include file="{$Lang}/privacy_policy.tpl"}
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