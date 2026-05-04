(function() {
    // Load Ace Editor from CDN if not already present
    if (typeof ace === 'undefined') {
        const aceScript = document.createElement('script');
        aceScript.src = 'https://cdnjs.cloudflare.com/ajax/libs/ace/1.37.1/ace.js';
        document.head.appendChild(aceScript);
    }

    function initSQLize() {
        if (typeof ace === 'undefined') {
            const existingScript = document.querySelector('script[src*="ace.js"]');
            if (!existingScript) {
                const aceScript = document.createElement('script');
                aceScript.src = 'https://cdnjs.cloudflare.com/ajax/libs/ace/1.37.1/ace.js';
                document.head.appendChild(aceScript);
            }
            setTimeout(initSQLize, 100);
            return;
        }

        const containers = document.querySelectorAll('[data-sqlize-editor]');
        containers.forEach(container => {
            if (container.dataset.sqlizeInitialized) return;
            container.dataset.sqlizeInitialized = 'true';

            const sqlVersion = container.getAttribute('data-sql-version') || 'mysql80';
            const readOnly = container.getAttribute('data-read-only') === 'true';
            const dbNames = {
                'mariadb123': 'MariaDB 12.3',
                'mysql80': 'MySQL 8.0',
                'mysql80_sakila': 'MySQL 8.0 Sakila (ReadOnly)',
                'mysql93': 'MySQL 9.3.0',
                'mysql97_sakila': 'MySQL 9.7 Sakila (ReadOnly)',
                'mariadb118': 'MariaDB 11.8',
                'mariadb118_openflights': 'MariaDB 11.8 OpenFlights (ReadOnly)',
                'mariadb': 'MariaDB 10',
                'mariadb_sakila': 'MariaDB 10 Sakila (ReadOnly)',
                'sqlite3': 'SQLite 3',
                'sqlite3_data': 'SQLite 3 Preloaded',
                'psql10demo': 'PostgreSQL 10 Bookings (ReadOnly)',
                'psql14': 'PostgreSQL 14',
                'psql15': 'PostgreSQL 15',
                'psql16': 'PostgreSQL 16',
                'psql17': 'PostgreSQL 17 + PostGIS',
                'psql17postgis': 'PostgreSQL 17 + PostGIS WorkShop (ReadOnly)',
                'psql18': 'PostgreSQL 18',
                'mssql2017': 'MS SQL Server 2017',
                'mssql2019': 'MS SQL Server 2019',
                'mssql2022': 'MS SQL Server 2022',
                'mssql2022aw': 'MS SQL Server 2022 AdventureWorks (ReadOnly)',
                'mssql2025': 'MS SQL Server 2025',
                'firebird4': 'Firebird 4.0',
                'firebird4_employee': 'Firebird 4.0 (Employee)',
                'firebird5': 'Firebird 5.0',
                'rdb5': 'RedDatabase 5.0',
                'oracle19hr': 'Oracle Database 19c (HR)',
                'oracle21': 'Oracle Database 21c',
                'oracle23': 'Oracle Database 26ai',
                'soqol': 'SOQOL',
                'clickhouse': 'ClickHouse'
            };
            const initialCode = (container.textContent || container.innerText || '').trim() || '';
            container.innerHTML = ''; // Clear initial content

            // Container Styles
            const wrapper = document.createElement('div');
            wrapper.className = 'sqlize-embed-wrapper';
            wrapper.style.cssText = 'border: 1px solid #ddd; border-radius: 6px; overflow: hidden; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; margin: 10px 0; box-shadow: 0 2px 4px rgba(0,0,0,0.05);';

            // Toolbar
            const toolbar = document.createElement('div');
            toolbar.style.cssText = 'background: #f8f9fa; padding: 10px 15px; border-bottom: 1px solid #ddd; display: flex; justify-content: space-between; align-items: center;';
            
            const info = document.createElement('div');
            info.innerHTML = `<span style="font-size: 11px; color: #888;">Powered by:</span>&nbsp;<a href="https://sqlize.online" target="_blank" style="text-decoration: none; font-size: 13px; color: #444; font-weight: 600;">SQLize.online</a> <span style="font-size: 11px; color: #888; margin-left: 8px;">DataBase: ${dbNames[sqlVersion] || sqlVersion}</span>`;
            
            const runBtn = document.createElement('button');
            runBtn.innerText = 'Run SQL';
            runBtn.style.cssText = 'padding: 6px 20px; background: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 13px; font-weight: 600; transition: background 0.2s;';
            runBtn.onmouseover = () => runBtn.style.background = '#218838';
            runBtn.onmouseout = () => runBtn.style.background = '#28a745';

            toolbar.appendChild(info);
            toolbar.appendChild(runBtn);

            // Editor Area
            const editorDiv = document.createElement('div');
            editorDiv.style.cssText = 'height: 250px; width: 100%; border-bottom: 1px solid #ddd;';
            
            // Result Area
            const resultDiv = document.createElement('div');
            resultDiv.style.cssText = 'background: #fff;';
            
            const resultHeader = document.createElement('div');
            resultHeader.style.cssText = 'padding: 8px 15px; font-size: 12px; color: #666; background: #f1f3f5; border-bottom: 1px solid #eee; font-weight: 600;';
            resultHeader.innerText = 'RESULTS';
            
            const resultRows = parseInt(container.getAttribute('result-rows')) || 12;
            const resultContent = document.createElement('div');
            resultContent.style.cssText = `width: 100%; height: ${resultRows * 1.5}em; border: none; padding: 12px; font-family: "SFMono-Regular", Consolas, "Liberation Mono", Menlo, monospace; font-size: 12px; box-sizing: border-box; background: #fafafa; color: #333; overflow: auto; display: block; white-space: pre-wrap;`;
            resultContent.innerText = 'Execution output will appear here...';

            resultDiv.appendChild(resultHeader);
            resultDiv.appendChild(resultContent);

            wrapper.appendChild(toolbar);
            wrapper.appendChild(editorDiv);
            wrapper.appendChild(resultDiv);
            container.appendChild(wrapper);

            // Initialize Ace Editor
            const editor = ace.edit(editorDiv);
            container.sqlizeEditor = editor; // Store editor for chain concatenation
            editor.setTheme("ace/theme/chrome");
            editor.session.setMode("ace/mode/sql");
            editor.setValue(initialCode, -1);
            const codeRows = parseInt(container.getAttribute('code-rows')) || 12;
            editorDiv.style.height = 'auto';
            editor.setOptions({
                fontSize: "14px",
                showPrintMargin: false,
                useWorker: false,
                highlightActiveLine: !readOnly,
                readOnly: readOnly,
                wrap: true,
                minLines: codeRows,
                maxLines: codeRows
            });

            runBtn.addEventListener('click', async () => {
                let fullCode = [];
                let currentCont = container;
                
                // Traverse up the chain of parents
                while (currentCont) {
                    const editorInstance = currentCont.sqlizeEditor;
                    if (editorInstance) {
                        fullCode.unshift(editorInstance.getValue());
                    }
                    
                    const parentId = currentCont.getAttribute('data-sqlize-parent');
                    if (parentId) {
                        currentCont = document.querySelector(`[data-sqlize-id="${parentId}"]`);
                    } else {
                        currentCont = null;
                    }
                }

                const code = fullCode.join('\n\n');
                if (!code.trim()) {
                    resultContent.innerText = 'Please enter some SQL code.';
                    return;
                }

                runBtn.disabled = true;
                runBtn.innerText = 'Executing...';
                runBtn.style.opacity = '0.7';
                resultContent.innerText = 'Connecting to SQLize API...';

                try {
                    // Step 1: Get Session Hash
                    const hashResponse = await fetch('https://api.sqlize.online/hash.php', {
                        method: 'POST',
                        mode: 'cors',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({
                            language: 'sql',
                            code: code,
                            sql_version: sqlVersion
                        })
                    });

                    if (!hashResponse.ok) {
                        const errorMsg = await hashResponse.text();
                        throw new Error(errorMsg || 'Failed to initialize session');
                    }
                    const sqlhash = await hashResponse.text();

                    // Step 2: Get Evaluation Results
                    resultContent.innerText = 'Fetching results...';
                    const evalResponse = await fetch(`https://api.sqlize.online/sqleval.php?sql_version=${sqlVersion}&sqlses=${sqlhash}`);
                    
                    if (!evalResponse.ok) {
                        throw new Error('Could not retrieve execution results');
                    }
                    const result = await evalResponse.text();
                    resultContent.innerHTML = result;
                } catch (err) {
                    resultContent.innerText = 'Error: ' + err.message + '\n\nNote: If this is a CORS error, the API might requires a proxy or domain whitelisting.';
                    console.error('SQLize Embed Error:', err);
                } finally {
                    runBtn.disabled = false;
                    runBtn.innerText = 'Run SQL';
                    runBtn.style.opacity = '1';
                }
            });
        });
    }

    // Initialize when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initSQLize);
    } else {
        initSQLize();
    }

    // Global access for dynamic content
    window.SQLizeEmbed = { init: initSQLize };

    // Watch for new editors added dynamically
    if (window.MutationObserver) {
        new MutationObserver((mutations) => {
            let shouldInit = false;
            mutations.forEach(m => {
                m.addedNodes.forEach(node => {
                    if (node.nodeType === 1 && (node.hasAttribute('data-sqlize-editor') || node.querySelector('[data-sqlize-editor]'))) {
                        shouldInit = true;
                    }
                });
            });
            if (shouldInit) initSQLize();
        }).observe(document.body, { childList: true, subtree: true });
    }
})();
