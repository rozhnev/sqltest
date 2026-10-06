{* Database landing page (Controller::database()): the layout, styles and data blocks.
   The text is in {$Lang}/database-{$DatabaseKey}.tpl ($DatabaseText), which places the blocks:
   database_topics.tpl, database_start_tasks.tpl and the table descriptions {$Lang}/{$DB}.tpl. *}
{include file='header.tpl'}
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/rozhnev/sql-highlighter@v1.0.2/sql-highlighter.min.css" media="all">
<body>
    <style>
        .db-landing {
            box-sizing: border-box;
            /* vw, not %: <main> grows to its content's width (the unwrapped <pre> lines) on mobile */
            width: min(960px, 100vw);
            margin: 0 auto;
            padding: 1.5rem 16px 3rem;
            color: var(--question-text);
            line-height: 1.6;
        }
        .db-landing h1 {
            margin: 0 0 0.75rem;
            font-size: clamp(1.6rem, 4vw, 2.2rem);
            line-height: 1.25;
        }
        .db-landing h2 {
            margin: 2.5rem 0 0.75rem;
            font-size: 1.4rem;
        }
        .db-landing p {
            margin: 0 0 0.9rem;
        }
        .db-landing a {
            color: var(--info-text-color);
        }
        .db-lead {
            font-size: 1.1rem;
            max-width: 46rem;
        }
        .db-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
            gap: 0.75rem;
            margin: 1.5rem 0;
            padding: 0;
            list-style: none;
        }
        .db-stats li {
            padding: 0.9rem 1rem;
            border: 1px solid var(--text-block-border-color);
            border-radius: 10px;
            background: var(--accordion-panel-bg-color);
        }
        .db-stats strong {
            display: block;
            font-size: 1.5rem;
            line-height: 1.2;
            font-variant-numeric: tabular-nums;
        }
        .db-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 0.75rem;
            margin: 1.25rem 0 0;
        }
        .db-actions .button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 220px;
            padding: 0.7rem 1.4rem;
            color: #fff;
            text-decoration: none;
        }
        .db-erd {
            display: block;
            margin: 1rem 0;
            padding: 1rem;
            border: 1px solid var(--text-block-border-color);
            border-radius: 10px;
            background: #fff;
            text-align: center;
        }
        .db-erd object {
            display: block;
            width: 100%;
            height: auto;
            aspect-ratio: 1920 / 1320;
            /* Clicks go to the link around it (the full-size ERD page) */
            pointer-events: none;
        }
        .db-groups {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 0.75rem;
            margin: 1rem 0;
        }
        .db-groups > div {
            padding: 1rem;
            border: 1px solid var(--text-block-border-color);
            border-radius: 10px;
        }
        .db-groups h3 {
            margin: 0 0 0.5rem;
            font-size: 1.05rem;
        }
        .db-landing .sql {
            font-family: var(--font-mono);
            color: var(--sql-color);
        }
        .db-landing table.db-rows {
            border-collapse: collapse;
            margin: 0.5rem 0 1rem;
            font-size: 0.95rem;
        }
        .db-landing table.db-rows th,
        .db-landing table.db-rows td {
            padding: 0.35rem 0.75rem;
            border: 1px solid var(--text-block-border-color);
            text-align: left;
        }
        .db-landing table.db-rows td.num {
            text-align: right;
            font-variant-numeric: tabular-nums;
        }
        .db-landing pre {
            margin: 0.5rem 0;
            border-radius: 8px;
            overflow: hidden;
            font-family: var(--font-mono);
            font-size: 0.9rem;
            line-height: 1.5;
        }
        .db-scroll {
            overflow-x: auto;
        }
        .db-tables .db-description {
            font-size: 1rem;
            padding: 0;
        }
        .db-topics,
        .db-start-tasks {
            margin: 0.5rem 0 1rem;
            padding: 0;
            list-style: none;
        }
        .db-topics li,
        .db-start-tasks li {
            display: flex;
            align-items: center;
            gap: 0.6rem;
            padding: 0.5rem 0;
            border-bottom: 1px solid var(--text-block-border-color);
        }
        .db-topics a,
        .db-start-tasks a {
            flex: 1;
        }
        .db-topics .db-count {
            font-variant-numeric: tabular-nums;
            opacity: 0.8;
            white-space: nowrap;
        }
        .db-levels {
            display: inline-flex;
            gap: 3px;
        }
        .db-levels .question-level {
            width: 12px;
            height: 12px;
            vertical-align: middle;
        }
        .db-faq h3 {
            margin: 1.25rem 0 0.4rem;
            font-size: 1.05rem;
        }
    </style>
    {include file='popups.tpl'}
    {* Like about.tpl: .container is the desktop grid, mobile pages go without it *}
    {if $MobileView}
        <header>
            {include file='m.top-menu.tpl' path="/database/{$DatabaseKey}"}
        </header>
        <main>
            <article class="db-landing">
                {include file=$DatabaseText}
            </article>
        </main>
        <footer>
            {include file='m.footer.tpl'}
        </footer>
    {else}
        <div class="container">
            <header>
                {include file='top-menu.tpl' path="/database/{$DatabaseKey}"}
            </header>
            <main>
                <article class="db-landing">
                    {include file=$DatabaseText}
                </article>
            </main>
            <footer>
                {include file='footer.tpl'}
            </footer>
        </div>
    {/if}
    {* Same highlighter as the lessons (lesson.tpl): colors the <pre><code> SQL examples *}
    <script src="https://cdn.jsdelivr.net/gh/rozhnev/sql-highlighter@v1.0.2/sql-highlighter.min.js"></script>
    <script>
        SQLHighlighter.extend({
            functions: ['AGGREGATION_FUNCTION', 'FUNCTION_NAME'],
        });
        SQLHighlighter.highlightCodeBlocks();
    </script>
</body>
</html>
