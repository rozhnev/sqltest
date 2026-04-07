<script src="https://yastatic.net/s3/passport-sdk/autofill/v1/sdk-suggest-with-polyfills-latest.js"></script>

<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id={$GOOGLE_TAG_MANAGER_ID}"></script>
<script>
    {literal}
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());

    gtag('config', '{/literal}{$GOOGLE_TAG_MANAGER_ID}{literal}');

    (function(m,e,t,r,i,k,a){m[i]=m[i]||function(){(m[i].a=m[i].a||[]).push(arguments)};
    m[i].l=1*new Date();
    for (var j = 0; j < document.scripts.length; j++) {if (document.scripts[j].src === r) { return; }}
    k=e.createElement(t),a=e.getElementsByTagName(t)[0],k.async=1,k.src=r,a.parentNode.insertBefore(k,a)})
    (window, document, "script", "https://mc.yandex.ru/metrika/tag.js", "ym");

    ym({/literal}{$YANDEX_METRIKA_ID}{literal}, "init", {
        clickmap:true,
        trackLinks:true,
        accurateTrackBounce:true
    });
    {/literal}
</script>
<noscript><div><img src="https://mc.yandex.ru/watch/{$YANDEX_METRIKA_ID}" style="position:absolute; left:-9999px;" alt="" /></div></noscript>