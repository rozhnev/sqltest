{include file='header.tpl'}
<body>
    {include file="{$Lang}/consent_banner.tpl"}
    <div class="container">
        {include file='popups.tpl'}
        <header>
        {if $MobileView}
            {include file='m.top-menu.tpl' path="/"}
        {else}
            {include file='top-menu.tpl' path="/"}
        {/if}
        </header>
        <main2 id="main2">
            <div class="column">
                {include file='menu.tpl'}
            </div>
            <div class="column" id="welcome-page-column">
                <style>
                    #welcome-page-column ol, 
                    #welcome-page-column ul {
                        line-height: 1.5em;
                    }
                    .welcome-container {
                        max-width: 900px;
                        margin: 0 auto;
                        padding: 1em;
                        line-height: 1.6;
                    }
                    .welcome-card {
                        background: var(--bg-color-secondary, #f9f9f9);
                        border: 1px solid var(--border-color, #ddd);
                        border-radius: 8px;
                        padding: 1.5em;
                        margin-bottom: 1.5em;
                    }
                    .step-card {
                        display: flex;
                        align-items: flex-start;
                        gap: 1em;
                        background: var(--bg-color-secondary, #fff);
                        border: 1px solid var(--border-color, #eee);
                        border-radius: 8px;
                        padding: 1em;
                        margin-bottom: 1em;
                    }
                    .step-icon {
                        font-size: 1.5em;
                        min-width: 40px;
                        height: 40px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        background: var(--bg-color-tertiary, #eef);
                        border-radius: 50%;
                    }
                    .step-content h4 {
                        margin: 0 0 0.5em 0;
                        font-size: 1.1em;
                    }
                    .step-content p {
                        margin: 0;
                        font-size: 0.95em;
                        opacity: 0.9;
                    }
                    [data-theme="dark"] .welcome-card,
                    [data-theme="dark"] .step-card {
                        background: var(--bg-color-secondary, #2d333b);
                        border-color: var(--border-color, #444);
                    }
                    [data-theme="dark"] .step-icon {
                        background: #333;
                    }


                    
                </style>
                <div style="
                    margin: 0 auto;
                    max-width: 1024px;
                    background-color: var(--accordion-panel-bg-color);
                    border: 1px solid var(--text-block-border-color);
                    color: var(--question-text);
                    border-radius: 6px 6px 0 0;">
                        {include file="{$Lang}/welcome.tpl"}
                </div>
            </div>
        </main2>
        <footer>
            {include file='footer.tpl'}
        </footer>
        </div>
        {include file='counters.tpl'}
    </body>
</html>