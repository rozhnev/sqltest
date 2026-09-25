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
    <div class="interview-feedback {if $AnswerResult.correct}correct{else}wrong{/if}">
        <p class="verdict">{if $AnswerResult.correct}✓ Ответ принят{else}✗ Ответ неверный{/if}</p>
        {if $AnswerResult.questionType === 'free_answer' && $check.comment}
            <p>{$check.comment|escape}</p>
        {/if}
        {if isset($check.hints)}
            {if isset($check.hints.emptyQuery)}
                <p>Запрос пустой.</p>
            {/if}
            {if isset($check.hints.wrongQueryHints)}
                {foreach $check.hints.wrongQueryHints as $hint}
                    {if $hint}<p>{$hint}</p>{/if}
                {/foreach}
            {/if}
            {if isset($check.hints.queryError)}
                <p>Запрос вернул ошибку: <span class="sql_error">{$check.hints.queryError|escape}</span></p>
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
        <p style="margin-top: 1rem;">
            {if $AnswerResult.nextQuestionId}
                <a class="button blue" href="/{$Lang}/interview/{$SessionId}/question">Следующий вопрос</a>
            {else}
                <a class="button green" href="/{$Lang}/interview/{$SessionId}/result">Завершить и посмотреть результат</a>
            {/if}
        </p>
    </div>
{/if}
