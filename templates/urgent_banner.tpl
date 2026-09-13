<script>
    (function () {
        try {
            if (localStorage.getItem('urgent-banner-closed') === '{$SHOW_URGENT_BANNER}') {
                document.documentElement.classList.add('urgent-banner-hidden');
            }
        } catch (error) {
            // Keep the banner visible if localStorage is unavailable.
        }
    })();
</script>
<style>
    html:not(.urgent-banner-hidden) .container:has(> #urgent-banner),
    html:not(.urgent-banner-hidden) .mobile-container:has(> #urgent-banner) {
        grid-template-rows: auto auto 1fr auto;
    }

    html:not(.urgent-banner-hidden) .container > #urgent-banner,
    html:not(.urgent-banner-hidden) .mobile-container > #urgent-banner {
        grid-column: 1 / -1;
    }

    html.urgent-banner-hidden #urgent-banner {
        display: none !important;
    }
</style>
<div id="urgent-banner" style="background:{$UrgentBanner.background}; color:{$UrgentBanner.text_color}; padding:0.75rem 1.5rem; text-align:center; display:flex; align-items:center; justify-content:center; gap:0.75rem; flex-wrap:wrap;">
    {$UrgentBanner.html nofilter}
    <button onclick="document.getElementById('urgent-banner').style.display='none'; localStorage.setItem('urgent-banner-closed','{$SHOW_URGENT_BANNER}');" style="background:transparent; border:1px solid rgba(255,255,255,0.5); color:#fff; border-radius:4px; padding:0.15rem 0.6rem; cursor:pointer; font-size:0.9em;">✕</button>
</div>
