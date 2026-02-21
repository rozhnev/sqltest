<div class="locale-card locale-card--{$language}">
    <div class="locale-card__header">
        <strong>{$label}</strong>
        <span class="locale-card__tag">{$language|upper}</span>
    </div>
    <div class="form-group">
        <label for="questionTitle{$language|upper}">Title</label>
        <div class="question-title__input-surface">
            <input class="question-title__input" type="text" id="questionTitle{$language|upper}" name="question[localizations][{$language}][title]" value="{$localization.title|default:''|escape:'html'}" placeholder="e.g. Optimize the sample query" />
        </div>
    </div>
    <div class="form-group">
        <label for="questionTask{$language|upper}">Question text</label>
        <textarea id="questionTask{$language|upper}" name="question[localizations][{$language}][task]" rows="5">{$localization.task|default:''|escape:'html'}</textarea>
    </div>
    <div class="form-group">
        <label for="questionHint{$language|upper}">Hint</label>
        <textarea id="questionHint{$language|upper}" name="question[localizations][{$language}][hint]" rows="3">{$localization.hint|default:''|escape:'html'}</textarea>
    </div>
    <div class="panel__actions">
        <div style="display:flex; flex-direction:row; align-items:center; gap:8px;">
            <label for="translate{$language|upper}ToLang">Translate to: </label>
            <div class="select-surface select-surface--lang" style="border: 1px solid var(--border); border-radius: 5px;padding: 0 10px; background: rgba(255, 255, 255, 0.02);">
            <select id="translate{$language|upper}ToLang">
                {foreach from=$Languages item=lang}
                {if $lang == {$language|lower}}
                    {continue}
                {/if}
                <option value="{$lang|escape:'html'}">{$LanguageLabels[$lang]|default:$lang|capitalize}</option>
                {/foreach}
            </select>
            </div>
            <button type="button" class="button" id="questionTranslate{$language|upper}Btn" onClick="questionTranslateTo('{$language|upper}')">Translate</button>
            <button type="button" class="button" id="questionReview{$language|upper}Btn" onClick="questionReview('{$language|upper}')">Review</button>
            <button type="button" class="button green" id="questionSave{$language|upper}Btn" onClick="questionLocalizationSave({$QuestionID}, '{$language|upper}')">Save</button>
        </div>
    </div>
    <div class="form-group">
        <label for="questionLLMResult{$language|upper}">LLM Result</label>
        <div id="questionLLMResult{$language|upper}" name="question[localizations][{$language}][review_result]" rows="3"></div>
    </div>
</div>