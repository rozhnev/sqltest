<!DOCTYPE html>
<html lang="{$Lang}">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="description" content="Urgent banner settings" />
        <title>SQLtest.online Admin - Urgent banner</title>
        <link rel="stylesheet" href="/style.min.css?{$VERSION}" media="all" />
        <link rel="stylesheet" href="/admin/style.min.css?{$VERSION}" media="all" />
    </head>
    <body>
        <div class="admin-shell">
            <header class="admin-shell__header">
                <div>
                    <p class="brand__title">SQLtest.online Admin</p>
                    <p class="brand__subtitle">Urgent banner</p>
                </div>
            </header>

            <main class="panel">
                <div class="panel__title">
                    <div>
                        <h2>Site-wide urgent banner</h2>
                        <p class="panel__sub">Edit without a deploy. Bump the version to re-show the banner to visitors who dismissed a previous one.</p>
                    </div>
                    <button type="submit" form="urgent-banner-form" class="button-primary">Save</button>
                </div>

                <form id="urgent-banner-form" class="editor-form">
                    <label>
                        <input type="checkbox" name="enabled" {if $Banner.enabled}checked{/if}>
                        Enabled
                    </label>

                    <label>
                        Version (bump to re-show to users who dismissed it)
                        <input type="number" name="version" min="1" value="{$Banner.version|default:1}">
                    </label>

                    <label>
                        Background (CSS color or gradient)
                        <input type="text" name="background" value="{$Banner.background|escape}">
                    </label>

                    <label>
                        Text color
                        <input type="text" name="text_color" value="{$Banner.text_color|escape}">
                    </label>

                    {foreach from=$Languages item=langCode}
                        <label>
                            Message HTML ({$langCode|upper})
                            <span class="translate-controls">
                                Translate from
                                <select class="translate-source" data-target="{$langCode}">
                                    {foreach from=$Languages item=sourceLangCode}
                                        {if $sourceLangCode !== $langCode}
                                            <option value="{$sourceLangCode}">{$sourceLangCode|upper}</option>
                                        {/if}
                                    {/foreach}
                                </select>
                                <button type="button" class="translate-button" data-target="{$langCode}">Translate</button>
                            </span>
                            <textarea name="messages[{$langCode}]" id="message-{$langCode}" rows="4">{$Banner.messages.$langCode|default:''}</textarea>
                        </label>
                    {/foreach}
                </form>
                <p class="panel__sub" id="urgent-banner-feedback"></p>
            </main>
        </div>
        <script>
        {literal}
            const LANGUAGE_LABELS = {
                ru: 'Russian',
                en: 'English',
                es: 'Spanish',
                fr: 'French',
                pt: 'Portuguese',
                zh: 'Chinese',
            };

            async function translateMessage(sourceLang, targetLang) {
                const sourceField = document.getElementById(`message-${sourceLang}`);
                const targetField = document.getElementById(`message-${targetLang}`);
                if (!sourceField || !targetField || !sourceField.value.trim()) {
                    return;
                }

                const response = await fetch('/admin/llm', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        task: 'translate',
                        from_lang: LANGUAGE_LABELS[sourceLang] || sourceLang,
                        to_lang: LANGUAGE_LABELS[targetLang] || targetLang,
                        text: sourceField.value,
                    }),
                });
                const body = await response.json();
                if (body.error) {
                    throw new Error(body.error);
                }
                targetField.value = body.result || '';
            }

            document.querySelectorAll('.translate-button').forEach(button => {
                button.addEventListener('click', async () => {
                    const targetLang = button.dataset.target;
                    const sourceLang = document.querySelector(`.translate-source[data-target="${targetLang}"]`).value;
                    const feedback = document.getElementById('urgent-banner-feedback');
                    feedback.textContent = 'Translating…';
                    try {
                        await translateMessage(sourceLang, targetLang);
                        feedback.textContent = `Translated into ${targetLang.toUpperCase()}. Review the HTML before saving.`;
                    } catch (error) {
                        feedback.textContent = error.message || 'Failed to translate.';
                    }
                });
            });

            document.getElementById('urgent-banner-form').addEventListener('submit', async function (event) {
                event.preventDefault();
                const feedback = document.getElementById('urgent-banner-feedback');
                feedback.textContent = 'Saving…';

                try {
                    const response = await fetch('/admin/urgent-banner', {
                        method: 'POST',
                        body: new FormData(event.target),
                    });
                    const body = await response.json();
                    feedback.textContent = body.status === 'ok' ? 'Saved.' : (body.error || 'Failed to save.');
                } catch (error) {
                    feedback.textContent = error.message || 'Failed to save.';
                }
            });
        {/literal}
        </script>
    </body>
</html>
