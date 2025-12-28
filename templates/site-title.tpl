{if !isset($PageTitle)}
    {assign var="PageTitle" value="{translate}page_default_title{/translate}"}
{/if}
{if !isset($PageDescription)}
    {assign var="PageDescription" value="{translate}page_default_description{/translate}"}
{/if}
{if !isset($PageOGTitle)}
    {assign var="PageOGTitle" value="{translate}og_title{/translate}"}
{/if}
{if !isset($PageOGDescription)}
    {assign var="PageOGDescription" value="{translate}og_description{/translate}"}
{/if}
{if !isset($PageOGImage)}
    {assign var="PageOGImage" value="https://sqltest.online/favicons/android-chrome-512x512.png"}
{/if}
{if !isset($PageOGImageAlt)}
    {assign var="PageOGImageAlt" value="SQLtest.online"}
{/if}
{if !isset($PageOGImageWidth)}
    {assign var="PageOGImageWidth" value="512"}
{/if}
{if !isset($PageOGImageHeight)}
    {assign var="PageOGImageHeight" value="512"}
{/if}
<title>{$PageTitle}</title>
<meta http-equiv = "content-language" content = "{$Lang}">
<meta name="description" content="{$PageDescription}"/>
<meta name="keywords" content="{translate}page_keywords{/translate}">
<meta property="og:site_name" content="SQLtest.online">
<meta property="og:type" content="website">
<meta property="og:title" content="{$PageOGTitle}"/>
<meta property="og:description" content="{$PageOGDescription}" />
{if isset($CanonicalLink) && $CanonicalLink}
<meta property="og:url" content="{$CanonicalLink}" />
{else}
<meta property="og:url" content="https://sqltest.online/" />
{/if}
<meta property="og:image" content="{$PageOGImage}" />
<meta property="og:image:alt" content="{$PageOGImageAlt}" />
<meta property="og:image:width" content="{$PageOGImageWidth}" />
<meta property="og:image:height" content="{$PageOGImageHeight}" />
<meta property="og:image:type" content="image/png" />
{if isset($PageOGModifiedTime) && $PageOGModifiedTime}
    <meta property="article:modified_time" content="{$PageOGModifiedTime|escape}" />
    <meta property="og:updated_time" content="{$PageOGModifiedTime|escape}" />
{else}
    <meta property="article:modified_time" content="2025-01-01T00:00:00Z" />
    <meta property="og:updated_time" content="2025-01-01T00:00:00Z" />
{/if}