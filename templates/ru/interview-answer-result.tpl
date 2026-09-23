{if !$AnswerResult.saved}
    <div class="interview-feedback">
        <p>
        {if $AnswerResult.error === 'empty'}
            Ответ пустой — напишите что-нибудь перед отправкой.
        {elseif $AnswerResult.error === 'no_option'}
            Выберите хотя бы один вариант ответа.
        {elseif $AnswerResult.error === 'llm_unavailable'}
            Не удалось проверить ответ прямо сейчас. Попробуйте отправить ещё раз через минуту — попытка не потрачена.
        {else}
            Этот вопрос уже не активен.
            <a href="/{$Lang}/interview/{$SessionId}/question">Перейти к текущему вопросу</a>
        {/if}
        </p>
    </div>
{else}
    {assign var="check" value=$AnswerResult.check}
    {assign var="feedback" value=$AnswerResult.feedback}
    <div class="interview-feedback {if $AnswerResult.correct}correct{elseif !$AnswerResult.final}retry{else}wrong{/if}">
        <p class="verdict">
            {if $AnswerResult.correct}✓ Ответ принят{if $AnswerResult.questionType === 'free_answer'} — {$check.score}/100{/if}
            {elseif !$AnswerResult.final}Почти! Попытка {$AnswerResult.attempt} из {$AnswerResult.maxAttempts}
            {else}✗ Ответ неверный{if $AnswerResult.questionType === 'free_answer'} — {$check.score}/100{/if}
            {/if}
        </p>
        {if isset($check.hints)}
            {if isset($check.hints.emptyQuery)}
                <p>Запрос пустой.</p>
            {/if}
            {if isset($check.hints.queryError)}
                <p>Запрос вернул ошибку: <span class="sql_error">{$check.hints.queryError|escape}</span></p>
            {/if}
            {* Detailed diagnostics would give the answer away while a retry is still open. *}
            {if $AnswerResult.final && !$feedback}
                {if isset($check.hints.wrongQueryHints)}
                    {foreach $check.hints.wrongQueryHints as $hint}
                        {if $hint}<p>{$hint}</p>{/if}
                    {/foreach}
                {/if}
                {if isset($check.hints.multipleResults)}
                    <p>Запрос вернул несколько наборов результатов, ожидается один.</p>
                {/if}
                {if isset($check.hints.columnsCount)}
                    <p>Ожидаемое число столбцов: {$check.hints.columnsCount}.</p>
                {/if}
                {if isset($check.hints.columnsList)}
                    <p>Ожидаемые столбцы: {$check.hints.columnsList}.</p>
                {/if}
                {if isset($check.hints.rowsCount)}
                    <p>Ожидаемое число строк: {$check.hints.rowsCount}.</p>
                {/if}
                {if isset($check.hints.rowsData)}
                    <p>Строка {$check.hints.rowsData.rowNumber} должна быть такой:</p>
                    {$check.hints.rowsData.rowTable}
                    <p>У вас получилось:</p>
                    {$check.hints.rowsData.resultTable}
                {/if}
            {/if}
        {/if}
    </div>

    {if $feedback && ($feedback.comment || $feedback.hint)}
        <div class="interview-dialog interview-reaction">
            <div class="dialog-row">
                {if $AnswerResult.questionType === 'query'}
                    <img class="dialog-avatar" src="/images/interview/meridian-logistics-sql-lead.jpg" alt="Дэниел Парк">
                {else}
                    <img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Елена Чо">
                {/if}
                <div class="dialog-message">
                    <p class="dialog-author">{if $AnswerResult.questionType === 'query'}Дэниел Парк{else}Елена Чо{/if}</p>
                    <div class="dialog-bubble">
                        {if !$AnswerResult.final}
                            <p class="pre-wrap">{$feedback.hint|default:$feedback.comment|escape}</p>
                            <p><em>Исправьте ответ и отправьте ещё раз.</em></p>
                        {else}
                            <p class="pre-wrap">{$feedback.comment|default:$feedback.hint|escape}</p>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    {/if}

    {if $AnswerResult.final}
        <p class="interview-next">
            {if $AnswerResult.nextQuestionId}
                <a class="button blue" href="/{$Lang}/interview/{$SessionId}/question">Следующий вопрос</a>
            {else}
                <a class="button green" href="/{$Lang}/interview/{$SessionId}/result">Завершить и посмотреть результат</a>
            {/if}
        </p>
    {/if}
{/if}
