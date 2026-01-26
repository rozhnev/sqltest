{include file='short-header.tpl'}
<body>
    <style>
        :root {
            --mdb-surface: #030a18;
            --mdb-card: rgba(255, 255, 255, 0.06);
            --mdb-card-strong: rgba(255, 255, 255, 0.12);
            --mdb-border: rgba(255, 255, 255, 0.25);
            --mdb-highlight: #15d0ff;
            --mdb-emerald: #64f3bd;
        }

        body {
            margin: 0;
            background-color: var(--mdb-surface);
            color: #f5fbff;
            font-family: 'Space Grotesk', 'Inter', 'Segoe UI', system-ui, sans-serif;
        }

        .mariadb-shell {
            min-height: 100vh;
            background:
                radial-gradient(circle at 25% 25%, rgba(21, 208, 255, 0.25), transparent 45%),
                radial-gradient(circle at 80% 5%, rgba(100, 243, 189, 0.2), transparent 40%),
                linear-gradient(180deg, rgba(2, 9, 28, 0.9), rgba(3, 10, 24, 1));
            display: flex;
            flex-direction: column;
        }

        .mariadb-header {
            width: 100%;
            padding: 0.9rem 1.5rem 0.75rem;
            background: linear-gradient(180deg, rgba(3, 10, 24, 0.95), rgba(3, 10, 24, 0.75));
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
            box-shadow: 0 20px 35px rgba(0, 0, 0, 0.55);
            position: sticky;
            top: 0;
            z-index: 20;
            backdrop-filter: blur(16px);
        }

        .mariadb-header-inner,
        .mariadb-footer-inner {
            width: min(1200px, 100%);
            margin: 0 auto;
        }

        .mariadb-header-inner {
            display: flex;
            justify-content: center;
        }

        .mariadb-header .top-menu-left .site-name,
        .mariadb-header .top-menu-center .site-description,
        .mariadb-header .top-menu-left a,
        .mariadb-header .top-menu-center,
        .mariadb-header .top-menu-switchers,
        .mariadb-header .top-menu-buttons a,
        .mariadb-header .top-menu-buttons span {
            color: #f5fbff;
        }
        .mariadb-header .top-menu-left 
        {
            min-width: 9vw;
        }
        .mariadb-header .top-menu-center
        {
            max-width: 53%;
        }
        .mariadb-header .divider
        {
            border: 0;
        }
        .mariadb-header .divider {
            background-color: rgba(255, 255, 255, 0.25);
        }

        header,
        footer {
            padding: 0 1rem;
        }

        main {
            flex: 1;
        }

        .mariadb-wrapper {
            width: min(1200px, 100%);
            margin: 0 auto;
            padding: 1.5rem 1.25rem 3rem;
        }

        .mariadb-page {
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }

        .mariadb-hero {
            padding: 2.5rem;
            border-radius: 20px;
            border: 1px solid var(--mdb-border);
            background: linear-gradient(135deg, rgba(27, 177, 255, 0.25), rgba(100, 243, 189, 0.15));
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }

        .hero-eyebrow {
            text-transform: uppercase;
            letter-spacing: 0.4rem;
            font-size: 0.8rem;
            color: rgba(245, 255, 255, 0.85);
            margin-bottom: 0.6rem;
        }

        .mariadb-hero h1 {
            margin: 0;
            font-size: clamp(2rem, 4vw, 3rem);
            letter-spacing: -0.02em;
        }

        .hero-subtitle {
            margin: 0.75rem 0 0.5rem;
            font-size: 1rem;
            color: rgba(245, 255, 255, 0.85);
        }

        .hero-subtitle a {
            color: #f5b13d;
            text-decoration: none;
        }

        .hero-cta {
            margin-top: 1.5rem;
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            align-items: center;
        }

        .mariadb-button {
            background: var(--mdb-highlight);
            color: #04101e;
            padding: 0.9rem 1.8rem;
            border-radius: 999px;
            font-weight: 600;
            text-decoration: none;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .mariadb-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(21, 208, 255, 0.4);
        }

        .hero-note {
            font-size: 0.95rem;
            color: rgba(255, 255, 255, 0.85);
        }

        .mariadb-highlight,
        .mariadb-grid {
            display: grid;
            gap: 1.5rem;
        }

        .mariadb-highlight {
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        }

        .mariadb-highlight > div,
        .mariadb-grid article {
            padding: 1.75rem;
            border-radius: 18px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .mariadb-highlight h2 {
            margin-top: 0;
        }

        .mariadb-list {
            padding-left: 1.1rem;
            margin: 1rem 0 0;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            color: rgba(255, 255, 255, 0.85);
        }

        .mariadb-list li::marker {
            color: var(--mdb-emerald);
        }

        .floating-card {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 18px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.45);
        }

        .floating-card h3 {
            margin-top: 0;
        }

        .mariadb-grid article {
            background: linear-gradient(180deg, rgba(255, 255, 255, 0.04), rgba(25, 46, 84, 0.7));
        }

        .mariadb-prizes {
            padding: 1.75rem;
            border-radius: 22px;
            border: 1px solid rgba(255, 255, 255, 0.12);
            background: rgba(12, 24, 45, 0.7);
        }

        .mariadb-prizes h2 {
            margin-top: 0;
        }

        .prize-grid {
            margin-top: 1rem;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1rem;
        }

        .prize-card {
            padding: 1.25rem;
            border-radius: 16px;
            background: rgba(22, 32, 70, 0.85);
            border: 1px solid rgba(255, 255, 255, 0.08);
            display: flex;
            flex-direction: column;
            gap: 0.6rem;
        }

        .prize-card h4 {
            margin: 0;
            color: var(--mdb-highlight);
        }

        .prize-note {
            margin-top: 1rem;
            color: rgba(255, 255, 255, 0.75);
        }

        .mariadb-final {
            padding: 1.75rem;
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.12);
            background: linear-gradient(135deg, rgba(100, 243, 189, 0.08), rgba(27, 177, 255, 0.1));
            display: flex;
            flex-direction: column;
            gap: 1rem;
            align-items: flex-start;
        }

        .mariadb-final p {
            margin: 0;
        }

        .external-link {
            color: var(--mdb-highlight);
            text-decoration: underline;
        }

        .mariadb-footer {
            padding: 2rem 1.25rem 3rem;
            background: linear-gradient(180deg, rgba(3, 10, 24, 0.92), rgba(3, 10, 24, 0.98));
            border-top: 1px solid rgba(255, 255, 255, 0.12);
        }

        .mariadb-footer-inner {
            background: rgba(7, 16, 34, 0.75);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 20px;
            padding: 2rem;
            display: flex;
            flex-direction: column;
            gap: 1rem;
            box-shadow: 0 25px 40px rgba(0, 0, 0, 0.45);
            backdrop-filter: blur(14px);
        }

        .mariadb-footer-inner .footer-links {
            border-bottom: 1px solid rgba(255, 255, 255, 0.06);
            padding-bottom: 1rem;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 0.75rem;
            color: rgba(245, 251, 255, 0.85);
        }

        .mariadb-footer-inner .footer-links:last-of-type {
            border-bottom: none;
            padding-bottom: 0;
        }

        @media (max-width: 768px) {
            .hero-subtitle {
                font-size: 0.95rem;
            }

            .mariadb-shell {
                padding-top: 1rem;
            }

            header,
            footer {
                padding: 0 0.5rem;
            }

            .mariadb-wrapper {
                padding: 1rem 1rem 2rem;
            }
        }
    </style>
    <div class="mariadb-shell">
            <header class="mariadb-header">
                <div class="mariadb-header-inner">
                    {if $MobileView}
                        {include file='m.top-menu.tpl' path="/test/mariadb"}
                    {else}
                        {include file='top-menu.tpl' path="/test/mariadb"}
                    {/if}
                </div>
            </header>
        <main>
            <div class="mariadb-wrapper">
                <div class="mariadb-page">
                    {include file="{$Lang}/test_mariadb.tpl"}
                </div>
            </div>
        </main>
            <footer class="mariadb-footer">
                <div class="mariadb-footer-inner">
                    {if $MobileView}
                        {include file='m.footer.tpl'}
                    {else}
                        {include file='footer.tpl'}
                    {/if}
                </div>
            </footer>
    </div>
    {include file='counters.tpl'}
</body>
</html>
