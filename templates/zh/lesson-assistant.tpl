{* Text of the lesson assistant panel, see templates/lesson-assistant.tpl *}
{if $part == 'title'}关于本课提问
{elseif $part == 'fab'}问 AI
{elseif $part == 'intro'}
    <p>本课有不懂的地方？问问 AI 导师：它了解本课内容，并会用 SQL 示例回答。</p>
{elseif $part == 'examples'}
    <button type="button" class="la-example" data-question="请用简单的话解释本课的核心思想。">用简单的话解释核心思想</button>
    <button type="button" class="la-example" data-question="请再给出一个本课相关的查询示例并解释。">再给一个查询示例</button>
    <button type="button" class="la-example" data-question="初学者在这个主题上常犯哪些错误？">常见错误有哪些？</button>
{elseif $part == 'placeholder'}输入关于本课的问题…
{elseif $part == 'send'}发送
{elseif $part == 'reset'}清空对话
{elseif $part == 'login'}登录后即可提问
{elseif $part == 'quota_free'}AI 额度：已使用 <span class="la-percent">{$AiQuota.percent_used}</span>% · 免费额度，不会续期 · <a href="/{$Lang}/subscribe">订阅</a>
{elseif $part == 'quota_subscriber'}AI 额度：已使用 <span class="la-percent">{$AiQuota.percent_used}</span>% · {$AiQuota.resets_at} 续期
{/if}
