<h2>Подписка SQLTest.online</h2>
<p>Ежемесячная подписка поддерживает проект и открывает:</p>
<ul>
    <li>Сайт без рекламы</li>
    <li>AI-бюджет в {$SubscriptionAiMultiplier} раз больше, с ежемесячным обновлением: ассистент урока и AI-проверка ответов</li>
</ul>

{if !$User->logged()}
    <div class="subscribe-actions">
        <p>Подписка привязывается к аккаунту, поэтому сначала войдите.</p>
        <p><a class="button green" href="" onClick="toggleLoginWindow(); return false;">Войти</a></p>
    </div>
{else}
    <div class="subscribe-status">
        {if $AiQuota.subscribed}
            <p>Подписка активна по <b>{$SubscriptionActiveThrough}</b> включительно.</p>
            <p>AI-бюджет: израсходовано {$AiQuota.percent_used}% · обновится {$AiQuota.resets_at}</p>
        {else}
            <p>У вас бесплатный тариф.</p>
            <p>Бесплатный AI-лимит: израсходовано {$AiQuota.percent_used}% · разовый, не обновляется</p>
        {/if}
        <div class="subscribe-meter"><div style="width: {$AiQuota.percent_used}%"></div></div>
    </div>
    <div class="subscribe-actions">
        {if $SubscriptionPaymentUrl}
            <p><a class="button blue" href="{$SubscriptionPaymentUrl|escape}" target="_blank" rel="noopener noreferrer">{if $AiQuota.subscribed}Продлить через Lava.top{else}Оформить через Lava.top{/if}</a></p>
            <p class="subscribe-note">
                Подписка активируется вручную вскоре после подтверждения оплаты.
                {if $UserEmail}Пожалуйста, при оплате укажите email аккаунта <b>{$UserEmail|escape}</b>, чтобы мы могли сопоставить платёж.{else}После оплаты напишите нам, чтобы мы привязали платёж к вашему аккаунту.{/if}
            </p>
        {else}
            <p>Оплата временно недоступна. Напишите нам, чтобы оформить подписку.</p>
        {/if}
    </div>
{/if}
