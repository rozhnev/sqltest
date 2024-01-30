

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
            {include file='../en/site-title.tpl'}
            <link rel="apple-touch-icon" sizes="180x180" href="/favicons/apple-touch-icon.png">
            <link rel="icon" type="image/png" href="/favicons/favicon-32x32.png" sizes="32x32">
            <link rel="icon" type="image/png" href="/favicons/favicon-16x16.png" sizes="16x16">
            <link rel="stylesheet" type="text/css" href="/style.css?8" media="all">
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/ace.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/ext-beautify.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/mode-sql.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/mode-mysql.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/theme-xcode.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/ext-language_tools.js"></script>
            <script type="text/javascript" src="/script.js?8" defer></script>
            <script>
                var lang = '{$Lang}',
                    db   = '{$DB}',
                    questionId = '{$QuestionID}';
            </script>

        </head>
        <body>
            <div class="container">
                <div class="toast" id="toast">php result copied to buffer</div>
                {include file='../en/login-popup.tpl'}

                {include file='../en/top-menu.tpl'}

                {if $Logged && $Admin}
                    Welcome, admin user!
                {else}
                    You must be looged as admin before open this page
                {/if}
                {include file='../footer.tpl'}