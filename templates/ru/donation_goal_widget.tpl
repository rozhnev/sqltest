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
        <div class="side-card-title">Поддержите SQLtest.online</div>
        <div class="side-card-body">
            <p>
                У проекта только один источник финансирования: ваши донаты.
                Ежемесячные расходы на поддержку проекта составляют <strong>${$goal|string_format:"%.0f"}</strong>.
            </p>
            <p>
                В прошлом месяце я добавил новую базу данных MariaDB с предустановленной базой University DB, 9 новых вопросов и отрефакторил много вопросов и уроков.
            </p>
            <p>
                С вашей поддержкой я планирую продолжать работу: писать новые уроки и задания, улучшать существующие уроки.
            </p>
            <p>
                Чтобы проект продолжил работать в следующем месяце, до конца текущего месяца нужно собрать как минимум эту сумму.
                Всё, что будет собрано сверх неё, пойдёт на новые уроки, задания и функции.
            </p>

            <div class="donation-stats">
                <span>Собрано: ${$received|string_format:"%.2f"}</span>
                <span>Цель: ${$goal|string_format:"%.2f"}</span>
            </div>
            <div class="side-card-progress">
                <div class="side-card-progress-fill" style="width: {$progress|string_format:'%.2f'}%"></div>
            </div>
            <div class="donation-percent">Прогресс: {$progress|string_format:"%.0f"}%</div>
            <div class="donation-action">
                <a href="/{$Lang}/donate" target="_self">
                    <button class="button green side-card-button"><span>{translate}top_menu_donate{/translate}</span></button>
                </a>
            </div>
        </div>
    </div>
</div>
