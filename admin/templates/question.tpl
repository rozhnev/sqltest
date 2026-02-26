<!DOCTYPE html>
<html lang="{$Lang}">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="description" content="Admin panel for SQLtest.online" />
        <title>SQLtest.online — Question editor</title>
        <link rel="stylesheet" href="/style.min.css?{$VERSION}" media="all" />
        <link rel="stylesheet" href="/admin/style.min.css?{$VERSION}" media="all" />
        <script>
            window.ADMIN_CONFIG = {
                lang: '{$Lang|escape:'javascript'}',
                db: '{$DB|escape:'javascript'}',
                version: '{$VERSION}',
                lessonId: {$LessonID|default:0},
                questionId: {$QuestionID|default:0}
            };
        </script>
        <script src="/admin/script.js?{$VERSION}" defer></script>
    </head>
    <body>
        <div class="admin-shell">
            <header class="admin-shell__header">
                <div>
                    <p class="brand__title">SQLtest.online Admin</p>
                    <p class="brand__subtitle">Question editor</p>
                </div>
                <div class="status-pill">
                    <span>LANG: {$Lang|upper}</span>
                    <span>DB: {$DB}</span>
                </div>
            </header>

            <div class="admin-shell__content">
                <div class="admin-shell__primary">
                    <section class="panel panel--editor">
                        <div class="panel__title">
                            <div>
                                <h2>Question #{if $QuestionID}{$QuestionID}{else}New{/if}</h2>
                                <p class="panel__sub">{if $QuestionID}Editing question {$QuestionID}{else}Create a new question{/if}</p>
                            </div>
                        </div>
                        <form id="questionForm" class="editor-form" data-question-id="{$QuestionID|default:0}" autocomplete="off">
                            <input type="hidden" name="question[id]" value="{$QuestionID|default:0}" />
                            <div class="field-row">
                                <label for="questionSlug">Slug</label>
                                <input type="text" id="questionSlug" name="question[title_sef]" value="{$Question.title_sef|default:''|escape:'html'}" readonly />
                                <small class="field-note">Generated from the English title to keep URLs stable.</small>
                            </div>
                            <div class="field-row field-row--select-surface">
                                <label for="questionDb">Database</label>
                                <div class="select-surface select-surface--db">
                                    <select id="questionDb" name="question[db]">
                                        {foreach from=$Databases key=dbKey item=dbLabel}
                                            <option value="{$dbKey|escape:'html'}"{if $Question.db === $dbKey} selected{/if}>{$dbLabel|escape:'html'}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="field-row field-row--select-surface">
                                <label for="questionDbTemplate">Database template</label>
                                <div class="select-surface select-surface--template">
                                    <select id="questionDbTemplate" name="question[db_template]">
                                        {foreach from=$DbTemplates key=templateKey item=templateLabel}
                                            <option value="{$templateKey|escape:'html'}"{if $Question.db_template === $templateKey} selected{/if}>{$templateLabel|escape:'html'}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="field-row">
                                <label for="questionSolution">Solution query</label>
                                <textarea id="questionSolution" name="question[solution_query]" rows="4">{$Question.solution_query|default:''|escape:'html'}</textarea>
                                <div class="panel__actions">
                                    <div style="display:flex; flex-direction:row; align-items:center; gap:8px;">
                                        <button type="button" class="button green" id="questionGenerateTaskBtn" onClick="questionGenerateTaskFromQuery({$QuestionID})">Generate task from query</button>
                                    </div>
                                </div>
                            </div>
                            <div class="field-row">
                                <label for="questionChecks">Query checks</label>
                                <div class="checks-table-wrapper">
                                    <div class="checks-table-scroll" style="max-height: 250px; overflow-y: auto;">
                                        <table class="checks-table" id="questionChecks">
                                        <thead>
                                            <tr>
                                                <th>Title</th>
                                                <th>Regexp</th>
                                                <th>Enabled</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {foreach from=$Question.query_checks item=check}
                                                <tr data-query-check-row data-check-id="{$check.id}">
                                                    <td>{$check.hint|default:'—'|escape:'html'}</td>
                                                    <td>{$check.regexp|default:'—'|escape:'html'}</td>
                                                    <td>
                                                        <input type="hidden" name="question[query_checks][{$check.id}]" value="0" />
                                                        <label class="checkbox">
                                                            <input type="checkbox" name="question[query_checks][{$check.id}]" value="1"{if $check.checked} checked{/if} />
                                                        </label>
                                                    </td>
                                                </tr>
                                            {/foreach}
                                        </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="panel__actions">
                                    <button type="button" class="button green" id="questionChecksSaveBtn" onClick="questionChecksSave({$QuestionID})">Save query checks</button>
                                </div>
                            </div>
                            <div class="field-row">
                                <label for="questionResult">Valid result</label>
                                <textarea id="questionResult" name="question[query_valid_result]" rows="3">{$Question.query_valid_result|default:''|escape:'html'}</textarea>
                            </div>
                            <div class="field-row">
                                <label for="questionPreCheck">Pre-check query</label>
                                <textarea id="questionPreCheck" name="question[query_pre_check]" rows="3">{$Question.query_pre_check|default:''|escape:'html'}</textarea>
                            </div>
                            <div class="field-row">
                                <label for="questionCheck">Check query</label>
                                <textarea id="questionCheck" name="question[query_check]" rows="3">{$Question.query_check|default:''|escape:'html'}</textarea>
                            </div>
                            <div class="locale-grid">
                                {foreach from=$Languages item=lang}
                                    {assign var=localization value=$Question.localizations[$lang]|default:[]}
                                    {assign var=label value=$LanguageLabels[$lang]|default:$lang|upper}
                                    {include file='partials/question-language.tpl' language=$lang localization=$localization label=$label}
                                {/foreach}
                            </div>
                            <div class="question-category-grid">
                                <div class="question-category-grid__header">
                                    <div>
                                        <p>Question categories</p>
                                        <small>Check the collections where this question should appear.</small>
                                    </div>
                                </div>
                                <div class="checks-table-wrapper">
                                    <div class="checks-table-scroll" style="max-height: 220px; overflow-y: auto;">
                                        <table class="checks-table" id="questionCategoryGrid">
                                            <thead>
                                                <tr>
                                                    <th>Category</th>
                                                    <th>Order</th>
                                                    <th>Included</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {foreach from=$Question.categories|default:[] item=category}
                                                    {if $category.category_id}
                                                        <tr data-question-category-row data-category-id="{$category.category_id}">
                                                            <td>
                                                                <strong>{$category.title|default:'—'|escape:'html'}</strong>
                                                                <div class="question-category-grid__meta">
                                                                    <span class="question-category-grid__tag">{$category.questionnaire|upper}</span>
                                                                </div>
                                                            </td>
                                                            <td>{$category.position|default:'—'}</td>
                                                            <td>
                                                                <input type="hidden" name="question[categories][{$category.category_id}]" value="0" />
                                                                <label class="checkbox">
                                                                    <input type="checkbox" name="question[categories][{$category.category_id}]" value="1"{if $category.checked} checked{/if} />
                                                                </label>
                                                            </td>
                                                        </tr>
                                                    {/if}
                                                {/foreach}
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="panel__actions">
                                <button type="button" class="button-primary" id="saveQuestionBtn">Save question</button>
                            </div>
                        </form>
                    </section>
                </div>

                <aside class="admin-shell__secondary">
                    <section class="panel">
                        <div class="panel__title">
                            <div>
                                <h3>Question library</h3>
                                <p class="panel__sub" id="selectedQuestionLabel">{if $QuestionID}Loaded question #{$QuestionID}{else}No question selected{/if}</p>
                            </div>
                        </div>
                        <div id="questionList" class="data-list"></div>
                        <div class="panel__actions">
                            <button type="button" class="button" id="newQuestionBtn">New question</button>
                            <button type="button" class="button red" id="deleteQuestionBtn">Delete question</button>
                        </div>
                    </section>
                </aside>
            </div>
            <div id="statusBar" class="status-bar"></div>
        </div>
    </body>
</html>