<link rel="stylesheet" type="text/css" href="/about.css?{$VERSION}" media="all">
<style>
.about .colored {
    color: var(--ligth-h2-color);
}
.rank-table {
    width: 100%;
    border-collapse: collapse;
    margin: 1.5rem 0;
}
.rank-table th, .rank-table td {
    padding: 1rem;
    border: 1px solid var(--border-color);
    text-align: left;
}
</style> 
<div class="about">
    <div class="section top colored">
        <div>
            <h2>测试你的 SQL 知识！</h2>
        </div>
    </div>
    <div class="section not-colored">
        <div>
            <p>我们的测试由 12 个不同难度级别的任务组成，这些任务是从网站的任务数据库中随机选择的。任务的难度由网站用户的投票结果决定。</p>
            测试结构：
            <ul class="difficulty-list">
                <li class="difficulty-item">4 个“简单”级别的任务</li>
                <li class="difficulty-item">3 个“简单”级别的任务</li>
                <li class="difficulty-item">2 个“中等”级别的任务</li>
                <li class="difficulty-item">2 个“困难”级别的任务</li>
                <li class="difficulty-item">1 个“困难”级别的任务</li>
                </ul>
            </div>
        </div>
        <div class="section colored">
            <div>
                <h2>时间和等级</h2>
                测试分配了三个小时的时间。在时间结束时（或更早），您将能够获得 SQL 的一个等级：
                <table class="rank-table">
                    <tr>
                        <th>等级</th>
                        <th>要求</th>
                    </tr>
                    <tr>
                        <td>实习生</td>
                        <td>解决至少 6 个任务（任何难度）</td>
                    </tr>
                    <tr>
                        <td>初级</td>
                        <td>解决所有简单和容易的任务</td>
                    </tr>
                    <tr>
                        <td>中级</td>
                        <td>解决所有简单和容易的任务 + 剩余任务的 2/3</td>
                    </tr>
                    <tr>
                        <td>高级</td>
                        <td>解决所有任务</td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="section not-colored">
            <div>
                <h2>奖励和惩罚</h2>
                第一次尝试成功解决任务会带来额外的积分，而在一个任务上尝试次数过多可能会导致评分降低。
                <div class="note-section">
                    <strong>注意：</strong>评分系统可能会根据测试结果和参与者的反馈进行调整。
                </div>
            </div>
        </div>
        <div class="section bottom colored">    {if $User->logged()}
            {if isset($LastTest)}
                {if $LastTest.closed}
                    {if $LastTest.rate eq 1}
                        <h2>良好的开始！根据测试结果，您的等级是实习生。</h2>这说明了您的潜力。您想进一步发展并提升到下一个等级吗？
                    {elseif $LastTest.rate eq 2}
                        <h2>您走在正确的道路上！您当前的等级是初级。</h2>这是一个很好的结果。您准备好扩展您的知识和技能吗？
                    {elseif $LastTest.rate eq 3}
                        <h2>您已达到中级水平！</h2>太好了！但总有改进的空间，对吧？准备好挑战自己并提高您的成绩吗？
                    {elseif $LastTest.rate eq 4}
                        <h2>恭喜！您现在是高级！</h2>准备好确认您的身份吗？
                    {else}
                        <h2>您上次测试的时间已到。</h2>准备好再试一次吗？
                    {/if}
                    <div style="text-align: center;">
                        <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/create" title="开始测试" class="button green">开始测试</a>
                    </div>
                {else}
                    {* 继续未完成的测试 *}
                    <div style="text-align: center;">
                        <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/{$LastTest.id}/question/" title="继续测试" class="button green">继续测试</a>
                    </div>
                {/if}
            {else}
                <h2>祝您好运！</h2>
                <div style="text-align: center;">
                    <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/create" title="开始测试" class="button green">开始测试</a>
                </div>
            {/if}
        {else}
            <h2><span class='warning'>
                此页面对未注册用户不可用。请登录以继续。
            </span></h2>
            <div style="text-align: center;">
                <button class="button green" onClick="toggleLoginWindow()">登录</button>
            </div>
        {/if}
    </div>
</div>