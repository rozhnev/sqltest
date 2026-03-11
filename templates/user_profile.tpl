{assign var="PageTitle" value="{translate}profile_page_title{/translate}"}
{assign var="PageDescription" value="{translate}profile_page_description{/translate}"}
{assign var="UseTubulator" value=true}
{include file='short-header.tpl'}
<link rel="stylesheet" type="text/css" href="/about.css?{$VERSION}" media="all">
<!-- Add to head section -->
<link href="https://unpkg.com/tabulator-tables@5.5.2/dist/css/tabulator.min.css" rel="stylesheet">
<script type="text/javascript" src="https://unpkg.com/tabulator-tables@5.5.2/dist/js/tabulator.min.js"></script>
<body>
    {include file='popups.tpl'}
    {if $MobileView}
        
    {else}
        <div class="container">
            <header>
                {include file='top-menu.tpl' path="/user/profile"}
            </header>
            <main>
                <div class="about">
                    <div class="section top colored">
                        <div>
                        <h2>{translate}profile_page_title{/translate}</h2>
                        </div>
                    </div>
                    <div class="section colored">
                        <div style="width: 100%;">
                            <div class="profile">
                                <div class="profile-field">
                                    <span class="profile-field-label" id="nickname-label">{translate}nickname{/translate}:</span>
                                    <div class="nickname-container">
                                        <span id="nickname-display" class="nickname">{$User->nickname()}</span>
                                        <input type="text" id="nickname-input" class="nickname-input hidden" value="{$User->nickname()}" maxlength="50">
                                        <div class="profile-actions">
                                            <button id="nickname-edit-btn" class="text-button edit-btn" onclick="toggleFieldEdit('nickname', true)" title="{translate}edit_nickname{/translate}"></button>
                                            <div id="nickname-save-cancel-btns" class="hidden save-cancel-btns">
                                                <button class="text-button green save-btn" onclick="saveNickname()" title="{translate}save_changes{/translate}"></button>
                                                <button class="text-button red cancel-btn" onclick="toggleFieldEdit('nickname', false)" title="{translate}cancel{/translate}"></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="profile-field">
                                    <span class="profile-field-label">{translate}full_name{/translate}:</span>
                                    <div class="nickname-container">
                                        <span id="fullname-display" class="nickname">{$User->getFullName()|escape}</span>
                                        <input type="text" id="fullname-input" class="nickname-input hidden" value="{$User->getFullName()|escape}" maxlength="100">
                                        <div class="profile-actions">
                                            <button id="fullname-edit-btn" class="text-button edit-btn" onclick="toggleFieldEdit('fullname', true)" title="{translate}edit_full_name{/translate}"></button>
                                            <div id="fullname-save-cancel-btns" class="hidden save-cancel-btns">
                                                <button class="text-button green save-btn" onclick="saveFullName()" title="{translate}save_changes{/translate}"></button>
                                                <button class="text-button red cancel-btn" onclick="toggleFieldEdit('fullname', false)" title="{translate}cancel{/translate}"></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="profile-field">
                                    <span class="profile-field-label" id="grade-label">{translate}your_grade{/translate}:</span>
                                    {$User->grade()} SQL Developer
                                </div>
                                <div class="profile-field">
                                    <span class="profile-field-label">
                                        {translate}email{/translate}:{if $EmailVerified}<span style="color: green;font-size: larger;" title="{translate}email_verified{/translate}">&nbsp; ✓</span>{/if}</span>
                                    <div class="nickname-container">
                                        <span id="email-display" class="nickname">{$UserEmail|escape}</span>
                                        <input type="email" id="profile-email-input" class="nickname-input hidden" value="{$UserEmail|escape}" placeholder="{translate}email_placeholder{/translate}">
                                        <div class="profile-actions">
                                            <button id="email-edit-btn" class="text-button edit-btn" onclick="toggleFieldEdit('email', true)" title="{translate}edit_email{/translate}"></button>
                                            <div id="email-save-cancel-btns" class="hidden save-cancel-btns">
                                                <button id="save-email-btn" class="text-button green save-btn" onclick="saveEmailOnly()" title="{translate}save_changes{/translate}"></button>
                                                <button class="text-button red cancel-btn" onclick="toggleFieldEdit('email', false)" title="{translate}cancel{/translate}"></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id ="email-verification-field" class="profile-field{if !$UserEmail || $EmailVerified} hidden{/if}">
                                    <span class="profile-field-label">{translate}profile_email_verification_label{/translate}:</span>
                                    <div class="submission-requirements-actions">
                                        <button id="send-verification-code-btn" class="button green" type="button" onclick="sendVerificationCode()">{translate}send_verification_code{/translate}</button>
                                        <input id="verification-code-input" type="text" class="nickname-input" maxlength="6" placeholder="{translate}verification_code_placeholder{/translate}" />
                                        <button id="confirm-verification-code-btn" class="button green" type="button" onclick="confirmVerificationCode()">{translate}confirm_code{/translate}</button>
                                    </div>
                                </div>
                                <div class="profile-field">
                                    <span class="profile-field-label">{translate}password{/translate}:</span>
                                    <div class="nickname-container">
                                        <span id="password-display" class="nickname">********</span>
                                        <div id="password-edit-container" class="hidden" style="display: flex; flex-direction: column; gap: 0.5rem;">
                                            <input id="profile-password-input" name="password" type="password" placeholder="{translate}new_password{/translate}" autocomplete="new-password" class="nickname-input" />
                                            <input id="profile-password-confirm-input" name="password_confirm" type="password" placeholder="{translate}confirm_password{/translate}" autocomplete="new-password" class="nickname-input" />
                                        </div>
                                        <div class="profile-actions">
                                            <button id="password-edit-btn" class="text-button edit-btn" onclick="toggleFieldEdit('password', true)" title="{translate}edit_password{/translate}"></button>
                                            <div id="password-save-cancel-btns" class="hidden save-cancel-btns">
                                                <button id="save-password-btn" class="text-button save-btn" onclick="savePasswordOnly()" title="{translate}save_changes{/translate}"></button>
                                                <button class="text-button red cancel-btn" onclick="toggleFieldEdit('password', false)" title="{translate}cancel{/translate}"></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="section colored" style="height: 100%;">
                        <div style="width: 100%;">
                            <h2>{translate}your_achievements{/translate}</h2>
                        </div>

                        <div class="profile-achievements">
                            {if !isset($Achievements) || $Achievements|@count == 0}
                                <div class="profile-achievements-empty">—</div>
                            {else}
                                {foreach $Achievements as $a}
                                    <div class="profile-achievement">
                                        <span class="pa-date">{$a.earned_at}</span>
                                        <a class="pa-title pa-title-link"
                                            href="/{$Lang}/achievement/{$a.user_achievement_id}"
                                            target="_blank" rel="noopener noreferrer"
                                            title="{translate}view_achievement{/translate}">
                                            {$a.title|escape}
                                        </a>
                                    </div>
                                {/foreach}
                            {/if}
                        </div>
                    </div>
                    <div class="section colored" style="height: 100%;">
                        <div style="width: 100%;">
                            <h2>{translate}task_submissions{/translate}</h2>
                        </div>
                        <div class="submission-requirements">
                            <div id="submission-requirements-status" class="submission-requirements-status">{translate}loading_submission_requirements{/translate}</div>
                        </div>
                        <div class="submission-form-grid">
                            <div>
                                <label for="submission-db-template">{translate}database_template{/translate}:</label>
                                <select id="submission-db-template" class="nickname-input">
                                    <option value="sakila">Sakila (MySQL)</option>
                                    <option value="bookings">Bookings (PostgreSQL)</option>
                                    <option value="adventureworks">AdventureWorks (SQL Server)</option>
                                    <option value="employees">Employees (Firebird)</option>
                                    <option value="querynomicon">Querynomicon (SQLite)</option>
                                </select>
                            </div>
                            <input id="submission-title" type="text" class="nickname-input" maxlength="160" placeholder="{translate}title{/translate}" />
                            <textarea id="submission-task" class="nickname-input submission-textarea" maxlength="5000" placeholder="{translate}submission_task_description_plain{/translate}"></textarea>
                            <textarea id="submission-hint" class="nickname-input submission-textarea" maxlength="2000" placeholder="{translate}submission_hint_plain{/translate}"></textarea>
                            <textarea id="submission-solution-query" class="nickname-input submission-textarea" maxlength="15000" placeholder="{translate}submission_reference_solution_sql_query{/translate}"></textarea>
                            <div class="submission-actions">
                                <div class="submission-requirements-actions">
                                    <label>
                                        <input id="submission-agreement-checkbox" type="checkbox" />
                                        {translate}submission_accept_i{/translate} <a href="/{$Lang}/user-agreement" target="_blank">{translate}submission_user_agreement{/translate}</a> {* {translate}submission_and{/translate} <a href="/{$Lang}/privacy-policy" target="_blank">{translate}footer_privacy_policy{/translate}</a>. *}
                                    </label>
                                </div>
                                <button id="submission-save-btn" class="button green" type="button" onclick="saveTaskSubmission()">{translate}submit{/translate}</button>
                                <button id="submission-cancel-btn" class="text-button red hidden" type="button" onclick="cancelTaskSubmissionEdit()">{translate}cancel_edit{/translate}</button>
                            </div>
                            <div id="submission-form-status" class="profile-achievements-empty"></div>
                        </div>
                        <div id="submissions-table" class="submissions-tabulator"></div>
                    </div>
                    <div class="section colored" style="height: 100%;">
                        <div style="width: 100%;">
                            <h2>{translate}tasks{/translate}</h2>
                        </div>
                        <div id="questions-table"></div>
                    </div>
                    <div class="section colored" style="height: 100%;">
                        <div style="width: 100%;">
                            <h2>{translate}tests{/translate}</h2>
                        </div>
                        <div id="tests-table"></div>
                    </div>
                </div>
            </main>
            <footer>               
                {include file='footer.tpl'}
            </footer>
        </div>
    {/if}
    {include file='counters.tpl'}
