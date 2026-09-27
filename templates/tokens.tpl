{include file='short-header.tpl'}
{* AI tokens page (see TOKEN_PURCHASE_PLAN.md). Logic and markup live here; the text comes
   from $TokensContentTemplate ({lang}/tokens.tpl), picked by the "part" parameter. *}
{assign var=Text value=$TokensContentTemplate}
{capture name=email_placeholder}{include file=$Text part='email_placeholder'}{/capture}
{capture name=promo_code_placeholder}{include file=$Text part='promo_code_placeholder'}{/capture}
<style>
    /* The site's light theme sets --regular-text-color to white; text on the plain page background needs --question-text. */
    .tokens-page { color: var(--question-text); max-width: 640px; margin: 10vh auto; padding: 0 16px; }
    .tokens-page h2 { text-align: center; }
    .tokens-page ul { line-height: 1.7; }
    .tokens-balance { margin: 1.5rem 0; padding: 1rem; border: 1px solid var(--text-block-border-color); border-radius: 6px; font-size: 1.1em; }
    .tokens-actions { text-align: center; margin-top: 1.5rem; }
    .tokens-actions form { display: inline-block; }
    .tokens-note { font-size: 0.9em; }
    .tokens-message { margin: 1rem 0; padding: 0.75rem 1rem; border-left: 4px solid var(--accordion-hover); background: var(--code-result-background-color); }
    .tokens-message.error { border-left-color: var(--danger-text-color); }
    .tokens-email { display: flex; gap: 0.5rem; justify-content: center; flex-wrap: wrap; }
    .tokens-email input { min-width: 240px; padding: 0.5rem; border: 1px solid var(--text-block-border-color); border-radius: 4px; background: var(--body-background-color); color: var(--question-text); }
    .tokens-promo { margin-bottom: 1rem; }
    .tokens-promo summary { cursor: pointer; text-decoration: underline; }
    .tokens-promo input { margin-top: 0.5rem; min-width: 200px; padding: 0.5rem; border: 1px solid var(--text-block-border-color); border-radius: 4px; background: var(--body-background-color); color: var(--question-text); text-transform: uppercase; }
    .tokens-history { width: 100%; margin-top: 0.5rem; border-collapse: collapse; }
    .tokens-history th, .tokens-history td { padding: 0.4rem 0.5rem; border-bottom: 1px solid var(--text-block-border-color); text-align: left; }
    .tokens-history td.num, .tokens-history th.num { text-align: right; }
</style>
<body>
    <div class="container">
        <header>
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/tokens"}
            {else}
                {include file='top-menu.tpl' path="/tokens"}
            {/if}
        </header>
        <main>
            <div class="tokens-page">
                <h2>{include file=$Text part='title'}</h2>
                {include file=$Text part='intro'}

                {if $TokensFlash}
                    <div class="tokens-message {$TokensFlash.type|escape}">{$TokensFlash.message|escape}</div>
                {/if}

                {if !$User->logged()}
                    <div class="tokens-actions">
                        <p>{include file=$Text part='login_prompt'}</p>
                        <p><a class="button green" href="" onClick="toggleLoginWindow(); return false;">{include file=$Text part='login_button'}</a></p>
                    </div>
                {else}
                    {if $TokensPaymentReturn}
                        <div class="tokens-message{if $TokensPaymentReturn != 'success'} error{/if}">
                            {include file=$Text part="payment_{$TokensPaymentReturn}"}
                        </div>
                        {if $TokensPaymentReturn == 'success'}
                            {* The webhook can arrive after the redirect: reload once without the parameter *}
                            <meta http-equiv="refresh" content="5;url=/{$Lang}/tokens">
                        {/if}
                    {/if}

                    <div class="tokens-balance">{include file=$Text part='balance'}</div>

                    <div class="tokens-actions">
                        {if !$TokensCheckoutAvailable}
                            <p>{include file=$Text part='unavailable'}</p>
                        {elseif !$UserEmail}
                            <p>{include file=$Text part='email_prompt'}</p>
                            <form method="post" action="/{$Lang}/tokens/email" class="tokens-email">
                                <input type="email" name="email" required placeholder="{$smarty.capture.email_placeholder|trim|escape}">
                                <button type="submit" class="button">{include file=$Text part='email_save'}</button>
                            </form>
                        {else}
                            <form method="post" action="/{$Lang}/tokens/checkout">
                                <details class="tokens-promo">
                                    <summary>{include file=$Text part='promo_code_label'}</summary>
                                    <input type="text" name="promo_code" maxlength="36" pattern="[A-Za-z0-9_\-]{ldelim}3,36{rdelim}" autocomplete="off" placeholder="{$smarty.capture.promo_code_placeholder|trim|escape}">
                                </details>
                                <button type="submit" class="button blue">{include file=$Text part='buy_button'}</button>
                            </form>
                            <p class="tokens-note">{include file=$Text part='checkout_note'}</p>
                        {/if}
                    </div>

                    {if $TokensHistory}
                        <h3>{include file=$Text part='history_title'}</h3>
                        <table class="tokens-history">
                            <tr>
                                <th>{include file=$Text part='history_date'}</th>
                                <th class="num">{include file=$Text part='history_tokens'}</th>
                                <th class="num">{include file=$Text part='history_amount'}</th>
                            </tr>
                            {foreach $TokensHistory as $purchase}
                                <tr>
                                    <td>{$purchase.paid_at|date_format:'%Y-%m-%d'}</td>
                                    <td class="num">{$purchase.tokens_text}</td>
                                    <td class="num">{$purchase.amount|string_format:'%.2f'} {$purchase.currency|escape}</td>
                                </tr>
                            {/foreach}
                        </table>
                    {/if}
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
