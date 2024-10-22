{include file='short-header.tpl'}
    <body>
        <div class="{if $MobileView}mobile-container{else}full-container{/if}">
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/"}
            {else}
                {include file='top-menu.tpl' path="/"}
            {/if}
            <div class="container3">
                <h3 style="margin: 50vh auto; text-align: center;">{translate}error_message{/translate}</h3>
            </div>
{if $MobileView}
    {include file='m.footer.tpl'}
{else}
    {include file='footer.tpl'}
{/if}