</body>
</html>
{literal}
<style>
.profile {
    display: flex;
    flex-direction: column !important;
    gap: 1rem;
    width: 100%;
}
.profile-field {
    color: var(--ligth-h2-color);
    display: flex;
    align-items: center;
    column-gap: 1rem;
}
.profile-field-inline {
    flex-wrap: wrap;
}
.profile-field-inline input {
    flex: 1 1 250px;
    border: 1px solid var(--text-block-border-color);
    border-radius: 4px;
    padding: 0.35rem 0.5rem;
    background: var(--block-background-color);
    color: var(--regular-text-color);
}
.profile-field-actions {
    justify-content: flex-end;
    width: 100%;
}
.profile-field-label {
    font-size: 1.1em;
    color: var(--ligth-h2-color);
    font-weight: bold;
    min-width: 5rem;
}

.nickname-container {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.nickname {
    font-size: 1.1em;
    padding: 0.25rem 0;
}

.nickname-input {
    font-size: 1.1em;
    padding: 0.25rem;
    border: 1px solid var(--text-block-border-color);
    border-radius: 4px;
}

.profile-actions {
    display: flex;
    gap: 0.5rem;
}
.save-cancel-btns {
    display: flex;
    gap: 0.5rem;
}
.save-btn {
    width: 24px;
    height: 24px;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%2316a34a' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M5 13l4 4L19 7'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: center;
    border: 1px solid #16a34a;
    border-radius: 3px;
}
.cancel-btn {
    width: 24px;
    height: 24px;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%23E60000' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M6 18L18 6M6 6l12 12'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: center;
    border: 1px solid;
    border-radius: 3px;
}
.edit-btn {
    width: 24px;
    height: 24px;
    background-image: url("data:image/svg+xml,%3Csvg width='16' height='16' viewBox='0 0 24 24' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M16.474 5.408l2.118 2.117m-.756-3.982L12.109 9.27a2.118 2.118 0 00-.58 1.082L11 13l2.648-.53c.41-.082.786-.283 1.082-.58l5.727-5.727a1.853 1.853 0 000-2.621 1.853 1.853 0 00-2.621 0z' stroke='%230069E6' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/%3E%3Cpath d='M19 15v3a2 2 0 01-2 2H6a2 2 0 01-2-2V7a2 2 0 012-2h3' stroke='%230069E6' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: center;
    border: 1px solid #0069E6;
    border-radius: 3px;
}
.hidden {
    display: none !important;
}

/* Custom Tabulator theme matching your site */
.tabulator {
    background-color: var(--ligth-panel-bg-color);
    border: none;
}

.tabulator .tabulator-header {
    background-color: var(--ligth-panel-bg-color) !important;
    border-bottom: 1px solid var(--text-block-border-color);
    border: 1px solid var(--text-block-border-color);
    border-radius: 6px;
}
.tabulator .tabulator-headers .tabulator-col {
    background-color: var(--ligth-panel-bg-color) !important;
    color: var(--ligth-h2-color);
    padding: 8px;
}
.tabulator .tabulator-row {
    border-bottom: 1px solid var(--text-block-border-color);
    color: darkslategray;
}

.tabulator .tabulator-row:hover {
    background-color: var(--menu-button-background-color);
    color: white;
    cursor: pointer;
}
/* Add to your existing CSS */
.tabulator .tabulator-row.tabulator-selectable:hover {
    background-color: var(--menu-button-background-color);
    color: white;
}

.tabulator .tabulator-row .tabulator-cell[tabulator-field="solved"] {
    text-align: center;
}

.tabulator .tabulator-row .tabulator-cell[tabulator-field="favorite"] {
    text-align: center;
}

/* Customize pagination buttons */
.tabulator .tabulator-footer {
    border: none;
    background-color: var(--ligth-panel-bg-color);
}
.tabulator .tabulator-footer .tabulator-paginator {
    color: var(--regular-text-color);
}

.tabulator .tabulator-footer .tabulator-page {
    background-color: var(--block-background-color);
    color: var(--regular-text-color);
    border: 1px solid var(--text-block-border-color);
}

.tabulator .tabulator-footer .tabulator-page.active {
    background-color: var(--menu-button-background-color);
    color: white;
}

.profile-achievements {
    display: flex;
    flex-direction: column;
    gap: 8px;
    width: 100%;
}

.profile-achievement {
    display: flex;
    gap: 12px;
    align-items: baseline;
    padding: 10px 12px;
    border: 1px solid var(--text-block-border-color);
    border-radius: 10px;
    background: var(--block-background-color);
    color: var(--regular-text-color);
}

.profile-achievement a {
    color: var(--regular-text-color);
}

.pa-date {
    flex: 0 0 auto;
    opacity: 0.85;
    font-variant-numeric: tabular-nums;
    white-space: nowrap;
}

.pa-title {
    flex: 1 1 auto;
    min-width: 0;
    font-weight: 600;
    overflow-wrap: anywhere;
}

.profile-achievements-empty {
    opacity: 0.7;
    padding: 8px 2px;
}

.submission-form-grid {
    display: grid;
    gap: 0.75rem;
    width: 100%;
}

.submission-requirements {
    display: grid;
    gap: 0.5rem;
    width: 100%;
    margin-bottom: 0.75rem;
}

.submission-requirements-status {
    font-size: 0.95rem;
}

.submission-requirements-actions {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    align-items: center;
}

.submission-textarea {
    width: 100%;
    min-height: 100px;
    resize: vertical;
    background: var(--text-block-background-color);
    color: var(--question-text);
    border: 1px solid var(--text-block-border-color);
}

.submission-actions {
    display: flex;
    gap: 0.5rem;
    align-items: center;
}

.submission-item {
    border: 1px solid var(--text-block-border-color);
    border-radius: 10px;
    background: var(--block-background-color);
    padding: 10px 12px;
}

.submission-header {
    display: flex;
    justify-content: space-between;
    gap: 1rem;
    font-weight: 600;
}

.submission-meta {
    opacity: 0.8;
    font-size: 0.9rem;
    margin-top: 0.3rem;
}

.submission-note {
    margin-top: 0.35rem;
}

.submissions-tabulator {
    width: 100%;
}

</style>

<script>
function toggleFieldEdit(fieldName, show) {
    const display = document.getElementById(`${fieldName}-display`);
    const editBtn = document.getElementById(`${fieldName}-edit-btn`);
    const actionBtns = document.getElementById(`${fieldName}-save-cancel-btns`);

    if (fieldName === 'password') {
        const container = document.getElementById('password-edit-container');
        const passInput = document.getElementById('profile-password-input');
        const confirmInput = document.getElementById('profile-password-confirm-input');

        if (show) {
            display.classList.add('hidden');
            container.classList.remove('hidden');
            editBtn.classList.add('hidden');
            actionBtns.classList.remove('hidden');
            passInput.value = '';
            confirmInput.value = '';
            passInput.focus();
        } else {
            display.classList.remove('hidden');
            container.classList.add('hidden');
            editBtn.classList.remove('hidden');
            actionBtns.classList.add('hidden');
            passInput.value = '';
            confirmInput.value = '';
        }
    } else {
        const input = document.getElementById(fieldName === 'email' ? 'profile-email-input' : `${fieldName}-input`);

        if (show) {
            display.classList.add('hidden');
            input.classList.remove('hidden');
            editBtn.classList.add('hidden');
            actionBtns.classList.remove('hidden');
            input.focus();
            input.select();
        } else {
            display.classList.remove('hidden');
            input.classList.add('hidden');
            editBtn.classList.remove('hidden');
            actionBtns.classList.add('hidden');
            input.value = display.textContent;
        }
    }
}

function saveNickname() {
    const display = document.getElementById('nickname-display');
    const input = document.getElementById('nickname-input');
    const newNickname = input.value.trim();

    if (newNickname && newNickname !== display.textContent) {
        fetch(`/${lang}/user/update`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ nickname: newNickname })
        })
        .then(response => response.json())
        .then(data => {
            if (data.ok) {
                display.textContent = newNickname;
                toggleFieldEdit('nickname', false);
                showToast('info', '{/literal}{translate}nickname_updated{/translate}{literal}');
            } else {
                showToast('error', data.error || '{/literal}{translate}update_failed{/translate}{literal}');
            }
        })
        .catch(error => {
            showToast('error', '{/literal}{translate}update_failed{/translate}{literal}');
            console.error('Error:', error);
        });
    } else {
        toggleFieldEdit('nickname', false);
    }
}

