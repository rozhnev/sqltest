<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SQLtest.online - Maintenance</title>
    <link rel="stylesheet" href="/style.css">
    <style>
        .maintenance-container {
            max-width: 800px;
            margin: 4rem auto;
            padding: 2rem;
            text-align: center;
        }

        .logo {
            font-family: 'Source Code Pro', monospace;
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 3rem;
            color: var(--primary-color);
        }

        .message-block {
            margin: 2rem 0;
            padding: 2rem;
            background: var(--background-color);
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .message-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--text-color);
        }

        .message-text {
            font-size: 1.1rem;
            line-height: 1.6;
            color: var(--text-color-secondary);
        }

        .estimated-time {
            margin-top: 1rem;
            font-style: italic;
            color: var(--text-color-secondary);
        }

        .contact-info {
            margin-top: 3rem;
            font-size: 0.9rem;
            color: var(--text-color-secondary);
        }

        .contact-info a {
            color: var(--primary-color);
            text-decoration: none;
        }

        .contact-info a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="full-container">
        <div class="container3">
            <div class="logo">
            <span class="logo-sql">SQL</span>
            <span class="logo-test">test</span>
            <span class="logo-dot">●</span>
            <span class="logo-test">online</span>
        </div>

        <!-- English -->
        <div class="message-block">
            <div class="message-title">Site Maintenance</div>
            <div class="message-text">
                We are currently performing scheduled maintenance to improve our services.
                The site will be back online shortly.
                <div class="estimated-time">
                    Estimated completion time: 2 hours
                </div>
            </div>
        </div>

        <!-- Russian -->
        <div class="message-block">
            <div class="message-title">Техническое обслуживание</div>
            <div class="message-text">
                В настоящее время проводятся плановые технические работы для улучшения наших сервисов.
                Сайт скоро возобновит работу.
                <div class="estimated-time">
                    Ориентировочное время завершения: 2 часа
                </div>
            </div>
        </div>

        <!-- Portuguese -->
        <div class="message-block">
            <div class="message-title">Manutenção do Site</div>
            <div class="message-text">
                Estamos realizando manutenção programada para melhorar nossos serviços.
                O site voltará ao ar em breve.
                <div class="estimated-time">
                    Tempo estimado de conclusão: 2 horas
                </div>
            </div>
        </div>

        <div class="contact-info">
            For urgent inquiries / Для срочных вопросов / Para consultas urgentes:<br>
            <a href="mailto:support@sqltest.online">rozhnev@msn.com</a>
        </div>
    </div>

    <script>
        // Определение предпочтительной темы пользователя
        if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
            document.body.setAttribute('data-theme', 'dark');
        }
    </script>
</body>
</html>