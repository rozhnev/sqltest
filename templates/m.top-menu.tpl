<div class="header">
    <div class="top-menu">
        <div class="top-menu-left" style="width: 25vw; display: flex; align-items: center;">
            <a href="/{$Lang}/" target="_self"><h1 class="site-name">SQLtest</h1></a>
        </div>
        <div class="top-menu-right" style="width: 75vw; display: flex; justify-content: space-between; padding-right: 18px;">
            {include file='theme-switcher.tpl'}
            <div style="display: flex; min-width: 90px; margin: 12px; align-items: center; justify-content: center;">
                <a href="/{$Lang}/donate" target="_self" class="donate-btn shake" id="donate-btn">{translate}top_menu_donate{/translate}</a>
            </div>
            {include file='lang-switcher.tpl'}
        </div>
    </div>
</div>