{* Text of the lesson assistant panel, see templates/lesson-assistant.tpl *}
{if $part == 'title'}Pregunta sobre esta lección
{elseif $part == 'fab'}Preguntar a la IA
{elseif $part == 'intro'}
    <p>¿Algo de esta lección no queda claro? Pregunta al tutor de IA: conoce el texto de la lección y responde con ejemplos en SQL.</p>
{elseif $part == 'examples'}
    <button type="button" class="la-example" data-question="Explica la idea principal de esta lección con palabras sencillas.">Explica la idea principal con palabras sencillas</button>
    <button type="button" class="la-example" data-question="Muestra otro ejemplo de consulta de esta lección y explícalo.">Muestra otro ejemplo de consulta</button>
    <button type="button" class="la-example" data-question="¿Cuáles son los errores comunes de los principiantes en este tema?">¿Cuáles son los errores comunes?</button>
{elseif $part == 'placeholder'}Haz una pregunta sobre la lección…
{elseif $part == 'send'}Enviar
{elseif $part == 'reset'}Borrar conversación
{elseif $part == 'login'}Inicia sesión para hacer preguntas
{elseif $part == 'quota_free'}Presupuesto de IA: <span class="la-percent">{$AiQuota.percent_used}</span>% usado · cuota gratuita, no se renueva · <a href="/{$Lang}/subscribe">Suscribirse</a>
{elseif $part == 'quota_subscriber'}Presupuesto de IA: <span class="la-percent">{$AiQuota.percent_used}</span>% usado · se renueva el {$AiQuota.resets_at}
{/if}
