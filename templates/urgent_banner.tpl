<div id="urgent-banner" style="background:#c0392b; color:#fff; padding:0.75rem 1.5rem; text-align:center; display:flex; align-items:center; justify-content:center; gap:0.75rem; flex-wrap:wrap;">
    {include file="{$Lang}/urgent_banner.tpl"}
    <button onclick="document.getElementById('urgent-banner').style.display='none'; localStorage.setItem('urgent-banner-closed','1');" style="background:transparent; border:1px solid rgba(255,255,255,0.5); color:#fff; border-radius:4px; padding:0.15rem 0.6rem; cursor:pointer; font-size:0.9em;">✕</button>
</div>
<script>
    if (localStorage.getItem('urgent-banner-closed') === '1') {
        document.getElementById('urgent-banner').style.display = 'none';
    }
</script>
