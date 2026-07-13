<!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml" lang="{$Lang}">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <meta charset="utf-8">
            <script>
                function loadUIConfig() {
                    const defaultConfig = {
                        hideSolvedTasks: false,
                        hideInfoPanel: false,
                        theme: 'light'
                    };
                    try {
                        const UIConfig = localStorage.getItem("UIConfig");
                        return UIConfig ? JSON.parse(UIConfig) : defaultConfig;
                    } catch (err) {
                        return defaultConfig
                    }
                }
                window.UIConfig = loadUIConfig();
                document.documentElement.setAttribute('data-theme', window.UIConfig.theme);
                window.AppConfig = Object.assign({}, window.AppConfig, {
                    googleClientId: '{$GOOGLE_CLIENT_ID|escape:"javascript"}',
                    githubClientId: '{$GITHUB_CLIENT_ID|escape:"javascript"}',
                    googleTagManagerId: '{$GOOGLE_TAG_MANAGER_ID|escape:"javascript"}',
                    yandexMetrikaId: '{$YANDEX_METRIKA_ID|escape:"javascript"}'
                });
            </script>
            {include file='site-title.tpl'}
            <link rel="apple-touch-icon" sizes="180x180" href="/favicons/apple-touch-icon.png">
            <link rel="icon" type="image/png" href="/favicons/favicon-32x32.png" sizes="32x32">
            <link rel="icon" type="image/png" href="/favicons/favicon-16x16.png" sizes="16x16">
            <link rel="stylesheet" type="text/css" href="/style.min.css?{$VERSION}" media="all">
            <script src="https://yastatic.net/s3/passport-sdk/autofill/v1/sdk-suggest-with-polyfills-latest.js"></script>
            <script type="text/javascript" src="/script.js?{$VERSION}" defer></script>
            <script type="text/javascript" src="/js/analytics.js?{$VERSION}" defer></script>
            <script>
                var lang = '{$Lang}',
                    db   = '',
                    questionId = '';
            </script>
            <!-- Yandex.Metrika noscript fallback -->
            <noscript><div><img src="https://mc.yandex.ru/watch/{$YANDEX_METRIKA_ID}" style="position:absolute; left:-9999px;" alt="" aria-hidden="true" /></div></noscript>

        </head>