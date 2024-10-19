<div class="toast" id="toast">{translate}toast_sql_copied_to_buffer{/translate}</div>
<div class="login-popup" id="login-popup">
    <div class="login-popup-header">
        <span class="login-popup-title">{translate}choose_login_method{/translate}</span>
        <span class="pointer-hand" onClick="toggleLoginWindow()">X</span>
    </div>
    {include file='login_buttons.tpl'}
    <div class="login-popup-footer">
        {translate}login_popup_footer{/translate}
    </div>
</div>