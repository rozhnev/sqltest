{* Text of the AI tokens page, see templates/tokens.tpl *}
{if $part == 'title'}AI 令牌
{elseif $part == 'intro'}
    <p>AI 令牌用于支付 SQLTest.online 的 AI 功能：</p>
    <ul>
        <li>课程助手：回答您正在阅读的课程相关问题</li>
        <li>自由作答的 AI 检查</li>
    </ul>
    <p>每个令牌包包含 <b>{$TokensPack}</b> 个令牌。一次性付款，令牌永不过期。</p>
{elseif $part == 'login_prompt'}令牌会添加到您的账户，请先登录。
{elseif $part == 'login_button'}登录
{elseif $part == 'payment_success'}已收到付款！令牌将在几秒钟内到账，本页面会自动刷新。
{elseif $part == 'payment_failed'}付款未成功。请重试或更换其他银行卡。
{elseif $part == 'payment_cancelled'}付款已取消。您可以随时购买令牌。
{elseif $part == 'balance'}您的余额：<b>{$AiQuota.remaining_text}</b> 个 AI 令牌
{elseif $part == 'unavailable'}付款暂时不可用。请联系我们购买令牌。
{elseif $part == 'email_prompt'}我们的支付服务商 Lava.top 会通过电子邮件发送收据。请先为您的账户添加邮箱。
{elseif $part == 'email_placeholder'}you@example.com
{elseif $part == 'email_save'}保存邮箱
{elseif $part == 'promo_code_label'}有优惠码？
{elseif $part == 'promo_code_placeholder'}优惠码
{elseif $part == 'buy_button'}购买 {$TokensPack} 个令牌
{elseif $part == 'checkout_note'}通过 Lava.top 以美元安全地一次性付款。
{elseif $part == 'history_title'}您的购买记录
{elseif $part == 'history_date'}日期
{elseif $part == 'history_tokens'}令牌
{elseif $part == 'history_amount'}已付
{/if}
