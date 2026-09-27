{* Text of the AI tokens page, see templates/tokens.tpl *}
{if $part == 'title'}Tokens de IA
{elseif $part == 'intro'}
    <p>Os tokens de IA pagam os recursos de IA do SQLTest.online:</p>
    <ul>
        <li>o assistente da lição, que responde perguntas sobre a lição que você está lendo</li>
        <li>a verificação por IA de respostas livres</li>
    </ul>
    <p>Um pacote dá <b>{$TokensPack}</b> tokens. É um pagamento único, e os tokens não expiram.</p>
{elseif $part == 'login_prompt'}Os tokens são adicionados à sua conta, então faça login primeiro.
{elseif $part == 'login_button'}Entrar
{elseif $part == 'payment_success'}Pagamento recebido! Os tokens serão adicionados em alguns segundos; esta página será atualizada automaticamente.
{elseif $part == 'payment_failed'}O pagamento não foi concluído. Tente novamente ou use outro cartão.
{elseif $part == 'payment_cancelled'}O pagamento foi cancelado. Você pode comprar tokens a qualquer momento.
{elseif $part == 'balance'}Seu saldo: <b>{$AiQuota.remaining_text}</b> tokens de IA
{elseif $part == 'unavailable'}O pagamento está temporariamente indisponível. Entre em contato conosco para comprar tokens.
{elseif $part == 'email_prompt'}A Lava.top, nossa provedora de pagamentos, envia os recibos por e-mail. Adicione primeiro um e-mail à sua conta.
{elseif $part == 'email_placeholder'}voce@exemplo.com
{elseif $part == 'email_save'}Salvar e-mail
{elseif $part == 'promo_code_label'}Tem um código promocional?
{elseif $part == 'promo_code_placeholder'}Código promocional
{elseif $part == 'buy_button'}Comprar {$TokensPack} tokens
{elseif $part == 'checkout_note'}Pagamento único seguro pela Lava.top em USD.
{elseif $part == 'history_title'}Suas compras
{elseif $part == 'history_date'}Data
{elseif $part == 'history_tokens'}Tokens
{elseif $part == 'history_amount'}Pago
{/if}
