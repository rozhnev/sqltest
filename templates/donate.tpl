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
        }
        .donation-method {
            text-align: center;
            padding: 1.5rem;
            border-radius: 8px;
            color: var(--ligth-h2-color);
            background-color: var(--ligth-panel-bg-color);
            max-width: 45%;
            min-width: 20rem;
            flex: 1 1 20rem;
            box-sizing: border-box;
        }
        .donation-method iframe {
            width: 100%;
            max-width: 346px;
            margin: 0 auto;
            display: block;
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
        .donation-suggested {
            margin: 0 0 1rem;
            padding-left: 1.25rem;
        }
        .donation-suggested li {
            margin: 0.35rem 0;
        }
        .donation-fallback {
            margin-top: 0.75rem;
            font-size: 0.95rem;
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
            }
            .donation-methods {
                gap: 1rem;
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