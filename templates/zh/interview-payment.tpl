<div style="max-width: 640px; margin: 15vh auto; text-align: center;">
    <h2>模拟面试访问权限</h2>
    <p>模拟面试为付费功能。请通过 Lava.top 付费以继续。</p>
    {if $InterviewPaymentUrl}
        <p><a class="button blue" href="{$InterviewPaymentUrl|escape}" target="_blank" rel="noopener noreferrer">通过 Lava.top 支付</a></p>
        <p style="font-size: 0.9em;">付款确认后，我们会尽快手动开通访问权限。</p>
    {else}
        <p>付款暂不可用，请联系我们获取访问权限。</p>
    {/if}
</div>
