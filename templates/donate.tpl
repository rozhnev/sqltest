    {assign var="PageTitle" value="{translate}donate_policy_page_title{/translate}"}
    {assign var="PageDescription" value="{translate}donate_policy_page_description{/translate}"}
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
            max-width: 40%;
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
        <div class="container">
            <header>
                {if $MobileView}
                    {include file='m.top-menu.tpl' path="/donate"}
                {else}
                    {include file='top-menu.tpl' path="/donate"}
                {/if}
            </header>
            <main>
                {include file="{$Lang}/donate.tpl"}
            </main>
            <footer>               
                {if $MobileView}
                    {include file='m.footer.tpl'}
                {else}
                    {include file='footer.tpl'}
                {/if}
            </footer>
        </div>
    </body>
</html>