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
                            <textarea name="messages[{$langCode}]" rows="4">{$Banner.messages.$langCode|default:''}</textarea>
                        </label>
                    {/foreach}
                </form>
                <p class="panel__sub" id="urgent-banner-feedback"></p>
            </main>
        </div>
        <script>
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
        </script>
    </body>
</html>
