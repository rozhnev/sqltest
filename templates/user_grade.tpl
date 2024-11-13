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
                {if $TestResult.ok}
                    {$grades = ['','Intern','Junior','Middle','Senior']}
                    Your done the test with grade {$grades[$TestResult.grade]}
                {else}
                    The test did not done. You can not be graded.
                {/if}
            </div>
{if $MobileView}
    {include file='m.footer.tpl'}
{else}
    {include file='footer.tpl'}
{/if}