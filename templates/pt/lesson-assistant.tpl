{* Text of the lesson assistant panel, see templates/lesson-assistant.tpl *}
{if $part == 'title'}Pergunte sobre esta lição
{elseif $part == 'fab'}Perguntar à IA
{elseif $part == 'intro'}
    <p>Travou em algo nesta lição? Pergunte ao tutor de IA: ele conhece o texto da lição e responde com exemplos em SQL.</p>
{elseif $part == 'examples'}
    <button type="button" class="la-example" data-question="Explique a ideia principal desta lição em palavras simples.">Explique a ideia principal em palavras simples</button>
    <button type="button" class="la-example" data-question="Mostre mais um exemplo de consulta desta lição e explique-o.">Mostre mais um exemplo de consulta</button>
    <button type="button" class="la-example" data-question="Quais são os erros comuns dos iniciantes neste tema?">Quais são os erros comuns?</button>
{elseif $part == 'placeholder'}Faça uma pergunta sobre a lição…
{elseif $part == 'send'}Enviar
{elseif $part == 'reset'}Limpar conversa
{elseif $part == 'login'}Entre para fazer perguntas
{elseif $part == 'quota_free'}Orçamento de IA: <span class="la-percent">{$AiQuota.percent_used}</span>% usado · cota gratuita, não é renovada · <a href="/{$Lang}/subscribe">Assinar</a>
{elseif $part == 'quota_subscriber'}Orçamento de IA: <span class="la-percent">{$AiQuota.percent_used}</span>% usado · renova em {$AiQuota.resets_at}
{/if}
