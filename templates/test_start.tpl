{assign var="PageTitle" value="{translate}privacy_policy_page_title{/translate}"}
{assign var="PageDescription" value="{translate}privacy_policy_page_description{/translate}"}
{include file='short-header.tpl'}
    <body>
        <div class="{if $MobileView}mobile-container{else}full-container{/if}">
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/privacy-policy"}
            {else}
                {include file='top-menu.tpl' path="/privacy-policy"}
            {/if}
            <div class="container3">
            {include file="{$Lang}/test_start.tpl"}
            </div>
{if $MobileView}
    {include file='m.footer.tpl'}
{else}
    {include file='footer.tpl'}
{/if}