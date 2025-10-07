

<!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml" lang="{$Lang}">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta http-equiv="Permissions-Policy" content="browsing-topics=('mc.yandex.com')">
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <meta charset="utf-8">
            <meta name="description" content="Free online SQL test.">
            <meta name="keywords" content="free sql test,online testing, sql, fiddle">
            {include file='../en/site-title.tpl'}
            <link rel="apple-touch-icon" sizes="180x180" href="/favicons/apple-touch-icon.png">
            <link rel="icon" type="image/png" href="/favicons/favicon-32x32.png" sizes="32x32">
            <link rel="icon" type="image/png" href="/favicons/favicon-16x16.png" sizes="16x16">
            <link rel="stylesheet" type="text/css" href="/style.css?{$VERSION}" media="all">
            <link rel="stylesheet" type="text/css" href="/admin/style.css?{$VERSION}" media="all">
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.9/ace.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.9/ext-beautify.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.9/mode-sql.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.9/mode-mysql.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.9/theme-xcode.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.9/theme-github_dark.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.9/ext-language_tools.js"></script>
            {* <script type="text/javascript" src="/script.js?8" defer></script> *}
            <script type="text/javascript" src="/admin/script.js?{$VERSION}"></script>
            <script>
                var lang = '{$Lang}',
                    db   = '{$DB}',
                    questionId = '{$QuestionID}';
            </script>
            <script type='text/javascript' src='https://platform-api.sharethis.com/js/sharethis.js#property=685bb6a18ca9160019f294e2&product=sop' async='async'></script>
        </head>
        <body>
            <div class="admin-container">
                <div class="admin-header">
                    <div class="top-menu">
                        <a href="/en/" target="_self"><h1 class="site-name">SQLtest</h1><h3 class="site-promo"> - place where you can test your SQL knowledge for free</h3></a>
                    </div>
                </div>
                <div class="admin-menu">Menu</div>
                <div class="question-form-top">
                    <label for="templae">Template:</label>
                    <select name="template" id="template">
                        <option value="sakila">Sakila</option>
                        <option value="sakila">Employee</option>
                    </select>
                    <label for="templae">SQL Server:</label>
                    <select name="template" id="server">
                        <option value="sakila">MySQL 8.0 Sakila</option>
                        <option value="sakila">Firebird 4.0 Employee</option>
                    </select>
                </div>
                <div class="question-form-left">
                    <div>
                        <label for="question-title-en">Question Title:</label>
                        <input type="text" id="question-title-en" name="question-title-en" style="width:300px" value="{$QuestionTitleEn}" />
                        <button onClick="translate('English', 'Russian', 'question-title-en', 'question-title-ru');">To Russian =></button>
                    </div>
                    <div>
                        <label for="question-title-en">Question:</label>
                        <textarea name="question-en" rows="4" cols="50">{$QuestionTaskEn}</textarea>
                        <button>To Russian =></button>
                    </div>
                    <div>
                        <label for="question-title-en">Hint:</label>
                        <input type="textarea" name="question-hint-en" value="{$QuestionHintEn}" />
                        <button>To Russian =></button>
                    </div>
                </div>
                <div class="question-form-right">
                    <div>
                        <button><= To English</button>
                        <input type="text" id="question-title-ru" name="question-title-ru" style="width:300px" value="{$QuestionTitleRu}" />
                    </div>
                    <div>
                        <button><= To English</button>
                        <textarea name="question-ru" rows="4" cols="50">{$QuestionTaskRu}</textarea>
                    </div>
                </div>
                <div class="question-form-bottom">
                    <div>
                        <label for="question-title-en">Solution Match:</label>
                        <input type="text" name="question-match" value="{$SolutionMatch}" />
                        <button>Check</button>
                    </div>
                    <div>
                        <label for="question-title-en">Solution Not Match:</label>
                        <input type="text" name="question-match" value="{$SolutionNotMatch}" />
                        <button>Check</button>
                    </div>
                    <div>
                        <label for="question-title-en">Result:</label>
                        <input type="text" name="question-match" value="{$QuestionResult}" />
                    </div>
                    <div>
                        <button class="button green" id="saveQuestionBtn" onClick="saveQuestion({$QuestionID})">Save</button>
                    </div>
                </div>
            <div class="admin-footer">
                © 2023-2024 SQLtest.online
                <a target="_blank" href="https://t.me/sqlize">
                    <img id="telegram_send_button" alt="telegramSendButton" src="https://sqlize.online/favicons/telegram.svg" style="cursor:pointer; width: 32px; height: 32px; margin-bottom: -12px;"> our telegram chat
                </a>
                <a href="/{$Lang}/about" target="_self">About</a>
                <a href="/{$Lang}/privacy-policy" target="_self">Privacy policy</a>
            </div>
        </div>
        {include file='counters.tpl'}
    </body>
</html>