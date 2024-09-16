<title>{if isset($PageTitle)}{$PageTitle}{else}{if isset($Question) && $Question.title}SQL тренажер: {$Question.title}{else}SQL задачи{/if}{/if}</title>
<meta http-equiv = "content-language" content = "ru">
{if !isset($PageDescription)}
    {if isset($Question) && $Question.title}
        {if $Question.have_answers}
            {assign var="PageDescription" value="Пройдите тест на знание SQL. Ответьте на вопрос: {$Question.title}"}
        {else}
            {assign var="PageDescription" value="Решите SQL задачу: «{$Question.title}». Напишите эффективный SQL запрос как профи!"}
        {/if}
    {else}
        {assign var="PageDescription" value="Пройдите SQL тест. Решайте SQL задачи, пишите эффективные SQL запросы, изучайте концепции и повышайте уровень знаний. Станьте экспертом в SQL!"}
    {/if}
{/if}
<meta name="description" content="{$PageDescription}"/>
<meta name="keywords" content="SQL тренажер, практические задачи по SQL, тест на знание SQL, sakila mysql, postgresql, sql server">
<meta property="og:site_name" content="SQLtest.online">
<meta property="og:type" content="website">
<meta property="og:title" content="SQLtest - задачи по SQL"/>
<meta property="og:description" content="SQL тренажер{if isset($Question) && $Question.title}. Задача: {$Question.title}{/if}" />
<meta property="og:url" content="https://sqltest.online/favicons/android-chrome-192x192.png" />
{* <meta property="og:image:secure_url" itemprop="image" content="https://sqltest.online/favicons/android-chrome-192x192.png" /> *}
<meta property="og:image" {*itemprop="image" *}content="https://sqltest.online/favicons/android-chrome-192x192.png" />
<meta property="og:image:width" content="192" />
<meta property="og:image:height" content="192" />
<meta property="og:image:type" content="image/png" />
<meta property="og:updated_time" content="20240101T000000Z" />