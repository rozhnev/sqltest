{include file='short-header.tpl'}
<style>
        .donation-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 2rem;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
        }
        
        .donation-header {
            text-align: center;
            margin-bottom: 2rem;
            /* color: #2c3e50; */
            color: var(--regualr-text-color);
        }
        
        .donation-section {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 1rem 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            color: #333;
        }
        
        .donation-methods {
            display: flex;
            flex-wrap: wrap;
            gap: 2rem;
            margin: 2rem 0;
            color: #333;
            flex-direction: row;
            justify-content: center;
        }
        /*         
        .donation-method {
            flex: 1;
            min-width: 300px;
        }
        */

        .donation-method:first-child {
            flex-basis: 35%;
        }

        .donation-method:last-child {
            flex-basis: 60%;
        }
        .donation-method {
            text-align: center;
            padding: 1.5rem;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            color: #79c0ff;
        }
        @media (max-width: 768px) {
            .donation-method {
                flex-basis: 100% !important; /* на мобильных колонки занимают всю ширину */
            }
            .donation-methods {
                gap: 2rem;
                margin: 0;
            }
        }
        .crypto-address {
            background: #f1f1f1;
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
        
        .thank-you {
            text-align: center;
            font-size: 1.2rem;
            color: #27ae60;
            margin-top: 2rem;
        }
    </style>
    <body>
        <div class="{if $MobileView}mobile-container{else}full-container{/if}">
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/donate"}
            {else}
                {include file='top-menu.tpl' path="/donate"}
            {/if}
            <div class="container3">
                {include file="{$Lang}/donate.tpl"}
            </div>
{if $MobileView}
    {include file='m.footer.tpl'}
{else}
    {include file='footer.tpl'}
{/if}