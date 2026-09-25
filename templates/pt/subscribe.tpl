<h2>Assinatura SQLTest.online</h2>
<p>A assinatura mensal apoia o projeto e oferece:</p>
<ul>
    <li>Site sem anúncios</li>
    <li>Orçamento de IA {$SubscriptionAiMultiplier}× maior, renovado todo mês: o assistente das lições e a verificação de respostas por IA</li>
</ul>

{if !$User->logged()}
    <div class="subscribe-actions">
        <p>A assinatura fica vinculada à sua conta, então faça login primeiro.</p>
        <p><a class="button green" href="" onClick="toggleLoginWindow(); return false;">Entrar</a></p>
    </div>
{else}
    <div class="subscribe-status">
        {if $AiQuota.subscribed}
            <p>Sua assinatura está ativa até <b>{$SubscriptionActiveThrough}</b>, inclusive.</p>
            <p>Orçamento de IA: {$AiQuota.percent_used}% usado · renova em {$AiQuota.resets_at}</p>
        {else}
            <p>Você está no plano gratuito.</p>
            <p>Cota gratuita de IA: {$AiQuota.percent_used}% usada · única, não é renovada</p>
        {/if}
        <div class="subscribe-meter"><div style="width: {$AiQuota.percent_used}%"></div></div>
    </div>
    <div class="subscribe-actions">
        {if $SubscriptionPaymentUrl}
            <p><a class="button blue" href="{$SubscriptionPaymentUrl|escape}" target="_blank" rel="noopener noreferrer">{if $AiQuota.subscribed}Renovar com Lava.top{else}Assinar com Lava.top{/if}</a></p>
            <p class="subscribe-note">
                A assinatura é ativada manualmente logo após a confirmação do pagamento.
                {if $UserEmail}Pague usando o e-mail da sua conta <b>{$UserEmail|escape}</b> para que possamos identificar o pagamento.{else}Após o pagamento, entre em contato conosco para vincularmos o pagamento à sua conta.{/if}
            </p>
        {else}
            <p>O pagamento está temporariamente indisponível. Entre em contato conosco para assinar.</p>
        {/if}
    </div>
{/if}
