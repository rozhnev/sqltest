{include file='header.tpl'}
<style>
    .menu-panel {
        padding: 0;
        background-color: var(--accordion-panel-bg-color);
        color: #0071DB;
        transition: max-height 0.2s ease-out;
        text-align: left;
        overflow-y: hidden;
        max-height: 100%;
    }
    .menu-panel ul {
        list-style-type: none;
        padding: 0;
    }
    .menu-panel .db-label {
        color: var(--menu-link-color);
        display: flex;
        margin: 7px 0;
        text-decoration: none;
        border-bottom: 1px solid silver;
        padding: 0.5rem;
    }
    .menu-panel .db-label input{
        margin: 0 6px 0 0;
    }
</style>
<body>
    <div class="container">
        {include file='popups.tpl'}
        <header>
        {if $MobileView}
            {include file='m.top-menu.tpl' path="/playground/"}
        {else}
            {include file='top-menu.tpl' path="/playground/"}
        {/if}
        </header>
        <main3 id="main3">
            <div class="column">
                <div class="menu" id="menu">
                    <div class="question-wrapper" style="margin-right: 6px;">
                        <div id="menu-content" class="menu-content">    
                            <button class="accordion active">
                                <span class="accordion-title">{translate}avaliable_databases{/translate}</span>
                            </button>
                            <div class="menu-panel active">
                                <ul>
                                    <li>
                                        <label class="db-label">
                                            <input type="radio" name="database" value="mariadb118" checked>
                                            MariaDB
                                        </label>
                                    </li>
                                    <li>
                                        <label class="db-label">
                                            <input type="radio" name="database" value="mysql80">
                                            MySQL
                                        </label>
                                    </li>
                                    <li>
                                        <label class="db-label">
                                            <input type="radio" name="database" value="psql17">
                                            PostgreSQL
                                        </label>
                                    </li>
                                    <li>
                                        <label class="db-label">
                                            <input type="radio" name="database" value="sqlite3">
                                            SQLite
                                        </label>
                                    </li>
                                    <li>
                                        <label class="db-label">
                                            <input type="radio" name="database" value="mssql2022">
                                            MS SQL Server
                                        </label>
                                    </li>
                                    <li>
                                        <label class="db-label">
                                            <input type="radio" name="database" value="oracle23">
                                            Oracle
                                        </label>
                                    </li>
                                    <li>
                                        <label class="db-label">
                                            <input type="radio" name="database" value="firebird4">
                                            Firebird
                                        </label>
                                    </li>
                                    <li>
                                        <label class="db-label">
                                            <input type="radio" name="database" value="soqol">
                                            SoQoL
                                        </label>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="column">
                <div class="question-wrapper" style="margin-right: 6px;">
                    <div class="code-actions-upper" id="code-actions">
                        <span class="text-button blue" onClick="copyCode(`{translate}toast_sql_copied_to_buffer{/translate}`)">
                            <i class="icon-copy"></i>
                            <span>{translate}question_action_copy_code{/translate}</span>
                        </span>
                        <span class="text-button red" onClick="clearEditor()">
                            <i class="icon-trash"></i>
                            <span>{translate}question_action_clear_editor{/translate}</span>
                        </span>
                    </div>
                    <div class="code-wrapper" id="sql-code" name="sql-code"></div>
                    <div class="code-buttons">
                        <button class="button green" id="runQueryBtn" onClick="executeQuery()" title="Ctrl+Enter">
                            <span>{translate}question_action_run_query{/translate}</span>
                            <i class="run-icon"></i>
                        </button>
                    </div>
                </div>
                <div class="question-wrapper" style="margin-right: 6px;">
                    <div class="code-result ace-xcode" id="code-result"></div>
                </div>
            </div>
            <div class="column" id="right-panel">
                <div style="display:flex; justify-content: center;">
                    <script>
                        atOptions = {
                        'key' : 'acc010b024bcd2bbf1573359d5f7f8d5',
                        'format' : 'iframe',
                        'height' : 600,
                        'width' : 160,
                        'params' : {}
                        };
                    </script>
                    <script src="https://www.highperformanceformat.com/acc010b024bcd2bbf1573359d5f7f8d5/invoke.js"></script>
                    {* <div id="yandex_rtb_R-A-4716552-7"></div> *}
                </div>
            </div>
        </main3>
        <footer>
            {include file='footer.tpl'}
        </footer>
        </div>
        {include file='counters.tpl'}
    </body>
    <script>
        {literal}
        function executeQuery() {
            setLoader('code-result');
            let formData = new FormData();
            const database = document.querySelector('input[name="database"]:checked').value;
            formData.append('query', window.sql_editor.getValue());
            fetch(`/${lang}/playground/${database}/query-run`, {
                method: "POST",
                mode: "cors",
                cache: "default",
                credentials: "same-origin",
                body: formData,
            })
            .then((async response=>{
                if (!response.ok) throw Error('Something went wrong.');
                return await response.text();
            }))
            .then(JSON.parse)
            .then((JSONmessage)=>{
                let html = '✓ (Done)';
                if (JSONmessage && JSONmessage[0]) {
                    const jsonObject = JSONmessage[0];
                    html = jsonObject.error 
                        ? errorToTable(jsonObject) 
                        : jsonToTable(jsonObject);
                }
                document.getElementById('code-result').innerHTML = html;
            })
            .catch(err=>{
                document.getElementById('code-result').innerHTML = 'Something went wrong. Please review your query and try again.';
            });
        }
        {/literal}
    </script>
</html>