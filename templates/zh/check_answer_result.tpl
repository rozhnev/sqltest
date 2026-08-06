{assign var=phrase_id value=0|mt_rand:4}

{if $AnswerResult.ok}
    {assign var="phrases" value=[
        ['太棒了！你完成了任务！', '为了保存你的进度，请 <a href="" onClick="toggleLoginWindow(); return false;">登录</a>。'],
        ['真棒！你完成了任务！', '为了确保你的进度安全，<a href="" onClick="toggleLoginWindow(); return false;">现在就登录</a>。'],
        ['你做到了！干得好！', '为了确保你的精彩工作被保存，<a href="" onClick="toggleLoginWindow(); return false;">请登录</a>。'],
        ['恭喜你完成了任务！', '<a href="" onClick="toggleLoginWindow(); return false;">现在登录</a>以保存你的进度。'],
        ['你太棒了！你完成了所有任务！', '别忘了 <a href="" onClick="toggleLoginWindow(); return false;">登录</a> 以确保你的所有进度安全无忧。😎']
    ] }
    <p>{$phrases[$phrase_id][0]}</p>
    {if !$User->logged()}
        <p class="question-action">
            {$phrases[$phrase_id][1]}
        </p>
    {else}
        <div class="question-rate-panel">
        <div style="min-width:280px; flex: 2 1; margin-bottom: 9px 0;">在开始下一个测试之前，请评价一下这个任务的难度：</div>
            <div class="buttons">
                <input type="radio" id="rate1" name="question_rate" value="太简单" onChange="rateQuestion({$QuestionID}, 1)"><label for="rate1">太简单</label>
                <input type="radio" id="rate2" name="question_rate" value="简单" onChange="rateQuestion({$QuestionID}, 2)"><label for="rate2">简单</label>
                <input type="radio" id="rate3" name="question_rate" value="正常" onChange="rateQuestion({$QuestionID}, 3)"><label for="rate3">正常</label>
                <input type="radio" id="rate4" name="question_rate" value="困难" onChange="rateQuestion({$QuestionID}, 4)"><label for="rate4">困难</label>
                <input type="radio" id="rate5" name="question_rate" value="非常困难" onChange="rateQuestion({$QuestionID}, 5)"><label for="rate5">非常困难</label>
            </div>
        </div>
    {/if}
{else}
    {assign var="phrases" value=[
        ['这不是答案，但继续思考！再试一次。'],
        ['不太对，但不要放弃！再试一次。'],
        ['让我们尝试不同的方法。'],
        ['差不多，但还不够。再试一次！'],
        ['再试一次。你快到了！']
    ]}
    {$phrases[$phrase_id][0]}
    <p>任务出错？ <a target="_blank" href="https://telegram.me/sqlize">报告！我们会修复它😊</a></p>
{/if}
{if isset($ReferralLink)}
    <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
        <div class="referral-link">
            {$ReferralLink.content}
        </div>
    </a>
{/if}