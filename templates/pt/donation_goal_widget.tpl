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
        <div class="side-card-title">Apoie o SQLtest.online</div>
        <div class="side-card-body">
            <p>
                Este projeto tem apenas uma fonte de financiamento: as suas doações.
                O custo mensal de manutenção é <strong>${$goal|string_format:"%.0f"}</strong>.
            </p>
            <p>
                No mês passado, adicionei um novo banco de dados MariaDB com um banco University DB pré-carregado, 9 novas questões e refatorei muitas questões e lições.
            </p>
            <p>
                Com o seu apoio, planeio continuar este trabalho: escrever novas lições e tarefas e melhorar as lições existentes.
            </p>
            <p>
                Para manter o projeto no próximo mês, precisamos arrecadar pelo menos esse valor até o fim deste mês.
                Tudo o que passar disso será usado em novas lições, exercícios e recursos.
            </p>

            <div class="donation-stats">
                <span>Recebido: ${$received|string_format:"%.2f"}</span>
                <span>Meta: ${$goal|string_format:"%.2f"}</span>
            </div>
            <div class="side-card-progress">
                <div class="side-card-progress-fill" style="width: {$progress|string_format:'%.2f'}%"></div>
            </div>
            <div class="donation-percent">Progresso: {$progress|string_format:"%.0f"}%</div>
            <div class="donation-action">
                <a href="/{$Lang}/donate" target="_self">
                    <button class="button green side-card-button"><span>{translate}top_menu_donate{/translate}</span></button>
                </a>
            </div>
        </div>
    </div>
</div>
