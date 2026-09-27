{assign var="goal" value=$DONATION_MONTHLY_GOAL|default:50}
{assign var="received" value=$DONATIONS.monthly_amount_usd|default:0}
{if $goal > 0}
    {math equation="(x / y) * 100" x=$received y=$goal assign="progressRaw"}
{else}
    {assign var="progressRaw" value=0}
{/if}
{if $progressRaw < 0}
    {assign var="progress" value=0}
{elseif $progressRaw > 100}
    {assign var="progress" value=100}
{else}
    {assign var="progress" value=$progressRaw}
{/if}

<div class="menu-ad donation-goal-widget">
    <div class="side-card">
        <div class="side-card-title">支持 SQLtest.online</div>
        <div class="side-card-body">
            <p>
                这个项目只有一个资金来源：你的捐款。
                每月维护成本为 <strong>${$goal|string_format:"%.0f"}</strong>。
            </p>
            <p>
                上个月我添加了一个新的 MariaDB 数据库，里面预加载了大学数据库，9 个新问题，并重构了许多问题和课程。
            </p>
            <p>
                在你的支持下，我计划继续这项工作：编写新课程和任务，并改进现有课程。
            </p>
            <p>
                为了让项目在下个月继续运行，我们需要在本月底之前至少收集到这个金额。
                超过的部分将用于新课程、练习和功能。
            </p>

            <div class="donation-stats">
                <span>已收到：${$received|string_format:"%.2f"}</span>
                <span>目标：${$goal|string_format:"%.2f"}</span>
            </div>
            <div class="side-card-progress">
                <div class="side-card-progress-fill" style="width: {$progress|string_format:'%.2f'}%"></div>
            </div>
            <div class="donation-percent">进度：{$progress|string_format:"%.0f"}%</div>
            <div class="donation-action">
                <a href="/{$Lang}/donate" target="_self">
                    <button class="button green side-card-button"><span>{translate}top_menu_donate{/translate}</span></button>
                </a>
            </div>
        </div>
    </div>
</div>