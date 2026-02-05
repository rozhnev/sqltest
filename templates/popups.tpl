<div class="toast" id="toast">{translate}toast_sql_copied_to_buffer{/translate}</div>

<!-- Email Login/Register Popup -->
<div id="emailLoginPopup" class="email-login-popup" style="display: none;">
    <div class="email-login-popup-content">
        <button onclick="closeEmailLoginPopUp()" class="email-login-popup-close">&times;</button>
        
        <!-- Login Form -->
        <div id="loginFormContainer">
            <h2 class="email-login-popup-title">{translate}login_form_title{/translate}</h2>
            <div id="loginErrorMessage" class="email-login-error-message" style="display: none;"></div>
            <form id="emailLoginForm" onsubmit="handleEmailLogin(event)">
                <div class="email-login-input-group">
                    <input type="email" id="loginEmail" name="email" placeholder="{translate}login_email_placeholder{/translate}" required 
                           class="email-login-input">
                </div>
                <div class="email-login-input-group">
                    <input type="password" id="loginPassword" name="password" placeholder="{translate}login_password_placeholder{/translate}" required 
                           class="email-login-input">
                </div>
                <button type="submit" class="email-login-submit-btn">
                    {translate}login_button{/translate}
                </button>
            </form>
            <div class="email-login-switch-text">
                <span>{translate}dont_have_account{/translate} </span>
                <a href="#" onclick="switchToRegister(event)" class="email-login-link">{translate}sign_up{/translate}</a>
            </div>
        </div>

        <!-- Register Form -->
        <div id="registerFormContainer" style="display: none;">
            <h2 class="email-login-popup-title">{translate}register_form_title{/translate}</h2>
            <div id="registerErrorMessage" class="email-login-error-message" style="display: none;"></div>
            <form id="emailRegisterForm" onsubmit="handleEmailRegister(event)">
                <div class="email-login-input-group">
                    <input type="text" id="registerName" name="name" placeholder="{translate}name_placeholder{/translate}" required 
                           class="email-login-input">
                </div>
                <div class="email-login-input-group">
                    <input type="email" id="registerEmail" name="email" placeholder="{translate}registration_email_placeholder{/translate}" required 
                           class="email-login-input">
                </div>
                <div class="email-login-input-group">
                    <input type="password" id="registerPassword" name="password" placeholder="{translate}registration_password_placeholder{/translate}" required minlength="6"
                           class="email-login-input">
                </div>
                <div class="email-login-input-group">
                    <input type="password" id="registerPasswordConfirm" name="passwordConfirm" placeholder="{translate}registration_password_confirm_placeholder{/translate}" required minlength="6"
                           class="email-login-input">
                </div>
                <button type="submit" class="email-login-submit-btn">
                    {translate}register_button{/translate}
                </button>
            </form>
            <div class="email-login-switch-text">
                <span>{translate}already_have_account{/translate} </span>
                <a href="#" onclick="switchToLogin(event)" class="email-login-link">{translate}log_in{/translate}</a>
            </div>
        </div>
    </div>
</div>

<script>
// Close popup when clicking outside
document.getElementById('emailLoginPopup')?.addEventListener('click', function(event) {
    if (event.target === this) {
        closeEmailLoginPopUp();
    }
});
</script>

{* <div class="login-popup" id="login-popup">
    <div class="login-popup-header">
        <span class="login-popup-title">{translate}choose_login_method{/translate}</span>
        <span class="pointer-hand" onClick="toggleLoginWindow()">X</span>
    </div>
    <div style="padding: 0 10px";>
    {include file='login-buttons.tpl'}
    </div>
    <div class="login-popup-footer">
        {translate}login_popup_footer{/translate}
    </div>
</div> *}