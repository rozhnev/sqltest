{* Texts of the playground assistant panel (templates/ai-assistant.tpl), from the playground_assistant_* translation keys *}
{if $part == 'title'}{translate}playground_assistant_title{/translate}
{elseif $part == 'fab'}{translate}playground_assistant_fab{/translate}
{elseif $part == 'intro'}<p>{translate}playground_assistant_intro{/translate}</p>
{elseif $part == 'context_note'}{translate}playground_assistant_context_note{/translate}
{elseif $part == 'quick_actions'}
    <button type="button" class="la-example" data-question="{translate}playground_assistant_q_explain{/translate}">{translate}playground_assistant_a_explain{/translate}</button>
    <button type="button" class="la-example" data-requires-error data-question="{translate}playground_assistant_q_fix{/translate}">{translate}playground_assistant_a_fix{/translate}</button>
    <button type="button" class="la-example" data-question="{translate}playground_assistant_q_improve{/translate}">{translate}playground_assistant_a_improve{/translate}</button>
    <button type="button" class="la-example" data-question="{translate}playground_assistant_q_write{/translate}">{translate}playground_assistant_a_write{/translate}</button>
{elseif $part == 'placeholder'}{translate}playground_assistant_placeholder{/translate}
{elseif $part == 'send'}{translate}playground_assistant_send{/translate}
{elseif $part == 'reset'}{translate}playground_assistant_reset{/translate}
{elseif $part == 'login'}{translate}playground_assistant_login{/translate}
{elseif $part == 'quota'}{translate}playground_assistant_tokens_left{/translate} <span class="la-remaining">{$AiQuota.remaining_text}</span> · <a href="/{$Lang}/buy-tokens">{translate}playground_assistant_buy_more{/translate}</a>
{/if}
