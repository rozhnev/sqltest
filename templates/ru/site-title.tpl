<title>
    {if isset($PageTitle)}
        {$PageTitle}
    {else}
        SQL задачи{if isset($Question) && $Question.title}: {$Question.title}{/if}
    {/if}
</title>
<meta http-equiv = "content-language" content = "ru">
<meta name="description" content="{if isset($PageDescription)}{$PageDescription}{else}Пройдите SQL тест. Решайте SQL задачи, пишите эффективные SQL запросы, изучайте концепции и повышайте уровень знаний. Станьте экспертом в SQL!{/if}"/>
<meta name="keywords" content="практические задачи по SQL, тест на знание SQL, sakila mysql, postgresql, sql server">
<meta property="og:site_name" content="SQLtest.online">
<meta property="og:type" content="website">
<meta property="og:title" content="SQLtest - задачи по SQL"/>
<meta property="og:description" content="Практические задачи по SQL{if $Question && $Question.title}: {$Question.title}{/if}" />
<meta property="og:url" content="https://sqltest.online/favicons/android-chrome-192x192.png" />
<meta property="og:image:secure_url" itemprop="image" content="https://sqltest.online/favicons/android-chrome-192x192.png" />
<meta property="og:image" itemprop="image" content="https://sqltest.online/favicons/android-chrome-192x192.png" />
<meta property="og:image:width" content="192" />
<meta property="og:image:height" content="192" />
<meta property="og:image:type" content="image/png" />
<meta property="og:updated_time" content="20240101T000000Z" />