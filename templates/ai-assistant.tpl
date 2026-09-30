{* AI assistant chat panel shared by the lesson page and the playground (see PLAYGROUND_ASSISTANT_PLAN.md).
   Params:
     assistantId - DOM id of the panel
     endpoint    - base URL of the actions: {endpoint}-ask and {endpoint}-reset
     text        - template with the texts, picked by the "part" parameter
     history     - [['role' => 'user'|'assistant', 'html' => ...]] from the session
     mobile      - render as a bottom sheet opened by a floating button
   Optional text parts: context_note (what the assistant sees), quick_actions (buttons above the input).
   The code block buttons (Copy, Insert into editor) use the shared ai_* translation keys. *}
{assign var=AssistantExhausted value=$AiQuota && $AiQuota.exhausted}
{* Text parts end with a newline; trim the ones used in attributes *}
{capture name=ai_title}{include file=$text part='title'}{/capture}
{capture name=ai_placeholder}{include file=$text part='placeholder'}{/capture}
{capture name=ai_context_note}{include file=$text part='context_note'}{/capture}
{capture name=ai_quick_actions}{include file=$text part='quick_actions'}{/capture}
{if $mobile}
    <button type="button" class="ai-assistant-fab button blue" data-ai-assistant-toggle>{include file=$text part='fab'}</button>
{/if}
<section id="{$assistantId}" class="ai-assistant side-card{if $mobile} mobile{/if}"
    data-endpoint="{$endpoint|escape}" data-logged="{if $User->logged()}1{else}0{/if}"
    data-copy-label="{translate}ai_copy{/translate}" data-copied-label="{translate}ai_copied{/translate}"
    data-insert-label="{translate}ai_insert_into_editor{/translate}"
    aria-label="{$smarty.capture.ai_title|trim|escape}">
    <div class="la-header side-card-title">
        <h3 class="la-title">{$smarty.capture.ai_title|trim|escape}</h3>
        {if $mobile}
            <button type="button" class="la-close" data-ai-assistant-toggle aria-label="Close">×</button>
        {/if}
    </div>
    <div class="la-body side-card-body">
        <div class="la-messages" aria-live="polite">
            {if !$history}
                <div class="la-intro">
                    {include file=$text part='intro'}
                    <div class="la-examples">
                        {include file=$text part='examples'}
                    </div>
                </div>
            {/if}
            {foreach $history as $message}
                <div class="la-message la-{$message.role}">{$message.html}</div>
            {/foreach}
        </div>
        <div class="la-notice{if !$AssistantExhausted} hidden{/if}">{if $AssistantExhausted}{$AiQuotaExceededMessage}{/if}</div>
        {if $User->logged()}
            {if $smarty.capture.ai_context_note|trim}
                <p class="la-context-note">{$smarty.capture.ai_context_note|trim}</p>
            {/if}
            <form class="la-form" autocomplete="off">
                {if $smarty.capture.ai_quick_actions|trim}
                    <div class="la-quick">{$smarty.capture.ai_quick_actions}</div>
                {/if}
                <textarea class="la-input" name="question" rows="3" maxlength="1000"
                    placeholder="{$smarty.capture.ai_placeholder|trim|escape}"{if $AssistantExhausted} disabled{/if}></textarea>
                <div class="la-actions">
                    <button type="button" class="la-reset text-button">{include file=$text part='reset'}</button>
                    <button type="submit" class="button green side-card-button la-send"{if $AssistantExhausted} disabled{/if}>{include file=$text part='send'}</button>
                </div>
            </form>
            <div class="la-quota">{include file=$text part='quota'}</div>
            <template class="la-exhausted-message">{$AiQuotaExceededMessage}</template>
        {else}
            <div class="la-login">
                <button type="button" class="button green side-card-button" onClick="toggleLoginWindow()">{include file=$text part='login'}</button>
            </div>
        {/if}
    </div>
</section>
