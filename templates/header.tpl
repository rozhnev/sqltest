
<!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml" lang="{$Lang}">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta http-equiv="Permissions-Policy" content="browsing-topics=('mc.yandex.com')">
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
            <meta Content-Security-Policy-Report-Only: script-src https://accounts.google.com/gsi/client; frame-src https://accounts.google.com/gsi/; connect-src https://accounts.google.com/gsi/; />
            <meta http-equiv="Content-Security-Policy" content="frame-src 'self' mc.yandex.md mc.yandex.ru mc.yandex.com yandex.ru passport.yandex.ru oauth.yandex.ru yango.com passport.yango.com oauth.yango.com yastatic.net autofill.yandex.ru;">
            <meta name="google-signin-client_id" content="340274762951-1d5m1pb8p9i2bhjbtuc4p8q9gveuk2ug.apps.googleusercontent.com">
            {include file='site-title.tpl'}
            <link rel="apple-touch-icon" sizes="180x180" href="/favicons/apple-touch-icon.png">
            <link rel="icon" type="image/png" href="/favicons/favicon-32x32.png" sizes="32x32">
            <link rel="icon" type="image/png" href="/favicons/favicon-16x16.png" sizes="16x16">
        {if $CanonicalLink}
            <link rel="canonical" href="{$CanonicalLink}">
        {/if}
            <link rel="stylesheet" type="text/css" href="/style.css?{$VERSION}" media="all">
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.9/ace.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.9/ext-beautify.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.9/mode-sql.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.9/mode-mysql.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.9/theme-xcode.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.9/ext-language_tools.js"></script>
            <!-- Yandex.RTB -->
            <script>window.yaContextCb=window.yaContextCb||[]</script>
            <script src="https://yandex.ru/ads/system/context.js" async></script>
            <script type="text/javascript" src="/script.js?{$VERSION}" defer></script>
            <script>
                {if $MobileView}
                    {literal}
                    window.yaContextCb.push(()=>{
                        Ya.Context.AdvManager.render({
                            "blockId": "R-A-4716552-3",
                            "type": "floorAd",
                            "platform": "touch"
                        })
                    })
                    {/literal}
                {else}
                    {literal}
                    window.yaContextCb.push(()=>{
                        Ya.Context.AdvManager.render({
                            "blockId": "R-A-4716552-2",
                            "renderTo": "yandex_rtb_R-A-4716552-2",
                            darkTheme: window.UIConfig.theme === 'dark'
                        })
                    });
                    window.yaContextCb.push(()=>{
                        Ya.Context.AdvManager.render({
                            "blockId": "R-A-4716552-4",
                            "renderTo": "yandex_rtb_R-A-4716552-4",
                            darkTheme: window.UIConfig.theme === 'dark'
                        })
                    })
                    {/literal}
                {/if}
                var lang = '{$Lang}',
                db   = '{$DB}',
                questionId = '{$QuestionID}';
            </script>
        </head>

