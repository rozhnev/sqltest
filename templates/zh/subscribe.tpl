{* Text of the subscribe page, see templates/subscribe.tpl *}
{if $part == 'title'}SQLTest.online 订阅
{elseif $part == 'intro'}
    <p>月度订阅支持本项目，并可享受：</p>
    <ul>
        <li>网站无广告</li>
        <li>{$SubscriptionAiMultiplier} 倍的 AI 额度，每月续期：课程助手和 AI 答案检查</li>
    </ul>
{elseif $part == 'login_prompt'}订阅与您的账户绑定，请先登录。
{elseif $part == 'login_button'}登录
{elseif $part == 'payment_success'}已收到付款！订阅将在几秒钟内开通，本页面会自动刷新。
{elseif $part == 'payment_failed'}付款未成功。请重试或更换其他银行卡。
{elseif $part == 'payment_cancelled'}付款已取消。您可以随时订阅。
{elseif $part == 'status_active'}您的订阅有效期至 <b>{$SubscriptionActiveThrough}</b>（含当天），每月自动续订。
{elseif $part == 'status_cancelled'}您的订阅有效期至 <b>{$SubscriptionActiveThrough}</b>（含当天）。已取消自动续订，到期后不会续期。
{elseif $part == 'status_manual'}您的订阅有效期至 <b>{$SubscriptionActiveThrough}</b>（含当天）。
{elseif $part == 'renewal_failed'}下个月的续订扣款失败。如果付款仍未成功，订阅将在 <b>{$SubscriptionActiveThrough}</b> 之后结束；请在 Lava.top 检查您的银行卡，或在到期后重新订阅。
{elseif $part == 'status_free'}您当前使用的是免费套餐。
{elseif $part == 'budget_subscriber'}AI 额度：已使用 {$AiQuota.percent_used}% · {$AiQuota.resets_at} 续期
{elseif $part == 'budget_free'}免费 AI 额度：已使用 {$AiQuota.percent_used}% · 一次性，不会续期
{elseif $part == 'budget_final'}AI 额度：已使用 {$AiQuota.percent_used}%
{elseif $part == 'cancel_button'}取消自动续订
{elseif $part == 'cancel_confirm'}确定取消自动续订吗？订阅在已付费期限结束前仍然有效。
{elseif $part == 'unavailable'}付款暂时不可用。请联系我们办理订阅。
{elseif $part == 'email_prompt'}我们的支付服务商 Lava.top 会通过电子邮件发送收据。请先为您的账户添加邮箱。
{elseif $part == 'email_placeholder'}you@example.com
{elseif $part == 'email_save'}保存邮箱
{elseif $part == 'subscribe_button'}订阅
{elseif $part == 'subscribe_again_button'}重新订阅
{elseif $part == 'checkout_note'}通过 Lava.top 以美元安全付款。订阅按月续订，您可以随时在此取消自动续订。
{/if}
