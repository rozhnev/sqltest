{include file='short-header.tpl'}
<link rel="stylesheet" type="text/css" href="/about.css?{$VERSION}" media="all">
<style>
    .mdb-result {
        --mdb-surface: #ffffff;
        --mdb-text: #0f1b2d;
        --mdb-text-muted: rgba(15, 27, 45, 0.7);
        --mdb-border: rgba(10, 118, 166, 0.25);
        --mdb-tile: rgba(15, 27, 45, 0.05);
        --mdb-accent: #0a76a6;
        --mdb-accent-text: #ffffff;
        --mdb-success: #12936c;
        --mdb-success-soft: rgba(18, 147, 108, 0.1);
        --mdb-warning: #c98a00;
        --mdb-glow-1: rgba(21, 208, 255, 0.16);
        --mdb-glow-2: rgba(100, 243, 189, 0.16);
        --mdb-icon-bg: linear-gradient(135deg, rgba(21, 208, 255, 0.18), rgba(100, 243, 189, 0.22));
        --mdb-icon-glow: rgba(18, 147, 108, 0.2);
        --mdb-shadow: rgba(15, 27, 45, 0.12);
        --mdb-btn-glow: rgba(10, 118, 166, 0.3);
        display: flex;
        justify-content: center;
        padding: 2rem 16px 3rem;
    }
    [data-theme="dark"] .mdb-result {
        --mdb-surface: #030a18;
        --mdb-text: #f5fbff;
        --mdb-text-muted: rgba(245, 251, 255, 0.75);
        --mdb-border: rgba(255, 255, 255, 0.18);
        --mdb-tile: rgba(255, 255, 255, 0.06);
        --mdb-accent: #15d0ff;
        --mdb-accent-text: #04101e;
        --mdb-success: #64f3bd;
        --mdb-success-soft: rgba(100, 243, 189, 0.12);
        --mdb-warning: #ffc861;
        --mdb-glow-1: rgba(21, 208, 255, 0.28);
        --mdb-glow-2: rgba(100, 243, 189, 0.2);
        --mdb-icon-bg: linear-gradient(135deg, rgba(21, 208, 255, 0.3), rgba(100, 243, 189, 0.3));
        --mdb-icon-glow: rgba(100, 243, 189, 0.35);
        --mdb-shadow: rgba(0, 0, 0, 0.35);
        --mdb-btn-glow: rgba(21, 208, 255, 0.35);
    }
    .mdb-result-card {
        width: min(640px, 100%);
        box-sizing: border-box;
        padding: 2.5rem 2rem 2rem;
        border-radius: 20px;
        border: 1px solid var(--mdb-border);
        color: var(--mdb-text);
        background:
            radial-gradient(circle at 20% 0%, var(--mdb-glow-1), transparent 50%),
            radial-gradient(circle at 90% 10%, var(--mdb-glow-2), transparent 45%),
            var(--mdb-surface);
        box-shadow: 0 16px 40px var(--mdb-shadow);
        text-align: center;
        line-height: 1.5;
    }
    .mdb-eyebrow {
        margin: 0 0 1.25rem;
        text-transform: uppercase;
        letter-spacing: 0.3rem;
        font-size: 0.8rem;
        color: var(--mdb-text-muted);
    }
    .mdb-prize-icon {
        width: 112px;
        height: 112px;
        margin: 0 auto 1.25rem;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 3.5rem;
        border-radius: 50%;
        background: var(--mdb-icon-bg);
        border: 2px solid var(--mdb-success);
        box-shadow: 0 0 32px var(--mdb-icon-glow);
    }
    .mdb-prize-icon.is-pending {
        background: var(--mdb-tile);
        border-color: var(--mdb-warning);
        box-shadow: none;
    }
    .mdb-result-title {
        margin: 0 0 1.5rem;
        font-size: 1.4rem;
        line-height: 1.4;
        color: var(--mdb-text);
    }
    .mdb-progress {
        margin: 0 0 1.75rem;
        text-align: left;
    }
    .mdb-progress-label {
        display: flex;
        justify-content: space-between;
        margin-bottom: 0.4rem;
        font-size: 0.9rem;
        color: var(--mdb-text-muted);
    }
    .mdb-progress-label strong {
        color: var(--mdb-text);
    }
    .mdb-progress-bar {
        height: 8px;
        border-radius: 999px;
        background: var(--mdb-tile);
        overflow: hidden;
    }
    .mdb-progress-bar span {
        display: block;
        height: 100%;
        border-radius: inherit;
        background: linear-gradient(90deg, var(--mdb-accent), var(--mdb-success));
    }
    .mdb-tiers {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 0.75rem;
        margin: 0 0 1.75rem;
        padding: 0;
        list-style: none;
    }
    .mdb-tier {
        padding: 0.9rem 0.6rem;
        border-radius: 14px;
        background: var(--mdb-tile);
        border: 1px solid transparent;
        color: var(--mdb-text-muted);
        font-size: 0.85rem;
        line-height: 1.3;
        opacity: 0.55;
    }
    .mdb-tier-icon {
        display: block;
        font-size: 1.6rem;
        margin-bottom: 0.4rem;
    }
    .mdb-tier.is-reached {
        opacity: 1;
        color: var(--mdb-text);
    }
    .mdb-tier.is-current {
        border-color: var(--mdb-success);
        background: var(--mdb-success-soft);
    }
    .mdb-note {
        margin: 0 0 1rem;
        padding: 0.75rem 1rem;
        border-radius: 12px;
        background: var(--mdb-tile);
        color: var(--mdb-text-muted);
        font-size: 0.95rem;
    }
    .mdb-optin {
        display: flex;
        align-items: flex-start;
        gap: 0.75rem;
        margin: 1.25rem 0 0;
        text-align: left;
        font-size: 0.85rem;
        color: var(--mdb-text-muted);
        cursor: pointer;
    }
    .mdb-optin input {
        margin-top: 0.2rem;
        flex-shrink: 0;
        accent-color: var(--mdb-success);
    }
    .mdb-actions {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 0.75rem;
        margin-top: 1.5rem;
    }
    .mdb-btn {
        display: inline-block;
        min-width: 200px;
        padding: 0.85rem 1.6rem;
        border-radius: 999px;
        border: 1px solid var(--mdb-accent);
        font: inherit;
        font-weight: 600;
        text-decoration: none;
        cursor: pointer;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .mdb-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 12px 25px var(--mdb-btn-glow);
    }
    .mdb-btn-primary {
        background: var(--mdb-accent);
        color: var(--mdb-accent-text);
    }
    .mdb-btn-secondary {
        background: transparent;
        color: var(--mdb-accent);
    }
    .mdb-claim-form .mdb-actions {
        margin-top: 1rem;
    }
    @media (max-width: 520px) {
        .mdb-result-card {
            padding: 2rem 1.25rem 1.5rem;
        }
        .mdb-result-title {
            font-size: 1.2rem;
        }
        .mdb-tiers {
            gap: 0.5rem;
        }
        .mdb-tier {
            font-size: 0.75rem;
        }
        .mdb-btn {
            width: 100%;
            min-width: 0;
        }
    }
