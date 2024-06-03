<!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <meta charset="utf-8">
            <script>
                function loadUIConfig() {
                    const defaultConfig = {
                        hideSolvedTasks: false,
                        hideInfoPanel: false,
                        theme: 'light'
                    };
                    try {
                        const UIConfig = localStorage.getItem("UIConfig");
                        return UIConfig ? JSON.parse(UIConfig) : defaultConfig;
                    } catch (err) {
                        return defaultConfig
                    }
                }
                window.UIConfig = loadUIConfig();
                document.documentElement.setAttribute('data-theme', window.UIConfig.theme);
            </script>
            {include file='site-title.tpl'}
            <link rel="apple-touch-icon" sizes="180x180" href="/favicons/apple-touch-icon.png">
            <link rel="icon" type="image/png" href="/favicons/favicon-32x32.png" sizes="32x32">
            <link rel="icon" type="image/png" href="/favicons/favicon-16x16.png" sizes="16x16">
            <link rel="stylesheet" type="text/css" href="/style.css?26" media="all">
            <!-- Yandex.RTB -->
            <script>window.yaContextCb=window.yaContextCb||[]</script>
            <script src="https://yandex.ru/ads/system/context.js" async></script>
                <script src="https://yastatic.net/s3/passport-sdk/autofill/v1/sdk-suggest-with-polyfills-latest.js"></script>
            <script type="text/javascript" src="/script.js?26" defer></script>
            {literal}
            <!-- Google tag (gtag.js) -->
            <script async src="https://www.googletagmanager.com/gtag/js?id=G-PCGW7ZLSD1"></script>
            <script>
                window.dataLayer = window.dataLayer || [];
                function gtag(){dataLayer.push(arguments);}
                gtag('js', new Date());

                gtag('config', 'G-PCGW7ZLSD1');
            </script>
            <!-- Yandex.Metrika counter -->
            <script type="text/javascript" >
            (function(m,e,t,r,i,k,a){m[i]=m[i]||function(){(m[i].a=m[i].a||[]).push(arguments)};
            m[i].l=1*new Date();
            for (var j = 0; j < document.scripts.length; j++) {if (document.scripts[j].src === r) { return; }}
            k=e.createElement(t),a=e.getElementsByTagName(t)[0],k.async=1,k.src=r,a.parentNode.insertBefore(k,a)})
            (window, document, "script", "https://mc.yandex.ru/metrika/tag.js", "ym");

            ym(95990842, "init", {
                clickmap:true,
                trackLinks:true,
                accurateTrackBounce:true
            });
            {/literal}
            </script>
            <noscript><div><img src="https://mc.yandex.ru/watch/95990842" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
            <!-- /Yandex.Metrika counter -->

        </head>