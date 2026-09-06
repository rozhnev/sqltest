<!DOCTYPE html>
<html lang="{$Lang}">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="description" content="MariaDB challenge results" />
        <title>SQLtest.online Admin - MariaDB challenge results</title>
        <link rel="stylesheet" href="/style.min.css?{$VERSION}" media="all" />
        <link rel="stylesheet" href="/admin/style.min.css?{$VERSION}" media="all" />
        <link href="https://unpkg.com/tabulator-tables@5.5.2/dist/css/tabulator.min.css" rel="stylesheet">
        <script type="text/javascript" src="https://unpkg.com/tabulator-tables@5.5.2/dist/js/tabulator.min.js"></script>
    </head>
    <body>
        <div class="admin-shell">
            <header class="admin-shell__header">
                <div>
                    <p class="brand__title">SQLtest.online Admin</p>
                    <p class="brand__subtitle">MariaDB challenge results</p>
                </div>
            </header>

            <main class="panel">
                <div class="panel__title">
                    <div>
                        <h2>Challenge results</h2>
                        <p class="panel__sub">One row per MariaDB challenge test.</p>
                    </div>
                </div>

                <div class="results-table-wrap">
                    <div id="mariadb-results-table"></div>
                </div>
            </main>

            <footer class="admin-shell__footer">
                {* <a href="/admin">Admin home</a> *}
            </footer>
        </div>
        <style>
            .results-filter { display: flex; align-items: end; gap: 10px; flex-wrap: wrap; }
            .results-filter label { display: flex; flex-direction: column; gap: 6px; color: var(--muted); font-size: .85rem; }
            .results-filter input { min-height: 42px; border: 1px solid var(--line); border-radius: 10px; background: rgba(255,255,255,.04); color: var(--text); padding: 0 10px; }
            .results-table-wrap { overflow-x: auto; }

            /* Tabulator theme matching the admin dark shell */
            .tabulator { background-color: var(--panel); border: 1px solid var(--line); border-radius: 10px; font-size: .92rem; }
            .tabulator .tabulator-header { background-color: var(--panel-alt); border-bottom: 1px solid var(--line); }
            .tabulator .tabulator-headers .tabulator-col { background-color: var(--panel-alt); border-right: none; }
            .tabulator .tabulator-col-title { color: var(--muted); font-size: .78rem; letter-spacing: .04em; text-transform: uppercase; }
            .tabulator .tabulator-header .tabulator-header-filter input,
            .tabulator .tabulator-header .tabulator-header-filter select {
                width: 100%; border: 1px solid var(--line); border-radius: 6px; background: rgba(255,255,255,.04); color: var(--text); padding: 4px 6px;
            }
            .tabulator .tabulator-row { background-color: var(--panel); color: var(--text); border-bottom: 1px solid var(--line); }
            .tabulator .tabulator-row.tabulator-row-even { background-color: var(--panel-alt); }
            .tabulator .tabulator-row:hover { background: linear-gradient(90deg, rgba(93, 241, 255, .16), rgba(75, 184, 230, .08)); }
            .tabulator .tabulator-cell { border-right: none; }
            .tabulator .tabulator-cell a { color: var(--accent); }
            .tabulator .tabulator-cell.results-number { text-align: center; font-variant-numeric: tabular-nums; }
            .tabulator .tabulator-footer { background-color: var(--panel-alt); border-top: 1px solid var(--line); color: var(--muted); }
            .tabulator .tabulator-footer .tabulator-page { background-color: var(--panel); color: var(--text); border: 1px solid var(--line); }
            .tabulator .tabulator-footer .tabulator-page.active { background-color: var(--accent-strong); color: var(--bg); }
            .tabulator-placeholder { color: var(--muted) !important; }
            @media (max-width: 760px) {
                .admin-shell { padding: 12px; }
                .admin-shell__header { align-items: flex-start; flex-direction: column; gap: 12px; }
                .panel__title { align-items: flex-start; flex-direction: column; }
            }
        </style>
        {literal}
        <script>
        const resultsTableData = {/literal}{$Results|json_encode nofilter}{literal};

        function escapeHtml(value) {
            const div = document.createElement("div");
            div.textContent = value == null ? "" : String(value);
            return div.innerHTML;
        }

        const resultsTable = new Tabulator("#mariadb-results-table", {
            data: resultsTableData,
            layout: "fitDataFill",
            placeholder: "No MariaDB challenge results found.",
            pagination: true,
            paginationMode: "local",
            paginationSize: 25,
            paginationSizeSelector: [10, 25, 50, 100],
            columns: [
                {
                    title: "Participant", field: "full_name", sorter: "string", headerFilter: "input", widthGrow: 2,
                    formatter: cell => cell.getValue() ? escapeHtml(cell.getValue()) : "-",
                },
                {
                    title: "Email", field: "email", sorter: "string", headerFilter: "input", widthGrow: 2,
                    formatter: cell => {
                        const value = cell.getValue();
                        if (!value) return "-";
                        const safe = escapeHtml(value);
                        return `<a href="mailto:${safe}">${safe}</a>`;
                    },
                },
                {
                    title: "Subscribed", field: "subscribed", sorter: "boolean", headerFilter: "select",
                    headerFilterParams: {values: {"": "All", true: "Yes", false: "No"}},
                    formatter: cell => cell.getValue() ? "Yes" : "No",
                },
                {title: "Started", field: "test_started", sorter: "string", headerFilter: "input"},
                {title: "Finished", field: "test_finished", sorter: "string", headerFilter: "input"},
                {title: "Total solved", field: "solved_questions", sorter: "number", headerFilter: "number", hozAlign: "center", cssClass: "results-number"},
                {title: "Tier 1", field: "tier1_solved_questions", sorter: "number", headerFilter: "number", hozAlign: "center", cssClass: "results-number"},
                {title: "Tier 2", field: "tier2_solved_questions", sorter: "number", headerFilter: "number", hozAlign: "center", cssClass: "results-number"},
                {title: "Tier 3", field: "tier3_solved_questions", sorter: "number", headerFilter: "number", hozAlign: "center", cssClass: "results-number"},
                {
                    title: "Free answer", field: "free_answer", sorter: "string", headerFilter: "input", widthGrow: 3,
                    formatter: cell => cell.getValue() ? escapeHtml(cell.getValue()) : "-",
                },
            ],
            initialSort: [
                {column: "test_started", dir: "desc"},
            ],
        });
        </script>
        {/literal}
    </body>
</html>