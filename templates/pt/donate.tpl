<div class="donation-container">
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
        }
        /* .donation-method {
            flex: 1;
            min-width: 300px; /* минимальная ширина колонки */
        } */

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

    <div class="donation-header">
        <h1>Apoie o SQLtest.online</h1>
        <p>Sua contribuição faz uma diferença significativa para a continuação e desenvolvimento do projeto.</p>
    </div>

    <div class="donation-section">
        <h2>Por que doar?</h2>
        <p>Somente graças ao seu apoio, somos capazes de:</p>
        <ul>
            <li>Manter os servidores funcionando</li>
            <li>Desenvolver novos recursos</li>
            <li>Criar mais conteúdo educacional</li>
            <li>Melhorar a experiência do usuário</li>
        </ul>
    </div>

    <div class="donation-section">
        <h2>Como doar:</h2>
        <div class="donation-methods">
            <div class="donation-method">
                <h3>Euro via Ko-fi</h3>
                <script type='text/javascript' src='https://storage.ko-fi.com/cdn/widget/Widget_2.js'></script>
                <script type='text/javascript'>
                    kofiwidget2.init('Me apoie no Ko-fi', 'revert-layer', 'D1D76X1T1');
                    kofiwidget2.draw();
                </script>
            </div>

            <div class="donation-method">
                <h3>USDT (TRC20)</h3>
                <div class="crypto-address">
                    TFb65PXkvCDhK7WjTT5hkcP5WHwxYh51A8
                </div>
                <img src="https://sqlize.online/favicons/usdt-TFb65PXkvCDhK7WjTT5hkcP5WHwxYh51A8.png" 
                     alt="USDT QR Code" 
                     style="max-width: 200px; margin: 1rem 0;">
                <p class="warning-text">Envie apenas USDT TRC20 para este endereço.<br>
                O envio de outros ativos pode resultar em perda permanente.</p>
            </div>
        </div>
    </div>

    <div class="thank-you">
        <p>Obrigado por ser uma parte valiosa da comunidade SQLtest.online! ❤️</p>
    </div>
</div>