function saveFullName() {
    const display = document.getElementById('fullname-display');
    const input = document.getElementById('fullname-input');
    const newFullName = input.value.trim();

    if (newFullName !== display.textContent) {
        fetch(`/${lang}/user/update`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ full_name: newFullName })
        })
        .then(response => response.json())
        .then(data => {
            if (data.ok) {
                display.textContent = newFullName;
                toggleFieldEdit('fullname', false);
                showToast('info', '{/literal}{translate}fullname_updated{/translate}{literal}');
            } else {
                showToast('error', data.error || '{/literal}{translate}update_failed{/translate}{literal}');
            }
        })
        .catch(error => {
            showToast('error', '{/literal}{translate}update_failed{/translate}{literal}');
            console.error('Error:', error);
        });
    } else {
        toggleFieldEdit('fullname', false);
    }
}

const profileEmailInput = document.getElementById('profile-email-input');
const saveEmailButton = document.getElementById('save-email-btn');
let profileEmailCached = profileEmailInput ? profileEmailInput.value.trim() : '';

function saveEmailOnly() {
    if (!profileEmailInput || !saveEmailButton) {
        return;
    }

    const display = document.getElementById('email-display');
    const newEmail = profileEmailInput.value.trim();

    if (!newEmail) {
        showToast('error', '{/literal}{translate}email_required{/translate}{literal}');
        return;
    }

    if (newEmail === profileEmailCached) {
        toggleFieldEdit('email', false);
        return;
    }

    saveEmailButton.disabled = true;
    fetch(`/${lang}/user/update`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email: newEmail })
    })
        .then(response => response.json())
        .then(data => {
            if (data.ok) {
                profileEmailCached = newEmail;
                display.textContent = newEmail;
                toggleFieldEdit('email', false);
                showToast('info', data.message || '{/literal}{translate}profile_update_success{/translate}{literal}');
                if (!data.verified) {
                    document.getElementById('email-verification-field').classList.remove('hidden');
                }
            } else {
                showToast('error', data.error || '{/literal}{translate}update_failed{/translate}{literal}');
            }
        })
        .catch(() => {
            showToast('error', '{/literal}{translate}update_failed{/translate}{literal}');
        })
        .finally(() => {
            saveEmailButton.disabled = false;
        });
}

