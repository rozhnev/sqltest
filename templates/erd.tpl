<!DOCTYPE html>
{assign var="Db" value=$Params.db}
{assign var="Theme" value=$Params.theme|default:'light'}
{assign var="ErdBase" value="/images/`$Db|lower`_`$Theme`"}
{assign var="PageTitle" value="`$Db` ER Diagram | SQLtest.online"}
{assign var="PageDescription" value="Entity relationship diagram for the `$Db` sample database with table-level foreign key relationships and downloadable SVG image."}
{assign var="PageOGTitle" value=$PageTitle}
{assign var="PageOGDescription" value=$PageDescription}
{assign var="PageOGImage" value="https://sqltest.online`$ErdBase`.jpg"}
{assign var="PageOGImageAlt" value="ER diagram for `$Db` database"}
{assign var="PageOGImageWidth" value="1600"}
{assign var="PageOGImageHeight" value="1200"}
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$Lang}" data-theme="{$Params.theme|default:'light'}">
    <head>
        {include file='site-title.tpl'}
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Permissions-Policy" content="browsing-topics=('mc.yandex.com')">
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <meta charset="utf-8">
        {if isset($CanonicalLink) && $CanonicalLink}
            <link rel="canonical" href="{$CanonicalLink}">
        {/if}
        <meta name="twitter:card" content="summary_large_image">
        <meta name="twitter:title" content="{$PageOGTitle|escape:'html'}">
        <meta name="twitter:description" content="{$PageOGDescription|escape:'html'}">
        <meta name="twitter:image" content="{$PageOGImage|escape:'html'}">
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
                    darkTheme: '{$Params.theme|default:'light'}' === 'dark'
                {rdelim})
            {rdelim})
        </script>
        <script type="application/ld+json">
            {ldelim}
                "@context": "https://schema.org",
                "@type": "WebPage",
                "name": "{$PageTitle|escape:'javascript'}",
                "description": "{$PageDescription|escape:'javascript'}",
                "inLanguage": "{$Lang|escape:'javascript'}",
                "primaryImageOfPage": {ldelim}
                    "@type": "ImageObject",
                    "contentUrl": "https://sqltest.online{$ErdBase|escape:'javascript'}.svg",
                    "encodingFormat": "image/svg+xml",
                    "name": "{$Db|escape:'javascript'} ER diagram"
                {rdelim}
            {rdelim}
        </script>
        <style>
            .erd-helper-text {
                text-align: center;
                color: var(--question-text);
            }
            .erd-lead {
                margin: 0 auto;
                max-width: 980px;
                text-align: center;
                color: var(--question-text);
                line-height: 1.5;
            }
            .erd-actions {
                margin-top: 0.75em;
                text-align: center;
            }
            .erd-actions a {
                margin: 0 0.5em;
            }
        </style>
    </head>
    <body>
        <div class="full-container">
            <div style="justify-items: center; margin-top: 5em;">
                <h1 class="erd-helper-text">{translate}erd_diagram{/translate}</h1>
                <p class="erd-lead">
                    This ER diagram shows the main entities and foreign key relationships for the {$Db} database.
                </p>
                <p class="erd-actions">
                    <a href="{$ErdBase}.svg" download>{$Db} ERD SVG</a>
                </p>
                <div style="margin-top: 1em; max-width:100%;">
                    <object data="{$ErdBase}.svg" type="image/svg+xml" style="max-width:100%;" aria-label="{$Db} entity relationship diagram" role="img"></object>
                </div>
            </div>
        </div>
        {include file='counters.tpl'}
    </body>
</html>