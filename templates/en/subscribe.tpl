<h2>SQLTest.online subscription</h2>
<p>A monthly subscription supports the project and unlocks:</p>
<ul>
    <li>No ads on the site</li>
    <li>{$SubscriptionAiMultiplier}× bigger AI budget, renewed every month: the lesson assistant and AI answer checks</li>
</ul>

{if !$User->logged()}
    <div class="subscribe-actions">
        <p>The subscription is tied to your account, so please log in first.</p>
        <p><a class="button green" href="" onClick="toggleLoginWindow(); return false;">Log in</a></p>
    </div>
{else}
    <div class="subscribe-status">
        {if $AiQuota.subscribed}
            <p>Your subscription is active through <b>{$SubscriptionActiveThrough}</b>.</p>
            <p>AI budget: {$AiQuota.percent_used}% used · renews on {$AiQuota.resets_at}</p>
        {else}
            <p>You are on the free plan.</p>
            <p>Free AI allowance: {$AiQuota.percent_used}% used · one-time, doesn't renew</p>
        {/if}
        <div class="subscribe-meter"><div style="width: {$AiQuota.percent_used}%"></div></div>
    </div>
    <div class="subscribe-actions">
        {if $SubscriptionPaymentUrl}
            <p><a class="button blue" href="{$SubscriptionPaymentUrl|escape}" target="_blank" rel="noopener noreferrer">{if $AiQuota.subscribed}Renew with Lava.top{else}Subscribe with Lava.top{/if}</a></p>
            <p class="subscribe-note">
                The subscription is activated manually shortly after the payment is confirmed.
                {if $UserEmail}Please pay with your account email <b>{$UserEmail|escape}</b> so we can match the payment.{else}Please contact us after paying so we can match the payment to your account.{/if}
            </p>
        {else}
            <p>Payment is temporarily unavailable. Please contact us to subscribe.</p>
        {/if}
    </div>
{/if}
