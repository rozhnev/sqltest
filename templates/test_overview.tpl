{* Test status above the task menu (test.tpl, m.test.tpl): a visual countdown, the solved tasks progress bar and
   the "I'm done!" link to the result. initTestOverview() in script.js runs the countdown from data-seconds-left
   (computed on the server, so the browser's time zone doesn't matter) and moves the bar after a correct check.
   WrapperClass: the block's own class on the page (question-wrapper / text-block). *}
<div id="test-timer" class="{$WrapperClass} test-overview"
    data-seconds-left="{$TestData.seconds_left|default:0}" data-duration="{$TestData.duration_seconds|default:1}"
    data-solved="{$TestData.solved_questions_count}" data-total="{$TestData.questions_count}"
    data-days-short="{translate}days_short{/translate}">
    {if isset($TestData.timeout) && $TestData.timeout}
        <p class="test-overview-over">{translate}test_time_out{/translate}</p>
        <a class="button green timer-action" href="/{$Lang}/test/{$TestId}/result">{translate}test_show_result{/translate}</a>
    {else}
        <div class="test-countdown" role="timer">
            <svg class="test-countdown-ring" viewBox="0 0 36 36" aria-hidden="true">
                <circle class="test-countdown-track" cx="18" cy="18" r="15.9155"></circle>
                <circle class="test-countdown-left" id="test-countdown-left" cx="18" cy="18" r="15.9155" pathLength="100" stroke-dasharray="100 100"></circle>
            </svg>
            <div class="test-countdown-copy">
                <span class="timer-title">{translate}test_time_to_complete{/translate}</span>
                <span id="test-timer-time" class="timer-value">&nbsp;</span>
            </div>
        </div>
        <div class="test-progress">
            <div class="test-progress-label">
                <span>{translate}tasks_completed{/translate}</span>
                <strong id="test-progress-count">{$TestData.solved_questions_count} / {$TestData.questions_count}</strong>
            </div>
            <div class="test-progress-bar" role="progressbar" aria-label="{translate}tasks_completed{/translate}"
                aria-valuemin="0" aria-valuemax="{$TestData.questions_count}" aria-valuenow="{$TestData.solved_questions_count}">
                <span id="test-progress-fill" style="width: {if $TestData.questions_count > 0}{($TestData.solved_questions_count * 100 / $TestData.questions_count)|string_format:"%d"}{else}0{/if}%;"></span>
            </div>
        </div>
        <a class="button green timer-action" id="doneTest" href="/{$Lang}/test/{$TestId}/result">{translate}test_done{/translate}</a>
        {* Shown by initTestOverview() when the time runs out on the page *}
        <template id="test-time-over">
            <p class="test-overview-over">{translate}test_time_over{/translate}</p>
            <a class="button green timer-action" href="/{$Lang}/test/{$TestId}/result">{translate}test_show_result{/translate}</a>
        </template>
    {/if}
</div>
