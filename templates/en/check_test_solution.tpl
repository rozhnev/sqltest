{if $QueryTestResult.ok}
    <style>
        .qts-celebration {
            position: relative;
            padding: 1.25rem 1.5rem 1rem;
            border-radius: 1rem;
            background:
                radial-gradient(circle at 25% -10%, rgba(255, 255, 255, 0.85), rgba(255, 255, 255, 0) 55%),
                linear-gradient(135deg, var(--text-block-background-color, #ffffff) 0%, var(--block-background-color, #466cbd) 70%);
            border: 1px solid var(--border-color, #0B4FCC);
            color: var(--question-text, #33196f);
            box-shadow: 0 15px 38px rgba(29, 7, 74, 0.18);
            overflow: hidden;
            margin-bottom: 1rem;
        }

        .qts-message {
            font-size: 1.35rem;
            font-weight: 700;
            color: inherit;
            letter-spacing: 0.05em;
            text-transform: uppercase;
        }

        .qts-message-glimmer {
            display: inline-flex;
            margin-left: 0.5rem;
            animation: qts-glimmer 2.8s ease-in-out infinite;
            color: var(--achievement-linkedin-fg, #f7b733);
        }

        .qts-confetti {
            position: absolute;
            inset: 0;
            pointer-events: none;
        }

        .qts-confetti-piece {
            position: absolute;
            top: -20px;
            width: 8px;
            height: 18px;
            border-radius: 3px;
            background: var(--color, var(--achievement-icon-fg, #ffd166));
            animation: qts-confetti-drop var(--duration, 2.4s) linear infinite;
            animation-delay: var(--delay, 0s);
            left: var(--x-start, 10%);
            filter: drop-shadow(0 2px 2px rgba(0, 0, 0, 0.25));
        }

        .qts-confetti-piece::after {
            content: '';
            position: absolute;
            inset: 0;
            border-radius: inherit;
            background: inherit;
            opacity: 0.45;
            transform: translateY(6px) scaleY(0.4);
        }

        @keyframes qts-confetti-drop {
            0% {
                transform: translate3d(0, 0, 0) rotate(0deg);
                opacity: 1;
            }
            100% {
                transform: translate3d(var(--x-end, 60px), 280px, 0) rotate(360deg);
                opacity: 0;
            }
        }

        @keyframes qts-glimmer {
            0% {
                opacity: 0.4;
                transform: scale(0.9);
            }
            50% {
                opacity: 1;
                transform: scale(1.1);
            }
            100% {
                opacity: 0.4;
                transform: scale(0.9);
            }
        }

        @keyframes qts-bounce {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.08);
            }
            100% {
                transform: scale(1);
            }
        }

        .qts-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            margin-top: 0.5rem;
            padding: 0.25rem 0.75rem;
            border-radius: 999px;
            border: 1px solid var(--border-color, #0B4FCC);
            background: var(--text-block-background-color, rgba(255, 255, 255, 0.85));
            color: var(--question-text, #4b2d9f);
            font-size: 0.85rem;
            font-weight: 600;
            animation: qts-bounce 1.6s ease-in-out infinite;
        }
    </style>

    <div class="qts-celebration">
        <div class="qts-message">
            Great! You have completed the task!
            <span class="qts-message-glimmer">✨</span>
        </div>
        <div class="qts-badge">Mission: accomplished</div>
        <div class="qts-confetti" aria-hidden="true">
            <span class="qts-confetti-piece" style="--x-start:5%; --x-end:40px; --delay:0s; --duration:2s; --color:var(--achievement-icon-fg, #ff6262)"></span>
            <span class="qts-confetti-piece" style="--x-start:18%; --x-end:-20px; --delay:0.25s; --duration:2.2s; --color:var(--achievement-linkedin-fg, #f7b733)"></span>
            <span class="qts-confetti-piece" style="--x-start:32%; --x-end:60px; --delay:0.45s; --duration:2s; --color:var(--green-btn-background, #2ecc71)"></span>
            <span class="qts-confetti-piece" style="--x-start:47%; --x-end:-50px; --delay:0.15s; --duration:2.3s; --color:var(--blue-btn-background, #3498db)"></span>
            <span class="qts-confetti-piece" style="--x-start:60%; --x-end:30px; --delay:0.35s; --duration:1.9s; --color:var(--accordion-active, #9b59b6)"></span>
            <span class="qts-confetti-piece" style="--x-start:72%; --x-end:-15px; --delay:0.55s; --duration:2.1s; --color:var(--donate-btn-background, #ffb74d)"></span>
            <span class="qts-confetti-piece" style="--x-start:85%; --x-end:-35px; --delay:0.65s; --duration:2.4s; --color:var(--accordion-hover, #1abc9c)"></span>
        </div>
    </div>
    <div style="display: flex; flex-flow: row; flex-wrap: wrap; line-height: 1.5em;">
        {if $QueryTestResult.cost > 0}
            <div style="flex: 2 1;">
            The cost of executing your query is {$QueryTestResult.cost} <span style="font-size: small;">(the lower the cost, the more effective the query)</span>
            {if $QueryBestCost}
                <br>Cost of the best solution: {$QueryBestCost}<br>
                {if $QueryBestCost == $QueryTestResult.cost} Congratulations! Your request is among the best on our website!
                {elseif $QueryBestCost > $QueryTestResult.cost} Congratulations on improving our record!
                {else} Unfortunately, your result is a little low of the record. You have something to work on! {/if}
            {/if}
            </div>
        {/if}
    </div>
{elseif array_key_exists('hints', $QueryTestResult) && array_key_exists('maxAttemptsReached', $QueryTestResult.hints)}
    {assign var="NextQuestion" value="{$QueryTestResult.nextQuestion}"}
    {translate}maximum_attempts_reached{/translate}{if $QueryTestResult.nextQuestion} {translate}go_to_next_task{/translate}{/if}
{elseif array_key_exists('hints', $QueryTestResult) && array_key_exists('timeOut', $QueryTestResult.hints)}
    {translate}test_time_out{/translate} {translate}go_to_rate{/translate}
{else}
    <style>
        .qts-error-card {
            border: 1px solid var(--sql-color, #5a9bd8);
            border-radius: 0.85rem;
            padding: 1.1rem 1.25rem;
            background:
                radial-gradient(circle at 20% -5%, rgba(235, 248, 255, 0.9), rgba(235, 248, 255, 0) 45%),
                linear-gradient(180deg, rgba(207, 229, 255, 0.55), rgba(92, 133, 196, 0.25));
            box-shadow: 0 12px 28px rgba(18, 54, 99, 0.22);
            animation: qts-breathe 3s ease-in-out infinite;
            color: var(--regular-text-color, #f0f6fc);
            margin-bottom: 1rem;
        }

        .qts-error-header {
            display: flex;
            align-items: baseline;
            justify-content: space-between;
            gap: 0.5rem;
        }

        .qts-error-message {
            font-size: 1.2rem;
            font-weight: 700;
            letter-spacing: 0.03em;
            color: var(--sql-color, #f85149);
        }

        .qts-error-emoji {
            font-size: 1.35rem;
            animation: qts-floating 2.2s ease-in-out infinite;
        }

        .qts-error-hints {
            margin-top: 0.85rem;
            color: var(--question-text, #f0f6fc);
        }

        .qts-error-hints p {
            margin: 0.35rem 0;
        }

        .qts-error-cta {
            margin-top: 0.8rem;
            font-weight: 600;
            letter-spacing: 0.08em;
            color: var(--question-text, #0B4FCC);
        }

        @keyframes qts-breathe {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.01);
            }
            100% {
                transform: scale(1);
            }
        }

        @keyframes qts-floating {
            0% {
                transform: translateY(2px);
            }
            50% {
                transform: translateY(-4px);
            }
            100% {
                transform: translateY(2px);
            }
        }

        .qts-error-referral {
            margin-top: 0.8rem;
        }

        .qts-error-referral .referral-link {
            border-radius: 999px;
            padding: 0.75rem 1rem;
            border: 1px dashed rgba(255, 255, 255, 0.4);
            background: rgba(255, 255, 255, 0.05);
            font-size: 0.9rem;
            text-align: center;
        }
    </style>

    <div class="qts-error-card" role="status" aria-live="assertive">
        <div class="qts-error-header">
            <div class="qts-error-message">
                Almost there!
                <span class="qts-error-emoji" role="img" aria-label="smiley">🤏</span>
            </div>
            <div class="qts-error-cta">Just tweak it and run again.</div>
        </div>
        {if array_key_exists('hints', $QueryTestResult) }
            <div class="qts-error-hints">
                {if array_key_exists('queryError', $QueryTestResult.hints) }
                    <p>Hint: the query returns the error: <span class="sql_error">{$QueryTestResult.hints.queryError}</span></p>
                {/if}
                {if array_key_exists('columnsCount', $QueryTestResult.hints) }
                    <p>Hint: the result table must consist of {$QueryTestResult.hints.columnsCount} columns.</p>
                {/if}
                {if array_key_exists('columnsList', $QueryTestResult.hints) }
                    <p>Hint: the resulting table should consist of the following columns: {$QueryTestResult.hints.columnsList}.</p>
                {/if}
                {if array_key_exists('rowsCount', $QueryTestResult.hints) }
                    <p>Hint: the result must contain {$QueryTestResult.hints.rowsCount} rows.</p>
                {/if}
                {if array_key_exists('rowsData', $QueryTestResult.hints) }
                    <p>Hint: the row number {$QueryTestResult.hints.rowsData.rowNumber} of the results table should contain the following values: 
                        {$QueryTestResult.hints.rowsData.rowTable}
                    </p>
                    <p>your result:
                        {$QueryTestResult.hints.rowsData.resultTable}
                    </p>
                {/if}
                {if array_key_exists('emptyQuery', $QueryTestResult.hints) }
                    <p>Hint: your query is empty.</p>
                {/if}
            </div>
        {/if}
        {if isset($ReferralLink)}
            <div class="qts-error-referral">
                <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
                    <div class="referral-link">
                        {$ReferralLink.content}
                    </div>
                </a>
            </div>
        {/if}
    </div>
{/if}