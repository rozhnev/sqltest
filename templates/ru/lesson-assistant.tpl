{* Text of the lesson assistant panel, see templates/lesson-assistant.tpl *}
{if $part == 'title'}Вопрос по уроку
{elseif $part == 'fab'}Спросить AI
{elseif $part == 'intro'}
    <p>Что-то непонятно в уроке? Спросите AI-преподавателя: он знает текст урока и отвечает с примерами на SQL.</p>
{elseif $part == 'examples'}
    <button type="button" class="la-example" data-question="Объясни главную идею этого урока простыми словами.">Объясни главную идею простыми словами</button>
    <button type="button" class="la-example" data-question="Покажи ещё один пример запроса по этому уроку и объясни его.">Покажи ещё один пример запроса</button>
    <button type="button" class="la-example" data-question="Какие типичные ошибки делают новички в этой теме?">Какие типичные ошибки?</button>
{elseif $part == 'placeholder'}Задайте вопрос по уроку…
{elseif $part == 'send'}Отправить
{elseif $part == 'reset'}Очистить чат
{elseif $part == 'login'}Войдите, чтобы задавать вопросы
{elseif $part == 'quota'}Осталось AI-токенов: <span class="la-remaining">{$AiQuota.remaining_text}</span> · <a href="/{$Lang}/tokens">Купить ещё</a>
{/if}
