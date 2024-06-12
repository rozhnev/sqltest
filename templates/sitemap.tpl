<?xml version="1.0" encoding="UTF-8"?>

<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    <url>
      <loc>https://sqltest.online/</loc>
      <lastmod>{$Today}</lastmod>
      <changefreq>monthly</changefreq>
      <priority>0.8</priority>
    </url>
    <url>
      <loc>https://sqltest.online/ru</loc>
      <lastmod>{$Today}</lastmod>
      <changefreq>monthly</changefreq>
      <priority>0.8</priority>
    </url>
    <url>
      <loc>https://sqltest.online/en/about</loc>
      <lastmod>{$Today}</lastmod>
      <changefreq>monthly</changefreq>
      <priority>0.3</priority>
    </url>
    <url>
      <loc>https://sqltest.online/ru/about</loc>
      <lastmod>{$Today}</lastmod>
      <changefreq>monthly</changefreq>
      <priority>0.3</priority>
    </url>
    <url>
      <loc>https://sqltest.online/en/privacy-policy</loc>
      <lastmod>{$Today}</lastmod>
      <changefreq>monthly</changefreq>
      <priority>0.3</priority>
    </url>
    <url>
      <loc>https://sqltest.online/ru/privacy-policy</loc>
      <lastmod>{$Today}</lastmod>
      <changefreq>monthly</changefreq>
      <priority>0.3</priority>
    </url>
    {foreach from=$Questionnire item=question}
      <url>
        <loc>https://sqltest.online/ru/{$question['category']}/{$question['question']}</loc>
        <lastmod>{$Today}</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.3</priority>
      </url>
      <url>
        <loc>https://sqltest.online/en/{$question['category']}/{$question['question']}</loc>
        <lastmod>{$Today}</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.3</priority>
      </url>
    {/foreach}
</urlset>