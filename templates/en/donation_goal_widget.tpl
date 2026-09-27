{assign var="goal" value=$DONATION_MONTHLY_GOAL|default:50}
{assign var="received" value=$DONATIONS.monthly_amount_usd|default:0}
{if $goal > 0}
    {math equation="(x / y) * 100" x=$received y=$goal assign="progressRaw"}
{else}
    {assign var="progressRaw" value=0}
{/if}
{if $progressRaw < 0}
    {assign var="progress" value=0}
{elseif $progressRaw > 100}
    {assign var="progress" value=100}
{else}
    {assign var="progress" value=$progressRaw}
{/if}

<div class="menu-ad donation-goal-widget">
    <div class="side-card">
        <div class="side-card-title">Support SQLtest.online</div>
        <div class="side-card-body">
            <p>
                This project has only one funding source: your donations.
                The monthly maintenance cost is <strong>${$goal|string_format:"%.0f"}</strong>.
            </p>
            <p>
                Last month I added a new MariaDB database with a preloaded University DB, 9 new questions, and refactored many questions and lessons.
            </p>
            <p>
                With your support, I plan to continue this work: write new lessons and tasks, and improve existing lessons.
            </p>
            <p>
                To keep the project running next month, we need to collect at least this amount by the end of this month.
                Anything above it goes to new lessons, exercises, and features.
            </p>

            <div class="donation-stats">
                <span>Received: ${$received|string_format:"%.2f"}</span>
                <span>Goal: ${$goal|string_format:"%.2f"}</span>
            </div>
            <div class="side-card-progress">
                <div class="side-card-progress-fill" style="width: {$progress|string_format:'%.2f'}%"></div>
            </div>
            <div class="donation-percent">Progress: {$progress|string_format:"%.0f"}%</div>
            <div class="donation-action">
                <a href="/{$Lang}/donate" target="_self">
                    <button class="button green side-card-button"><span>{translate}top_menu_donate{/translate}</span></button>
                </a>
            </div>
        </div>
    </div>
</div>
