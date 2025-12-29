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
                                            <button id="edit-btn" class="text-button edit-btn" onclick="toggleNicknameEdit(true)" title="{translate}edit_nickname{/translate}"></button>
                                            <div id="save-cancel-btns" class="hidden save-cancel-btns">
                                                <button class="text-button green save-btn" onclick="saveNickname()" title="{translate}save_changes{/translate}"></button>
                                                <button class="text-button red cancel-btn" onclick="toggleNicknameEdit(false)" title="{translate}cancel{/translate}"></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="profile-field">
                                    <span class="profile-field-label" id="grade-label">{translate}your_grade{/translate}:</span>
                                    {$User->grade()} SQL Developer
                                </div>
                                <div class="profile-field">
                                    <span class="profile-field-label">{translate}email{/translate}:</span>
                                    <div class="nickname-container">
                                        <span id="email-display" class="nickname">{$UserEmail|escape}</span>
                                        <input type="email" id="profile-email-input" class="nickname-input hidden" value="{$UserEmail|escape}" placeholder="{translate}email_placeholder{/translate}">
                                        <div class="profile-actions">
                                            <button id="email-edit-btn" class="text-button edit-btn" onclick="toggleEmailEdit(true)" title="{translate}edit_email{/translate}"></button>
                                            <div id="email-save-cancel-btns" class="hidden save-cancel-btns">
                                                <button id="save-email-btn" class="text-button green save-btn" onclick="saveEmailOnly()" title="{translate}save_changes{/translate}"></button>
                                                <button class="text-button red cancel-btn" onclick="toggleEmailEdit(false)" title="{translate}cancel{/translate}"></button>
                                            </div>
                                        </div>
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
                                            <button id="password-edit-btn" class="text-button edit-btn" onclick="togglePasswordEdit(true)" title="{translate}edit_password{/translate}"></button>
                                            <div id="password-save-cancel-btns" class="hidden save-cancel-btns">
                                                <button id="save-password-btn" class="text-button save-btn" onclick="savePasswordOnly()" title="{translate}save_changes{/translate}"></button>
                                                <button class="text-button red cancel-btn" onclick="togglePasswordEdit(false)" title="{translate}cancel{/translate}"></button>
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

</style>

<script>
function toggleNicknameEdit(show) {
    const display = document.getElementById('nickname-display');
    const input = document.getElementById('nickname-input');
    const editBtn = document.getElementById('edit-btn');
    const actionBtns = document.getElementById('save-cancel-btns');

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
                toggleNicknameEdit(false);
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
        toggleNicknameEdit(false);
    }
}

function toggleEmailEdit(show) {
    const display = document.getElementById('email-display');
    const input = document.getElementById('profile-email-input');
    const editBtn = document.getElementById('email-edit-btn');
    const actionBtns = document.getElementById('email-save-cancel-btns');

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
        toggleEmailEdit(false);
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
                toggleEmailEdit(false);
                showToast('info', data.message || '{/literal}{translate}profile_update_success{/translate}{literal}');
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

function togglePasswordEdit(show) {
    const display = document.getElementById('password-display');
    const container = document.getElementById('password-edit-container');
    const editBtn = document.getElementById('password-edit-btn');
    const actionBtns = document.getElementById('password-save-cancel-btns');
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
}

function savePasswordOnly() {
    const passInput = document.getElementById('profile-password-input');
    const confirmInput = document.getElementById('profile-password-confirm-input');
    const saveBtn = document.getElementById('save-password-btn');

    const password = passInput.value;
    const confirm = confirmInput.value;

    if (!password) {
        togglePasswordEdit(false);
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
            togglePasswordEdit(false);
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
const tasksTableData = {/literal}{$Questions|json_encode nofilter}{literal};
const dbmsFilter = tasksTableData.reduce((acc,el)=>{acc[el.dbms] = el.dbms; return acc;}, {});
const rateFilter = tasksTableData.reduce((acc,el)=>{acc[el.rate] = el.rate; return acc;}, {})
let tasksTable = new Tabulator("#questions-table", {
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
const testsTableData = {/literal}{$Tests|json_encode nofilter}{literal};

let testsTable = new Tabulator("#tests-table", {
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
tasksTable.on("rowClick", function(e, row){
    window.location.href = "/{/literal}{$Lang}{literal}/question/" + row.getData().category + "/" + row.getData().slug;
});
</script>
{/literal}