{* Text of the AI tokens page, see templates/tokens.tpl *}
{if $part == 'title'}Tokens de IA
{elseif $part == 'intro'}
    <p>Los tokens de IA pagan las funciones de IA de SQLTest.online:</p>
    <ul>
        <li>el asistente de la lección, que responde preguntas sobre la lección que estás leyendo</li>
        <li>la revisión con IA de respuestas libres</li>
    </ul>
    <p>Un paquete te da <b>{$TokensPack}</b> tokens. Es un pago único y los tokens no caducan.</p>
{elseif $part == 'login_prompt'}Los tokens se agregan a tu cuenta, así que primero inicia sesión.
{elseif $part == 'login_button'}Iniciar sesión
{elseif $part == 'payment_success'}¡Pago recibido! Los tokens se agregarán en unos segundos; esta página se actualizará automáticamente.
{elseif $part == 'payment_failed'}El pago no se completó. Inténtalo de nuevo o usa otra tarjeta.
{elseif $part == 'payment_cancelled'}El pago fue cancelado. Puedes comprar tokens en cualquier momento.
{elseif $part == 'balance'}Tu saldo: <b>{$AiQuota.remaining_text}</b> tokens de IA
{elseif $part == 'unavailable'}El pago no está disponible temporalmente. Contáctanos para comprar tokens.
{elseif $part == 'email_prompt'}Lava.top, nuestro proveedor de pagos, envía los recibos por correo electrónico. Primero agrega un correo a tu cuenta.
{elseif $part == 'email_placeholder'}tu@ejemplo.com
{elseif $part == 'email_save'}Guardar correo
{elseif $part == 'promo_code_label'}¿Tienes un código promocional?
{elseif $part == 'promo_code_placeholder'}Código promocional
{elseif $part == 'buy_button'}Comprar {$TokensPack} tokens
{elseif $part == 'checkout_note'}Pago único seguro a través de Lava.top en USD.
{elseif $part == 'history_title'}Tus compras
{elseif $part == 'history_date'}Fecha
{elseif $part == 'history_tokens'}Tokens
{elseif $part == 'history_amount'}Pagado
{/if}
