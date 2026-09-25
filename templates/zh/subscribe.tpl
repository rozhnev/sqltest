<h2>SQLTest.online 订阅</h2>
<p>月度订阅支持本项目，并可享受：</p>
<ul>
    <li>网站无广告</li>
    <li>{$SubscriptionAiMultiplier} 倍的 AI 额度，每月续期：课程助手和 AI 答案检查</li>
</ul>

{if !$User->logged()}
    <div class="subscribe-actions">
        <p>订阅与您的账户绑定，请先登录。</p>
        <p><a class="button green" href="" onClick="toggleLoginWindow(); return false;">登录</a></p>
    </div>
{else}
    <div class="subscribe-status">
        {if $AiQuota.subscribed}
            <p>您的订阅有效期至 <b>{$SubscriptionActiveThrough}</b>（含当天）。</p>
            <p>AI 额度：已使用 {$AiQuota.percent_used}% · {$AiQuota.resets_at} 续期</p>
        {else}
            <p>您当前使用的是免费套餐。</p>
            <p>免费 AI 额度：已使用 {$AiQuota.percent_used}% · 一次性，不会续期</p>
        {/if}
        <div class="subscribe-meter"><div style="width: {$AiQuota.percent_used}%"></div></div>
    </div>
    <div class="subscribe-actions">
        {if $SubscriptionPaymentUrl}
            <p><a class="button blue" href="{$SubscriptionPaymentUrl|escape}" target="_blank" rel="noopener noreferrer">{if $AiQuota.subscribed}通过 Lava.top 续订{else}通过 Lava.top 订阅{/if}</a></p>
            <p class="subscribe-note">
                付款确认后，我们会尽快手动开通订阅。
                {if $UserEmail}付款时请使用您的账户邮箱 <b>{$UserEmail|escape}</b>，以便我们核对付款。{else}付款后请联系我们，以便我们将付款与您的账户关联。{/if}
            </p>
        {else}
            <p>付款暂时不可用。请联系我们办理订阅。</p>
        {/if}
    </div>
{/if}
