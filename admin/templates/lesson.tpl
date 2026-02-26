<!DOCTYPE html>
<html lang="{$Lang}">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="description" content="Admin panel for SQLtest.online" />
        <title>SQLtest.online — Lesson editor</title>
        <link rel="stylesheet" href="/style.min.css?{$VERSION}" media="all" />
        <link rel="stylesheet" href="/admin/style.min.css?{$VERSION}" media="all" />
        <script>
            window.ADMIN_CONFIG = {
                lang: '{$Lang|escape:'javascript'}',
                db: '{$DB|escape:'javascript'}',
                version: '{$VERSION}',
                lessonId: {$LessonID|default:0}
            };
        </script>
        <script src="/admin/script.js?{$VERSION}" defer></script>
    </head>
    <body>
        <div class="admin-shell">
            <header class="admin-shell__header">
                <div>
                    <p class="brand__title">SQLtest.online Admin</p>
                    <p class="brand__subtitle">Lesson editor</p>
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
                                <h2>Lesson #{if $LessonID}{$LessonID}{else}New{/if}</h2>
                                <p class="panel__sub">{if $LessonID}Editing lesson {$LessonID}{else}Create a new lesson{/if}</p>
                            </div>
                        </div>
                        <form id="lesson-form" class="editor-form" data-lesson-id="{$LessonID|default:0}" autocomplete="off">
                            <input type="hidden" name="lesson[id]" value="{$LessonID|default:0}" />
                            <div class="field-row">
                                <label>Slug</label>
                                <input type="text" id="lesson-slug" name="lesson[slug]" value="{$Lesson.slug|default:''}" readonly />
                                <small class="field-note">Automatically generated from the English title.</small>
                            </div>
                            <div class="field-row">
                                <label>Module ID</label>
                                <input type="text" id="lesson-module" name="lesson[module_id]" value="{$Lesson.module_id|default:''}" readonly />
                            </div>
                            <div class="locale-grid">
                                {foreach from=$Languages item=lang}
                                    {assign var=localization value=$Lesson.localizations[$lang]|default:[]}
                                    {assign var=label value=$LanguageLabels[$lang]|default:{$lang|upper}}
                                    {include file='partials/lesson-language.tpl' language=$lang localization=$localization label=$label}
                                {/foreach}
                            </div>
                            <div class="panel__actions">
                                <button type="submit" class="button-primary">Save lesson</button>
                            </div>
                        </form>
                    </section>
                </div>

                <aside class="admin-shell__secondary">
                    <section class="panel">
                        <div class="panel__title">
                            <h3>Lesson overview</h3>
                        </div>
                        <div class="editor-form">
                            <div class="field-row">
                                <label>Deleted</label>
                                <input type="text" value="{if $Lesson.deleted}Yes{else}No{/if}" readonly />
                            </div>
                            <div class="field-row">
                                <label>Sequence</label>
                                <input type="text" value="{$Lesson.sequence_position|default:'—'}" readonly />
                            </div>
                            <div class="field-row">
                                <label>Slug preview</label>
                                <input type="text" value="{$Lesson.slug|default:'—'}" readonly />
                            </div>
                        </div>
                    </section>
                    <section class="panel">
                        <div class="panel__title">
                            <h3>Tips</h3>
                        </div>
                        <p class="panel__sub">Use the per-language cards above to edit titles, descriptions, and content. The slug is locked to keep URLs stable.</p>
                    </section>
                </aside>
            </div>

            <div id="statusBar" class="status-bar"></div>
            <footer class="admin-shell__footer">
                © 2023-2026 SQLtest.online — <a href="/en/about">About</a>
            </footer>
        </div>
    </body>
</html>
