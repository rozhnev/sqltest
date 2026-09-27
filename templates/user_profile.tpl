{assign var="PageTitle" value="{translate}profile_page_title{/translate}"}
{assign var="PageDescription" value="{translate}profile_page_description{/translate}"}
{assign var="UseTubulator" value=true}
{include file='short-header.tpl'}
<link rel="stylesheet" type="text/css" href="/about.css?{$VERSION}" media="all">
<!-- Add to head section -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/tabulator/5.5.2/css/tabulator.min.css" rel="stylesheet">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tabulator/5.5.2/js/tabulator.min.js"></script>
<body>
    {include file='popups.tpl'}
    {* The page body is shared by the mobile and desktop layouts below. *}
    {capture name="profileContent"}
                <div class="profile-page">
                    <aside class="profile-card">
                        <div class="profile-card-head">
                            <div class="profile-avatar" aria-hidden="true">
                                <svg viewBox="0 0 24 24" width="36" height="36" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4.4 3.6-8 8-8s8 3.6 8 8"/></svg>
                            </div>
                            <div class="profile-card-name">
                                <div class="profile-field">
                                    <span class="profile-field-label" id="nickname-label">{translate}nickname{/translate}</span>
                                    <div class="nickname-container">
                                        <span id="nickname-display" class="nickname profile-nickname">{$User->nickname()}</span>
                                        <input type="text" id="nickname-input" class="nickname-input hidden" value="{$User->nickname()}" maxlength="50" aria-labelledby="nickname-label">
                                        <div class="profile-actions">
                                            <button id="nickname-edit-btn" class="text-button edit-btn" onclick="toggleFieldEdit('nickname', true)" title="{translate}edit_nickname{/translate}" aria-label="{translate}edit_nickname{/translate}"></button>
                                            <div id="nickname-save-cancel-btns" class="hidden save-cancel-btns">
                                                <button class="text-button green save-btn" onclick="saveNickname()" title="{translate}save_changes{/translate}" aria-label="{translate}save_changes{/translate}"></button>
                                                <button class="text-button red cancel-btn" onclick="toggleFieldEdit('nickname', false)" title="{translate}cancel{/translate}" aria-label="{translate}cancel{/translate}"></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="profile-field">
                                    <span class="profile-field-label" id="fullname-label">{translate}full_name{/translate}</span>
                                    <div class="nickname-container">
                                        <span id="fullname-display" class="nickname">{$User->getFullName()|escape}</span>
                                        <input type="text" id="fullname-input" class="nickname-input hidden" value="{$User->getFullName()|escape}" maxlength="100" aria-labelledby="fullname-label">
                                        <div class="profile-actions">
                                            <button id="fullname-edit-btn" class="text-button edit-btn" onclick="toggleFieldEdit('fullname', true)" title="{translate}edit_full_name{/translate}" aria-label="{translate}edit_full_name{/translate}"></button>
                                            <div id="fullname-save-cancel-btns" class="hidden save-cancel-btns">
                                                <button class="text-button green save-btn" onclick="saveFullName()" title="{translate}save_changes{/translate}" aria-label="{translate}save_changes{/translate}"></button>
                                                <button class="text-button red cancel-btn" onclick="toggleFieldEdit('fullname', false)" title="{translate}cancel{/translate}" aria-label="{translate}cancel{/translate}"></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="profile-grade" id="grade-label">
                            {if $User->grade()}
                                <span class="profile-grade-value">{$User->grade()} SQL Developer</span>
                            {else}
                                <span>{translate}profile_grade_not_set{/translate}</span>
                                <a class="profile-link" href="/{$Lang}/test/start">{translate}profile_take_test{/translate} →</a>
                            {/if}
                        </div>

                        <dl class="profile-stats">
                            <div class="profile-stat">
                                <dt>{translate}profile_stat_solved{/translate}</dt>
                                <dd>{$ProfileStats.solved}</dd>
                            </div>
                            <div class="profile-stat">
                                <dt>{translate}profile_stat_tests{/translate}</dt>
                                <dd>{$ProfileStats.tests}</dd>
                            </div>
                            <div class="profile-stat">
                                <dt>{translate}profile_stat_best_interview{/translate}</dt>
                                <dd>{if $ProfileStats.bestInterview !== null}{$ProfileStats.bestInterview}%{else}—{/if}</dd>
                            </div>
                            <div class="profile-stat">
                                <dt>{translate}profile_stat_achievements{/translate}</dt>
                                <dd>{$ProfileStats.achievements}</dd>
                            </div>
                        </dl>

                        <section class="profile-account">
                            <h3 class="profile-account-title">{translate}profile_account{/translate}</h3>
                            <div class="profile-field">
                                <span class="profile-field-label" id="email-label">{translate}email{/translate}</span>
                                <div class="nickname-container">
                                    <span id="email-display" class="nickname">{$UserEmail|escape}</span>
                                    <input type="email" id="profile-email-input" class="nickname-input hidden" value="{$UserEmail|escape}" placeholder="{translate}email_placeholder{/translate}" aria-labelledby="email-label">
                                    <div class="profile-actions">
                                        <button id="email-edit-btn" class="text-button edit-btn" onclick="toggleFieldEdit('email', true)" title="{translate}edit_email{/translate}" aria-label="{translate}edit_email{/translate}"></button>
                                        <div id="email-save-cancel-btns" class="hidden save-cancel-btns">
                                            <button id="save-email-btn" class="text-button green save-btn" onclick="saveEmailOnly()" title="{translate}save_changes{/translate}" aria-label="{translate}save_changes{/translate}"></button>
                                            <button class="text-button red cancel-btn" onclick="toggleFieldEdit('email', false)" title="{translate}cancel{/translate}" aria-label="{translate}cancel{/translate}"></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="profile-field">
                                <span class="profile-field-label">{translate}password{/translate}</span>
                                <div class="nickname-container">
                                    <span id="password-display" class="nickname">********</span>
                                    <div id="password-edit-container" class="hidden" style="display: flex; flex-direction: column; gap: 0.5rem;">
                                        <input id="profile-password-input" name="password" type="password" placeholder="{translate}new_password{/translate}" autocomplete="new-password" class="nickname-input" aria-label="{translate}new_password{/translate}" />
                                        <input id="profile-password-confirm-input" name="password_confirm" type="password" placeholder="{translate}confirm_password{/translate}" autocomplete="new-password" class="nickname-input" aria-label="{translate}confirm_password{/translate}" />
                                    </div>
                                    <div class="profile-actions">
                                        <button id="password-edit-btn" class="text-button edit-btn" onclick="toggleFieldEdit('password', true)" title="{translate}edit_password{/translate}" aria-label="{translate}edit_password{/translate}"></button>
                                        <div id="password-save-cancel-btns" class="hidden save-cancel-btns">
                                            <button id="save-password-btn" class="text-button save-btn" onclick="savePasswordOnly()" title="{translate}save_changes{/translate}" aria-label="{translate}save_changes{/translate}"></button>
                                            <button class="text-button red cancel-btn" onclick="toggleFieldEdit('password', false)" title="{translate}cancel{/translate}" aria-label="{translate}cancel{/translate}"></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </aside>

                    <section class="profile-main">
                        <div class="profile-tabs" role="tablist">
                            <button class="profile-tab" role="tab" data-tab="tasks" id="tab-btn-tasks" aria-controls="tab-tasks">{translate}tasks{/translate} <span class="profile-tab-count">{$Questions|@count}</span></button>
                            <button class="profile-tab" role="tab" data-tab="tests" id="tab-btn-tests" aria-controls="tab-tests">{translate}tests{/translate} <span class="profile-tab-count">{$Tests|@count}</span></button>
                            <button class="profile-tab" role="tab" data-tab="interviews" id="tab-btn-interviews" aria-controls="tab-interviews">{translate}interviews{/translate} <span class="profile-tab-count">{$InterviewSessions|@count}</span></button>
                            <button class="profile-tab" role="tab" data-tab="achievements" id="tab-btn-achievements" aria-controls="tab-achievements">{translate}your_achievements{/translate} <span class="profile-tab-count">{$Achievements|@count}</span></button>
                        </div>

                        <div class="profile-panel" role="tabpanel" id="tab-tasks" aria-labelledby="tab-btn-tasks">
                            {if $Questions}
                                <div class="profile-table-wrap"><div id="questions-table"></div></div>
                            {else}
                                <div class="profile-empty">
                                    <p>{translate}profile_empty_tasks{/translate}</p>
                                    <a class="button blue" href="/{$Lang}/">{translate}profile_empty_tasks_action{/translate}</a>
                                </div>
                            {/if}
                        </div>

                        <div class="profile-panel" role="tabpanel" id="tab-tests" aria-labelledby="tab-btn-tests" hidden>
                            {if $Tests}
                                <div class="profile-table-wrap"><div id="tests-table"></div></div>
                            {else}
                                <div class="profile-empty">
                                    <p>{translate}profile_empty_tests{/translate}</p>
                                    <a class="button blue" href="/{$Lang}/test/start">{translate}profile_take_test{/translate}</a>
                                </div>
                            {/if}
                        </div>

                        <div class="profile-panel" role="tabpanel" id="tab-interviews" aria-labelledby="tab-btn-interviews" hidden>
                            {if $InterviewSessions}
                                <div class="profile-table-wrap"><div id="interviews-table"></div></div>
                            {else}
                                <div class="profile-empty profile-promo">
                                    <img src="/images/interview/meridian-logistics-representative.jpeg" alt="" class="profile-promo-avatar">
                                    <p>{translate}profile_interview_promo{/translate}</p>
                                    <a class="button blue" href="/{$Lang}/interview-start">{translate}profile_interview_promo_action{/translate}</a>
                                </div>
                            {/if}
                        </div>

                        <div class="profile-panel" role="tabpanel" id="tab-achievements" aria-labelledby="tab-btn-achievements" hidden>
                            {if $Achievements}
                                <div class="profile-badges">
                                    {foreach $Achievements as $a}
                                        <a class="profile-badge" href="/{$Lang}/achievement/{$a.user_achievement_id}"
                                           target="_blank" rel="noopener noreferrer" title="{translate}view_achievement{/translate}">
                                            <span class="profile-badge-icon" aria-hidden="true">🏆</span>
                                            <span class="profile-badge-title">{$a.title|escape}</span>
                                            <span class="profile-badge-date">{$a.earned_at}</span>
                                        </a>
                                    {/foreach}
                                </div>
                            {else}
                                <div class="profile-empty"><p>{translate}profile_empty_achievements{/translate}</p></div>
                            {/if}
                            {if $PrizeClaims|@count > 0}
                                <h3 class="profile-subheading">{translate}mariadb_prize_qr_code{/translate}</h3>
                                <div class="profile-badges">
                                    {foreach $PrizeClaims as $claim}
                                        <div class="profile-badge">
                                            <img src="{$claim.qr_code_url}" alt="QR code" style="max-width: 180px;">
                                            <code>{$claim.identifier}</code>
                                            <span class="profile-badge-date">{$claim.created_at}</span>
                                        </div>
                                    {/foreach}
                                </div>
                            {/if}
                        </div>
                    </section>
                </div>
    {/capture}
    {if $MobileView}
        <header>
            {include file='m.top-menu.tpl' path="/user/profile"}
        </header>
        <main>
            {$smarty.capture.profileContent}
        </main>
        <footer>
            {include file='m.footer.tpl'}
        </footer>
    {else}
        <div class="container">
            <header>
                {include file='top-menu.tpl' path="/user/profile"}
            </header>
            <main>
                {$smarty.capture.profileContent}
            </main>
            <footer>
                {include file='footer.tpl'}
            </footer>
        </div>
    {/if}
