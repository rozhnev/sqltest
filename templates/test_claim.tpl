{include file='short-header.tpl'}
<link rel="stylesheet" type="text/css" href="/about.css?{$VERSION}" media="all">
<body>
    <div class="container">
        <header>
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/test/{$TestData.id}/claim"}
            {else}
                {include file='top-menu.tpl' path="/test/{$TestData.id}/claim"}
            {/if}
        </header>
        <main>
            <div class="about">
                <div class="section top colored">
                    <div>
                        <h2>{translate}claim_my_prize{/translate}</h2>
                    </div>
                </div>
                <div class="section not-colored" style="height: 100%;">
                    <div style="display: flex; flex-direction: column; justify-content: center;">
                        {if $ClaimDone}
                            <p>{translate}prize_claim_success{/translate}</p>
                        {elseif $AlreadyClaimed}
                            <p>{translate}prize_claim_already_done{/translate}</p>
                            <p><strong>{translate}mariadb_prize_qr_code{/translate}:</strong></p>
                            <img src="{$AlreadyClaimed.qr_code_url}" alt="QR code" style="max-width: 220px; display: block; margin: 1rem auto;">
                            <p><code>{$AlreadyClaimed.identifier}</code></p>
                        {else}
                            {if !$CanClaim}
                                <p>{translate}mariadb_prize_claim_requires_three{/translate}</p>
                            {else}
                                <form method="post" action="/{$Lang}/test/{$TestData.id}/claim">
                                    {if !$UserSubscribed}
                                        <label style="display:flex; align-items:flex-start; gap:0.75rem; margin: 1rem 0;">
                                            <input type="checkbox" name="newsletter_opt_in" value="mariadb_newsletter">
                                            <span>{translate}mariadb_newsletter_checkbox_label{/translate}</span>
                                        </label>
                                    {/if}
                                    <div style="text-align: center; margin-top: 1.5rem;">
                                        <button type="submit" class="button green" style="display:inline-block; width:240px;">{translate}claim_my_prize{/translate}</button>
                                    </div>
                                </form>
                            {/if}
                        {/if}
                    </div>
                </div>
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
