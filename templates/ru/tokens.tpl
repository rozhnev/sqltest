{* Text of the AI tokens page, see templates/tokens.tpl *}
{if $part == 'title'}AI-токены
{elseif $part == 'intro'}
    <p>AI-токены оплачивают AI-функции SQLTest.online:</p>
    <ul>
        <li>ассистента урока, который отвечает на вопросы по уроку, который вы читаете</li>
        <li>AI-проверку ответов в свободной форме</li>
    </ul>
    <p>Пакет даёт <b>{$TokensPack}</b> токенов. Это разовый платёж, токены не сгорают.</p>
{elseif $part == 'login_prompt'}Токены зачисляются на аккаунт, поэтому сначала войдите.
{elseif $part == 'login_button'}Войти
{elseif $part == 'payment_success'}Оплата получена! Токены будут зачислены через несколько секунд, страница обновится сама.
{elseif $part == 'payment_failed'}Оплата не прошла. Попробуйте ещё раз или используйте другую карту.
{elseif $part == 'payment_cancelled'}Оплата отменена. Купить токены можно в любой момент.
{elseif $part == 'balance'}Ваш баланс: <b>{$AiQuota.remaining_text}</b> AI-токенов
{elseif $part == 'unavailable'}Оплата временно недоступна. Напишите нам, чтобы купить токены.
{elseif $part == 'email_prompt'}Платёжный сервис Lava.top отправляет чеки на email. Сначала добавьте email в аккаунт.
{elseif $part == 'email_placeholder'}you@example.com
{elseif $part == 'email_save'}Сохранить email
{elseif $part == 'promo_code_label'}Есть промокод?
{elseif $part == 'promo_code_placeholder'}Промокод
{elseif $part == 'buy_button'}Купить {$TokensPack} токенов
{elseif $part == 'checkout_note'}Безопасный разовый платёж через Lava.top в рублях.
{elseif $part == 'history_title'}Ваши покупки
{elseif $part == 'history_date'}Дата
{elseif $part == 'history_tokens'}Токены
{elseif $part == 'history_amount'}Оплачено
{/if}