</style>
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
            {$prizes = ['🏷️', '👕', '📜']}
            {$prizeNames = ['mariadb_prize_sticker', 'mariadb_prize_tshirt', 'mariadb_prize_voucher_draw']}
            {$grade = $TestResult.grade|default:0}
            <div class="mdb-result">
                <div class="mdb-result-card">
                    <p class="mdb-eyebrow">{translate}test_result{/translate}</p>

                    {if $TestResult.ok}
                        {capture assign="Prize"}{$prizes[$grade-1]} {translate}{$prizeNames[$grade-1]}{/translate}{/capture}
                        <div class="mdb-prize-icon" aria-hidden="true">{$prizes[$grade-1]}</div>
                        <h2 class="mdb-result-title">
                            {if $AlreadyClaimed}
                                {translate}mariadb_prize_already_claimed{/translate}
                            {else}
                                {translate}mariadb_prize_prize_draw{/translate}
                            {/if}
                        </h2>
                    {else}
                        <div class="mdb-prize-icon is-pending" aria-hidden="true">⏳</div>
                        {if !$AlreadyClaimed && array_key_exists('hints', $TestResult) && array_key_exists('not_enought_tasks_solved', $TestResult.hints)}
                            {assign var="MinTasksRequired" value="{$TestResult.hints.must_to_solve}"}
                            <h2 class="mdb-result-title">{translate}not_solved_minimum_tasks{/translate}</h2>
                        {/if}
                    {/if}

                    {if $TestData.questions_count > 0}
                        <div class="mdb-progress">
                            <div class="mdb-progress-label">
                                <span>{translate}mariadb_solved_tasks{/translate}</span>
                                <strong>{$TestData.solved_questions_count} / {$TestData.questions_count}</strong>
                            </div>
                            <div class="mdb-progress-bar">
                                <span style="width: {($TestData.solved_questions_count * 100 / $TestData.questions_count)|string_format:"%d"}%;"></span>
                            </div>
                        </div>
                    {/if}

                    <ul class="mdb-tiers">
                        {foreach $prizes as $i => $icon}
                            <li class="mdb-tier{if $TestResult.ok && $i < $grade} is-reached{/if}{if $TestResult.ok && $i == $grade-1} is-current{/if}">
                                <span class="mdb-tier-icon" aria-hidden="true">{$icon}</span>
                                {translate}{$prizeNames[$i]}{/translate}
                            </li>
                        {/foreach}
                    </ul>

                    {if $TestResult.ok}
                        {if !$AlreadyClaimed && !$TestData.timeout && $TestData.questions_count > $TestData.solved_questions_count}
                            {assign var="ImproveTimeoutHours" value="{($TestData.time_to_end - $TestData.time_to_end % 60) / 60}"}
                            {assign var="ImproveTimeoutMinutes" value="{$TestData.time_to_end % 60}"}
                            <p class="mdb-note">{translate}test_improve{/translate}</p>
                        {/if}
                    {else}
                        {if $TestData.timeout}
                            {assign var="NextTestTry" value="{$TestData.next_test_in}"}
                            <p class="mdb-note">{translate}you_can_try_again{/translate}</p>
                        {elseif !$AlreadyClaimed}
                            <p class="mdb-note">{translate}mariadb_prize_claim_requires_three{/translate}</p>
                        {/if}
                    {/if}

                    {if !$AlreadyClaimed}
                        {if $TestResult.ok}
                            <form class="mdb-claim-form" method="post" action="/{$Lang}/test/{$TestData.id}/claim">
                                {if !$UserSubscribed}
                                    <label class="mdb-optin">
                                        <input type="checkbox" name="newsletter_opt_in" value="mariadb_newsletter">
                                        <span>{translate}mariadb_newsletter_checkbox_label{/translate}</span>
                                    </label>
                                {/if}
                                <div class="mdb-actions">
                                    <button type="submit" class="mdb-btn mdb-btn-primary">{translate}claim_my_prize{/translate}</button>
                                    {if !$TestData.timeout}
                                        <a class="mdb-btn mdb-btn-secondary" href="/{$Lang}/test/{$TestData.id}/question/" title="{translate}return_to_test{/translate}">{translate}return_to_test{/translate}</a>
                                    {/if}
                                </div>
                            </form>
                        {else}
                            <div class="mdb-actions">
                                {if $TestData.timeout}
                                    <a class="mdb-btn mdb-btn-primary" href="/{$Lang}/question/db-theory/what-is-sql" title="{translate}continue_practice{/translate}">{translate}continue_practice{/translate}</a>
                                {else}
                                    <a class="mdb-btn mdb-btn-primary" href="/{$Lang}/test/{$TestData.id}/question/" title="{translate}return_to_test{/translate}">{translate}return_to_test{/translate}</a>
                                {/if}
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
</body>
</html>
