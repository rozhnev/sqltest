<div class="locale-card locale-card--{$language}">
    <div class="locale-card__header">
        <strong>{$label}</strong>
        <span class="locale-card__tag">{$language|upper}</span>
    </div>
    <div class="form-group">
        <label for="lesson-title-{$language}">Title</label>
        <input type="text" id="lesson-title-{$language}" name="lesson[localizations][{$language}][title]" value="{$localization.title|default:''|escape:'html'}" required />
    </div>
    <div class="form-group">
        <label for="lesson-content-{$language}">Content</label>
        <textarea id="lesson-content-{$language}" name="lesson[localizations][{$language}][content]" rows="6">{$localization.content|default:''|escape:'html'}</textarea>
    </div>
    <div class="form-group">
        <label for="lesson-description-{$language}">Description</label>
        <textarea id="lesson-description-{$language}" name="lesson[localizations][{$language}][description]" rows="4">{$localization.description|default:''|escape:'html'}</textarea>
    </div>
</div>
