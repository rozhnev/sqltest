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
        <div class="side-card-title">Soutenir SQLtest.online</div>
        <div class="side-card-body">
            <p>
                Ce projet n'a qu'une seule source de financement : vos dons.
                Le coût de maintenance mensuel est de <strong>${$goal|string_format:"%.0f"}</strong>.
            </p>
            <p>
                Le mois dernier, j'ai ajouté une nouvelle base de données MariaDB avec une base University DB préchargée, 9 nouvelles questions, et j'ai refactoré de nombreuses questions et leçons.
            </p>
            <p>
                Avec votre soutien, je prévois de poursuivre ce travail : écrire de nouvelles leçons et tâches, et améliorer les leçons existantes.
            </p>
            <p>
                Pour maintenir le projet le mois prochain, nous devons recevoir au moins cette somme avant la fin du mois en cours.
                Tout ce qui dépasse ce montant sera consacré à de nouvelles leçons, à de nouveaux exercices et à de nouvelles fonctionnalités.
            </p>

            <div class="donation-stats">
                <span>Reçu : ${$received|string_format:"%.2f"}</span>
                <span>Objectif : ${$goal|string_format:"%.2f"}</span>
            </div>
            <div class="side-card-progress">
                <div class="side-card-progress-fill" style="width: {$progress|string_format:'%.2f'}%"></div>
            </div>
            <div class="donation-percent">Progression : {$progress|string_format:"%.0f"}%</div>
            <div class="donation-action">
                <a href="/{$Lang}/donate" target="_self">
                    <button class="button green side-card-button"><span>{translate}top_menu_donate{/translate}</span></button>
                </a>
            </div>
        </div>
    </div>
</div>
