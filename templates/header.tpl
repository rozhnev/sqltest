
<!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta http-equiv="Permissions-Policy" content="browsing-topics=('mc.yandex.com')">
            <meta name="viewport" content="width=device-width, initial-scale=1;"/>
            <meta charset="utf-8">
            <meta name="description" content="Free online SQL test.">
            <meta name="keywords" content="free sql test,online testing, sql, fiddle">
            <meta Content-Security-Policy-Report-Only: script-src https://accounts.google.com/gsi/client; frame-src https://accounts.google.com/gsi/; connect-src https://accounts.google.com/gsi/; />
            <meta name="google-signin-client_id" content="340274762951-1d5m1pb8p9i2bhjbtuc4p8q9gveuk2ug.apps.googleusercontent.com">
            {include file='site-title.tpl'}
            <link rel="apple-touch-icon" sizes="180x180" href="/favicons/apple-touch-icon.png">
            <link rel="icon" type="image/png" href="/favicons/favicon-32x32.png" sizes="32x32">
            <link rel="icon" type="image/png" href="/favicons/favicon-16x16.png" sizes="16x16">
            <link rel="stylesheet" type="text/css" href="/style.css?7" media="all">
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/ace.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/ext-beautify.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/mode-sql.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/mode-mysql.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/theme-xcode.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/ext-language_tools.js"></script>
            <!-- Yandex.RTB -->
            <script>window.yaContextCb=window.yaContextCb||[]</script>
            <script src="https://yandex.ru/ads/system/context.js" async></script>
                <script src="https://yastatic.net/s3/passport-sdk/autofill/v1/sdk-suggest-with-polyfills-latest.js"></script>
            <script type="text/javascript" src="/script.js?6" defer></script>
            {literal}
            <!-- Yandex.RTB R-A-4716552-1 -->
            <script>
            window.yaContextCb.push(()=>{
                // Ya.Context.AdvManager.render({
                //     "blockId": "R-A-4716552-1",
                //     "type": "fullscreen",
                //     "platform": "touch"
                // });
                Ya.Context.AdvManager.render({
                    "blockId": "R-A-4716552-2",
                    "renderTo": "yandex_rtb_R-A-4716552-2"
                })
            })
            <!-- Yandex.RTB R-A-4716552-2 -->
            </script>
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
            var lang = '{$Lang}',
                db   = '{$DB}',
                questionId = '{$QuestionID}';
            </script>
            <noscript><div><img src="https://mc.yandex.ru/watch/95990842" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
            <!-- /Yandex.Metrika counter -->

        </head>
        <body>
            <div class="container">
                <div class="toast" id="toast">php result copied to buffer</div>
                {include file='login-popup.tpl'}
