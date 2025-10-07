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