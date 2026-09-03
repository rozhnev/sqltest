<!DOCTYPE html>
<html lang="{$Lang}">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="description" content="MariaDB challenge results" />
        <title>SQLtest.online Admin - MariaDB challenge results</title>
        <link rel="stylesheet" href="/style.min.css?{$VERSION}" media="all" />
        <link rel="stylesheet" href="/admin/style.min.css?{$VERSION}" media="all" />
    </head>
    <body>
        <div class="admin-shell">
            <header class="admin-shell__header">
                <div>
                    <p class="brand__title">SQLtest.online Admin</p>
                    <p class="brand__subtitle">MariaDB challenge results</p>
                </div>
                <div class="status-pill">
                    <span>QUESTIONNAIRE: 999</span>
                    <span>FROM: {$StartDate}</span>
                </div>
            </header>

            <main class="panel">
                <div class="panel__title">
                    <div>
                        <h2>Challenge results</h2>
                        <p class="panel__sub">One row per MariaDB challenge test.</p>
                    </div>
                    <form method="get" action="/admin/mariadb-results" class="results-filter">
                        <label for="start-date">Started from</label>
                        <input id="start-date" type="date" name="start_date" value="{$StartDate|escape:'html'}" />
                        <button type="submit" class="button-primary">Apply</button>
                    </form>
                </div>

                <div class="results-table-wrap">
                    <table class="results-table">
                        <thead>
                            <tr>
                                <th>Participant</th>
                                <th>Email</th>
                                <th>Test ID</th>
                                <th>Started</th>
                                <th>Total solved</th>
                                <th>Tier 1</th>
                                <th>Tier 2</th>
                                <th>Tier 3</th>
                                <th>Free answer</th>
                            </tr>
                        </thead>
                        <tbody>
                            {if $Results|@count === 0}
                                <tr>
                                    <td colspan="9" class="results-empty">No MariaDB challenge results found.</td>
                                </tr>
                            {else}
                                {foreach $Results as $result}
                                    <tr>
                                        <td>{$result.full_name|default:'-'|escape:'html'}</td>
                                        <td><a href="mailto:{$result.email|escape:'html'}">{$result.email|default:'-'|escape:'html'}</a></td>
                                        <td><code>{$result.id|escape:'html'}</code></td>
                                        <td>{$result.test_start|escape:'html'}</td>
                                        <td class="results-number">{$result.solved_questions}</td>
                                        <td class="results-number">{$result.tier1_solved_questions}</td>
                                        <td class="results-number">{$result.tier2_solved_questions}</td>
                                        <td class="results-number">{$result.tier3_solved_questions}</td>
                                        <td class="results-number">{$result.free_answer}</td>
                                    </tr>
                                {/foreach}
                            {/if}
                        </tbody>
                    </table>
                </div>
            </main>

            <footer class="admin-shell__footer">
                <a href="/admin">Admin home</a>
            </footer>
        </div>
        <style>
            .results-filter { display: flex; align-items: end; gap: 10px; flex-wrap: wrap; }
            .results-filter label { display: flex; flex-direction: column; gap: 6px; color: var(--muted); font-size: .85rem; }
            .results-filter input { min-height: 42px; border: 1px solid var(--line); border-radius: 10px; background: rgba(255,255,255,.04); color: var(--text); padding: 0 10px; }
            .results-table-wrap { overflow-x: auto; }
            .results-table { width: 100%; min-width: 1050px; border-collapse: collapse; }
            .results-table th, .results-table td { padding: 12px 10px; border-bottom: 1px solid var(--line); text-align: left; white-space: nowrap; }
            .results-table th { color: var(--muted); font-size: .78rem; letter-spacing: .04em; text-transform: uppercase; }
            .results-table td { color: var(--text); }
            .results-table code { color: var(--accent); font-size: .78rem; }
            .results-number { text-align: center !important; font-variant-numeric: tabular-nums; }
            .results-empty { color: var(--muted) !important; text-align: center !important; padding: 32px !important; }
            @media (max-width: 760px) {
                .admin-shell { padding: 12px; }
                .admin-shell__header { align-items: flex-start; flex-direction: column; gap: 12px; }
                .panel__title { align-items: flex-start; flex-direction: column; }
            }
        </style>
    </body>
</html>