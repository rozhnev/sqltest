<div class="test-info-container">
    <style>
        .test-info-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 1rem;
        }
        
        .test-section {
            background: var(--background-color);
            border-radius: 8px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .difficulty-list {
            list-style: none;
            padding: 0;
            margin: 1.5rem 0;
        }
        
        .difficulty-item {
            display: flex;
            align-items: center;
            margin: 0.5rem 0;
            padding: 0.5rem;
            border-radius: 4px;
            background: var(--background-color-secondary);
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
        
        .rank-table th {
            background: var(--background-color-secondary);
        }
        
        .note-section {
            background: var(--background-color-secondary);
            padding: 1rem;
            border-radius: 8px;
            margin-top: 2rem;
            font-style: italic;
        }
    </style>

    <div class="test-section">
        <h1>Проверьте свои знания SQL!</h1>
        
        <p>Наш тест состоит из 13 заданий разных уровней сложности, выбранных из базы заданий сайта случайным образом. Сложность заданий устанавливается по результатам голосования пользователей сайта.</p>
        
        <h2>Структура теста:</h2>
        <ul class="difficulty-list">
            <li class="difficulty-item">4 задачи уровня "Просто"</li>
            <li class="difficulty-item">3 задачи уровня "Легко"</li>
            <li class="difficulty-item">2 задачи уровня "Средне"</li>
            <li class="difficulty-item">2 задачи уровня "Сложно"</li>
            <li class="difficulty-item">1 задача уровня "Трудно"</li>
        </ul>

        <h2>Время и ранги</h2>
        <p>Для выполнения теста отводится три часа времени. По окончании времени (или раньше) вы сможете получить один из рангов в SQL:</p>
        
        <table class="rank-table">
            <tr>
                <th>Ранг</th>
                <th>Требования</th>
            </tr>
            <tr>
                <td>Интерн</td>
                <td>Решить минимум 5 заданий (любой сложности)</td>
            </tr>
            <tr>
                <td>Джуниор</td>
                <td>Решить все лёгкие и простые задачи</td>
            </tr>
            <tr>
                <td>Миддл</td>
                <td>Решить все лёгкие и простые задачи + 2/3 остальных задач</td>
            </tr>
            <tr>
                <td>Синьор</td>
                <td>Решить все задачи</td>
            </tr>
        </table>

        <h2>Бонусы и штрафы</h2>
        <p>Успешное решение задания с первой попытки приносит дополнительные баллы, а большое количество попыток на одно задание может привести к снижению оценки.</p>

        <div class="note-section">
            <strong>Примечание:</strong> Система оценки может быть скорректирована в зависимости от результатов тестирования и обратной связи от участников.
        </div>
    </div>
</div>
{if $Logged}
    {if isset($LastTest)}
        {if $LastTest.closed}
            {if $LastTest.rate > 0}
                После последнего теста ваша оценка {$LastTest.rate}! Хотите улучшить решетку?
            {else}
                Ваш последний тест истек. Хотите получить новый шанс?
            {/if}
            <div style="text-align: center; margin: 36px;">
                <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/create" title="Начать тест" class="button green">Начать тест</a>
            </div>
        {else}
            {* Продолжить открытый тест *}
            <div style="text-align: center; margin: 36px;">
                <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/{$LastTest.id}" title="Начать тест" class="button green">Продолжить тест</a>
            </div>
        {/if}
    {else}
        <div style="text-align: center; margin: 36px;">
            <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/create" title="Начать тест" class="button green">Начать тест</a>
        </div>
    {/if}
{else}
    <p class='warning'>
        Эта страница недоступна для незарегистрированных пользователей. Пожалуйста, войдите, чтобы продолжить.
    </p>
    <div style="text-align: center; margin: 36px;">
        <button class="button green" onClick="toggleLoginWindow()">Войти</button>
    </div>
{/if}