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
<title>{$PageTitle}</title>
<meta http-equiv = "content-language" content = "{$Lang}">
<meta name="description" content="{$PageDescription}"/>
<meta name="keywords" content="{translate}page_keywords{/translate}">
<meta property="og:site_name" content="SQLtest.online">
<meta property="og:type" content="website">
<meta property="og:title" content="{$PageOGTitle}"/>
<meta property="og:description" content="{$PageOGDescription}" />
<meta property="og:url" content="https://sqltest.online/favicons/android-chrome-192x192.png" />
<meta property="og:image" content="https://sqltest.online/favicons/android-chrome-192x192.png" />
<meta property="og:image:width" content="192" />
<meta property="og:image:height" content="192" />
<meta property="og:image:type" content="image/png" />
<meta property="og:updated_time" content="20240101T000000Z" />