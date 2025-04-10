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
    }
    .menu-panel .db-label {
        color: var(--menu-link-color);
        display: flex;
        margin: 7px 0;
        text-decoration: none;
        border-bottom: 1px solid silver;
        padding: 0.5rem;
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
                    <div id="menu-content" class="menu-content">    
                        <button class="accordion active">
                            <span class="accordion-title">{translate}avaliable_databases{/translate}</span>
                        </button>
                        <div class="menu-panel active">
                            <ul>
                                <li>
                                    <label class="db-label">
                                        <input type="radio" name="database" value="mysql8">
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
                                        <input type="radio" name="database" value="mariadb">
                                        MariaDB
                                    </label>
                                </li>
                                <li>
                                    <label class="db-label">
                                        <input type="radio" name="database" value="sqlite">
                                        SQLite
                                    </label>
                                </li>
                                <li>
                                    <label class="db-label">
                                        <input type="radio" name="database" value="sqlserver">
                                        SQL Server
                                    </label>
                                </li>
                                <li>
                                    <label class="db-label">
                                        <input type="radio" name="database" value="oracle">
                                        Oracle
                                    </label>
                                </li>
                                <li>
                                    <label class="db-label">
                                        <input type="radio" name="database" value="firebird">
                                        Firebird
                                    </label>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="column">
                <div class="code-actions-upper" id="code-actions">
                    <span class="text-button blue" onClick="copyCode(`{translate}toast_sql_copied_to_buffer{/translate}`)">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M9 3.25C5.82436 3.25 3.25 5.82436 3.25 9V16.1069C3.25 16.5211 3.58579 16.8569 4 16.8569C4.41421 16.8569 4.75 16.5211 4.75 16.1069V9C4.75 6.65279 6.65279 4.75 9 4.75H16.0129C16.4271 4.75 16.7629 4.41421 16.7629 4C16.7629 3.58579 16.4271 3.25 16.0129 3.25H9Z" fill="#0069E6"/>
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M18.4026 6.79315C15.1616 6.43093 11.8384 6.43093 8.59748 6.79315C7.6742 6.89634 6.93227 7.62293 6.82344 8.55337C6.43906 11.8399 6.43906 15.1599 6.82344 18.4464C6.93227 19.3769 7.6742 20.1034 8.59748 20.2066C11.8384 20.5689 15.1616 20.5689 18.4026 20.2066C19.3258 20.1034 20.0678 19.3769 20.1766 18.4464C20.561 15.1599 20.561 11.8399 20.1766 8.55337C20.0678 7.62293 19.3258 6.89634 18.4026 6.79315ZM8.76409 8.28387C11.8943 7.93402 15.1057 7.93402 18.2359 8.28387C18.4733 8.31039 18.6599 8.4981 18.6867 8.72762C19.0576 11.8983 19.0576 15.1015 18.6867 18.2722C18.6599 18.5017 18.4733 18.6894 18.2359 18.7159C15.1057 19.0658 11.8943 19.0658 8.76409 18.7159C8.52674 18.6894 8.34013 18.5017 8.31329 18.2722C7.94245 15.1015 7.94245 11.8983 8.31329 8.72762C8.34013 8.4981 8.52674 8.31039 8.76409 8.28387Z" fill="#0069E6"/>
                        </svg>
                        <span>{translate}question_action_copy_code{/translate}</span>
                    </span>
                    <span class="text-button red" onClick="clearEditor()">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M10 2.25C9.58579 2.25 9.25 2.58579 9.25 3V3.75H5C4.58579 3.75 4.25 4.08579 4.25 4.5C4.25 4.91421 4.58579 5.25 5 5.25H19C19.4142 5.25 19.75 4.91421 19.75 4.5C19.75 4.08579 19.4142 3.75 19 3.75H14.75V3C14.75 2.58579 14.4142 2.25 14 2.25H10Z" fill="#E60000"/>
                            <path d="M10 10.6499C10.4142 10.6499 10.75 10.9857 10.75 11.3999V18.3999C10.75 18.8141 10.4142 19.1499 10 19.1499C9.58579 19.1499 9.25 18.8141 9.25 18.3999V11.3999C9.25 10.9857 9.58579 10.6499 10 10.6499Z" fill="#E60000"/>
                            <path d="M14.75 11.3999C14.75 10.9857 14.4142 10.6499 14 10.6499C13.5858 10.6499 13.25 10.9857 13.25 11.3999V18.3999C13.25 18.8141 13.5858 19.1499 14 19.1499C14.4142 19.1499 14.75 18.8141 14.75 18.3999V11.3999Z" fill="#E60000"/>
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M5.99142 7.91718C6.03363 7.53735 6.35468 7.25 6.73684 7.25H17.2632C17.6453 7.25 17.9664 7.53735 18.0086 7.91718L18.2087 9.71852C18.5715 12.9838 18.5715 16.2793 18.2087 19.5446L18.189 19.722C18.045 21.0181 17.0404 22.0517 15.7489 22.2325C13.2618 22.5807 10.7382 22.5807 8.25108 22.2325C6.95954 22.0517 5.955 21.0181 5.81098 19.722L5.79128 19.5446C5.42846 16.2793 5.42846 12.9838 5.79128 9.71852L5.99142 7.91718ZM7.40812 8.75L7.2821 9.88417C6.93152 13.0394 6.93152 16.2238 7.2821 19.379L7.3018 19.5563C7.37011 20.171 7.84652 20.6612 8.45905 20.747C10.8082 21.0758 13.1918 21.0758 15.5409 20.747C16.1535 20.6612 16.6299 20.171 16.6982 19.5563L16.7179 19.379C17.0685 16.2238 17.0685 13.0394 16.7179 9.88417L16.5919 8.75H7.40812Z" fill="#E60000"/>
                        </svg>
                        <span>{translate}question_action_clear_editor{/translate}</span>
                    </span>
                </div>
                <div class="code-wrapper" id="sql-code" name="sql-code"></div>
                <div class="code-buttons">
                    <button class="button green" id="runQueryBtn" onClick="executeQuery()" title="Ctrl+Enter">
                        <span>{translate}question_action_run_query{/translate}</span>
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M19.266 10.4837C20.2579 11.2512 20.2579 12.7486 19.266 13.5161C16.2685 15.8355 12.9213 17.6637 9.34979 18.9321L8.69732 19.1639C7.44904 19.6072 6.13053 18.7627 5.96154 17.4741C5.48938 13.8739 5.48938 10.1259 5.96154 6.52574C6.13053 5.23719 7.44905 4.39263 8.69732 4.83597L9.34979 5.06771C12.9213 6.33619 16.2685 8.16434 19.266 10.4837ZM18.3481 12.3298C18.5639 12.1628 18.5639 11.837 18.3481 11.67C15.4763 9.44796 12.2695 7.69648 8.84777 6.4812L8.1953 6.24947C7.87035 6.13406 7.49691 6.35401 7.44881 6.72079C6.99363 10.1915 6.99363 13.8083 7.44881 17.2791C7.49691 17.6458 7.87035 17.8658 8.19529 17.7504L8.84777 17.5187C12.2695 16.3034 15.4763 14.5519 18.3481 12.3298Z" fill="white"/>
                        </svg>
                    </button>
                </div>
                <div class="code-result ace-xcode" id="code-result"></div>
            </div>
            <div class="column" id="right-panel">
                <div class="referal-add-block" style="height: 100%;">
                    <div id="yandex_rtb_R-A-4716552-7"></div>
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
            formData.append('query', window.sql_editor.getValue());
            fetch(`/${lang}/playground/query-run`, {
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