function savePasswordOnly() {
    const passInput = document.getElementById('profile-password-input');
    const confirmInput = document.getElementById('profile-password-confirm-input');
    const saveBtn = document.getElementById('save-password-btn');

    const password = passInput.value;
    const confirm = confirmInput.value;

    if (!password) {
        toggleFieldEdit('password', false);
        return;
    }

    if (password !== confirm) {
        showToast('error', '{/literal}{translate}passwords_dont_match{/translate}{literal}');
        return;
    }

    saveBtn.disabled = true;
    fetch(`/${lang}/user/update`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ password: password })
    })
    .then(response => response.json())
    .then(data => {
        if (data.ok) {
            toggleFieldEdit('password', false);
            showToast('info', data.message || '{/literal}{translate}profile_update_success{/translate}{literal}');
        } else {
            showToast('error', data.error || '{/literal}{translate}update_failed{/translate}{literal}');
        }
    })
    .catch(() => {
        showToast('error', '{/literal}{translate}update_failed{/translate}{literal}');
    })
    .finally(() => {
        saveBtn.disabled = false;
    });
}

const taskSubmissionState = {
    submissions: [],
    editingId: 0,
    requirements: {
        email: '',
        email_verified: false,
        agreement_accepted: false,
        has_submissions: false
    }
};
let submissionsTable = null;

