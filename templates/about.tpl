{include file='short-header.tpl'}
    <body>
        <div class="{if $MobileView}mobile-container{else}full-container{/if}">
            <div class="header">
                <div class="top-menu">
                    {if $MobileView}
                        {include file='m.site-name.tpl'}
                    {else}
                        {include file='site-name.tpl'}
                    {/if}
                    <div style="display: flex; justify-content: center; min-width: 100px;">
                        {include file='theme-switcher.tpl'}
                        {include file='lang-switcher.tpl' path="about"}
                    </div>
                </div>
            </div>
            <div class="container3">
                {include file="{$Lang}/about.tpl"}
            </div>
{if $MobileView}
    {include file='m.footer.tpl'}
{else}
    {include file='footer.tpl'}
{/if}