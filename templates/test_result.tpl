{* Result of a regular test (Controller::test_result(), Test::calculateResult()): status, solved tasks against the
   minimum, the tasks by difficulty, the grade ladder and the next action. Styles: css/test.css (.test-result). *}
{include file='short-header.tpl'}
<link rel="stylesheet" href="/css/test.min.css?{$VERSION}" media="all">
<body>
    {$grades = ['Intern', 'Junior', 'Middle', 'Senior']}
    {$grade = $TestResult.grade|default:0}
    {$solved = $TestResult.solved_questions|default:$TestData.solved_questions_count}
    {$total = $TestResult.total_questions|default:$TestData.questions_count}
    {$mustSolve = $TestResult.hints.must_to_solve|default:0}
    {$notEnough = isset($TestResult.hints.not_enought_tasks_solved)}
    {$belowMinimum = isset($TestResult.hints.grade_below_the_minimum)}
    {$canImprove = !$TestData.timeout && $total > $solved}
    {assign var="MinTasksRequired" value=$mustSolve}
    {assign var="TasksLeft" value=$mustSolve - $solved}{if $TasksLeft < 0}{assign var="TasksLeft" value=0}{/if}
    {assign var="NextTestTry" value=$TestData.next_test_in}
    {assign var="ImproveTimeoutHours" value=(($TestData.time_to_end - $TestData.time_to_end % 60) / 60)}
    {assign var="ImproveTimeoutMinutes" value=($TestData.time_to_end % 60)}
    {if $TestResult.ok}{assign var="Grade" value=$grades[$grade - 1]}{/if}
    {capture name=test_result}
        <div class="test-result">
            <div class="test-result-card">
                <p class="test-result-eyebrow">{translate}test_result{/translate}</p>

                <div class="test-result-icon{if $TestResult.ok} is-ok{elseif $TestData.timeout} is-over{/if}" aria-hidden="true">
                    {if $TestResult.ok}🏅{elseif $TestData.timeout}⌛{else}⏳{/if}
                </div>
                <h1 class="test-result-title">
                    {if $TestResult.ok}
                        {translate}test_done_with_grade{/translate}
                    {elseif $notEnough && !$TestData.timeout}
                        {translate}test_result_need_more{/translate}
                    {elseif $notEnough}
                        {translate}not_solved_minimum_tasks{/translate}
                    {elseif $belowMinimum}
                        {translate}grade_below_the_minimum{/translate}
                    {/if}
                </h1>
                {if !$TestResult.ok && $belowMinimum && !$notEnough}
                    <p class="test-result-subtitle">{translate}test_result_easy_required{/translate}</p>
                {/if}

                {* Solved tasks against the minimum needed for a grade *}
                <div class="test-progress test-result-progress">
                    <div class="test-progress-label">
                        <span>{translate}tasks_completed{/translate}</span>
                        <strong>{$solved} / {$total}</strong>
                    </div>
                    <div class="test-progress-bar" role="progressbar" aria-label="{translate}tasks_completed{/translate}"
                        aria-valuemin="0" aria-valuemax="{$total}" aria-valuenow="{$solved}">
                        <span style="width: {if $total > 0}{($solved * 100 / $total)|string_format:"%d"}{else}0{/if}%;"></span>
                    </div>
                    {if $mustSolve > 0 && $total > 0}
                        <div class="test-result-minimum{if $solved >= $mustSolve} is-reached{/if}" style="left: {($mustSolve * 100 / $total)|string_format:"%d"}%;">
                            <span>{translate}test_result_minimum{/translate}</span>
                        </div>
                    {/if}
                </div>

                {* Tasks by difficulty: the question-level colors of the task menu *}
                {$levels = [
                    ['rate' => 1, 'total' => $TestResult.easy_questions|default:0, 'solved' => $TestResult.solved_easy_questions|default:0],
                    ['rate' => 2, 'total' => $TestResult.simple_questions|default:0, 'solved' => $TestResult.solved_simple_questions|default:0],
                    ['rate' => 3, 'total' => $TestResult.normal_questions|default:0, 'solved' => $TestResult.solved_normal_questions|default:0],
                    ['rate' => 4, 'total' => $TestResult.difficult_questions|default:0, 'solved' => $TestResult.solved_difficult_questions|default:0],
                    ['rate' => 5, 'total' => $TestResult.hard_questions|default:0, 'solved' => $TestResult.solved_hard_questions|default:0]
                ]}
                <div class="test-result-levels">
                    <p class="test-result-section">{translate}test_result_by_difficulty{/translate}</p>
                    <ul>
                        {foreach $levels as $level}
                            {if $level.total > 0}
                                <li>
                                    <span class="question-level rate{$level.rate}" aria-hidden="true"></span>
                                    <span class="test-result-level-bar"><span style="width: {($level.solved * 100 / $level.total)|string_format:"%d"}%;"></span></span>
                                    <span class="test-result-level-count">{$level.solved} / {$level.total}</span>
                                </li>
                            {/if}
                        {/foreach}
                    </ul>
                </div>

                {* Grade ladder: the earned grade is highlighted *}
                <ol class="test-result-grades">
                    {foreach $grades as $i => $name}
                        <li class="{if $TestResult.ok && $i < $grade}is-reached{/if}{if $TestResult.ok && $i == $grade - 1} is-current{/if}">{$name}</li>
                    {/foreach}
                </ol>

                {if $canImprove}
                    <p class="test-result-note">{translate}test_improve{/translate}</p>
                {elseif $TestData.timeout && !$TestResult.ok}
                    <p class="test-result-note">{translate}you_can_try_again{/translate}</p>
                {/if}

                <div class="test-result-actions">
                    {if !$TestData.timeout}
                        <a class="button green test-result-primary" href="/{$Lang}/test/{$TestData.id}/question/">{translate}return_to_test{/translate}</a>
                    {elseif !$TestResult.ok}
                        <a class="button green test-result-primary" href="/{$Lang}/question/db-theory/what-is-sql">{translate}continue_practice{/translate}</a>
                    {/if}
                    {if $TestResult.ok}
                        <a class="button blue{if $TestData.timeout} test-result-primary{/if}" href="/{$Lang}/test/{$TestData.id}/grade">{translate}save_my_grade{/translate}</a>
                    {/if}
                </div>
            </div>
        </div>
    {/capture}
    <div class="container">
        <header>
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/test/{$TestData.id}/result"}
            {else}
                {include file='top-menu.tpl' path="/test/{$TestData.id}/result"}
            {/if}
        </header>
        <main>{$smarty.capture.test_result}</main>
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
