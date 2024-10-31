{if !isset($PageTitle)}
    {if isset($Question) && $Question.title}
        {if $Question.have_answers}
            {assign var="PageTitle" value="{translate}page_question_title{/translate}: {$Question.title}"}
        {else}
            {assign var="PageTitle" value="{translate}page_task_title{/translate}: {$Question.title}"}
        {/if}
    {else}
        {assign var="PageTitle" value="{translate}page_default_title{/translate}"}
    {/if}
{/if}
{if !isset($PageDescription)}
    {if isset($Question) && $Question.title}
        {if $Question.have_answers}
            {assign var="PageDescription" value="{translate}page_question_description{/translate}: «{$Question.title}»"}
        {else}
            {assign var="PageDescription" value="{translate}page_task_description{/translate}: «{$Question.title}»"}
        {/if}
    {else}
        {assign var="PageDescription" value="{translate}page_default_description{/translate}"}
    {/if}
{/if}

<title>{$PageTitle}</title>
<meta http-equiv = "content-language" content = "{$Lang}">
<meta name="description" content="{$PageDescription}"/>
<meta name="keywords" content="{translate}page_keywords{/translate}">
<meta property="og:site_name" content="SQLtest.online">
<meta property="og:type" content="website">
<meta property="og:title" content="{translate}og_title{/translate}"/>
<meta property="og:description" content="{translate}og_description{/translate}{if isset($Question) && $Question.title}: {$Question.title}{else}.{/if}" />
<meta property="og:url" content="https://sqltest.online/favicons/android-chrome-192x192.png" />
<meta property="og:image" content="https://sqltest.online/favicons/android-chrome-192x192.png" />
<meta property="og:image:width" content="192" />
<meta property="og:image:height" content="192" />
<meta property="og:image:type" content="image/png" />
<meta property="og:updated_time" content="20240101T000000Z" />