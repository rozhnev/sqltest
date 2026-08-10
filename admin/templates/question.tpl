<!DOCTYPE html>
<html lang="{$Lang}">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="description" content="Admin panel for SQLtest.online" />
        <title>SQLtest.online — Question editor</title>
        <link rel="stylesheet" href="/style.min.css?{$VERSION}" media="all" />
        <link rel="stylesheet" href="/admin/style.min.css?{$VERSION}" media="all" />
        <style>
            .answer-workspace {
                display: grid;
                grid-template-columns: minmax(260px, 340px) 1fr;
                gap: 14px;
                align-items: start;
            }

            .answer-workspace__list,
            .answer-workspace__editor {
                border: 1px solid var(--border, #d6d6d6);
                border-radius: 8px;
                padding: 10px;
                background: rgba(255, 255, 255, 0.02);
            }

            .answer-workspace__list-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 8px;
            }

            .answer-list {
                display: flex;
                flex-direction: column;
                gap: 6px;
                max-height: 360px;
                overflow-y: auto;
                margin-bottom: 10px;
            }

            .answer-list-item {
                display: flex;
                gap: 8px;
                align-items: flex-start;
                border: 1px solid var(--border, #d6d6d6);
                border-radius: 8px;
                background: transparent;
                color: inherit;
                padding: 8px;
                text-align: left;
                cursor: pointer;
            }

            .answer-list-item.active {
                border-color: #2c7be5;
                background: rgba(44, 123, 229, 0.08);
            }

            .answer-list-item__index {
                min-width: 26px;
                font-weight: 700;
            }

            .answer-list-item__meta {
                display: flex;
                flex-direction: column;
                gap: 2px;
                width: 100%;
            }

            .answer-editor-empty {
                color: #777;
            }

            .answer-editor__header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: 10px;
                margin-bottom: 8px;
            }

            .answer-editor__tabs {
                display: flex;
                gap: 6px;
                flex-wrap: wrap;
                margin-bottom: 8px;
            }

            .answer-editor__tabs .button.active {
                border-color: #2c7be5;
                color: #2c7be5;
            }

            .answer-editor__tabs .button.missing {
                border-color: #d97904;
            }

            @media (max-width: 980px) {
                .answer-workspace {
                    grid-template-columns: 1fr;
                }
            }
        </style>
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
        <div class="toast" id="toast"></div>
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
                                <p class="panel__sub" id="questionModeBadge">Mode: {if $Question.have_answers}Theoretical (answers){else}SQL query{/if}</p>
                                <div class="panel__actions">
                                    <button type="button" class="button" id="questionStartTheoryBtn">Switch to theoretical mode</button>
                                </div>
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
                            <div class="field-row" data-query-fields>
                                <label for="questionSolution">Solution query</label>
                                <textarea id="questionSolution" name="question[solution_query]" rows="4">{$Question.solution_query|default:''|escape:'html'}</textarea>
                                <div class="panel__actions">
                                    <div style="display:flex; flex-direction:row; align-items:center; gap:8px;">
                                        <div class="select-surface select-surface--inline">
                                            <select id="generateTaskLanguage">
                                                {foreach from=$Languages item=lang}
                                                    <option value="{$lang|escape:'html'}"{if $Lang === $lang} selected{/if}>{$LanguageLabels[$lang]|default:$lang|upper}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                        <button type="button" class="button green" id="questionGenerateTaskBtn" onClick="questionGenerateTaskFromQuery({$QuestionID})">Generate task from query</button>
                                    </div>
                                </div>
                            </div>
                            <div class="field-row" data-query-fields>
                                <span class="form-label">Query checks</span>
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
                            <div class="field-row" data-query-fields>
                                <label for="questionResult">Valid result</label>
                                <textarea id="questionResult" name="question[query_valid_result]" rows="3">{$Question.query_valid_result|default:''|escape:'html'}</textarea>
                            </div>
                            <div class="field-row" data-query-fields>
                                <label for="questionPreCheck">Pre-check query</label>
                                <textarea id="questionPreCheck" name="question[query_pre_check]" rows="3">{$Question.query_pre_check|default:''|escape:'html'}</textarea>
                            </div>
                            <div class="field-row" data-query-fields>
                                <label for="questionCheck">Check query</label>
                                <textarea id="questionCheck" name="question[query_check]" rows="3">{$Question.query_check|default:''|escape:'html'}</textarea>
                            </div>
                            <div class="field-row" id="questionAnswersSection" style="{if !$Question.have_answers}display:none;{/if}">
                                <div id="questionInitialAnswers" style="display:none;">
                                    {foreach from=$Question.answers|default:[] item=answer}
                                        <div data-initial-answer data-answer-id="{$answer.id}" data-answer-valid="{if $answer.is_valid}1{else}0{/if}">
                                            {foreach from=$Languages item=lang}
                                                <span data-initial-lang="{$lang|escape:'html'}">{$answer.localizations[$lang].title|default:''|escape:'html'}</span>
                                            {/foreach}
                                        </div>
                                    {/foreach}
                                </div>
                                <div>
                                    <span class="form-label">Answer options (theoretical mode)</span>
                                    <small class="field-note">Rules: at least 2 answers, at least 1 correct answer, and text in EN/RU/PT/FR/ZH for every answer.</small>
                                </div>
                                <div class="answer-workspace">
                                    <div class="answer-workspace__list">
                                        <div class="answer-workspace__list-header">
                                            <strong>Answers</strong>
                                            <small id="questionAnswerStats">0 answers</small>
                                        </div>
                                        <div class="answer-list" id="questionAnswerList"></div>
                                        <div class="panel__actions">
                                            <button type="button" class="button" id="questionAddAnswerBtn">Add answer</button>
                                            <button type="button" class="button" id="questionDuplicateAnswerBtn">Duplicate</button>
                                            <button type="button" class="button red" id="questionDeleteAnswerBtn">Delete</button>
                                        </div>
                                    </div>
                                    <div class="answer-workspace__editor">
                                        <div id="questionAnswerEditorEmpty" class="answer-editor-empty">Select or add an answer to edit details.</div>
                                        <div id="questionAnswerEditorPanel" style="display:none;">
                                            <div class="answer-editor__header">
                                                <strong id="questionAnswerEditorTitle">Answer</strong>
                                                <label class="checkbox" style="display:flex; align-items:center; gap:8px;">
                                                    <input type="checkbox" id="questionAnswerCorrectToggle" />
                                                    <span>Correct answer</span>
                                                </label>
                                            </div>
                                            <div class="answer-editor__tabs" id="questionAnswerLanguageTabs">
                                                {foreach from=$Languages item=lang}
                                                    <button type="button" class="button" data-answer-language="{$lang|escape:'html'}">{$lang|upper}</button>
                                                {/foreach}
                                            </div>
                                            <div class="form-group">
                                                <label for="questionAnswerTitleInput">Answer text</label>
                                                <textarea id="questionAnswerTitleInput" rows="4"></textarea>
                                                <small class="field-note" id="questionAnswerMissingHint"></small>
                                            </div>
                                            <div class="panel__actions">
                                                <button type="button" class="button" id="questionCopyEnToEmptyBtn">Copy EN to empty languages</button>
                                                <button type="button" class="button" id="questionNextIncompleteBtn">Next incomplete</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel__actions">
                                    <button type="button" class="button green" id="questionSaveAnswersBtn" onClick="questionAnswersSave({$QuestionID})">Save answers</button>
                                </div>
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
                                <button type="button" class="button-primary" id="saveQuestionCategoriesBtn" onClick="questionCategoriesSave({$QuestionID})">Save question categories</button>
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
        </div>
    </body>
</html>