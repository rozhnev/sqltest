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
                <div class="container800-header">
                    <h1>{translate}test_result{/translate}</h1>
                </div>
                    <div class="container800-section">
                        <p>
                             {* <pre>
                            {var_export($TestData)}
                            </pre> *}
                            {*
                            <pre>
                            {var_export($TestResult)} 
                            </pre>*}
                            {if $TestResult.ok}
                                {$grades = ['Intern','Junior','Middle','Senior']}
                                {assign var="Grade" value="{$grades[$TestResult.grade-1]}"}
                                <h2>{translate}test_done_with_grade{/translate}</h2>
                                {if !$TestData.timeout}
                                    {assign var="ImproveTimeoutHours" value="{($TestData.time_to_end  - $TestData.time_to_end  % 60) / 60}"}
                                    {assign var="ImproveTimeoutMinutes" value="{$TestData.time_to_end % 60}"}
                                    {translate}test_improve{/translate}
                                    <div style="text-align: center; margin: 36px;">
                                        <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/{$TestData.id}" title="Начать тест" class="button green">{translate}return_to_test{/translate}</a>
                                    </div>
                                    <div style="text-align: center; margin: 36px;">
                                        <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/{$TestData.id}/grade" title="Начать тест" class="button blue">{translate}save_my_grade{/translate}</a>
                                    </div>
                                {/if}
                            {else}
                                {if array_key_exists('hints', $TestResult) && array_key_exists('not_enought_tasks_solved', $TestResult.hints)}
                                    {assign var="MinTasksRequired" value="{$TestResult.hints.must_to_solve}"}
                                    {translate}not_solved_minimum_tasks{/translate} <br>
                                {/if}
                                {if $TestData.timeout}
                                    {assign var="NextTestTry" value="{$TestData.next_test_in}"}
                                    {translate}you_can_try_again{/translate} 
                                    <div style="text-align: center; margin: 36px;">
                                        <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/question/db-theory/what-is-sql" title="Start quiz" class="button green">{translate}continue_practice{/translate}</a>
                                    </div>
                                {else}
                                    <div style="text-align: center; margin: 36px;">
                                        <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/{$TestData.id}" title="Начать тест" class="button green">{translate}return_to_test{/translate}</a>
                                    </div>
                                {/if}
                            {/if}
                        </p>
                    </div>
                </div>
            </div>
{if $MobileView}
    {include file='m.footer.tpl'}
{else}
    {include file='footer.tpl'}
{/if}