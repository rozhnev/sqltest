<h2>Suscripción a SQLTest.online</h2>
<p>La suscripción mensual apoya el proyecto y te ofrece:</p>
<ul>
    <li>Sitio sin anuncios</li>
    <li>Un presupuesto de IA {$SubscriptionAiMultiplier}× mayor, renovado cada mes: el asistente de las lecciones y la verificación de respuestas con IA</li>
</ul>

{if !$User->logged()}
    <div class="subscribe-actions">
        <p>La suscripción está vinculada a tu cuenta, así que primero inicia sesión.</p>
        <p><a class="button green" href="" onClick="toggleLoginWindow(); return false;">Iniciar sesión</a></p>
    </div>
{else}
    <div class="subscribe-status">
        {if $AiQuota.subscribed}
            <p>Tu suscripción está activa hasta el <b>{$SubscriptionActiveThrough}</b> inclusive.</p>
            <p>Presupuesto de IA: {$AiQuota.percent_used}% usado · se renueva el {$AiQuota.resets_at}</p>
        {else}
            <p>Estás en el plan gratuito.</p>
            <p>Cuota gratuita de IA: {$AiQuota.percent_used}% usada · única, no se renueva</p>
        {/if}
        <div class="subscribe-meter"><div style="width: {$AiQuota.percent_used}%"></div></div>
    </div>
    <div class="subscribe-actions">
        {if $SubscriptionPaymentUrl}
            <p><a class="button blue" href="{$SubscriptionPaymentUrl|escape}" target="_blank" rel="noopener noreferrer">{if $AiQuota.subscribed}Renovar con Lava.top{else}Suscribirse con Lava.top{/if}</a></p>
            <p class="subscribe-note">
                La suscripción se activa manualmente poco después de confirmar el pago.
                {if $UserEmail}Paga con el correo de tu cuenta <b>{$UserEmail|escape}</b> para que podamos identificar el pago.{else}Después de pagar, contáctanos para vincular el pago a tu cuenta.{/if}
            </p>
        {else}
            <p>El pago no está disponible temporalmente. Contáctanos para suscribirte.</p>
        {/if}
    </div>
{/if}