</body>
</html>
{literal}
<style>
/* Profile layout: a profile card on the left, tabs with the user's activity on the right.
   Colors come from theme variables only -- the light theme's --regular-text-color is white. */
.profile-page {
    display: grid;
    grid-template-columns: minmax(260px, 320px) minmax(0, 1fr);
    gap: 1.5rem;
    align-items: start;
    max-width: 1280px;
    width: 100%;
    box-sizing: border-box;
    margin: 1.5rem auto;
    padding: 0 1rem;
    color: var(--light-h2-color);
}

/* ---- Profile card ---- */
.profile-card {
    background: var(--light-panel-bg-color);
    border: 1px solid var(--text-block-border-color);
    border-radius: 14px;
    padding: 1.25rem;
    display: flex;
    flex-direction: column;
    gap: 1rem;
}
.profile-card-head { display: flex; gap: 0.9rem; align-items: flex-start; }
.profile-avatar {
    flex: 0 0 auto;
    width: 56px; height: 56px; border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    background: var(--menu-button-background-color); color: #fff;
}
.profile-card-name { min-width: 0; display: flex; flex-direction: column; gap: 0.5rem; }
.profile-field { display: flex; flex-direction: column; gap: 0.15rem; }
.profile-field-label {
    font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.04em;
    color: var(--question-date-color);
}
.nickname-container { display: flex; align-items: center; gap: 0.4rem; flex-wrap: nowrap; min-width: 0; }
/* The value (or its input) takes the free width and wraps; the edit/save/cancel buttons stay on its line. */
.nickname { flex: 1 1 auto; min-width: 0; font-size: 1rem; padding: 0.15rem 0; overflow-wrap: anywhere; }
.nickname-container > input, #password-edit-container { flex: 1 1 auto; min-width: 0; }
.profile-nickname { font-size: 1.25rem; font-weight: 700; }
.nickname-input {
    font-size: 1rem; padding: 0.3rem 0.4rem; width: 100%; min-width: 0; box-sizing: border-box;
    border: 1px solid var(--text-block-border-color); border-radius: 6px;
    background: var(--text-block-background-color); color: var(--question-text);
}

