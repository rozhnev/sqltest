-- Singleton table backing the site-wide urgent banner (see templates/urgent_banner.tpl).
-- Bump "version" whenever the message changes to re-show the banner to visitors who dismissed a previous one.
CREATE TABLE IF NOT EXISTS urgent_banner (
    id smallint PRIMARY KEY DEFAULT 1,
    enabled boolean NOT NULL DEFAULT false,
    version integer NOT NULL DEFAULT 1,
    background text NOT NULL DEFAULT 'linear-gradient(90deg, #7f1d1d 0%, #b91c1c 45%, #dc2626 100%)',
    text_color text NOT NULL DEFAULT '#ffffff',
    messages jsonb NOT NULL DEFAULT '{}'::jsonb,
    updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT urgent_banner_singleton CHECK (id = 1)
);

INSERT INTO urgent_banner (id, enabled, version, background, text_color, messages)
VALUES (
    1,
    true,
    1,
    'linear-gradient(90deg, #7f1d1d 0%, #b91c1c 45%, #dc2626 100%)',
    '#ffffff',
    '{
        "ru": "<span style=\"color:#ffffff;\">\ud83d\ude4f <strong style=\"color:#ffe082;\">\u0421\u043f\u0430\u0441\u0438\u0431\u043e \u0437\u0430 \u043f\u043e\u0434\u0434\u0435\u0440\u0436\u043a\u0443 \u0432 \u043f\u0440\u043e\u0448\u043b\u043e\u043c \u043c\u0435\u0441\u044f\u0446\u0435!</strong> \u041f\u043e\u0434\u0434\u0435\u0440\u0436\u0438\u0442\u0435 \u043d\u0430\u0441 \u0441\u043d\u043e\u0432\u0430 \u2014 \u043f\u0440\u043e\u0435\u043a\u0442 \u0440\u0430\u0441\u0442\u0451\u0442 \u0431\u043b\u0430\u0433\u043e\u0434\u0430\u0440\u044f \u0432\u0430\u043c.</span> <a href=\"/ru/donate\" style=\"color:#ffd54f; text-decoration:underline; font-weight:bold; white-space:nowrap;\">\u041f\u043e\u0434\u0434\u0435\u0440\u0436\u0430\u0442\u044c \u0441\u043d\u043e\u0432\u0430 \u2192</a>",
        "en": "<span style=\"color:#ffffff;\">\ud83d\ude4f <strong style=\"color:#ffe082;\">Thank you for your support last month!</strong> Thanks to you, the project keeps growing. We''d be grateful if you could support us again this month.</span> <a href=\"/en/donate\" style=\"color:#ffd54f; text-decoration:underline; font-weight:bold; white-space:nowrap;\">Support again \u2192</a>",
        "es": "<span style=\"color:#ffffff;\">\ud83d\ude4f <strong style=\"color:#ffe082;\">\u00a1Gracias por su apoyo el mes pasado!</strong> Gracias a usted, el proyecto sigue creciendo. Nos encantar\u00eda contar con su apoyo tambi\u00e9n este mes.</span> <a href=\"/es/donate\" style=\"color:#ffd54f; text-decoration:underline; font-weight:bold; white-space:nowrap;\">Apoyar de nuevo \u2192</a>",
        "fr": "<span style=\"color:#ffffff;\">\ud83d\ude4f <strong style=\"color:#ffe082;\">Merci pour votre soutien le mois dernier !</strong> Gr\u00e2ce \u00e0 vous, le projet continue de grandir. Nous esp\u00e9rons pouvoir compter sur votre soutien \u00e0 nouveau ce mois-ci.</span> <a href=\"/fr/donate\" style=\"color:#ffd54f; text-decoration:underline; font-weight:bold; white-space:nowrap;\">Soutenir \u00e0 nouveau \u2192</a>",
        "pt": "<span style=\"color:#ffffff;\">\ud83d\ude4f <strong style=\"color:#ffe082;\">Obrigado pelo seu apoio no m\u00eas passado!</strong> Gra\u00e7as a voc\u00ea, o projeto continua crescendo. Ficar\u00edamos gratos se pudesse nos apoiar novamente este m\u00eas.</span> <a href=\"/pt/donate\" style=\"color:#ffd54f; text-decoration:underline; font-weight:bold; white-space:nowrap;\">Apoiar novamente \u2192</a>",
        "zh": "<span style=\"color:#ffffff;\">\ud83d\ude4f <strong style=\"color:#ffe082;\">\u611f\u8c22\u60a8\u4e0a\u4e2a\u6708\u7684\u652f\u6301\uff01</strong> \u56e0\u4e3a\u6709\u60a8\uff0c\u8fd9\u4e2a\u9879\u76ee\u5f97\u4ee5\u6301\u7eed\u53d1\u5c55\u3002\u5e0c\u671b\u672c\u6708\u4e5f\u80fd\u7ee7\u7eed\u5f97\u5230\u60a8\u7684\u652f\u6301\u3002</span> <a href=\"/zh/donate\" style=\"color:#ffd54f; text-decoration:underline; font-weight:bold; white-space:nowrap;\">\u518d\u6b21\u652f\u6301 \u2192</a>"
    }'::jsonb
)
ON CONFLICT (id) DO NOTHING;
