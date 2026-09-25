{* Text of the lesson assistant panel, see templates/lesson-assistant.tpl *}
{if $part == 'title'}Ask about this lesson
{elseif $part == 'fab'}Ask AI
{elseif $part == 'intro'}
    <p>Stuck on something in this lesson? Ask the AI tutor: it knows the lesson text and answers with SQL examples.</p>
{elseif $part == 'examples'}
    <button type="button" class="la-example" data-question="Explain the main idea of this lesson in simple words.">Explain the main idea in simple words</button>
    <button type="button" class="la-example" data-question="Show one more example query for this lesson and explain it.">Show one more example query</button>
    <button type="button" class="la-example" data-question="What are the common mistakes beginners make with this topic?">What are the common mistakes?</button>
{elseif $part == 'placeholder'}Ask a question about the lesson…
{elseif $part == 'send'}Send
{elseif $part == 'reset'}Clear chat
{elseif $part == 'login'}Log in to ask questions
{elseif $part == 'quota_free'}AI budget: <span class="la-percent">{$AiQuota.percent_used}</span>% used · free allowance, doesn't renew · <a href="/{$Lang}/subscribe">Subscribe</a>
{elseif $part == 'quota_subscriber'}AI budget: <span class="la-percent">{$AiQuota.percent_used}</span>% used · renews on {$AiQuota.resets_at}
{/if}
