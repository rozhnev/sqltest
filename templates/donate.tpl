    {assign var="PageTitle" value="{translate}donate_page_title{/translate}"}
    {assign var="PageDescription" value="{translate}donate_page_description{/translate}"}
    {include file='short-header.tpl'}
    <style>             
        .donation-methods {
            display: flex;
            flex-wrap: wrap;
            gap: 2rem;
            margin: 2rem 0;
            color: #333;
            flex-direction: row;
            justify-content: center;
            align-items: flex-start;
        }
        .donation-method {
            text-align: center;
            padding: 1.5rem;
            border-radius: 12px;
            color: var(--ligth-h2-color);
            background-color: var(--ligth-panel-bg-color);
            border: 1px solid var(--text-block-border-color);
            max-width: 45%;
            min-width: 20rem;
            flex: 1 1 20rem;
            box-sizing: border-box;
            box-shadow: 0 8px 22px rgba(0, 0, 0, 0.08);
        }
        .donation-method h3 {
            margin: 0 0 0.7rem;
            font-size: 1.85rem;
            line-height: 1.22;
        }
        .donation-method p {
            margin: 0.55rem 0;
            line-height: 1.4;
        }
        .donation-method a {
            color: var(--blue-btn-background);
        }
        .donation-method a:hover {
            text-decoration: underline;
        }
        .donation-method img {
            max-width: 100%;
            height: auto;
        }
        .donation-method iframe {
            width: 100%;
            max-width: 346px;
            margin: 0 auto;
            display: block;
            border: 0;
            border-radius: 10px;
            background: #fff;
            box-shadow: inset 0 0 0 1px rgba(0, 0, 0, 0.06);
        }
        .donation-intro,
        .donation-helper,
        .donation-fallback,
        .donation-suggested {
            text-align: left;
        }
        .donation-helper {
            margin: 0.75rem 0 1rem;
            color: var(--text-color);
            line-height: 1.5;
        }
        .about .top .donation-suggested {
            margin: 0 0 1rem;
            padding-left: 1.25rem;
            color: var(--ligth-h2-color) !important;
            list-style: disc !important;
        }
        .about .top .donation-suggested li {
            margin: 0.35rem 0;
            color: var(--ligth-h2-color) !important;
            list-style: disc !important;
        }
        .about .top .donation-suggested li::marker {
            color: var(--ligth-h2-color) !important;
        }
        .donation-fallback {
            margin-top: 0.75rem;
            font-size: 0.9rem;
            overflow-wrap: anywhere;
        }
        .payment-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            border: 1px solid var(--text-block-border-color);
            border-radius: 999px;
            padding: 0.2rem 0.6rem;
            font-size: 0.84rem;
            background: var(--text-block-background-color);
            color: var(--ligth-h2-color);
            line-height: 1.2;
            white-space: nowrap;
        }
        .payment-badge.mir {
            background: linear-gradient(90deg, #23a038 0%, #1f9ed8 100%);
            color: #fff;
            border-color: transparent;
            font-weight: 700;
            letter-spacing: 0.02em;
        }
        .payment-badge.mir .mir-logo {
            font-weight: 800;
        }
        .donation-method .button.green {
            background: linear-gradient(135deg, #16a34a 0%, #15803d 100%);
            border-color: #166534;
            box-shadow: 0 6px 14px rgba(21, 128, 61, 0.28);
            transition: transform 0.16s ease, box-shadow 0.16s ease, filter 0.16s ease;
        }
        .donation-method .button.green:hover {
            transform: translateY(-1px);
            box-shadow: 0 10px 18px rgba(21, 128, 61, 0.34);
            filter: brightness(1.04);
        }
        .donation-method .button.green:focus-visible {
            outline: 2px solid #22c55e;
            outline-offset: 2px;
        }
        [data-theme=dark] .donation-method {
            box-shadow: 0 10px 26px rgba(0, 0, 0, 0.28);
            background: linear-gradient(180deg, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0) 100%), var(--ligth-panel-bg-color);
        }
        .donations-history {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }
        .donations-history-table {
            width: 100%;
            min-width: 42rem;
        }
        .donations-history-empty {
            margin: 0;
        }
        .crypto-address {
            background-color: var(--dark-panel-bg-color);
            color: white;
            padding: 0.5rem;
            border-radius: 4px;
            font-family: monospace;
            font-size: 0.9rem;
            word-break: break-all;
        }
        .warning-text {
            color: #e74c3c;
            font-size: 0.9rem;
            margin-top: 1rem;
        }
        @media (max-width: 768px) {
            .donation-method {
                max-width: 100%;
                min-width: 0;
                width: 100%;
                padding: 1rem;
            }
            .donation-method h3 {
                font-size: 1.45rem;
            }
            .donation-methods {
                gap: 1rem;
            }
            .donations-history-table {
                min-width: 34rem;
            }
            .payment-method-hints .hint-label {
                font-size: 0.85rem;
            }
        }
    </style>
    <body>
        {if $MobileView}
            <header>
                {include file='m.top-menu.tpl' path="/donate"}
            </header>
            <main>
                {include file="{$Lang}/donate.tpl"}
            </main>
            <footer>               
                {include file='m.footer.tpl'}
            </footer>
        {else}
            <div class="container">
                <header>
                    {include file='top-menu.tpl' path="/donate"}
                </header>
                <main>
                    {include file="{$Lang}/donate.tpl"}
                </main>
                <footer>               
                    {include file='footer.tpl'}
                </footer>
            </div>
        {/if}
    </body>
</html>