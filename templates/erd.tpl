<!DOCTYPE html>
{assign var="Db" value=$Params.db}
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$Lang}" data-theme="{$Params.theme|default:'ligth'}">
    <head>
        <title>{translate}erd_diagram{/translate}</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Permissions-Policy" content="browsing-topics=('mc.yandex.com')">
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <meta charset="utf-8">
        <link rel="apple-touch-icon" sizes="180x180" href="/favicons/apple-touch-icon.png">
        <link rel="icon" type="image/png" href="/favicons/favicon-32x32.png" sizes="32x32">
        <link rel="icon" type="image/png" href="/favicons/favicon-16x16.png" sizes="16x16">
        <link rel="stylesheet" type="text/css" href="/style.css?{$VERSION}" media="all">
        <!-- Yandex.RTB -->
        <script>window.yaContextCb=window.yaContextCb||[]</script>
        <script src="https://yandex.ru/ads/system/context.js" async></script>
        <!-- Yandex.RTB R-A-4716552-6 -->
        <script>
            window.yaContextCb.push(() => {ldelim}
                Ya.Context.AdvManager.render({ldelim}
                    "blockId": "R-A-4716552-6",
                    "type": "topAd",
                    darkTheme: '{$Params.theme|default:'ligth'}' === 'dark'
                {rdelim})
            {rdelim})
        </script>
    </head>
    <body>
        <div class="full-container">
            <div style="justify-items: center; margin-top: 5em;">
                <h2 style="text-align: center;">{translate}erd_diagram{/translate}</h2>
                <div style="margin-top: 1em; max-width:100%;">
                    <img src="/images/{$Params.db|lower}_{$Params.theme|default:'ligth'}.png" title="" style="max-width:100%;"/>
                </div>
            </div>
        </div>
    </body>
</html>