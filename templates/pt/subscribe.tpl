{* Text of the subscribe page, see templates/subscribe.tpl *}
{if $part == 'title'}Assinatura SQLTest.online
{elseif $part == 'intro'}
    <p>A assinatura mensal apoia o projeto e oferece:</p>
    <ul>
        <li>Site sem anúncios</li>
        <li>Orçamento de IA {$SubscriptionAiMultiplier}× maior, renovado todo mês: o assistente das lições e a verificação de respostas por IA</li>
    </ul>
{elseif $part == 'login_prompt'}A assinatura fica vinculada à sua conta, então faça login primeiro.
{elseif $part == 'login_button'}Entrar
{elseif $part == 'payment_success'}Pagamento recebido! Sua assinatura será ativada em alguns segundos; esta página será atualizada automaticamente.
{elseif $part == 'payment_failed'}O pagamento não foi concluído. Tente novamente ou use outro cartão.
{elseif $part == 'payment_cancelled'}O pagamento foi cancelado. Você pode assinar a qualquer momento.
{elseif $part == 'status_active'}Sua assinatura está ativa até <b>{$SubscriptionActiveThrough}</b>, inclusive, e é renovada automaticamente todo mês.
{elseif $part == 'status_cancelled'}Sua assinatura está ativa até <b>{$SubscriptionActiveThrough}</b>, inclusive. A renovação automática foi cancelada, então ela não será renovada.
{elseif $part == 'status_manual'}Sua assinatura está ativa até <b>{$SubscriptionActiveThrough}</b>, inclusive.
{elseif $part == 'renewal_failed'}Não conseguimos cobrar o próximo mês no seu cartão. A assinatura termina após <b>{$SubscriptionActiveThrough}</b> se o pagamento não for concluído; verifique seu cartão na Lava.top ou assine novamente depois que ela terminar.
{elseif $part == 'status_free'}Você está no plano gratuito.
{elseif $part == 'budget_subscriber'}Orçamento de IA: {$AiQuota.percent_used}% usado · renova em {$AiQuota.resets_at}
{elseif $part == 'budget_free'}Cota gratuita de IA: {$AiQuota.percent_used}% usada · única, não é renovada
{elseif $part == 'budget_final'}Orçamento de IA: {$AiQuota.percent_used}% usado
{elseif $part == 'cancel_button'}Cancelar renovação automática
{elseif $part == 'cancel_confirm'}Cancelar a renovação automática? A assinatura continua ativa até o fim do período pago.
{elseif $part == 'unavailable'}O pagamento está temporariamente indisponível. Entre em contato conosco para assinar.
{elseif $part == 'email_prompt'}A Lava.top, nossa provedora de pagamentos, envia os recibos por e-mail. Adicione primeiro um e-mail à sua conta.
{elseif $part == 'email_placeholder'}voce@exemplo.com
{elseif $part == 'email_save'}Salvar e-mail
{elseif $part == 'subscribe_button'}Assinar
{elseif $part == 'subscribe_again_button'}Assinar novamente
{elseif $part == 'checkout_note'}Pagamento seguro pela Lava.top em USD. A assinatura é renovada mensalmente; você pode cancelar a renovação automática aqui a qualquer momento.
{/if}
