{* Text of the subscribe page, see templates/subscribe.tpl *}
{if $part == 'title'}Suscripción a SQLTest.online
{elseif $part == 'intro'}
    <p>La suscripción mensual apoya el proyecto y te ofrece:</p>
    <ul>
        <li>Sitio sin anuncios</li>
        <li>Un presupuesto de IA {$SubscriptionAiMultiplier}× mayor, renovado cada mes: el asistente de las lecciones y la verificación de respuestas con IA</li>
    </ul>
{elseif $part == 'login_prompt'}La suscripción está vinculada a tu cuenta, así que primero inicia sesión.
{elseif $part == 'login_button'}Iniciar sesión
{elseif $part == 'payment_success'}¡Pago recibido! Tu suscripción se activará en unos segundos; esta página se actualizará automáticamente.
{elseif $part == 'payment_failed'}El pago no se completó. Inténtalo de nuevo o usa otra tarjeta.
{elseif $part == 'payment_cancelled'}El pago fue cancelado. Puedes suscribirte en cualquier momento.
{elseif $part == 'status_active'}Tu suscripción está activa hasta el <b>{$SubscriptionActiveThrough}</b> inclusive y se renueva automáticamente cada mes.
{elseif $part == 'status_cancelled'}Tu suscripción está activa hasta el <b>{$SubscriptionActiveThrough}</b> inclusive. La renovación automática está cancelada, así que no se renovará.
{elseif $part == 'status_manual'}Tu suscripción está activa hasta el <b>{$SubscriptionActiveThrough}</b> inclusive.
{elseif $part == 'renewal_failed'}No pudimos cobrar el próximo mes en tu tarjeta. La suscripción termina después del <b>{$SubscriptionActiveThrough}</b> si el pago no se completa; revisa tu tarjeta en Lava.top o suscríbete de nuevo cuando termine.
{elseif $part == 'status_free'}Estás en el plan gratuito.
{elseif $part == 'budget_subscriber'}Presupuesto de IA: {$AiQuota.percent_used}% usado · se renueva el {$AiQuota.resets_at}
{elseif $part == 'budget_free'}Cuota gratuita de IA: {$AiQuota.percent_used}% usada · única, no se renueva
{elseif $part == 'budget_final'}Presupuesto de IA: {$AiQuota.percent_used}% usado
{elseif $part == 'cancel_button'}Cancelar la renovación automática
{elseif $part == 'cancel_confirm'}¿Cancelar la renovación automática? La suscripción sigue activa hasta el final del período pagado.
{elseif $part == 'unavailable'}El pago no está disponible temporalmente. Contáctanos para suscribirte.
{elseif $part == 'email_prompt'}Lava.top, nuestro proveedor de pagos, envía los recibos por correo electrónico. Primero agrega un correo a tu cuenta.
{elseif $part == 'email_placeholder'}tu@ejemplo.com
{elseif $part == 'email_save'}Guardar correo
{elseif $part == 'subscribe_button'}Suscribirse
{elseif $part == 'subscribe_again_button'}Suscribirse de nuevo
{elseif $part == 'checkout_note'}Pago seguro a través de Lava.top en USD. La suscripción se renueva cada mes; puedes cancelar la renovación automática aquí en cualquier momento.
{/if}