function escapeHtml(value) {
    return String(value || '')
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#039;');
}

function getTaskSubmissionPayload() {
    return {
        agreement: document.getElementById('submission-agreement-checkbox').checked,
        title: document.getElementById('submission-title').value.trim(),
        task: document.getElementById('submission-task').value.trim(),
        hint: document.getElementById('submission-hint').value.trim(),
        solution_query: document.getElementById('submission-solution-query').value.trim(),
        db_template: document.getElementById('submission-db-template').value.trim() || 'sakila',
        db: document.getElementById('submission-db-template').value.trim() || 'sakila'
    };
}

function setTaskSubmissionFormStatus(message) {
    document.getElementById('submission-form-status').textContent = message || '';
}

function resetTaskSubmissionForm() {
    taskSubmissionState.editingId = 0;
    document.getElementById('submission-title').value = '';
    document.getElementById('submission-task').value = '';
    document.getElementById('submission-hint').value = '';
    document.getElementById('submission-solution-query').value = '';
    document.getElementById('submission-db-template').value = 'sakila';
    document.getElementById('submission-save-btn').textContent = '{/literal}{translate}submit{/translate}{literal}';
    document.getElementById('submission-cancel-btn').classList.add('hidden');
}

function renderSubmissionRequirements() {
    const statusNode = document.getElementById('submission-requirements-status');
    if (!statusNode) {
        return;
    }

    const email = taskSubmissionState.requirements.email || '';
    const emailVerified = Boolean(taskSubmissionState.requirements.email_verified);
    const agreementAccepted = Boolean(taskSubmissionState.requirements.agreement_accepted);
    const hasSubmissions = Boolean(taskSubmissionState.requirements.has_submissions);

    statusNode.textContent = hasSubmissions
        ? `{/literal}{translate}submission_requirements_satisfied{/translate}{literal}`
        : `{/literal}{translate}submission_first_requirements{/translate}{literal} - {/literal}{translate}email{/translate}{literal}: ${email || '{/literal}{translate}submission_not_set{/translate}{literal}'}; {/literal}{translate}submission_verified{/translate}{literal}: ${emailVerified ? '{/literal}{translate}submission_yes{/translate}{literal}' : '{/literal}{translate}submission_no{/translate}{literal}'}; `;

    const agreementCheckbox = document.getElementById('submission-agreement-checkbox');
    if (agreementCheckbox) {
        agreementCheckbox.checked = agreementAccepted;
    }

    // document.getElementById('accept-agreement-btn').disabled = agreementAccepted;
    // document.getElementById('confirm-verification-code-btn').disabled = emailVerified;
    // document.getElementById('verification-code-input').disabled = emailVerified;

    // const saveButton = document.getElementById('submission-save-btn');
    // if (!taskSubmissionState.editingId) {
    //     saveButton.disabled = firstSubmissionLocked;
    // }
}

