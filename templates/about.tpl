{include file='short-header.tpl'}
    <body>
        <div class="{if $MobileView}mobile-container{else}full-container{/if}">
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/about"}
            {else}
                {include file='top-menu.tpl' path="/about"}
            {/if}
            <div class="container3">
                {include file="{$Lang}/about.tpl"}
            </div>
{if $MobileView}
    {include file='m.footer.tpl'}
{else}
    {include file='footer.tpl'}
{/if}