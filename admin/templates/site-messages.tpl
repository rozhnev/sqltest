<!DOCTYPE html>
<html lang="{$Lang}">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="description" content="Site messages: donation goal and urgent banner" />
        <title>SQLtest.online Admin - Site messages</title>
        <link rel="stylesheet" href="/style.min.css?{$VERSION}" media="all" />
        <link rel="stylesheet" href="/admin/style.min.css?{$VERSION}" media="all" />
        <style>
            .site-messages-language { margin: 1.5rem 0 0; padding: 1rem; border: 1px solid var(--text-block-border-color); border-radius: 8px; }
            .site-messages-language legend { padding: 0 0.4rem; font-weight: 700; }
            .site-messages-language h3 { margin: 1rem 0 0.4rem; font-size: 1rem; }
            .site-messages-settings { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 0.6rem; align-items: end; }
            .site-messages-row { display: flex; flex-wrap: wrap; gap: 0.5rem; align-items: center; margin-top: 0.5rem; }
            /* Label above a full-width field; checkboxes stay on one line */
            #site-messages-form label { display: flex; flex-direction: column; gap: 0.3rem; margin-top: 0.6rem; }
            #site-messages-form label:has(> input[type="checkbox"]) { flex-direction: row; align-items: center; }
            #site-messages-form input[type="text"], #site-messages-form input[type="number"] { width: 100%; box-sizing: border-box; padding: 0.4rem; }
            #site-messages-form .translate-controls select { width: auto; }
        </style>
    </head>
    <body>
        <div class="admin-shell">
            <header class="admin-shell__header">
                <div>
                    <p class="brand__title">SQLtest.online Admin</p>
                    <p class="brand__subtitle">Site messages</p>
                </div>
            </header>

            <main class="panel">
                <div class="panel__title">
                    <div>
                        <h2>Donation goal and urgent banner</h2>
                        <p class="panel__sub">Edit without a deploy. One set per language. Bump a banner's version to re-show it to visitors who closed it.</p>
                    </div>
                    <button type="submit" form="site-messages-form" class="button-primary">Save</button>
                </div>

                <form id="site-messages-form" class="editor-form">
                    <label>
                        Monthly donation goal, USD (the same for every language)
                        <input type="number" name="donation_goal_amount" min="0" step="0.01" value="{$DonationGoalAmount|escape}">
                    </label>

                    {foreach from=$Languages item=langCode}
                        {assign var=m value=$Messages.$langCode|default:[]}
                        <fieldset class="site-messages-language" data-lang="{$langCode}">
                            <legend>{$langCode|upper}</legend>
                            <div class="site-messages-row translate-controls">
                                Translate all texts from
                                <select class="translate-source" data-target="{$langCode}">
                                    {foreach from=$Languages item=sourceLangCode}
                                        {if $sourceLangCode !== $langCode}
                                            <option value="{$sourceLangCode}">{$sourceLangCode|upper}</option>
                                        {/if}
                                    {/foreach}
                                </select>
                                <button type="button" class="translate-button" data-target="{$langCode}">Translate</button>
                            </div>

                            <h3>Donation goal widget</h3>
                            <label>
                                Title
                                <input type="text" name="messages[{$langCode}][donation_goal_title]" id="donation_goal_title-{$langCode}" data-translatable value="{$m.donation_goal_title|default:''|escape}">
                            </label>
                            <label>
                                Text (HTML; ##goal## is replaced by the amount)
                                <textarea name="messages[{$langCode}][donation_goal]" id="donation_goal-{$langCode}" data-translatable rows="6">{$m.donation_goal|default:''|escape}</textarea>
                            </label>

                            <h3>Urgent banner</h3>
                            <div class="site-messages-settings">
                                <label>
                                    <input type="checkbox" name="messages[{$langCode}][urgent_banner_enabled]" data-setting="enabled" {if $m.urgent_banner_enabled|default:false}checked{/if}>
                                    Enabled
                                </label>
                                <label>
                                    Version
                                    <input type="number" name="messages[{$langCode}][urgent_banner_version]" data-setting="version" min="1" value="{$m.urgent_banner_version|default:1}">
                                </label>
                                <label>
                                    Background (CSS color or gradient)
                                    <input type="text" name="messages[{$langCode}][urgent_banner_background]" data-setting="background" value="{$m.urgent_banner_background|default:''|escape}">
                                </label>
                                <label>
                                    Text color
                                    <input type="text" name="messages[{$langCode}][urgent_banner_text_color]" data-setting="text_color" value="{$m.urgent_banner_text_color|default:'#ffffff'|escape}">
                                </label>
                            </div>
                            <div class="site-messages-row">
                                <button type="button" class="apply-settings-button" data-source="{$langCode}">Apply these banner settings to all languages</button>
                            </div>
                            <label>
                                Banner HTML
                                <textarea name="messages[{$langCode}][urgent_banner]" id="urgent_banner-{$langCode}" data-translatable rows="4">{$m.urgent_banner|default:''|escape}</textarea>
                            </label>
                        </fieldset>
                    {/foreach}
                </form>
                <p class="panel__sub" id="site-messages-feedback"></p>
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
            const feedback = document.getElementById('site-messages-feedback');

            async function translateField(fieldPrefix, sourceLang, targetLang) {
                const sourceField = document.getElementById(`${fieldPrefix}-${sourceLang}`);
                const targetField = document.getElementById(`${fieldPrefix}-${targetLang}`);
                if (!sourceField || !targetField || !sourceField.value.trim()) {
                    return;
                }
                const response = await fetch('/admin/llm', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        task: 'translate-html',
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

            // Translate the title, the widget text and the banner of one language from another
            document.querySelectorAll('.translate-button').forEach(button => {
                button.addEventListener('click', async () => {
                    const targetLang = button.dataset.target;
                    const sourceLang = document.querySelector(`.translate-source[data-target="${targetLang}"]`).value;
                    feedback.textContent = 'Translating…';
                    try {
                        for (const field of ['donation_goal_title', 'donation_goal', 'urgent_banner']) {
                            await translateField(field, sourceLang, targetLang);
                        }
                        feedback.textContent = `Translated into ${targetLang.toUpperCase()}. Review the HTML before saving.`;
                    } catch (error) {
                        feedback.textContent = error.message || 'Failed to translate.';
                    }
                });
            });

            // Copy one language's banner settings (enabled, version, colors) to every language
            document.querySelectorAll('.apply-settings-button').forEach(button => {
                button.addEventListener('click', () => {
                    const source = document.querySelector(`.site-messages-language[data-lang="${button.dataset.source}"]`);
                    document.querySelectorAll('.site-messages-language').forEach(section => {
                        source.querySelectorAll('[data-setting]').forEach(input => {
                            const target = section.querySelector(`[data-setting="${input.dataset.setting}"]`);
                            if (input.type === 'checkbox') {
                                target.checked = input.checked;
                            } else {
                                target.value = input.value;
                            }
                        });
                    });
                    feedback.textContent = `Banner settings of ${button.dataset.source.toUpperCase()} applied to all languages. Save to keep them.`;
                });
            });

            document.getElementById('site-messages-form').addEventListener('submit', async function (event) {
                event.preventDefault();
                feedback.textContent = 'Saving…';
                try {
                    const response = await fetch('/admin/site-messages', {
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
