{assign var="PageTitle" value="{translate}profile_page_title{/translate}"}
{assign var="PageDescription" value="{translate}profile_page_description{/translate}"}
{assign var="UseTubulator" value=true}
{include file='short-header.tpl'}
<link rel="stylesheet" type="text/css" href="/about.css?{$VERSION}" media="all">
<!-- Add to head section -->
<link href="https://unpkg.com/tabulator-tables@5.5.2/dist/css/tabulator.min.css" rel="stylesheet">
<script type="text/javascript" src="https://unpkg.com/tabulator-tables@5.5.2/dist/js/tabulator.min.js"></script>
<body>
    {if $MobileView}
        
    {else}
        <header>
            {include file='top-menu.tpl' path="/user//profile"}
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
                        <div class="profile-field">
                            <span id="nickname-label">{translate}nickname{/translate}:</span>
                            <div class="nickname-container">
                                <span id="nickname-display" class="nickname">{$User->getNickname()}</span>
                                <input type="text" id="nickname-input" class="nickname-input hidden" value="{$User->getNickname()}" maxlength="50">
                                <div class="profile-actions">
                                    <button id="edit-btn" class="text-button" onclick="toggleNicknameEdit(true)" title="{translate}edit_nickname{/translate}">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M16.474 5.408l2.118 2.117m-.756-3.982L12.109 9.27a2.118 2.118 0 00-.58 1.082L11 13l2.648-.53c.41-.082.786-.283 1.082-.58l5.727-5.727a1.853 1.853 0 000-2.621 1.853 1.853 0 00-2.621 0z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                            <path d="M19 15v3a2 2 0 01-2 2H6a2 2 0 01-2-2V7a2 2 0 012-2h3" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                        </svg>
                                    </button>
                                    <div id="save-cancel-btns" class="hidden">
                                        <button class="text-button green" onclick="saveNickname()" title="{translate}save_changes{/translate}">
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M5 13l4 4L19 7" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                            </svg>
                                        </button>
                                        <button class="text-button red" onclick="toggleNicknameEdit(false)" title="{translate}cancel{/translate}">
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M6 18L18 6M6 6l12 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="section colored" style="height: 100%;">
                    <div style="width: 100%;">
                        <h2>{translate}profile_page_title{/translate}</h2>
                    </div>
                    <div id="questions-table"></div>

                </div>
                <div class="section bottom colored">
                    <div>
                    </div>
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
.profile-field {
    display: flex;
    align-items: center;
    gap: 1rem;
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
    background-color: var(--block-background-color);
    color: var(--regualr-text-color);
}

.profile-actions {
    display: flex;
    gap: 0.5rem;
}
#save-cancel-btns {
    display: flex;
    gap: 0.5rem;
}
.hidden {
    display: none !important;
}

/* Custom Tabulator theme matching your site */
.tabulator {
    background-color: var(--ligth-panel-bg-color);
    border: 1px solid var(--text-block-border-color);
    border-radius: 6px;
}

.tabulator .tabulator-header {
    background-color: var(--ligth-panel-bg-color) !important;
    border-bottom: 1px solid var(--text-block-border-color);
    color: white;
}
.tabulator .tabulator-headers .tabulator-col {
    background-color: var(--ligth-panel-bg-color) !important;
    padding: 8px;
}
.tabulator .tabulator-row {
    border-bottom: 1px solid var(--text-block-border-color);
    color: var(--regular-text-color);
}

.tabulator .tabulator-row:hover {
    background-color: var(--menu-button-background-color);
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
        fetch(`/{$Lang}/user/update`, {
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
                showToast('success', '{translate}nickname_updated{/translate}');
            } else {
                showToast('error', data.error || '{translate}update_failed{/translate}');
            }
        })
        .catch(error => {
            showToast('error', '{translate}update_failed{/translate}');
            console.error('Error:', error);
        });
    } else {
        toggleNicknameEdit(false);
    }
}

let table = new Tabulator("#questions-table", {
    data: {/literal}{$Questions|json_encode nofilter}{literal}, // Use preloaded data
    layout: "fitColumns",
    pagination: true,
    paginationSize: 25,
    columns: [
        {title: "{/literal}{translate}question_title{/translate}{literal}", field: "title", sorter: "string", widthGrow: 3, headerFilter: "input"},
        {title: "{/literal}{translate}dbms{/translate}{literal}", field: "dbms", sorter: "string", headerFilter: "select", 
            headerFilterParams: {
                values: {"Firebird": "Firebird", "MySQL": "MySQL", "PostgreSQL":"PostgreSQL", "SQL Server 2022":"SQL Server 2022", "SQLite":"SQLite"}
            }
        },
        {title: "{/literal}{translate}complexity_level{/translate}{literal}", field: "rate", formatter: "star"},
        {
            title: "{/literal}{translate}question_solved_at{/translate}{literal}", 
            field: "solved_at", 
            formatter: "date",
        },
        {title: "{/literal}{translate}favorite{/translate}{literal}", field: "favorite", formatter: "tickCross", widthGrow: 1}
    ],
    rowClick: function(e, row) {
        window.location.href = `/{$Lang}/question/${row.getData().category}/${row.getData().slug}`;
    },
    // Add initial sort
    initialSort: [
        {column: "title", dir: "asc"},
        {column: "dbms", dir: "asc"}
    ]
});
</script>
{/literal}