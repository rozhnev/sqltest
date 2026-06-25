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
    .menu-panel .version-select-wrap {
        padding: 0.5rem;
    }
    .menu-panel .version-select-wrap label {
        display: block;
        color: var(--menu-link-color);
        margin-bottom: 0.35rem;
    }
    .menu-panel .version-select-wrap select {
        width: 100%;
        border: 1px solid silver;
        border-radius: 4px;
        padding: 0.35rem;
        background: #fff;
        color: #111;
    }
    .playground-content {
        margin: 12px 6px 0;
        font-size: small;
    }
    .playground-text-section {
        padding: 1.5rem;
    }
    .playground-text-section h1,
    .playground-text-section h2 {
        margin: 0 0 0.75rem;
    }
    .playground-text-section p {
        margin: 0 0 1rem;
        line-height: 1.65;
    }
    .playground-text-section ul {
        margin: 0 0 1.25rem;
        padding-left: 1.25rem;
    }
    .playground-text-section li {
        margin-bottom: 0.5rem;
        line-height: 1.55;
    }
    .column {
        overflow-y: visible;
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
            <main class="column">
                <div class="menu" id="menu">
                    <div class="question-wrapper" style="margin-right: 6px;">
                        <div id="menu-content" class="menu-content">    
                            <button class="accordion active">
                                <span class="accordion-title">{translate}avaliable_databases{/translate}</span>
                            </button>
                            <div class="menu-panel active">
                                <ul>
                                    {foreach from=$PlaygroundDatabases item=db}
                                        <li>
                                            <label class="db-label">
                                                <input type="radio" name="database" value="{$db.id|escape:'html'}" {if $db.id == $PlaygroundSelectedDatabase}checked{/if}>
                                                {$db.label|escape:'html'}
                                            </label>
                                        </li>
                                    {/foreach}
                                    <li class="version-select-wrap">
                                        <label for="databaseVersion">Version</label>
                                        <select id="databaseVersion" name="databaseVersion"></select>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <article>
                    <section class="playground-content">
                        <div class="question-wrapper playground-text-section">
                            <h1>{translate}playground_content_title{/translate}</h1>
                            <p>{translate}playground_content_intro{/translate}</p>

                            <h2>{translate}playground_content_summary_title{/translate}</h2>
                            <ul>
                                <li>{translate}playground_content_summary_1{/translate}</li>
                                <li>{translate}playground_content_summary_2{/translate}</li>
                                <li>{translate}playground_content_summary_3{/translate}</li>
                                <li>{translate}playground_content_summary_4{/translate}</li>
                            </ul>

                            <h2>{translate}playground_content_features_title{/translate}</h2>
                            <ul>
                                <li>{translate}playground_content_feature_1{/translate}</li>
                                <li>{translate}playground_content_feature_2{/translate}</li>
                                <li>{translate}playground_content_feature_3{/translate}</li>
                            </ul>

                            <h2>{translate}playground_content_supported_title{/translate}</h2>
                            <p>{translate}playground_content_supported_text{/translate}</p>

                            <h2>{translate}playground_content_use_cases_title{/translate}</h2>
                            <p>{translate}playground_content_use_cases_text{/translate}</p>

                            <h2>{translate}playground_content_faq_title{/translate}</h2>
                            <h3>{translate}playground_content_faq_q1{/translate}</h3>
                            <p>{translate}playground_content_faq_a1{/translate}</p>
                            <h3>{translate}playground_content_faq_q2{/translate}</h3>
                            <p>{translate}playground_content_faq_a2{/translate}</p>
                            <h3>{translate}playground_content_faq_q3{/translate}</h3>
                            <p>{translate}playground_content_faq_a3{/translate}</p>
                        </div>
                    </section>
                </article>
            </main>
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
            <aside class="column db-description" id="right-panel">            
                {if $User->showAd()}
                    {include file="{$Lang}/donation_goal_widget.tpl"}
                {/if} 
            </aside>
        </main3>
        <footer>
            {include file='footer.tpl'}
        </footer>
        </div>
        {include file='counters.tpl'}
    </body>
    <script>
        {literal}
        const playgroundDatabases = {/literal}{$PlaygroundDatabases|json_encode nofilter}{literal};
        const defaultPlaygroundVersion = {/literal}{$PlaygroundDefaultVersion|json_encode nofilter}{literal};
        const selectedPlaygroundVersion = {/literal}{$PlaygroundSelectedVersion|json_encode nofilter}{literal};
        const initialSnippetHash = {/literal}{$PlaygroundInitialSnippetHash|json_encode nofilter}{literal};
        const initialSnippetQuery = {/literal}{$PlaygroundInitialQuery|json_encode nofilter}{literal};

        function updateVersionOptions(databaseId, preferredVersion = null) {
            const versionSelect = document.getElementById('databaseVersion');
            if (!versionSelect) {
                return;
            }

            const selectedDatabase = playgroundDatabases.find((db) => db.id === databaseId);
            const versions = selectedDatabase ? selectedDatabase.versions : [];

            versionSelect.innerHTML = '';
            versions.forEach((version) => {
                const option = document.createElement('option');
                option.value = version.id;
                option.textContent = version.label;
                versionSelect.appendChild(option);
            });

            if (versions.length === 0) {
                return;
            }

            const requestedVersion = preferredVersion || defaultPlaygroundVersion;
            const hasRequestedVersion = versions.some((version) => version.id === requestedVersion);
            versionSelect.value = hasRequestedVersion ? requestedVersion : versions[0].id;
        }

        document.addEventListener('DOMContentLoaded', () => {
            const checkedDatabase = document.querySelector('input[name="database"]:checked');
            if (checkedDatabase) {
                updateVersionOptions(checkedDatabase.value, selectedPlaygroundVersion || defaultPlaygroundVersion);
            }

            document.querySelectorAll('input[name="database"]').forEach((radio) => {
                radio.addEventListener('change', (event) => {
                    updateVersionOptions(event.target.value);
                });
            });

            const applySnippetToEditor = () => {
                if (!initialSnippetHash || !initialSnippetQuery) {
                    return;
                }
                if (!window.sql_editor || typeof window.sql_editor.setValue !== 'function') {
                    return;
                }

                window.sql_editor.setValue(initialSnippetQuery, -1);
                window.sql_editor.focus();
                window.sql_editor.session.selection.clearSelection();
            };

            // Try immediate apply on DOM ready and one deferred retry for slow editor init.
            applySnippetToEditor();
            setTimeout(applySnippetToEditor, 150);
        });

        function executeQuery() {
            setLoader('code-result');
            let formData = new FormData();
            const databaseVersion = document.getElementById('databaseVersion').value;
            formData.append('query', window.sql_editor.getValue());
            fetch(`/${lang}/playground/${databaseVersion}/query-run`, {
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