.profile-grade { display: flex; flex-direction: column; gap: 0.25rem; }
.profile-grade-value { font-size: 1.05rem; font-weight: 600; color: var(--accordion-active); }
.profile-link, .profile-link:visited { color: var(--accordion-active); }

.profile-stats {
    display: grid; grid-template-columns: 1fr 1fr; gap: 0.6rem; margin: 0;
}
.profile-stat {
    background: var(--text-block-background-color);
    border: 1px solid var(--text-block-border-color);
    border-radius: 10px;
    padding: 0.6rem 0.75rem;
}
.profile-stat dt { font-size: 0.78rem; color: var(--question-date-color); }
.profile-stat dd { margin: 0.15rem 0 0; font-size: 1.4rem; font-weight: 700; font-variant-numeric: tabular-nums; }

.profile-account { border-top: 1px solid var(--text-block-border-color); padding-top: 0.75rem; }
.profile-account-title { margin: 0 0 0.75rem; font-size: 1rem; }
.profile-account .profile-field + .profile-field { margin-top: 0.75rem; }

/* Edit / save / cancel icon buttons (the icon itself is 16px). */
.profile-actions, .save-cancel-btns { display: flex; gap: 0.3rem; flex: 0 0 auto; }
.edit-btn, .save-btn, .cancel-btn {
    width: 26px; height: 26px; padding: 0; flex: 0 0 auto;
    background-repeat: no-repeat; background-position: center; border-radius: 6px;
}
.save-btn {
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%2316a34a' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M5 13l4 4L19 7'/%3E%3C/svg%3E");
    border: 1px solid #16a34a;
}
.cancel-btn {
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%23E60000' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M6 18L18 6M6 6l12 12'/%3E%3C/svg%3E");
    border: 1px solid #E60000;
}
.edit-btn {
    background-image: url("data:image/svg+xml,%3Csvg width='16' height='16' viewBox='0 0 24 24' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M16.474 5.408l2.118 2.117m-.756-3.982L12.109 9.27a2.118 2.118 0 00-.58 1.082L11 13l2.648-.53c.41-.082.786-.283 1.082-.58l5.727-5.727a1.853 1.853 0 000-2.621 1.853 1.853 0 00-2.621 0z' stroke='%230069E6' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/%3E%3Cpath d='M19 15v3a2 2 0 01-2 2H6a2 2 0 01-2-2V7a2 2 0 012-2h3' stroke='%230069E6' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
    border: 1px solid #0069E6;
}
.hidden {
    display: none !important;
}

/* ---- Tabs ---- */
.profile-main { min-width: 0; }
.profile-tabs {
    display: flex; gap: 0.25rem; overflow-x: auto; scrollbar-width: thin;
    border-bottom: 1px solid var(--text-block-border-color);
    margin-bottom: 1rem;
}
.profile-tab {
    flex: 0 0 auto;
    background: none; border: none; border-bottom: 3px solid transparent; border-radius: 8px 8px 0 0;
    padding: 0.6rem 0.9rem; cursor: pointer; font: inherit; font-weight: 600;
    color: var(--question-date-color); white-space: nowrap;
    transition: color 0.15s, background-color 0.15s, border-color 0.15s;
}
.profile-tab.active { color: var(--accordion-active); border-bottom-color: var(--accordion-active); }
/* Hover: accent text on a translucent accent tint -- reads on both the light and the dark background
   (in the dark theme the muted tab color is already near-white, so a text-only change was invisible). */
@media (hover: hover) {
    .profile-tab:hover {
        color: var(--accordion-active);
        background-color: rgba(0, 110, 245, 0.12);
        border-bottom-color: rgba(0, 110, 245, 0.45);
    }
    .profile-tab.active:hover { border-bottom-color: var(--accordion-active); }
}
.profile-tab:focus-visible { outline: 2px solid var(--accordion-active); outline-offset: -2px; }
.profile-tab-count {
    display: inline-block; min-width: 1.4em; padding: 0 0.35em; margin-left: 0.25em;
    border-radius: 999px; font-size: 0.8em; text-align: center;
    background: var(--light-panel-bg-color); border: 1px solid var(--text-block-border-color);
}
.profile-panel[hidden] { display: none; }

/* ---- Empty states ---- */
.profile-empty {
    display: flex; flex-direction: column; align-items: center; gap: 0.75rem; text-align: center;
    padding: 2.5rem 1rem;
    background: var(--light-panel-bg-color);
    border: 1px dashed var(--text-block-border-color);
    border-radius: 14px;
}
.profile-empty p { margin: 0; max-width: 34rem; }
.profile-empty .button, .profile-empty .button:visited { color: #fff; text-decoration: none; }
.profile-promo-avatar { width: 64px; height: 64px; border-radius: 50%; object-fit: cover; }

/* ---- Achievements ---- */
.profile-badges {
    display: grid; grid-template-columns: repeat(auto-fill, minmax(170px, 1fr)); gap: 0.75rem;
}
.profile-badge, .profile-badge:visited {
    display: flex; flex-direction: column; align-items: center; gap: 0.35rem; text-align: center;
    padding: 1rem 0.75rem;
    background: var(--light-panel-bg-color);
    border: 1px solid var(--text-block-border-color);
    border-radius: 12px;
    color: var(--light-h2-color); text-decoration: none;
}
a.profile-badge:hover { border-color: var(--accordion-active); }
.profile-badge-icon { font-size: 2rem; line-height: 1; }
.profile-badge-title { font-weight: 600; overflow-wrap: anywhere; }
.profile-badge-date { font-size: 0.8rem; color: var(--question-date-color); font-variant-numeric: tabular-nums; }
.profile-subheading { margin: 1.5rem 0 0.75rem; }

/* ---- Tables (Tabulator) ---- */
/* Padding lives on a wrapper: padding on the Tabulator element itself breaks its fitColumns width math. */
.profile-table-wrap {
    padding: 0.75rem;
    background-color: var(--light-panel-bg-color);
    border: 1px solid var(--text-block-border-color);
    border-radius: 12px;
}
.tabulator {
    background-color: var(--light-panel-bg-color);
    border: none;
    border-radius: 8px;
}
.tabulator .tabulator-cell {
    height: 31px !important;
}
.tabulator .tabulator-header {
    background-color: var(--light-panel-bg-color) !important;
    border-bottom: 1px solid var(--text-block-border-color);
}
.tabulator .tabulator-headers .tabulator-col {
    background-color: var(--light-panel-bg-color) !important;
    color: var(--light-h2-color);
    padding: 8px;
}
.tabulator .tabulator-row {
    border-bottom: 1px solid var(--text-block-border-color);
    /* tabulator.min.css paints rows white, and a fixed dark text color was unreadable on the dark theme */
    color: var(--light-h2-color);
    background-color: var(--text-block-background-color);
    min-height: 32px;
}
.tabulator .tabulator-row.tabulator-row-even { background-color: var(--light-panel-bg-color); }
.tabulator .tabulator-tableholder { background-color: transparent; }
.tabulator .tabulator-row:hover,
.tabulator .tabulator-row.tabulator-selectable:hover {
    background-color: var(--menu-button-background-color);
    color: white;
    cursor: pointer;
}
.tabulator .tabulator-row .tabulator-cell[tabulator-field="solved"],
.tabulator .tabulator-row .tabulator-cell[tabulator-field="favorite"] {
    text-align: center;
}
.tabulator .tabulator-footer { border: none; background-color: var(--light-panel-bg-color); }
.tabulator .tabulator-footer .tabulator-paginator { color: var(--light-h2-color); }
/* Pagination buttons. Tabulator's own styles make the active page red (#d00) and darken on hover; the
   old blue background was also identical for normal and active pages in the light theme. */
.tabulator .tabulator-footer .tabulator-page {
    background-color: var(--text-block-background-color);
    color: var(--light-h2-color);
    border: 1px solid var(--text-block-border-color);
    border-radius: 6px;
    padding: 3px 8px;
}
.tabulator .tabulator-footer .tabulator-page.active {
    background-color: var(--accordion-active);
    border-color: var(--accordion-active);
    color: #fff;
}
.tabulator .tabulator-footer .tabulator-page:disabled {
    opacity: 0.45;
}
@media (hover: hover) and (pointer: fine) {
    .tabulator .tabulator-footer .tabulator-page:not(.disabled):not(:disabled):not(.active):hover {
        background-color: var(--text-block-background-color);
        border-color: var(--accordion-active);
        color: var(--accordion-active);
    }
}

/* ---- Narrow screens: card on top, tabs scroll horizontally ---- */
@media (max-width: 900px) {
    .profile-page { grid-template-columns: minmax(0, 1fr); margin: 1rem auto; }
    .profile-table-wrap { padding: 0.4rem; }
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
// Tables per tab, created only when there is data (an empty tab shows its empty state instead).
const profileTables = {};

// Pagination buttons and header filter placeholder in the page language (translations/{lang}.php).
const tabulatorLocale = {
    locale: "site",
    langs: {
        site: {
            pagination: {
                first: "{/literal}{translate}tabulator_first{/translate}{literal}", first_title: "{/literal}{translate}tabulator_first_title{/translate}{literal}",
                prev: "{/literal}{translate}tabulator_prev{/translate}{literal}", prev_title: "{/literal}{translate}tabulator_prev_title{/translate}{literal}",
                next: "{/literal}{translate}tabulator_next{/translate}{literal}", next_title: "{/literal}{translate}tabulator_next_title{/translate}{literal}",
                last: "{/literal}{translate}tabulator_last{/translate}{literal}", last_title: "{/literal}{translate}tabulator_last_title{/translate}{literal}",
            },
            headerFilters: {default: "{/literal}{translate}tabulator_filter{/translate}{literal}"},
        },
    },
};

const tasksTableData = {/literal}{$Questions|json_encode nofilter}{literal};
if (tasksTableData.length) {
    const dbmsFilter = tasksTableData.reduce((acc,el)=>{acc[el.dbms] = el.dbms; return acc;}, {});
    const rateFilter = tasksTableData.reduce((acc,el)=>{acc[el.rate] = el.rate; return acc;}, {});
    profileTables.tasks = new Tabulator("#questions-table", {
        ...tabulatorLocale,
        data: tasksTableData,
        layout: "fitColumns",
        pagination: true,
        paginationMode: "local",
        paginationSize: 10,
        paginationInitialPage: 1,
        paginationButtonCount: 5,
        selectable: false,
        columns: [
            // "textarea" wraps long titles instead of cutting them off.
            {title: "{/literal}{translate}question_title{/translate}{literal}", field: "title", sorter: "string", widthGrow: 4, headerFilter: "input", formatter: "textarea"},
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
            {title: "{/literal}{translate}favorite{/translate}{literal}", field: "favorite", formatter: "tickCross", width: 140, hozAlign: "center"},
        ],
        initialSort: [
            {column: "title", dir: "asc"},
            {column: "dbms", dir: "asc"}
        ]
    });
    profileTables.tasks.on("rowClick", function(e, row){
        const data = row.getData();
        if (data && data.category && data.slug) {
            window.location.href = "/{/literal}{$Lang}{literal}/question/" + data.category + "/" + data.slug;
        }
    });
}

const testsTableData = {/literal}{$Tests|json_encode nofilter}{literal};
if (testsTableData.length) {
    profileTables.tests = new Tabulator("#tests-table", {
        ...tabulatorLocale,
        data: testsTableData,
        layout: "fitColumns",
        pagination: true,
        paginationSize: 10,
        selectable: false,
        columns: [
            {
                title: "{/literal}{translate}date{/translate}{literal}",
                field: "created_at",
                formatter: "date",
            },
            {title: "{/literal}{translate}tasks_count{/translate}{literal}", field: "tasks_count", formatter: "number", widthGrow: 1},
            {title: "{/literal}{translate}tasks_solved_count{/translate}{literal}", field: "tasks_solved_count", formatter: "number", widthGrow: 1},
            {title: "{/literal}{translate}test_result{/translate}{literal}", field: "grade"},
        ],
        initialSort: [
            {column: "created_at", dir: "desc"}
        ]
    });
    profileTables.tests.on("rowClick", function(e, row){
        window.location.href = "/{/literal}{$Lang}{literal}/test/" + row.getData().id + "/result";
    });
}

// Mock interviews: a finished session opens its result page, an unfinished one continues where it stopped.
const interviewsTableData = {/literal}{$InterviewSessions|json_encode nofilter}{literal};
if (interviewsTableData.length) {
    profileTables.interviews = new Tabulator("#interviews-table", {
        ...tabulatorLocale,
        data: interviewsTableData,
        layout: "fitColumns",
        pagination: true,
        paginationSize: 10,
        selectable: false,
        columns: [
            {title: "{/literal}{translate}date{/translate}{literal}", field: "created_at", widthGrow: 1},
            {title: "{/literal}{translate}interview_position{/translate}{literal}", field: "position_label", widthGrow: 1.5},
            {title: "{/literal}{translate}interview_grade{/translate}{literal}", field: "grade_label", widthGrow: 1},
            {title: "{/literal}{translate}interview_status{/translate}{literal}", field: "finished", widthGrow: 1.5,
                formatter: (cell) => cell.getValue()
                    ? "{/literal}{translate}interview_status_finished{/translate}{literal}"
                    : "{/literal}{translate}interview_status_active{/translate}{literal}"},
            {title: "{/literal}{translate}interview_score{/translate}{literal}", field: "final_score", widthGrow: 1, hozAlign: "right",
                formatter: (cell) => cell.getValue() === null ? "—" : cell.getValue() + "%"},
        ],
        initialSort: [{column: "created_at", dir: "desc"}],
    });
    profileTables.interviews.on("rowClick", function (e, row) {
        const session = row.getData();
        window.location.href = "/{/literal}{$Lang}{literal}/interview/" + session.id + (session.finished ? "/result" : "");
    });
}

// Tabs. The open tab is kept in the URL hash (#tests, #interviews, ...) so it survives a reload and can be linked to.
(function () {
    const tabs = [...document.querySelectorAll('.profile-tab')];
    const names = tabs.map(tab => tab.dataset.tab);

    function showTab(name, updateHash) {
        tabs.forEach(tab => {
            const active = tab.dataset.tab === name;
            tab.classList.toggle('active', active);
            tab.setAttribute('aria-selected', active ? 'true' : 'false');
            tab.tabIndex = active ? 0 : -1;
            document.getElementById('tab-' + tab.dataset.tab).hidden = !active;
        });
        // A table built inside a hidden tab has no width yet -- lay it out once it becomes visible.
        if (profileTables[name]) {
            profileTables[name].redraw(true);
        }
        if (updateHash) {
            history.replaceState(null, '', '#' + name);
        }
    }

    tabs.forEach((tab, index) => {
        tab.addEventListener('click', () => showTab(tab.dataset.tab, true));
        // Arrow keys move between tabs (WAI-ARIA tabs pattern).
        tab.addEventListener('keydown', (event) => {
            const step = event.key === 'ArrowRight' ? 1 : event.key === 'ArrowLeft' ? -1 : 0;
            if (!step) return;
            const next = tabs[(index + step + tabs.length) % tabs.length];
            next.focus();
            showTab(next.dataset.tab, true);
        });
    });

    const fromHash = location.hash.slice(1);
    showTab(names.includes(fromHash) ? fromHash : names[0], false);
})();
</script>
{/literal}
