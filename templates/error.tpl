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
            {if !isset($ErrorMessage)}
                {assign var="ErrorMessage" value="{translate}error_message{/translate}"}
            {/if}
            <h3 style="margin: 50vh auto; text-align: center;">{$ErrorMessage}</h3>
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