{* Text of the AI tokens page, see templates/tokens.tpl *}
{if $part == 'title'}AI tokens
{elseif $part == 'intro'}
    <p>AI tokens pay for the AI features of SQLTest.online:</p>
    <ul>
        <li>the lesson assistant, which answers questions about the lesson you're reading</li>
        <li>AI checks of free-form answers</li>
    </ul>
    <p>A pack gives you <b>{$TokensPack}</b> tokens. It's a one-time payment, and the tokens never expire.</p>
{elseif $part == 'login_prompt'}Tokens are added to your account, so please log in first.
{elseif $part == 'login_button'}Log in
{elseif $part == 'payment_success'}Payment received! The tokens will be added in a few seconds; this page refreshes automatically.
{elseif $part == 'payment_failed'}The payment didn't go through. You can try again, or use another card.
{elseif $part == 'payment_cancelled'}The payment was cancelled. You can buy tokens any time.
{elseif $part == 'balance'}Your balance: <b>{$AiQuota.remaining_text}</b> AI tokens
{elseif $part == 'unavailable'}Payment is temporarily unavailable. Please contact us to buy tokens.
{elseif $part == 'email_prompt'}Lava.top, our payment provider, sends receipts by email. Please add an email to your account first.
{elseif $part == 'email_placeholder'}you@example.com
{elseif $part == 'email_save'}Save email
{elseif $part == 'promo_code_label'}Have a promo code?
{elseif $part == 'promo_code_placeholder'}Promo code
{elseif $part == 'buy_button'}Buy {$TokensPack} tokens
{elseif $part == 'checkout_note'}Secure one-time payment through Lava.top in USD.
{elseif $part == 'history_title'}Your purchases
{elseif $part == 'history_date'}Date
{elseif $part == 'history_tokens'}Tokens
{elseif $part == 'history_amount'}Paid
{/if}
