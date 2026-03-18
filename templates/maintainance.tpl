<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SQLtest.online — Maintenance</title>
    <link rel="stylesheet" href="/style.min.css?{$VERSION}">
    <style>
        .maintenance-container {
            max-width: 680px;
            margin: 0 auto;
            padding: 2rem 1.5rem;
            text-align: center;
        }

        .maintenance-logo {
            font-family: 'Source Code Pro', monospace;
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 2rem;
            letter-spacing: -0.5px;
        }

        .maintenance-status {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(255, 165, 0, 0.12);
            border: 1px solid rgba(255, 165, 0, 0.4);
            border-radius: 2rem;
            padding: 0.4rem 1.1rem;
            font-size: 0.85rem;
            font-weight: 600;
            color: #d97706;
            margin-bottom: 2.5rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .maintenance-status::before {
            content: '';
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #f59e0b;
            animation: pulse 1.8s ease-in-out infinite;
            flex-shrink: 0;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50%       { opacity: 0.4; transform: scale(0.7); }
        }

        .maintenance-icon {
            font-size: 3rem;
            margin-bottom: 1.5rem;
            display: block;
        }

        .message-block {
            margin: 1rem 0;
            padding: 1.5rem 2rem;
            background: var(--background-color);
            border-radius: 10px;
            border-left: 4px solid var(--primary-color);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            text-align: left;
        }

        .message-header {
            display: flex;
            align-items: center;
            gap: 0.6rem;
            margin-bottom: 0.75rem;
        }

        .message-flag {
            font-size: 1.2rem;
            line-height: 1;
        }

        .message-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--text-color);
        }

        .message-text {
            font-size: 1rem;
            line-height: 1.65;
            color: var(--text-color-secondary);
        }

        .estimated-time {
            margin-top: 0.75rem;
            font-size: 0.9rem;
            font-style: italic;
            color: var(--text-color-secondary);
            opacity: 0.85;
        }

        .contact-info {
            margin-top: 2.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--border-color, rgba(0,0,0,0.1));
            font-size: 0.88rem;
            color: var(--text-color-secondary);
            line-height: 1.8;
        }

        .contact-info a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
        }

        .contact-info a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="full-container">
        <div class="container3" style="background-color: var(--body-background-color);">
            <div class="maintenance-container">

                <div class="maintenance-logo">
                    <span class="logo-sql">SQL</span><span class="logo-test">test</span>.<span class="logo-test">online</span>
                </div>

                <span class="maintenance-status">Maintenance in progress</span>

                <span class="maintenance-icon">🔧</span>

                <!-- English -->
                <div class="message-block">
                    <div class="message-header">
                        <span class="message-flag">🇬🇧</span>
                        <div class="message-title">Site Maintenance</div>
                    </div>
                    <div class="message-text">
                        We are currently performing scheduled maintenance to improve our services and infrastructure.
                        We apologize for the inconvenience — the site will be back online shortly.
                        <div class="estimated-time">⏱ Estimated completion: 2 hours</div>
                    </div>
                </div>

                <!-- French -->
                <div class="message-block">
                    <div class="message-header">
                        <span class="message-flag">🇫🇷</span>
                        <div class="message-title">Maintenance du Site</div>
                    </div>
                    <div class="message-text">
                        Nous effectuons actuellement une maintenance programmée afin d'améliorer nos services et notre infrastructure.
                        Nous vous prions de nous excuser pour la gêne occasionnée — le site sera de nouveau disponible très prochainement.
                        <div class="estimated-time">⏱ Durée estimée : 2 heures</div>
                    </div>
                </div>

                <!-- Russian -->
                <div class="message-block">
                    <div class="message-header">
                        <span class="message-flag">🇷🇺</span>
                        <div class="message-title">Техническое обслуживание</div>
                    </div>
                    <div class="message-text">
                        В настоящее время проводятся плановые технические работы по улучшению наших сервисов и инфраструктуры.
                        Приносим извинения за неудобства — сайт скоро возобновит работу в полном объёме.
                        <div class="estimated-time">⏱ Ориентировочное время завершения: 2 часа</div>
                    </div>
                </div>

                <!-- Portuguese -->
                <div class="message-block">
                    <div class="message-header">
                        <span class="message-flag">🇧🇷</span>
                        <div class="message-title">Manutenção do Site</div>
                    </div>
                    <div class="message-text">
                        Estamos realizando manutenção programada para melhorar nossos serviços e infraestrutura.
                        Pedimos desculpas pelo inconveniente — o site voltará ao ar em breve.
                        <div class="estimated-time">⏱ Tempo estimado de conclusão: 2 horas</div>
                    </div>
                </div>

                <div class="contact-info">
                    For urgent inquiries / Pour toute urgence / Для срочных вопросов / Para consultas urgentes:<br>
                    <a href="mailto:support@sqltest.online">support@sqltest.online</a>
                </div>

            </div>
        </div>
    </div>

    <script>
        if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
            document.body.setAttribute('data-theme', 'dark');
        }
    </script>
</body>
</html>