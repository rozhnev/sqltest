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
            <h2>Проверьте свои знания SQL!</h2>
        </div>
    </div>
    <div class="section not-colored">
        <div>
            <p>Наш тест состоит из 12 заданий разных уровней сложности, выбранных из базы заданий сайта случайным образом. Сложность заданий устанавливается по результатам голосования пользователей сайта.</p>
            Структура теста:
            <ul class="difficulty-list">
                <li class="difficulty-item">4 задачи уровня "Просто"</li>
                <li class="difficulty-item">3 задачи уровня "Легко"</li>
                <li class="difficulty-item">2 задачи уровня "Средне"</li>
                <li class="difficulty-item">2 задачи уровня "Сложно"</li>
                <li class="difficulty-item">1 задача уровня "Трудно"</li>
            </ul>
        </div>
    </div>
    <div class="section colored">
        <div>
            <h2>Время и ранги</h2>
            Для выполнения теста отводится три часа времени. По окончании времени (или раньше) вы сможете получить один из рангов в SQL:
            <table class="rank-table">
                <tr>
                    <th>Ранг</th>
                    <th>Требования</th>
                </tr>
                <tr>
                    <td>Интерн</td>
                    <td>Решить минимум 6 заданий (любой сложности)</td>
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
        </div>
    </div>
    <div class="section not-colored">
        <div>
            <h3>Бонусы и штрафы</h3>
            Успешное решение задания с первой попытки приносит дополнительные баллы, а большое количество попыток на одно задание может привести к снижению оценки.
            <div class="note-section">
                <strong>Примечание:</strong> Система оценки может быть скорректирована в зависимости от результатов тестирования и обратной связи от участников.
            </div>
        </div>
    </div>
    <div class="section bottom colored">
        {if $User->logged()}
            {if isset($LastTest)}
                {if $LastTest.closed}
                    {if $LastTest.rate eq 1}
                        <h2>Отличное начало! По результатам теста ваш уровень — Intern.</h2>Это говорит о вашем потенциале. Хотите развиваться дальше и перейти на новый уровень?
                    {elseif $LastTest.rate eq 2}
                        <h2>Вы на правильном пути! Ваш текущий уровень — Junior.</h2>
                        <h4>Это замечательный результат. Готовы ли вы расширить свои знания и навыки?</h4>
                    {elseif $LastTest.rate eq 3}
                        <h2>Вы достигли уровня Middle!</h2>
                        <h4>Это замечательно! Но ведь всегда есть к чему стремиться, верно? Готовы бросить вызов себе и улучшить свои результаты?</h4>
                    {elseif $LastTest.rate eq 4}
                        <h2>Поздравляем! Ваш уровень - Senior!</h2>
                        <h4>Готовы подтвердить свой статус?</h4>
                    {else}
                        <h2>Время вашего последнего теста вышло.</h2>
                        <h4>Готовы попробовать еще раз?</h4>
                    {/if}
                    <div style="text-align: center;">
                        <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/create" title="Начать тест" class="button green">Начать тест</a>
                    </div>
                {else}
                    {* Продолжить открытый тест *}
                    <div style="text-align: center; margin: 36px;">
                        <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/{$LastTest.id}" title="Начать тест" class="button green">Продолжить тест</a>
                    </div>
                {/if}
            {else}
                <h2>Желаем удачи!</h2>
                <div style="text-align: center; margin: 36px;">
                    <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/create" title="Начать тест" class="button green">Начать тест</a>
                </div>
            {/if}
        {else}
            <h2><span class='warning'>
                Тестирование доступно только для пользователей сайта. Войдите в свой аккаунт, чтобы продолжить.
            </span></h2>
            <div style="text-align: center; margin: 36px;">
                <button class="button green" onClick="toggleLoginWindow()">Войти</button>
            </div>
        {/if}
    </div>
</div>