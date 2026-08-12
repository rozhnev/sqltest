<link rel="stylesheet" type="text/css" href="/about.css?{$VERSION}" media="all">
<div class="about">
    <div class="section top colored">
        <div>
            <h2>❤️ 支持 SQLtest.online</h2>
        </div>
        <div style="display: block; text-align: left;">
            <p>
                SQLtest.online 是一个免费的 SQL 学习平台，供学生、开发者和准备技术面试的专业人士使用。
                你的支持使项目得以持续 - 负担服务器费用、资助新课程，并帮助我们构建更多互动的 SQL 练习。
            </p>
        </div>
    </div>
    <div class="section" style="height: 100%;">
        <div style="display: block;">      
            <h2 style="color: var(--ligth-h2-color);">💳 选择支持方式</h2>
            <div class="donation-methods">
                {* <div class="donation-method">
                    <h3>Ko‑fi（银行卡 / PayPal）</h3>
                    <p style="margin: 1.5rem 0;">
                    <script type='text/javascript' src='https://storage.ko-fi.com/cdn/widget/Widget_2.js'></script>
                    <script type='text/javascript'>
                        kofiwidget2.init('在 Ko-fi 上支持我们', 'revert-layer', 'D1D76X1T1');
                        kofiwidget2.draw();
                    </script>
                    </p>
                    <p>大多数地区提供简单安全的支付方式。</p>
                    <p class="donation-fallback">如果小部件未加载，请使用直接链接：<a href="https://ko-fi.com/D1D76X1T1" target="_blank" rel="noopener noreferrer">ko-fi.com/D1D76X1T1</a>。</p>
                </div> *}
                <div class="donation-method">
                    <h3>加密货币捐赠</h3>
                    <p>喜欢加密货币？请使用下面的小部件：</p>
                    <iframe
                    src="https://nowpayments.io/embeds/payment-widget?iid=4471785527"
                    width="410"
                    height="696"
                    frameborder="0"
                    scrolling="no"
                    style="overflow-y: hidden;"
                    >
                        无法加载小部件
                    </iframe>
                    {* <iframe src="https://nowpayments.io/embeds/donation-widget?api_key=8881e1d0-aaef-46c4-9a60-298bb6f26c3b" width="346" height="623" frameborder="0" scrolling="no" style="overflow-y: hidden;">
                        无法加载小部件
                    </iframe> *}
                    <p class="donation-fallback">如果被浏览器阻止，请尝试禁用内容拦截器或使用 Ko‑fi。</p>
                </div>
            </div>
            <h3 style="color: var(--ligth-h2-color);">🎯 你的支持如何帮助我们</h3>
            <div class="donation-method donations-history">
            <ul class="donation-suggested">
                <li>$3-5 有助于覆盖部分月度服务器费用。</li>
                <li>$10-15 有助于资助新课程和练习。</li>
                <li>$25+ 有助于加速新开发。</li>
            </ul>
            <p class="donation-helper">
                每一份贡献，无论大小，都非常感谢。感谢你帮助我们让 SQLtest.online 变得更好！
            </p>
            </div>
            <h3 style="color: var(--ligth-h2-color); margin-top: 2rem;">💬 最近的支持</h3>
            <div class="donation-method donations-history">
                {if $LatestDonations|@count > 0}
                    <table class="donations-history-table">
                        <thead>
                            <tr>
                                <th>用户</th>
                                <th>日期</th>
                                <th class="align-right">金额</th>
                                <th class="align-right">美元</th>
                                <th>备注</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$LatestDonations item=donation}
                                <tr>
                                    <td>{$donation.donor_name|escape}</td>
                                    <td>{$donation.donated_at|escape}</td>
                                    <td class="align-right">{$donation.amount|escape} {$donation.currency|escape}</td>
                                    <td class="align-right">$ {$donation.amount_usd|escape}</td>
                                    <td>{$donation.notes|default:'-'|escape}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                {else}
                    <p class="donations-history-empty">尚无捐赠记录。</p>
                {/if}
            </div>
            <h3 style="color: var(--ligth-h2-color);">🙏 谢谢你</h3>
            <div class="donation-method donations-history">
                嗨，我是 Slava — 我创建了 SQLtest.online 来帮助人们免费学习 SQL。
                我自己构建和维护这个项目，你的支持直接帮助我
                维持服务器运行，发布新课程，并开发更多互动练习。
                感谢你帮助 SQL 学习对每个人都保持可及性。
            </div>
        </div>
    </div>
    <div class="section bottom colored">
        <div>
            <h4>
                感谢你成为 SQLtest.online 社区的精彩一员！
                你的支持带来了真正的改变。❤️
                我们一起让 SQL 学习对每个人都更加可及和愉快。
            </h4>
        </div>
    </div>
</div>