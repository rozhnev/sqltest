{include file='short-header.tpl'}
{* AI tokens page (see TOKEN_PURCHASE_PLAN.md). Text comes from the tokens_* keys in translations/.
   The cards use the shared .side-card classes from style.css. *}
{capture name=email_placeholder}{translate}tokens_email_placeholder{/translate}{/capture}
{capture name=promo_code_placeholder}{translate}tokens_promo_code_placeholder{/translate}{/capture}
<style>
    /* The site's light theme sets --regular-text-color to white; text on the plain page background needs --question-text. */
    .tokens-page { color: var(--question-text); max-width: 880px; margin: 6vh auto 4rem; padding: 0 16px; }
    .tokens-hero { text-align: center; margin-bottom: 1.75rem; }
    .tokens-hero h1 { margin: 0 0 0.4rem; font-size: clamp(1.6rem, 4vw, 2.2rem); }
    .tokens-hero p { margin: 0 auto; max-width: 560px; font-size: 1.05rem; line-height: 1.5; opacity: 0.85; }

    .tokens-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1rem; align-items: stretch; }
    .tokens-grid .side-card { margin: 0; display: flex; flex-direction: column; }
    .tokens-grid .side-card-body { flex: 1; display: flex; flex-direction: column; gap: 0.9rem; font-size: 1rem; }

    .tokens-amount { display: flex; align-items: baseline; gap: 0.5rem; flex-wrap: wrap; }
    .tokens-amount strong { font-size: clamp(2rem, 6vw, 2.6rem); line-height: 1.1; font-variant-numeric: tabular-nums; }
    .tokens-amount span { font-size: 1rem; opacity: 0.75; }
    .tokens-amount.empty strong { color: var(--danger-text-color); }
    .tokens-price { margin-top: -0.5rem; font-size: 1.5rem; font-weight: 600; font-variant-numeric: tabular-nums; color: var(--cost-best-color); }
    .tokens-muted { margin: 0; font-size: 0.92rem; opacity: 0.8; line-height: 1.45; }

    .tokens-features { list-style: none; margin: 0; padding: 0; display: flex; flex-direction: column; gap: 0.45rem; }
    .tokens-features li { display: flex; gap: 0.55rem; align-items: flex-start; line-height: 1.4; }
    .tokens-features li::before { content: ""; flex: none; width: 1.15rem; height: 1.15rem; margin-top: 0.1rem; border-radius: 50%;
        background: #16a34a url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3E%3Cpath d='M4 8.5l2.5 2.5L12 5.5' fill='none' stroke='white' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E") center / 80% no-repeat; }

    .tokens-buy { margin-top: auto; display: flex; flex-direction: column; gap: 0.6rem; }
    /* .button is display: flex with max-width: max-content site-wide */
    .tokens-buy .button { width: 100%; max-width: none; justify-content: center; margin: 0; font-size: 1.05rem; padding: 0.7rem 1rem; }
    .tokens-note { margin: 0; font-size: 0.85rem; text-align: center; opacity: 0.75; }
    .tokens-promo summary { cursor: pointer; font-size: 0.92rem; text-decoration: underline; width: fit-content; }
    .tokens-promo input { width: 100%; margin-top: 0.5rem; padding: 0.55rem 0.6rem; border: 1px solid var(--text-block-border-color); border-radius: 4px;
        background: var(--body-background-color); color: var(--question-text); font: inherit; text-transform: uppercase; letter-spacing: 0.04em; }
    .tokens-refund { margin: 0; padding-top: 0.7rem; border-top: 1px solid var(--text-block-border-color); font-size: 0.85rem; text-align: center; opacity: 0.75; }
    .tokens-email { display: flex; gap: 0.5rem; flex-wrap: wrap; }
    .tokens-email input { flex: 1 1 180px; padding: 0.55rem 0.6rem; border: 1px solid var(--text-block-border-color); border-radius: 4px;
        background: var(--body-background-color); color: var(--question-text); font: inherit; }
    .tokens-email .button { width: auto; margin: 0; }

    .tokens-message { margin: 0 0 1rem; padding: 0.75rem 1rem; border-radius: 6px; border-left: 4px solid #16a34a; background: var(--accordion-panel-bg-color); }
    .tokens-message.error { border-left-color: var(--danger-text-color); }

    .tokens-history { margin-top: 1rem; }
    .tokens-history table { width: 100%; border-collapse: collapse; font-variant-numeric: tabular-nums; }
    /* Override the site-wide td borders */
    .tokens-history th, .tokens-history td { padding: 0.45rem 0.5rem; border: none; border-bottom: 1px solid var(--text-block-border-color); background: none; text-align: left; }
    .tokens-history tr:last-child td { border-bottom: none; }
    .tokens-history th { font-weight: 600; font-size: 0.88rem; opacity: 0.8; }
    .tokens-history .num { text-align: right; }
</style>
<body>
    {* Email login/register popup: the login menu's email option opens it *}
    {include file='popups.tpl'}
    <div class="container">
        <header>
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/buy-tokens"}
            {else}
                {include file='top-menu.tpl' path="/buy-tokens"}
            {/if}
        </header>
        <main>
            <div class="tokens-page">
                <div class="tokens-hero">
                    <h1>{translate}tokens_title{/translate}</h1>
                    <p>{translate}tokens_subtitle{/translate}</p>
                </div>

                {if $TokensFlash}
                    <div class="tokens-message {$TokensFlash.type|escape}">{$TokensFlash.message|escape}</div>
                {/if}
                {if $User->logged() && $TokensPaymentReturn}
                    <div class="tokens-message{if $TokensPaymentReturn != 'success'} error{/if}">
                        {if $TokensPaymentReturn == 'success'}{translate}tokens_payment_success{/translate}{elseif $TokensPaymentReturn == 'failed'}{translate}tokens_payment_failed{/translate}{else}{translate}tokens_payment_cancelled{/translate}{/if}
                    </div>
                    {if $TokensPaymentReturn == 'success'}
                        {* The webhook can arrive after the redirect: reload once without the parameter *}
                        <meta http-equiv="refresh" content="5;url=/{$Lang}/buy-tokens">
                    {/if}
                {/if}

                <div class="tokens-grid">
                    {if $User->logged()}
                        <section class="side-card">
                            <div class="side-card-title">{translate}tokens_balance_title{/translate}</div>
                            <div class="side-card-body">
                                <div class="tokens-amount{if $AiQuota.exhausted} empty{/if}">
                                    <strong>{$AiQuota.remaining_text}</strong>
                                    <span>{translate}tokens_unit{/translate}</span>
                                </div>
                                <p class="tokens-muted">{translate}tokens_balance_uses{/translate}</p>
                            </div>
                        </section>
                    {/if}

                    <section class="side-card">
                        <div class="side-card-title">{translate}tokens_pack_title{/translate}</div>
                        <div class="side-card-body">
                            <div class="tokens-amount">
                                <strong>{$TokensPack}</strong>
                                <span>{translate}tokens_unit{/translate}</span>
                            </div>
                            {if $TokensPackPrice}
                                <div class="tokens-price">{$TokensPackPrice|escape}</div>
                            {/if}
                            <ul class="tokens-features">
                                <li>{translate}tokens_feature_one_time{/translate}</li>
                                <li>{translate}tokens_feature_never_expire{/translate}</li>
                                <li>{translate}tokens_feature_adds_up{/translate}</li>
                            </ul>

                            <div class="tokens-buy">
                                {if !$User->logged()}
                                    <p class="tokens-muted">{translate}tokens_login_prompt{/translate}</p>
                                    <button type="button" class="button green side-card-button" onClick="toggleLoginWindow()">{translate}login_button{/translate}</button>
                                {elseif !$TokensCheckoutAvailable}
                                    <p class="tokens-muted">{translate}tokens_unavailable{/translate}</p>
                                {elseif !$UserEmail}
                                    <p class="tokens-muted">{translate}tokens_email_prompt{/translate}</p>
                                    <form method="post" action="/{$Lang}/buy-tokens/email" class="tokens-email">
                                        <input type="email" name="email" required placeholder="{$smarty.capture.email_placeholder|trim|escape}">
                                        <button type="submit" class="button green side-card-button">{translate}tokens_email_save{/translate}</button>
                                    </form>
                                {else}
                                    <form method="post" action="/{$Lang}/buy-tokens/checkout" class="tokens-buy">
                                        <details class="tokens-promo">
                                            <summary>{translate}tokens_promo_code_label{/translate}</summary>
                                            <input type="text" name="promo_code" maxlength="36" pattern="[A-Za-z0-9_\-]{ldelim}3,36{rdelim}" autocomplete="off" placeholder="{$smarty.capture.promo_code_placeholder|trim|escape}">
                                        </details>
                                        <button type="submit" class="button green side-card-button">{translate}tokens_buy_button{/translate}</button>
                                    </form>
                                    <p class="tokens-note">{translate}tokens_checkout_note{/translate}</p>
                                {/if}
                            </div>
                            <p class="tokens-refund">{translate}tokens_no_refund{/translate}</p>
                        </div>
                    </section>
                </div>

                {if $TokensHistory}
                    <section class="side-card tokens-history">
                        <div class="side-card-title">{translate}tokens_history_title{/translate}</div>
                        <div class="side-card-body">
                            <table>
                                <tr>
                                    <th>{translate}tokens_history_date{/translate}</th>
                                    <th class="num">{translate}tokens_history_tokens{/translate}</th>
                                    <th class="num">{translate}tokens_history_amount{/translate}</th>
                                </tr>
                                {foreach $TokensHistory as $purchase}
                                    <tr>
                                        <td>{$purchase.paid_at|date_format:'%Y-%m-%d'}</td>
                                        <td class="num">{$purchase.tokens_text}</td>
                                        <td class="num">{$purchase.amount|string_format:'%.2f'} {$purchase.currency|escape}</td>
                                    </tr>
                                {/foreach}
                            </table>
                        </div>
                    </section>
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
