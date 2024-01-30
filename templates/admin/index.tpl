

<!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en">
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta http-equiv="Permissions-Policy" content="browsing-topics=('mc.yandex.com')">
            <meta name="viewport" content="width=device-width, initial-scale=1;"/>
            <meta charset="utf-8">
            <meta name="description" content="Free online SQL test.">
            <meta name="keywords" content="free sql test,online testing, sql, fiddle">
            {include file='../en/site-title.tpl'}
            <link rel="apple-touch-icon" sizes="180x180" href="/favicons/apple-touch-icon.png">
            <link rel="icon" type="image/png" href="/favicons/favicon-32x32.png" sizes="32x32">
            <link rel="icon" type="image/png" href="/favicons/favicon-16x16.png" sizes="16x16">
            <link rel="stylesheet" type="text/css" href="style.css?8" media="all">
            <link rel="stylesheet" type="text/css" href="admin/style.css?8" media="all">
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/ace.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/ext-beautify.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/mode-sql.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/mode-mysql.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/theme-xcode.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/ace/1.32.2/ext-language_tools.js"></script>
            <script type="text/javascript" src="script.js?8" defer></script>
            <script>
                var lang = '{$Lang}',
                    db   = '{$DB}',
                    questionId = '{$QuestionID}';
            </script>

        </head>
        <body>
            <div class="admin-container">
            {include file='../en/top-menu.tpl'}
                <div class="menu"></div>
                <div class="main">
                    <div class="toast" id="toast">php result copied to buffer</div>
                    {include file='../en/login-popup.tpl'}
                    <form class="question-form">
                        <div class="top">
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
                        <div class="left">
                            <label for="question-title-en">Question Title:</label>
                            <input type="text" name="question-title-en" value="{$QuestionTitleEn}" />
                            <label for="question-title-en">Question:</label>
                            <input type="textarea" name="question-en" value="{$QuestionEn}" />
                            <label for="question-title-en">Hint:</label>
                            <input type="textarea" name="question-hint-en" value="{$QuestionHintEn}" />
                        </div>
                        <div class="right">
                            <input type="text" name="question-title-ru" value="{$QuestionTitleRu}" />
                        </div>
                        <div class="bottom">
                            {* {if $Logged && $Admin} *}
                                Welcome, admin user!
                            {* {else} *}
                                {* You must be looged as admin before open this page *}
                            {* {/if} *}
                            <label for="question-title-en">Solution Match:</label>
                            <input type="text" name="question-match" value="{$QuestionHintEn}" />
                            <label for="question-title-en">Solution Not Match:</label>
                            <input type="text" name="question-match" value="{$QuestionHintEn}" />
                            <button class="button test" id="saveQuestionBtn" onClick="saveQuestion({$QuestionID})">Save</button>
                        </div>

                    </form>
                </div>
                {include file='../footer.tpl'}