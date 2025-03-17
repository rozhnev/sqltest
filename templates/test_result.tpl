{include file='short-header.tpl'}
<link rel="stylesheet" type="text/css" href="/about.css?{$VERSION}" media="all">
<body>
    <div class="container">
        <header>
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/test/{$TestData.id}/result"}
            {else}
                {include file='top-menu.tpl' path="/test/{$TestData.id}/result"}
            {/if}
        </header>
        <main>
            <div class="about">
                <div class="section top colored">
                    <div>
                        <h2>{translate}test_result{/translate}</h2>
                    </div>
                </div>
                <div class="section not-colored" style="height: 100%;">
                    <div>
                        <p>
                            {if $TestResult.ok}
                                {$grades = ['Intern','Junior','Middle','Senior']}
                                {assign var="Grade" value="{$grades[$TestResult.grade-1]}"}
                                <h2>{translate}test_done_with_grade{/translate}</h2>
                                {if !$TestData.timeout}
                                    {assign var="ImproveTimeoutHours" value="{($TestData.time_to_end  - $TestData.time_to_end  % 60) / 60}"}
                                    {assign var="ImproveTimeoutMinutes" value="{$TestData.time_to_end % 60}"}
                                    {translate}test_improve{/translate}
                                {/if}
                            {else}
                                {if array_key_exists('hints', $TestResult)}
                                    {if array_key_exists('not_enought_tasks_solved', $TestResult.hints)}
                                        {assign var="MinTasksRequired" value="{$TestResult.hints.must_to_solve}"}
                                        {translate}not_solved_minimum_tasks{/translate} <br>
                                    {/if}
                                    {if array_key_exists('grade_below_the_minimum', $TestResult.hints)}
                                        {assign var="MinTasksRequired" value="{$TestResult.hints.must_to_solve}"}
                                        {translate}grade_below_the_minimum{/translate} <br>
                                    {/if}
                                {/if}
                                {if $TestData.timeout}
                                    {assign var="NextTestTry" value="{$TestData.next_test_in}"}
                                    {translate}you_can_try_again{/translate} 
                                {else}
                                {/if}
                            {/if}
                        </p>
                    </div>
                </div>
                <div class="section bottom colored">
                    <div>
                    {if $TestResult.ok}
                        {$grades = ['Intern','Junior','Middle','Senior']}
                        {assign var="Grade" value="{$grades[$TestResult.grade-1]}"}
                        {if !$TestData.timeout}
                            {assign var="ImproveTimeoutHours" value="{($TestData.time_to_end  - $TestData.time_to_end  % 60) / 60}"}
                            {assign var="ImproveTimeoutMinutes" value="{$TestData.time_to_end % 60}"}
                            <div style="text-align: center;">
                                <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/{$TestData.id}/question/" title="{translate}return_to_test{/translate}" class="button green">{translate}return_to_test{/translate}</a>
                            </div>
                            <div style="text-align: center;">
                                <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/{$TestData.id}/grade" title="{translate}save_my_grade{/translate}" class="button blue">{translate}save_my_grade{/translate}</a>
                            </div>
                        {/if}
                    {else}
                        {if $TestData.timeout}
                            {assign var="NextTestTry" value="{$TestData.next_test_in}"}
                            <div style="text-align: center;">
                                <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/question/db-theory/what-is-sql" title="{translate}continue_practice{/translate}" class="button green">{translate}continue_practice{/translate}</a>
                            </div>
                        {else}
                            <div style="text-align: center;">
                                <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/{$TestData.id}/question/" title="{translate}return_to_test{/translate}" class="button green">{translate}return_to_test{/translate}</a>
                            </div>
                        {/if}
                    {/if}
                    </div>
                </div>
            </main>
            <footer>               
                {if $MobileView}
                    {include file='m.footer.tpl'}
                {else}
                    {include file='footer.tpl'}
                {/if}
            </footer>
        </div>
        {include file='counters.tpl'}
    </body>
</html>