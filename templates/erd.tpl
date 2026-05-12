<!DOCTYPE html>
{assign var="Db" value=$Params.db}
{assign var="Theme" value=$Params.theme|default:'ligth'}
{assign var="ErdBase" value="/images/`$Db|lower`_`$Theme`"}
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
        <link rel="stylesheet" type="text/css" href="/style.min.css?{$VERSION}" media="all">
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
        <style>
            .erd-helper-text {
                text-align: center;
                color: var(--question-text);
            }
        </style>
    </head>
    <body>
        <div class="full-container">
            <div style="justify-items: center; margin-top: 5em;">
                <h2 class="erd-helper-text">{translate}erd_diagram{/translate}</h2>
                <div style="margin-top: 1em; max-width:100%;">
                    <object data="{$ErdBase}.svg" type="image/svg+xml" style="max-width:100%;">
                        <img src="{$ErdBase}.jpg" title="" style="max-width:100%;" onerror="this.onerror=null;this.src='{$ErdBase}.png';"/>
                    </object>
                </div>
            </div>
        </div>
        {include file='counters.tpl'}
    </body>
</html>