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
    html.urgent-banner-hidden #urgent-banner {
        display: none !important;
    }
</style>
{* <div id="urgent-banner" style="background:linear-gradient(90deg, #7f1d1d 0%, #b91c1c 45%, #dc2626 100%); color:#fff; padding:0.75rem 1.5rem; text-align:center; display:flex; align-items:center; justify-content:center; gap:0.75rem; flex-wrap:wrap;"> *}
<div id="urgent-banner" style="background:linear-gradient(90deg, #14532d 0%, #15803d 45%, #16a34a 100%); color:#fff; padding:0.75rem 1.5rem; text-align:center; display:flex; align-items:center; justify-content:center; gap:0.75rem; flex-wrap:wrap;">
    {include file="{$Lang}/urgent_banner.tpl"}
    <button onclick="document.getElementById('urgent-banner').style.display='none'; localStorage.setItem('urgent-banner-closed','{$SHOW_URGENT_BANNER}');" style="background:transparent; border:1px solid rgba(255,255,255,0.5); color:#fff; border-radius:4px; padding:0.15rem 0.6rem; cursor:pointer; font-size:0.9em;">✕</button>
</div>
