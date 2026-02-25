<div class="footer-links">
    <div>
        © 2023-2026 SQLtest.online
    </div>
    <div>
        {translate}footer_have_questions{/translate}
        <a target="_blank" href="{translate}telegram_link{/translate}" class=""> 
            <span class="tg-icon">
                <span class=""> </span>
            </span>
            {translate}footer_ask_in_telegram{/translate}
        </a>
        <a href="mailto:support@sqltest.online" class="email-link" style="margin-left: 1em; vertical-align: middle;">
            <span style="display: inline-block; vertical-align: middle; margin-top: 5px;">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="4" width="20" height="16" rx="2"/><polyline points="22,6 12,13 2,6"/></svg>
            </span>
            support@sqltest.online
        </a>
    </div>
    <!-- ShareThis BEGIN -->
    <div class="sharethis-inline-share-buttons"></div>
    <!-- ShareThis END -->
    {* <div>
        <script src="https://yastatic.net/share2/share.js"></script>
        {translate}footer_like_site{/translate}
        <div class="ya-share2" data-curtain data-services="telegram,twitter,whatsapp,linkedin,reddit"></div>
    </div> *}
    <div>
        <a href="/{$Lang}/about" target="_self">{translate}footer_about{/translate}</a>
        <a href="#" target="_self" onclick="window.ceadConsent && window.ceadConsent.toggleBanner(); return false;">Cookie Settings</a>
        <a href="/{$Lang}/privacy-policy" target="_self">{translate}footer_privacy_policy{/translate}</a>
        <a href="/{$Lang}/books" target="_self">{translate}footer_books{/translate}</a>
        <a href="/{$Lang}/lesson/getting-started/introduction-to-databases" target="_self">{translate}lessons{/translate}</a>
        <a href="/{$Lang}/playground/" target="_self">{translate}playground{/translate}</a>
    </div>
</div>
<script>
    {if $MobileView}
        {literal}
        window.yaContextCb.push(()=>{
            Ya.Context.AdvManager.render({
                "blockId": "R-A-4716552-3",
                "type": "floorAd",
                "platform": "touch"
            })
        })
        {/literal}
    {else}
        {literal}
            if (document.getElementById('yandex_rtb_R-A-4716552-2')) {
                window.yaContextCb.push(()=>{
                    Ya.Context.AdvManager.render({
                        "blockId": "R-A-4716552-2",
                        "renderTo": "yandex_rtb_R-A-4716552-2",
                        darkTheme: window.UIConfig.theme === 'dark'
                    })
                });
            }
            if (document.getElementById('yandex_rtb_R-A-4716552-4')) {
                window.yaContextCb.push(()=>{
                    Ya.Context.AdvManager.render({
                        "blockId": "R-A-4716552-4",
                        "renderTo": "yandex_rtb_R-A-4716552-4",
                        darkTheme: window.UIConfig.theme === 'dark'
                    })
                })
            }
            if (document.getElementById('yandex_rtb_R-A-4716552-7')) {
                window.yaContextCb.push(()=>{
                    Ya.Context.AdvManager.render({
                        "blockId": "R-A-4716552-4",
                        "renderTo": "yandex_rtb_R-A-4716552-7",
                        darkTheme: window.UIConfig.theme === 'dark'
                    })
                })
            }
        {/literal}
    {/if}
    window.cead = {
        cookie: 'consent',
        cookies: [
            '_ga',
            new RegExp('_ga_.+'),
            new RegExp('_ym_.+')
        ]
    }
</script>
<script src="/js/cead.js"></script>
