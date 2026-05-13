<!DOCTYPE html>
{assign var="Db" value=$Params.db}
{assign var="DbKey" value=$Db|lower}
{assign var="PageTitle" value="`$Db` ER Diagram — Database Schema Visualization | SQLtest.online"}
{assign var="PageDescription" value="Interactive ER diagram for the `$Db` database. Explore table structure, primary/foreign key relationships, and download the schema as SVG. Perfect for SQL learning and database design."}
{assign var="PageOGTitle" value=$PageTitle}
{assign var="PageOGDescription" value=$PageDescription}
{assign var="PageOGImage" value="https://sqltest.online`$ErdBase`.svg"}
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
        <link rel="stylesheet" type="text/css" href="/css/erd.css?{$VERSION}" media="all">
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
    </head>
    <body>
        <div class="full-container">
            <div class="erd-page-wrap">
                <h1 class="erd-helper-text">{translate}erd_diagram{/translate}</h1>
                <p class="erd-lead">
                    This ER diagram shows the main entities and foreign key relationships for the {$Db} database.
                </p>
                <div class="erd-figure-wrap">
                {if file_exists("images/erd_{$DbKey}.svg")}
                    {include file="images/erd_{$DbKey}.svg"}
                {/if}
                </div>
            </div>
        </div>
        {include file='counters.tpl'}
    </body>
</html>