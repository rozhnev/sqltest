{* Lesson assistant panel (see LESSON_ASSISTANT_PLAN.md, Stage 5). Text comes from
   $LessonAssistantTemplate ({lang}/lesson-assistant.tpl), picked by the "part" parameter.
   Params: mobile (bool) - render as a bottom sheet opened by a floating button. *}
{assign var=AssistantText value=$LessonAssistantTemplate}
{assign var=AssistantExhausted value=$AiQuota && $AiQuota.exhausted}
{* Text parts end with a newline; trim the ones used in attributes *}
{capture name=la_title}{include file=$AssistantText part='title'}{/capture}
{capture name=la_placeholder}{include file=$AssistantText part='placeholder'}{/capture}
{if $mobile}
    <button type="button" class="lesson-assistant-fab button blue" data-lesson-assistant-toggle>{include file=$AssistantText part='fab'}</button>
{/if}
<section id="lesson-assistant" class="lesson-assistant{if $mobile} mobile{/if}"
    data-lang="{$Lang}" data-lesson-id="{$LessonData.id}" data-logged="{if $User->logged()}1{else}0{/if}"
    aria-label="{$smarty.capture.la_title|trim|escape}">
    <div class="la-header">
        <h3 class="la-title">{$smarty.capture.la_title|trim|escape}</h3>
        {if $mobile}
            <button type="button" class="la-close" data-lesson-assistant-toggle aria-label="Close">×</button>
        {/if}
    </div>
    <div class="la-messages" aria-live="polite">
        {if !$LessonAssistantHistory}
            <div class="la-intro">
                {include file=$AssistantText part='intro'}
                <div class="la-examples">
                    {include file=$AssistantText part='examples'}
                </div>
            </div>
        {/if}
        {foreach $LessonAssistantHistory as $message}
            <div class="la-message la-{$message.role}">{$message.html}</div>
        {/foreach}
    </div>
    <div class="la-notice{if !$AssistantExhausted} hidden{/if}">{if $AssistantExhausted}{$AiQuotaExceededMessage}{/if}</div>
    {if $User->logged()}
        <form class="la-form" autocomplete="off">
            <textarea class="la-input" name="question" rows="3" maxlength="1000"
                placeholder="{$smarty.capture.la_placeholder|trim|escape}"{if $AssistantExhausted} disabled{/if}></textarea>
            <div class="la-actions">
                <button type="button" class="la-reset text-button">{include file=$AssistantText part='reset'}</button>
                <button type="submit" class="button green la-send"{if $AssistantExhausted} disabled{/if}>{include file=$AssistantText part='send'}</button>
            </div>
        </form>
        <div class="la-quota">
            {if $AiQuota.subscribed}
                {include file=$AssistantText part='quota_subscriber'}
            {else}
                {include file=$AssistantText part='quota_free'}
            {/if}
            <div class="la-meter"><div style="width: {$AiQuota.percent_used}%"></div></div>
        </div>
        <template class="la-exhausted-message">{$AiQuotaExceededMessage}</template>
    {else}
        <div class="la-login">
            <button type="button" class="button green" onClick="toggleLoginWindow()">{include file=$AssistantText part='login'}</button>
        </div>
    {/if}
</section>
