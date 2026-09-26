{* Text of the subscribe page, see templates/subscribe.tpl *}
{if $part == 'title'}Подписка SQLTest.online
{elseif $part == 'intro'}
    <p>Ежемесячная подписка поддерживает проект и открывает:</p>
    <ul>
        <li>Сайт без рекламы</li>
        <li>AI-бюджет в {$SubscriptionAiMultiplier} раз больше, с ежемесячным обновлением: ассистент урока и AI-проверка ответов</li>
    </ul>
{elseif $part == 'login_prompt'}Подписка привязывается к аккаунту, поэтому сначала войдите.
{elseif $part == 'login_button'}Войти
{elseif $part == 'payment_success'}Оплата получена! Подписка активируется через несколько секунд, страница обновится сама.
{elseif $part == 'payment_failed'}Оплата не прошла. Попробуйте ещё раз или используйте другую карту.
{elseif $part == 'payment_cancelled'}Оплата отменена. Оформить подписку можно в любой момент.
{elseif $part == 'status_active'}Подписка активна по <b>{$SubscriptionActiveThrough}</b> включительно и продлевается автоматически каждый месяц.
{elseif $part == 'status_cancelled'}Подписка активна по <b>{$SubscriptionActiveThrough}</b> включительно. Автопродление отменено, подписка не продлится.
{elseif $part == 'status_manual'}Подписка активна по <b>{$SubscriptionActiveThrough}</b> включительно.
{elseif $part == 'renewal_failed'}Не удалось списать оплату за следующий месяц. Если платёж не пройдёт, подписка закончится после <b>{$SubscriptionActiveThrough}</b>. Проверьте карту в Lava.top или оформите подписку заново после её окончания.
{elseif $part == 'status_free'}У вас бесплатный тариф.
{elseif $part == 'budget_subscriber'}AI-бюджет: израсходовано {$AiQuota.percent_used}% · обновится {$AiQuota.resets_at}
{elseif $part == 'budget_free'}Бесплатный AI-лимит: израсходовано {$AiQuota.percent_used}% · разовый, не обновляется
{elseif $part == 'budget_final'}AI-бюджет: израсходовано {$AiQuota.percent_used}%
{elseif $part == 'cancel_button'}Отменить автопродление
{elseif $part == 'cancel_confirm'}Отменить автопродление? Подписка будет действовать до конца оплаченного периода.
{elseif $part == 'unavailable'}Оплата временно недоступна. Напишите нам, чтобы оформить подписку.
{elseif $part == 'email_prompt'}Платёжный сервис Lava.top отправляет чеки на email. Сначала добавьте email в аккаунт.
{elseif $part == 'email_placeholder'}you@example.com
{elseif $part == 'email_save'}Сохранить email
{elseif $part == 'subscribe_button'}Оформить подписку
{elseif $part == 'subscribe_again_button'}Оформить заново
{elseif $part == 'checkout_note'}Безопасная оплата через Lava.top в рублях. Подписка продлевается ежемесячно, автопродление можно отменить здесь в любой момент.
{/if}
