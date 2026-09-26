{* Text of the subscribe page, see templates/subscribe.tpl *}
{if $part == 'title'}SQLTest.online subscription
{elseif $part == 'intro'}
    <p>A monthly subscription supports the project and unlocks:</p>
    <ul>
        <li>No ads on the site</li>
        <li>{$SubscriptionAiMultiplier}× bigger AI budget, renewed every month: the lesson assistant and AI answer checks</li>
    </ul>
{elseif $part == 'login_prompt'}The subscription is tied to your account, so please log in first.
{elseif $part == 'login_button'}Log in
{elseif $part == 'payment_success'}Payment received! Your subscription will be activated in a few seconds; this page refreshes automatically.
{elseif $part == 'payment_failed'}The payment didn't go through. You can try again, or use another card.
{elseif $part == 'payment_cancelled'}The payment was cancelled. You can subscribe any time.
{elseif $part == 'status_active'}Your subscription is active through <b>{$SubscriptionActiveThrough}</b> and renews automatically every month.
{elseif $part == 'status_cancelled'}Your subscription is active through <b>{$SubscriptionActiveThrough}</b>. Auto-renewal is cancelled, so it won't renew.
{elseif $part == 'status_manual'}Your subscription is active through <b>{$SubscriptionActiveThrough}</b>.
{elseif $part == 'renewal_failed'}We couldn't charge your card for the next month. The subscription ends after <b>{$SubscriptionActiveThrough}</b> unless the payment goes through; check your card in Lava.top or subscribe again after it ends.
{elseif $part == 'status_free'}You are on the free plan.
{elseif $part == 'budget_subscriber'}AI budget: {$AiQuota.percent_used}% used · renews on {$AiQuota.resets_at}
{elseif $part == 'budget_free'}Free AI allowance: {$AiQuota.percent_used}% used · one-time, doesn't renew
{elseif $part == 'budget_final'}AI budget: {$AiQuota.percent_used}% used
{elseif $part == 'cancel_button'}Cancel auto-renewal
{elseif $part == 'cancel_confirm'}Cancel auto-renewal? The subscription stays active until the end of the paid period.
{elseif $part == 'unavailable'}Payment is temporarily unavailable. Please contact us to subscribe.
{elseif $part == 'email_prompt'}Lava.top, our payment provider, sends receipts by email. Please add an email to your account first.
{elseif $part == 'email_placeholder'}you@example.com
{elseif $part == 'email_save'}Save email
{elseif $part == 'subscribe_button'}Subscribe
{elseif $part == 'subscribe_again_button'}Subscribe again
{elseif $part == 'checkout_note'}Secure payment through Lava.top in USD. The subscription renews monthly; you can cancel auto-renewal here at any time.
{/if}