function loadSubmissionRequirements() {
    if (!document.getElementById('submission-requirements-status')) {
        return Promise.resolve();
    }

    return fetch(`/${lang}/user/submission-requirements`, {
        method: 'GET',
        headers: { 'Accept': 'application/json' }
    })
        .then(response => response.json())
        .then((data) => {
            if (!data.ok) {
                throw new Error(data.error || '{/literal}{translate}failed_load_submission_requirements{/translate}{literal}');
            }
            taskSubmissionState.requirements = data.requirements || taskSubmissionState.requirements;
            renderSubmissionRequirements();
        })
        .catch((error) => {
            showToast('error', error.message || '{/literal}{translate}failed_load_submission_requirements{/translate}{literal}');
        });
}

function sendVerificationCode() {
    fetch(`/${lang}/user/send-email-verification-code`, {
        method: 'POST',
        headers: { 'Accept': 'application/json' }
    })
        .then(response => response.json())
        .then((data) => {
            if (!data.ok) {
                throw new Error(data.error || '{/literal}{translate}failed_send_verification_code{/translate}{literal}');
            }
            showToast('info', '{/literal}{translate}verification_code_sent{/translate}{literal}');
        })
        .catch((error) => {
            showToast('error', error.message || '{/literal}{translate}failed_send_verification_code{/translate}{literal}');
        });
}

function confirmVerificationCode() {
    const code = document.getElementById('verification-code-input').value.trim();
    fetch(`/${lang}/user/confirm-email-verification-code`, {
        method: 'POST',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ code })
    })
        .then(response => response.json())
        .then((data) => {
            if (!data.ok) {
                throw new Error(data.error || '{/literal}{translate}failed_verify_email{/translate}{literal}');
            }
            document.getElementById('email-verification-field').classList.add('hidden');
            showToast('info', '{/literal}{translate}email_verified{/translate}{literal}');
            return loadSubmissionRequirements();
        })
        .catch((error) => {
            showToast('error', error.message || '{/literal}{translate}failed_verify_email{/translate}{literal}');
        });
}

function openTaskSubmissionEdit(submissionId) {
    const submission = taskSubmissionState.submissions.find((item) => Number(item.id) === Number(submissionId));
    if (!submission || submission.status !== 'pending') {
        showToast('error', '{/literal}{translate}only_pending_submissions_editable{/translate}{literal}');
        return;
    }

    taskSubmissionState.editingId = Number(submission.id);
    document.getElementById('submission-title').value = submission.title || '';
    document.getElementById('submission-task').value = submission.task || '';
    document.getElementById('submission-hint').value = submission.hint || '';
    document.getElementById('submission-solution-query').value = submission.solution_query || '';
    document.getElementById('submission-db-template').value = submission.db_template || 'sakila';
    document.getElementById('submission-save-btn').textContent = '{/literal}{translate}save_changes{/translate}{literal}';
    document.getElementById('submission-cancel-btn').classList.remove('hidden');
    setTaskSubmissionFormStatus(`{/literal}{translate}editing_submission{/translate}{literal} #${submission.id}`);
}

function cancelTaskSubmissionEdit() {
    resetTaskSubmissionForm();
    setTaskSubmissionFormStatus('');
}

function getSubmissionStatusLabel(status) {
    const value = String(status || '').toLowerCase();
    if (value === 'pending') {
        return '{/literal}{translate}submission_status_pending{/translate}{literal}';
    }
    if (value === 'approved') {
        return '{/literal}{translate}submission_status_approved{/translate}{literal}';
    }
    if (value === 'rejected') {
        return '{/literal}{translate}submission_status_rejected{/translate}{literal}';
    }
    return status || '';
}

