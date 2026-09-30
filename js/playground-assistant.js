// Playground side of the AI assistant (see PLAYGROUND_ASSISTANT_PLAN.md): gives js/ai-assistant.js
// the editor SQL, the selected engine and the last run's result, and inserts answers into the editor.
(function () {
    // Rows per result set kept for the assistant; the server caps further (PLAYGROUND_ASSISTANT_MAX_RESULT_ROWS)
    var MAX_ROWS = 50;
    var lastResult = null;

    // Called by executeQuery() with the parsed query-run JSON
    window.playgroundAssistantSetResult = function (result) {
        lastResult = Array.isArray(result) ? result.map(function (set) {
            if (set && set.error) {
                return { error: String(set.error) };
            }
            var data = set && Array.isArray(set.data) ? set.data : [];
            return { headers: set && set.headers ? set.headers : [], data: data.slice(0, MAX_ROWS), total: data.length };
        }) : null;

        var hasError = Array.isArray(lastResult) && lastResult.some(function (set) { return set.error; });
        var panel = document.querySelector('.ai-assistant');
        if (panel) {
            panel.classList.toggle('ai-has-error', hasError);
        }
    };

    window.aiAssistantContext = function () {
        var version = document.getElementById('databaseVersion');
        return {
            version: version ? version.value : '',
            sql: window.sql_editor ? window.sql_editor.getValue() : '',
            result: lastResult ? JSON.stringify(lastResult) : ''
        };
    };

    window.aiAssistantInsert = function (sql) {
        if (!window.sql_editor) {
            return;
        }
        window.sql_editor.insert(sql.replace(/\s+$/, '') + '\n');
        window.sql_editor.focus();
    };
})();
