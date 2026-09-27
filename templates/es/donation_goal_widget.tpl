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
        <div class="side-card-title">Apoyar a SQLtest.online</div>
        <div class="side-card-body">
            <p>
                Este proyecto tiene una única fuente de financiación: tus donaciones.
                El costo de mantenimiento mensual es de <strong>${$goal|string_format:"%.0f"}</strong>.
            </p>
            <p>
                El mes pasado añadí una nueva base de datos MariaDB con una base de datos universitaria precargada, 9 nuevas preguntas y refactoricé muchas preguntas y lecciones.
            </p>
            <p>
                Con tu apoyo, planeo continuar este trabajo: escribir nuevas lecciones y tareas, y mejorar las lecciones existentes.
            </p>
            <p>
                Para mantener el proyecto en funcionamiento el próximo mes, necesitamos recaudar al menos esta cantidad para fin de mes.
                Cualquier monto adicional se destinará a nuevas lecciones, ejercicios y características.
            </p>

            <div class="donation-stats">
                <span>Recibido: ${$received|string_format:"%.2f"}</span>
                <span>Meta: ${$goal|string_format:"%.2f"}</span>
            </div>
            <div class="side-card-progress">
                <div class="side-card-progress-fill" style="width: {$progress|string_format:'%.2f'}%"></div>
            </div>
            <div class="donation-percent">Progreso: {$progress|string_format:"%.0f"}%</div>
            <div class="donation-action">
                <a href="/{$Lang}/donate" target="_self">
                    <button class="button green side-card-button"><span>{translate}top_menu_donate{/translate}</span></button>
                </a>
            </div>
        </div>
    </div>
</div>