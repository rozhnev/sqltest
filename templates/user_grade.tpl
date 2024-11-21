{include file='short-header.tpl'}
    <body>
        <div class="{if $MobileView}mobile-container{else}full-container{/if}">
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/"}
            {else}
                {include file='top-menu.tpl' path="/"}
            {/if}
            <div class="container3">
                <div class="container800">
                    <div class="container800-section">
                    {if $TestResult.ok}
                        {$grades = ['','Intern','Junior','Middle','Senior']}
                        {assign var="Grade" value="{$grades[$TestResult.grade]}"}
                        <h2>{translate}test_done_with_grade{/translate}</h2>
                        <div style="display: flex;">
                        <img src="/images/user_grade_{$Grade}.jpeg" title="{$Grade}" style="margin: 0 auto;" alt="Your grade is {$Grade}">
                        </div>
                    {else}
                        The test did not done. You can not be graded.
                    {/if}
                    <div style="text-align: center; margin: 36px;">
                        <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/question/db-theory/what-is-sql" title="Start quiz" class="button green">{translate}continue_practice{/translate}</a>
                    </div>
                    </div>
                </div>
            </div>
{if $MobileView}
    {include file='m.footer.tpl'}
{else}
    {include file='footer.tpl'}
{/if}