function ensureSubmissionsTable() {
    if (submissionsTable) {
        return submissionsTable;
    }

    const submissionsNode = document.getElementById('submissions-table');
    if (!submissionsNode) {
        return null;
    }

    submissionsTable = new Tabulator(submissionsNode, {
        ajaxURL: `/${lang}/user/task-submissions`,
        ajaxConfig: {
            method: 'GET',
            headers: {
                'Accept': 'application/json'
            }
        },
        ajaxResponse: function(url, params, response) {
            if (!response || !response.ok) {
                throw new Error((response && response.error) || '{/literal}{translate}failed_load_submissions{/translate}{literal}');
            }

            const submissions = response.submissions || [];
            taskSubmissionState.submissions = submissions;
            taskSubmissionState.requirements.has_submissions = submissions.length > 0;
            renderSubmissionRequirements();

            return submissions.map((item) => {
                const status = String(item.status || 'pending').toLowerCase();
                return {
                    id: Number(item.id),
                    title: item.title || `{/literal}{translate}submission{/translate}{literal} #${item.id}`,
                    status: status,
                    statusLabel: getSubmissionStatusLabel(status),
                    db_template: item.db_template || '',
                    created_at: item.created_at || '',
                    moderation_note: item.moderation_note || '',
                    approved_question_id: item.approved_question_id ? String(item.approved_question_id) : '',
                    isPending: status === 'pending'
                };
            });
        },
        ajaxError: function(error) {
            showToast('error', error.message || '{/literal}{translate}failed_load_submissions{/translate}{literal}');
        },
        layout: 'fitColumns',
        pagination: true,
        paginationSize: 10,
        placeholder: '{/literal}{translate}no_submissions_yet{/translate}{literal}',
        columns: [
            {
                title: '{/literal}{translate}title{/translate}{literal}',
                field: 'title',
                sorter: 'string',
                formatter: 'plaintext',
                widthGrow: 2.2
            },
            {
                title: '{/literal}{translate}submission_status{/translate}{literal}',
                field: 'statusLabel',
                sorter: 'string',
                formatter: 'plaintext',
                widthGrow: 1
            },
            {
                title: '{/literal}{translate}database_template{/translate}{literal}',
                field: 'db_template',
                sorter: 'string',
                formatter: 'plaintext',
                widthGrow: 1.1
            },
            {
                title: '{/literal}{translate}created{/translate}{literal}',
                field: 'created_at',
                sorter: 'string',
                formatter: 'plaintext',
                widthGrow: 1.2
            },
            {
                title: '{/literal}{translate}moderation_note{/translate}{literal}',
                field: 'moderation_note',
                sorter: 'string',
                formatter: 'plaintext',
                widthGrow: 1.8
            },
            {
                title: '{/literal}{translate}approved_question_id{/translate}{literal}',
                field: 'approved_question_id',
                sorter: 'number',
                formatter: 'plaintext',
                widthGrow: 1
            },
            {
                title: '{/literal}{translate}actions{/translate}{literal}',
                field: 'actions',
                hozAlign: 'center',
                headerSort: false,
                widthGrow: 1.3,
                formatter: function(cell) {
                    const row = cell.getRow().getData();
                    if (!row.isPending) {
                        return '';
                    }
                    return '<button type="button" class="text-button" data-action="edit" data-id="' + Number(row.id) + '">{/literal}{translate}edit{/translate}{literal}</button>' +
                        ' <button type="button" class="text-button red" data-action="delete" data-id="' + Number(row.id) + '">{/literal}{translate}delete{/translate}{literal}</button>';
                },
                cellClick: function(e, cell) {
                    const actionButton = e.target.closest('button[data-action][data-id]');
                    if (!actionButton) {
                        return;
                    }
                    const action = actionButton.getAttribute('data-action');
                    const submissionId = Number(actionButton.getAttribute('data-id'));
                    if (action === 'edit') {
                        openTaskSubmissionEdit(submissionId);
                        return;
                    }
                    if (action === 'delete') {
                        deleteTaskSubmission(submissionId);
                    }
                }
            }
        ],
        initialSort: [
            { column: 'created_at', dir: 'desc' }
        ]
    });

    return submissionsTable;
}

function renderTaskSubmissions(submissions) {
    const table = ensureSubmissionsTable();
    if (!table) {
        return;
    }

    const rows = (submissions || []).map((item) => {
        const status = String(item.status || 'pending').toLowerCase();
        return {
            id: Number(item.id),
            title: item.title || `{/literal}{translate}submission{/translate}{literal} #${item.id}`,
            status: status,
            statusLabel: getSubmissionStatusLabel(status),
            db_template: item.db_template || '',
            created_at: item.created_at || '',
            moderation_note: item.moderation_note || '',
            approved_question_id: item.approved_question_id ? String(item.approved_question_id) : '',
            isPending: status === 'pending'
        };
    });

    table.setData(rows);
    table.redraw(true);
}

function loadTaskSubmissions() {
    const table = ensureSubmissionsTable();
    if (!table) {
        return Promise.resolve();
    }

    return table.setData()
        .catch((error) => {
            showToast('error', error.message || '{/literal}{translate}failed_load_submissions{/translate}{literal}');
        });
}

