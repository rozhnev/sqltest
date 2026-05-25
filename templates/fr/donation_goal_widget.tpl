{assign var="goal" value=$DONATION_MONTHLY_GOAL|default:50}
{assign var="received" value=$DONATION_RECEIVED_CURRENT_MONTH|default:0}
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
    <style>
        .donation-goal-widget .donation-card {
            margin: 0.5em 0 0 0;
            background-color: var(--accordion-panel-bg-color);
            border: 1px solid var(--text-block-border-color);
            color: var(--question-text);
            border-radius: 0 6px 0 0;
            overflow: hidden;
        }
        .donation-goal-widget .donation-title {
            background-color: var(--menu-button-background-color);
            padding: 0.6em 0.7em;
            color: #fff;
            font-weight: 700;
        }
        .donation-goal-widget .donation-body {
            padding: 0.7em;
            font-size: 0.92rem;
            line-height: 1.45;
        }
        .donation-goal-widget .donation-stats {
            margin-top: 0.6em;
            display: flex;
            justify-content: space-between;
            gap: 0.6em;
            font-size: 0.9rem;
            font-weight: 600;
        }
        .donation-goal-widget .donation-progress {
            margin-top: 0.45em;
            background: var(--text-block-border-color);
            border-radius: 999px;
            overflow: hidden;
            height: 10px;
        }
        .donation-goal-widget .donation-progress-fill {
            height: 10px;
            width: {$progress|string_format:"%.2f"}%;
            background: linear-gradient(90deg, #22c55e, #10b981);
        }
        .donation-goal-widget .donation-percent {
            margin-top: 0.35em;
            font-size: 0.82rem;
            opacity: 0.85;
        }
        .donation-goal-widget .donation-action {
            margin-top: 0.65em;
        }
        .donation-goal-widget .donation-action .button {
            width: 100%;
        }
    </style>

    <div class="donation-card">
        <div class="donation-title">Soutenir SQLtest.online</div>
        <div class="donation-body">
            <p>
                Ce projet n'a qu'une seule source de financement : vos dons.
                Le coût de maintenance mensuel est de <strong>${$goal|string_format:"%.0f"}</strong>.
            </p>
            <p>
                Pour maintenir le projet le mois prochain, nous devons recevoir au moins cette somme avant la fin du mois en cours.
            </p>

            <div class="donation-stats">
                <span>Reçu : ${$received|string_format:"%.2f"}</span>
                <span>Objectif : ${$goal|string_format:"%.2f"}</span>
            </div>
            <div class="donation-progress">
                <div class="donation-progress-fill"></div>
            </div>
            <div class="donation-percent">Progression : {$progress|string_format:"%.0f"}%</div>
            <div class="donation-action">
                <a href="/{$Lang}/donate" target="_self">
                    <button class="button green"><span>{translate}top_menu_donate{/translate}</span></button>
                </a>
            </div>
        </div>
    </div>
</div>
