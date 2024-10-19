{include file='short-header.tpl'}
    <body>
    <div class="full-container">
    <div class="header">
        <div class="top-menu">
            {include file='site-name.tpl'}
            <div style="display: flex; justify-content: center; min-width: 100px;">
                {include file='theme-switcher.tpl'}
                {include file='lang-switcher.tpl' path="/"}
            </div>
        </div>
    </div>
    <div class="container3">
        <h3 style="margin: 50vh auto; text-align: center;">{translate}error_message{/translate}</h3>
    </div>
{include file='footer.tpl'}