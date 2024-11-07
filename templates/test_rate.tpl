{include file='short-header.tpl'}
    <body>
        <div class="{if $MobileView}mobile-container{else}full-container{/if}">
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/"}
            {else}
                {include file='top-menu.tpl' path="/"}
            {/if}
            <div class="container3">
                <pre>
                {var_export($TestData)}
                </pre>
                <pre>
                {var_export($TestResult)}
                </pre>
                {if !$TestResult.ok && !$TestData.timeout}
                    The test did not done. 
                    <div style="text-align: center; margin: 36px;">
                        <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/{$TestData.id}" title="Начать тест" class="button green">Continue to solution</a>
                    </div>
                {/if}
            </div>
{if $MobileView}
    {include file='m.footer.tpl'}
{else}
    {include file='footer.tpl'}
{/if}