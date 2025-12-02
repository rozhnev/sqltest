    {include file='header.tpl'}
    <body>
    <div class="mobile-container">
        {include file='popups.tpl'}
        <header>
            {include file='m.top-menu.tpl' path="/"}
        </header>
        <div class="main" id="welcome-page-column">
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
                margin: 0.5em auto;
                max-width: 95%;
                background-color: var(--accordion-panel-bg-color);
                border: 1px solid var(--text-block-border-color);
                color: var(--question-text);
                border-radius: 6px 6px 0 0;">
                    {include file="{$Lang}/welcome.tpl"}
            </div>
            <div style="
                display:flex; flex-flow: column;
                align-items:center; gap:12px;
                margin-top:1.5em;
                color: var(--question-text);
                max-width: 95%;">
                <div class="welcome-controls">
                    <label>
                        <input type="checkbox" id="welcome-dont-show" onchange="hideWelcome(this.checked)" />
                        <span>{translate}dont_show_this_page_again{/translate}</span>
                    </label>
                </div>
                <div>
                    <a class="button green" href="/{$Lang}/question/sql-basics/get-the-actors" title="Приступить к практике">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd" clip-rule="evenodd" d="M19.266 10.4837C20.2579 11.2512 20.2579 12.7486 19.266 13.5161C16.2685 15.8355 12.9213 17.6637 9.34979 18.9321L8.69732 19.1639C7.44904 19.6072 6.13053 18.7627 5.96154 17.4741C5.48938 13.8739 5.48938 10.1259 5.96154 6.52574C6.13053 5.23719 7.44905 4.39263 8.69732 4.83597L9.34979 5.06771C12.9213 6.33619 16.2685 8.16434 19.266 10.4837ZM18.3481 12.3298C18.5639 12.1628 18.5639 11.837 18.3481 11.67C15.4763 9.44796 12.2695 7.69648 8.84777 6.4812L8.1953 6.24947C7.87035 6.13406 7.49691 6.35401 7.44881 6.72079C6.99363 10.1915 6.99363 13.8083 7.44881 17.2791C7.49691 17.6458 7.87035 17.8658 8.19529 17.7504L8.84777 17.5187C12.2695 16.3034 15.4763 14.5519 18.3481 12.3298Z" fill="white"></path>
                        </svg>
                        <span>{translate}start_practicing{/translate}</span>
                    </a>
                </div>
            </div>
        </div>
        <footer>
            {include file='m.footer.tpl'}
        </footer>
        </div>
        {include file='counters.tpl'}
    </body>
</html>