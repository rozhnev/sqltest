{if $QueryTestResult.ok}
    {assign var="successVariants" value=[
        "干得好！你解决了这个任务！",
        "恭喜！任务成功完成！",
        "优秀！你的查询产生了正确的结果！",
        "太棒了！你正确地解决了这个任务！",
        "做得好！你的解决方案是正确的！"
    ]}
    {assign var="successIndex" value=$successVariants|@array_rand}
    <div class="query-success-title">
        {$successVariants[$successIndex]}
    </div>
    <div class="query-success-body">
        {if $QueryTestResult.cost > 0}
            <div class="query-cost">
            执行你的查询成本是 <span class="query-cost-value{if $QueryBestCost < $QueryTestResult.cost} worse{/if}">{$QueryTestResult.cost}</span> <span class="query-cost-hint">（成本越低，查询越高效）</span>
            {if $QueryBestCost}
                <br>最佳方案成本： <span class="query-cost-value">{$QueryBestCost}</span>
                {if $QueryBestCost == $QueryTestResult.cost}
                    <p class="query-cost-note">
                        <i class="icon icon-flame" aria-hidden="true"></i>
                        恭喜！你的查询已跻身本站最佳方案之一！
                    </p>
                {elseif $QueryBestCost > $QueryTestResult.cost}
                    <p class="query-cost-note">
                        <i class="icon icon-flame" aria-hidden="true"></i>
                        恭喜！你刷新了我们的最佳记录！
                    </p>
                {else}
                    <p class="query-cost-note worse">
                        很遗憾，你的结果与最佳记录还有差距。继续优化吧！
                    </p>
                {/if}
            {/if}
            </div>
        {/if}
        <div>
            <button class="button green" onClick="showOthersSolutions({$QuestionID})">查看其他解法！</button>
        </div>
     </div>
     {if !$User->logged()}
        <p class="question-action">
            若要保存进度并查看其他解法，请先 <a href="" onClick="toggleLoginWindow(); return false;">登录</a>
        </p>
    {else}
        <div class="question-rate-panel">
            <div class="question-rate-panel__title">开始下一题前，请为本题难度评分：</div>
            <div class="buttons">
                <input type="radio" id="rate1" name="question_rate" value="太简单" onChange="rateQuestion({$QuestionID}, 1)"><label for="rate1">太简单</label>
                <input type="radio" id="rate2" name="question_rate" value="简单" onChange="rateQuestion({$QuestionID}, 2)"><label for="rate2">简单</label>
                <input type="radio" id="rate3" name="question_rate" value="普通" onChange="rateQuestion({$QuestionID}, 3)"><label for="rate3">普通</label>
                <input type="radio" id="rate4" name="question_rate" value="困难" onChange="rateQuestion({$QuestionID}, 4)"><label for="rate4">困难</label>
                <input type="radio" id="rate5" name="question_rate" value="非常困难" onChange="rateQuestion({$QuestionID}, 5)"><label for="rate5">非常困难</label>
            </div>
        </div>
    {/if}
    {if isset($ReferralLink)}
        <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
            <div class="referral-link">
                {$ReferralLink.content}
            </div>
        </a>
    {/if}
{else}
     很遗憾，答案不正确。
     {if array_key_exists('hints', $QueryTestResult) }
        {if array_key_exists('wrongQuery', $QueryTestResult.hints) }
            <p>
                查询结果是对的，但查询本身不符合题目要求{if array_key_exists('wrongQueryHints', $QueryTestResult.hints)}：
                    <ul>
                    {foreach from=$QueryTestResult.hints.wrongQueryHints item=wrongQueryHint}
                        <li>{$wrongQueryHint}</li>
                    {/foreach}
                    </ul>
                {else}。
                {/if}
                <span class="text-button blue" onclick="getHelp('{$Lang}', {$QuestionID})">
                    <i class="icon icon-hint" aria-hidden="true"></i>
                    使用提示并尝试重写你的查询。
                </span>
            </p>
        {/if}
        {if array_key_exists('multipleResults', $QueryTestResult.hints) }
            <p>提示：返回了多个结果集。系统只期望一个结果集。</p>
        {/if}
        {if array_key_exists('queryError', $QueryTestResult.hints) }
            <p>提示：查询返回错误：<span class="sql_error">{$QueryTestResult.hints.queryError}</span></p>
        {/if}
        {if array_key_exists('columnsCount', $QueryTestResult.hints) }
            <p>提示：结果表必须包含 {$QueryTestResult.hints.columnsCount} 列。</p>
        {/if}
        {if array_key_exists('columnsList', $QueryTestResult.hints) }
            <p>提示：结果表应包含以下列：{$QueryTestResult.hints.columnsList}。</p>
        {/if}
        {if array_key_exists('rowsCount', $QueryTestResult.hints) }
            <p>提示：结果必须包含 {$QueryTestResult.hints.rowsCount} 行。</p>
        {/if}
        {if array_key_exists('rowsData', $QueryTestResult.hints) }
            <p>提示：你的结果第 {$QueryTestResult.hints.rowsData.rowNumber} 行与预期不同：</p>
            {include file='row_diff.tpl' RowDiff=$QueryTestResult.hints.rowsData}
        {/if}
        {if array_key_exists('emptyQuery', $QueryTestResult.hints) }
            <p>提示：你的查询为空。</p>
        {/if}
     {/if}
    <div style="display: flex; flex-direction: column; align-items: flex-start; margin-top: 10px;">
        再试一次。<br>
        <p style="display: flex; margin-top: 2em; column-gap: 6px; font-style: italic;">
            发现题目有问题？&nbsp;
            <a style="display: flex; column-gap: 6px; justify-content: center; align-items: center;" target="_blank" href="https://telegram.me/sqltest_online" class="">
                <span class="tg-icon">
                    <span class=""> </span>
                </span>
                告诉我们！
            </a>
        </p>
    </div>
    {if isset($ReferralLink)}
        <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
            <div class="referral-link">
                {$ReferralLink.content}
            </div>
        </a>
    {/if}
{/if}