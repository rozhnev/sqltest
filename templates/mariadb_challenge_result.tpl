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
                    <div style="display: flex; justify-content: center; flex-direction: column; align-items: center;">
                        <p>
                            {if $TestResult.ok}
                                {$prizes = ['🏷️', '👕', '📜']}
                                {assign var="Prize" value="{$prizes[$TestResult.grade-1]}"}
                                {if AlreadyClaimed === true}
                                    <h2>{translate}mariadb_prize_already_claimed{/translate}</h2>
                                {else}
                                    <h2>{translate}mariadb_prize_prize_draw{/translate}</h2>
                                {/if}
                                {if AlreadyClaimed !== true && !$TestData.timeout && $TestData.questions_count > $TestData.solved_questions_count}
                                    {assign var="ImproveTimeoutHours" value="{($TestData.time_to_end - $TestData.time_to_end  % 60) / 60}"}
                                    {assign var="ImproveTimeoutMinutes" value="{$TestData.time_to_end % 60}"}
                                    {translate}test_improve{/translate}
                                {/if}
                            {else}
                                {if AlreadyClaimed !== true && array_key_exists('hints', $TestResult)}
                                    {if array_key_exists('not_enought_tasks_solved', $TestResult.hints)}
                                        {assign var="MinTasksRequired" value="{$TestResult.hints.must_to_solve}"}
                                        {translate}not_solved_minimum_tasks{/translate} <br>
                                    {/if}
                                {/if}
                                {if $TestData.timeout}
                                    {assign var="NextTestTry" value="{$TestData.next_test_in}"}
                                    {translate}you_can_try_again{/translate} 
                                {else}
                                {/if}
                            {/if}
                        </p>
                        <p>
                            {if AlreadyClaimed !== true}
                                {if $TestResult.ok}
                                    {if !$TestData.timeout}
                                        {assign var="ImproveTimeoutHours" value="{($TestData.time_to_end  - $TestData.time_to_end  % 60) / 60}"}
                                        {assign var="ImproveTimeoutMinutes" value="{$TestData.time_to_end % 60}"}
                                        <div style="text-align: center;">
                                            <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/{$TestData.id}/question/" title="{translate}return_to_test{/translate}" class="button green">{translate}return_to_test{/translate}</a>
                                        </div>
                                    {/if}
                                    <div style="text-align: center;">
                                        <form method="post" action="/{$Lang}/test/{$TestData.id}/claim">
                                            {if !$UserSubscribed}
                                                <label style="display:flex; align-items:flex-start; gap:0.75rem; margin: 1rem 0;">
                                                    <input type="checkbox" name="newsletter_opt_in" value="mariadb_newsletter">
                                                    <span>{translate}mariadb_newsletter_checkbox_label{/translate}</span>
                                                </label>
                                            {/if}
                                            <div style="text-align: center; margin-top: 1.5rem;">
                                                <button type="submit" class="button green" style="display:inline-block; width:240px;">{translate}claim_my_prize{/translate}</button>
                                            </div>
                                        </form>
                                        {* <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/{$TestData.id}/claim" title="{translate}claim_my_prize{/translate}" class="button blue">{translate}claim_my_prize{/translate}</a> *}
                                    </div>
                                {else}
                                    {if $TestData.timeout}
                                        {assign var="NextTestTry" value="{$TestData.next_test_in}"}
                                        <div style="text-align: center;">
                                            <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/question/db-theory/what-is-sql" title="{translate}continue_practice{/translate}" class="button green">{translate}continue_practice{/translate}</a>
                                        </div>
                                    {else}
                                        <div style="margin-top: 1rem; color: var(--regular-text-color);">{translate}mariadb_prize_claim_requires_three{/translate}</div>
                                        <div style="text-align: center;">
                                            <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/{$TestData.id}/question/" title="{translate}return_to_test{/translate}" class="button green">{translate}return_to_test{/translate}</a>
                                        </div>
                                    {/if}
                                {/if}
                            {/if}
                        </p>
                    </div>
                </div>
                <div class="section bottom colored">
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
    </body>
</html>