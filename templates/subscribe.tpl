{include file='short-header.tpl'}
{* Subscription page (see SUBSCRIPTION_PLAN.md). Logic and markup live here; the text comes
   from $SubscribeContentTemplate ({lang}/subscribe.tpl), picked by the "part" parameter. *}
{assign var=Text value=$SubscribeContentTemplate}
{assign var=SubStatus value=$SubscriptionState.status}
{assign var=Subscribed value=$AiQuota && $AiQuota.subscribed}
{capture name=cancel_confirm}{include file=$Text part='cancel_confirm'}{/capture}
{capture name=email_placeholder}{include file=$Text part='email_placeholder'}{/capture}
<style>
    /* The site's light theme sets --regular-text-color to white; text on the plain page background needs --question-text. */
    .subscribe-page { color: var(--question-text); max-width: 640px; margin: 10vh auto; padding: 0 16px; }
    .subscribe-page h2 { text-align: center; }
    .subscribe-page ul { line-height: 1.7; }
    .subscribe-status { margin: 1.5rem 0; padding: 1rem; border: 1px solid var(--text-block-border-color); border-radius: 6px; }
    .subscribe-meter { height: 8px; margin-top: 0.5rem; border-radius: 4px; background: rgba(128, 128, 128, 0.3); overflow: hidden; }
    .subscribe-meter > div { height: 100%; background: #2EA043; }
    .subscribe-actions { text-align: center; margin-top: 1.5rem; }
    .subscribe-actions form { display: inline-block; }
    .subscribe-note { font-size: 0.9em; }
    .subscribe-message { margin: 1rem 0; padding: 0.75rem 1rem; border-left: 4px solid var(--accordion-hover); background: var(--code-result-background-color); }
    .subscribe-message.error { border-left-color: var(--danger-text-color); }
    .subscribe-email { display: flex; gap: 0.5rem; justify-content: center; flex-wrap: wrap; }
    .subscribe-email input { min-width: 240px; padding: 0.5rem; border: 1px solid var(--text-block-border-color); border-radius: 4px; background: var(--body-background-color); color: var(--question-text); }
    .subscribe-link-button { border: none; background: none; color: var(--question-text); text-decoration: underline; cursor: pointer; font: inherit; }
</style>
<body>
    <div class="container">
        <header>
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/subscribe"}
            {else}
                {include file='top-menu.tpl' path="/subscribe"}
            {/if}
        </header>
        <main>
            <div class="subscribe-page">
                <h2>{include file=$Text part='title'}</h2>
                {include file=$Text part='intro'}

                {if $SubscribeFlash}
                    <div class="subscribe-message {$SubscribeFlash.type|escape}">{$SubscribeFlash.message|escape}</div>
                {/if}

                {if !$User->logged()}
                    <div class="subscribe-actions">
                        <p>{include file=$Text part='login_prompt'}</p>
                        <p><a class="button green" href="" onClick="toggleLoginWindow(); return false;">{include file=$Text part='login_button'}</a></p>
                    </div>
                {else}
                    {if !$Subscribed && $SubscriptionPaymentReturn}
                        <div class="subscribe-message{if $SubscriptionPaymentReturn != 'success'} error{/if}">
                            {include file=$Text part="payment_{$SubscriptionPaymentReturn}"}
                        </div>
                        {if $SubscriptionPaymentReturn == 'success'}
                            {* The webhook can arrive after the redirect: reload once without the parameter *}
                            <meta http-equiv="refresh" content="5;url=/{$Lang}/subscribe">
                        {/if}
                    {/if}

                    <div class="subscribe-status">
                        {if $Subscribed}
                            {if $SubStatus == 'active'}
                                <p>{include file=$Text part='status_active'}</p>
                            {elseif $SubStatus == 'cancelled'}
                                <p>{include file=$Text part='status_cancelled'}</p>
                            {else}
                                <p>{include file=$Text part='status_manual'}</p>
                            {/if}
                            {if $SubscriptionState.renewal_failed}
                                <div class="subscribe-message error">{include file=$Text part='renewal_failed'}</div>
                            {/if}
                            {* Only an auto-renewing subscription refreshes the budget on resets_at *}
                            <p>{if $SubStatus == 'active'}{include file=$Text part='budget_subscriber'}{else}{include file=$Text part='budget_final'}{/if}</p>
                        {else}
                            <p>{include file=$Text part='status_free'}</p>
                            <p>{include file=$Text part='budget_free'}</p>
                        {/if}
                        <div class="subscribe-meter"><div style="width: {$AiQuota.percent_used}%"></div></div>
                    </div>

                    <div class="subscribe-actions">
                        {if $Subscribed && $SubStatus == 'active'}
                            <form method="post" action="/{$Lang}/subscribe/cancel" onsubmit="return confirm('{$smarty.capture.cancel_confirm|trim|escape:'javascript'|escape}');">
                                <button type="submit" class="subscribe-link-button">{include file=$Text part='cancel_button'}</button>
                            </form>
                        {elseif !$SubscriptionCheckoutAvailable}
                            <p>{include file=$Text part='unavailable'}</p>
                        {elseif !$UserEmail}
                            <p>{include file=$Text part='email_prompt'}</p>
                            <form method="post" action="/{$Lang}/subscribe/email" class="subscribe-email">
                                <input type="email" name="email" required placeholder="{$smarty.capture.email_placeholder|trim|escape}">
                                <button type="submit" class="button">{include file=$Text part='email_save'}</button>
                            </form>
                        {else}
                            <form method="post" action="/{$Lang}/subscribe/checkout">
                                <button type="submit" class="button blue">{if $Subscribed}{include file=$Text part='subscribe_again_button'}{else}{include file=$Text part='subscribe_button'}{/if}</button>
                            </form>
                            <p class="subscribe-note">{include file=$Text part='checkout_note'}</p>
                        {/if}
                    </div>
                {/if}
            </div>
        </main>
        <footer>
            {if $MobileView}
                {include file='m.footer.tpl'}
            {else}
                {include file='footer.tpl'}
            {/if}
        </footer>
    </div>
</body>
</html>
