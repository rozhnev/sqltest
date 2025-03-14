<div class="top-menu-left" style="width: 25vw; display: flex; align-items: center;">
    <a href="/{$Lang}/" target="_self"><h1 class="site-name">SQLtest</h1></a>
</div>
<div class="top-menu-buttons mobile">
    <a href="/{$Lang}/donate" target="_self" id="donate-btn" style="display: block; margin-right: 2.5rem;">
        <button class="button green">$</button>
    </a>
    {if $User->logged()}
        <button class="button blue" onclick="location.href = '/ru/logout';"><span>⎆</span></button>
    {else}
        <button id="showLoginWindowBtn" class="button blue" onClick="toggleLoginWindow()">⎆</button>
    {/if}
</div>
<div class="top-menu-switchers">
    {include file='lang-switcher.tpl'}
    {include file='theme-switcher.tpl'}
</div>