<?xml version="1.0" encoding="UTF-8"?>

<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    <url>
      <loc>https://{$Domain}/</loc>
      <lastmod>{$Today}</lastmod>
      <changefreq>monthly</changefreq>
      <priority>0.8</priority>
    </url>
    {foreach from=$Languages key=langCode item=langName}
    <url>
      <loc>https://{$Domain}/{$langCode}</loc>
      <lastmod>{$Today}</lastmod>
      <changefreq>monthly</changefreq>
      <priority>0.8</priority>
    </url>
    <url>
      <loc>https://{$Domain}/{$langCode}/books</loc>
      <lastmod>{$Today}</lastmod>
      <changefreq>monthly</changefreq>
      <priority>0.8</priority>
    </url>
    <url>
      <loc>https://{$Domain}/{$langCode}/about</loc>
      <lastmod>{$Today}</lastmod>
      <changefreq>monthly</changefreq>
      <priority>0.3</priority>
    </url>
    <url>
      <loc>https://{$Domain}/{$langCode}/privacy-policy</loc>
      <lastmod>{$Today}</lastmod>
      <changefreq>monthly</changefreq>
      <priority>0.3</priority>
    </url>
    {/foreach}
    {foreach from=$Questionnire item=question}
      {foreach from=$Languages key=langCode item=langName}
      <url>
        <loc>https://{$Domain}/{$langCode}/question/{$question['category']}/{$question['question']}</loc>
        <lastmod>{$Today}</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.3</priority>
      </url>
      {/foreach}
    {/foreach}
    {foreach from=$Lessons item=lesson}
      {foreach from=$Languages key=langCode item=langName}
      <url>
        <loc>https://{$Domain}/{$langCode}/lesson/{$lesson['module']}/{$lesson['slug']}</loc>
        <lastmod>{$Today}</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.3</priority>
      </url>
      {/foreach}
    {/foreach}
</urlset>