function saveTaskSubmission() {
    const payload = getTaskSubmissionPayload();
    if (!payload.title || !payload.task || !payload.hint || !payload.solution_query) {
        showToast('error', '{/literal}{translate}submission_required_fields{/translate}{literal}');
        return;
    }

    const isFirstSubmission = !taskSubmissionState.requirements.has_submissions;
    if (isFirstSubmission) {
        if (!taskSubmissionState.requirements.email_verified) {
            showToast('error', '{/literal}{translate}verify_email_before_first_submission{/translate}{literal}');
            return;
        }
        if (!payload.agreement) {
            showToast('error', '{/literal}{translate}accept_user_agreement_before_submission{/translate}{literal}');
            return;
        }
    }

    const isEdit = taskSubmissionState.editingId > 0;
    const url = isEdit
        ? `/${lang}/user/${taskSubmissionState.editingId}/task-submission-update`
        : `/${lang}/user/task-submission-create`;

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        },
        body: JSON.stringify(payload)
    })
        .then(response => response.json())
        .then(data => {
            if (!data.ok) {
                throw new Error(data.error || '{/literal}{translate}failed_save_submission{/translate}{literal}');
            }
            resetTaskSubmissionForm();
            setTaskSubmissionFormStatus(isEdit ? '{/literal}{translate}submission_updated{/translate}{literal}' : '{/literal}{translate}submission_sent_for_review{/translate}{literal}');
            showToast('info', isEdit ? '{/literal}{translate}submission_updated{/translate}{literal}' : '{/literal}{translate}submission_sent_for_review{/translate}{literal}');
            loadTaskSubmissions();
        })
        .catch((error) => {
            showToast('error', error.message || '{/literal}{translate}failed_save_submission{/translate}{literal}');
        });
}

function deleteTaskSubmission(submissionId) {
    if (!confirm('{/literal}{translate}delete_pending_submission_confirm{/translate}{literal}')) {
        return;
    }

    fetch(`/${lang}/user/${submissionId}/task-submission-delete`, {
        method: 'POST',
        headers: {
            'Accept': 'application/json'
        }
    })
        .then(response => response.json())
        .then((data) => {
            if (!data.ok) {
                throw new Error(data.error || '{/literal}{translate}failed_delete_submission{/translate}{literal}');
            }
            if (Number(taskSubmissionState.editingId) === Number(submissionId)) {
                resetTaskSubmissionForm();
                setTaskSubmissionFormStatus('');
            }
            showToast('info', '{/literal}{translate}submission_deleted{/translate}{literal}');
            loadTaskSubmissions();
        })
        .catch((error) => {
            showToast('error', error.message || '{/literal}{translate}failed_delete_submission{/translate}{literal}');
        });
}

loadSubmissionRequirements().then(() => loadTaskSubmissions());

const tasksTableData = {/literal}{$Questions|json_encode nofilter}{literal};
const dbmsFilter = tasksTableData.reduce((acc,el)=>{acc[el.dbms] = el.dbms; return acc;}, {});
const rateFilter = tasksTableData.reduce((acc,el)=>{acc[el.rate] = el.rate; return acc;}, {})
let tasksTable = null;
if (document.getElementById('questions-table')) {
    tasksTable = new Tabulator("#questions-table", {
        data: tasksTableData, // Use preloaded data
        layout: "fitColumns",
        pagination: true,
        paginationSize: 10,
        selectable: false, // Enable row selection to ensure rowClick works
        columns: [
            {title: "{/literal}{translate}question_title{/translate}{literal}", field: "title", sorter: "string", widthGrow: 4, headerFilter: "input"},
            {title: "{/literal}{translate}dbms{/translate}{literal}", field: "dbms", sorter: "string", headerFilter: "select", 
                headerFilterParams: {values: dbmsFilter}
            },
            {title: "{/literal}{translate}complexity_level{/translate}{literal}", field: "rate",  widthGrow: 1.5, headerFilter: "select", 
                headerFilterParams: {values: rateFilter}
            },
            {
                title: "{/literal}{translate}question_solved_at{/translate}{literal}", 
                field: "solved_at", 
                formatter: "date",
            },
            {title: "{/literal}{translate}favorite{/translate}{literal}", field: "favorite", formatter: "tickCross", width: 140, align: "center"},
        ],
        // Add initial sort
        initialSort: [
            {column: "title", dir: "asc"},
            {column: "dbms", dir: "asc"}
        ]
    });
    tasksTable.on("rowClick", function(e, row){
        window.location.href = "/{/literal}{$Lang}{literal}/question/" + row.getData().category + "/" + row.getData().slug;
    });
}
const testsTableData = {/literal}{$Tests|json_encode nofilter}{literal};

let testsTable = null;
if (document.getElementById('tests-table')) {
    testsTable = new Tabulator("#tests-table", {
        data: testsTableData, // Use preloaded data
        layout: "fitColumns",
        pagination: true,
        paginationSize: 10,
        selectable: false, // Enable row selection to ensure rowClick works
        columns: [
            {
                title: "{/literal}{translate}date{/translate}{literal}", 
                field: "created_at", 
                formatter: "date",
            },
            {
                title: "{/literal}{translate}question_solved_at{/translate}{literal}", 
                field: "solved_at", 
                formatter: "date",
            },
            {title: "{/literal}{translate}tasks_count{/translate}{literal}", field: "tasks_count", formatter: "number", widthGrow: 1},
            {title: "{/literal}{translate}tasks_solved_count{/translate}{literal}", field: "tasks_solved_count", formatter: "number", widthGrow: 1},
            {title: "{/literal}{translate}test_result{/translate}{literal}", field: "grade"},
        ],
        // Add initial sort
        initialSort: [
            {column: "created_at", dir: "desc"},
            {column: "solved_at", dir: "desc"}
        ]
    });
}
</script>
{/literal}