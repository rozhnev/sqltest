<?xml version="1.0" encoding="UTF-8"?>

<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    {foreach from=$SITEMAP item=site}
    <url>
        <loc>{$site['loc']}</loc>
        <lastmod>{$site['lastmod']}</lastmod>
        <changefreq>{$site['changefreq']}</changefreq>
        <priority>{$site['priority']}</priority>
      </url>
    {/foreach}
</urlset>