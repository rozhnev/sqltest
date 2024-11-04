<div>
<h2>Ваши навыки и демонстрация вашего опыта с SQLTest.online!</h2>
<p>
    Помимо просто практики SQL-запросов, sqltest.online дает вам возможность оценить и продемонстрировать свой профессиональный уровень. Наша интерактивная платформа включает в себя уникальный инструмент самооценки, который позволяет вам оценить свои навыки в различных областях SQL.
</p><p>
    Этот инструмент самооценки выходит за рамки простого формата «да/нет». Вы углубитесь в определенные области, такие как обработка данных, методы запросов, соединение таблиц и многое другое. Для каждой области вы можете выбрать начальный, средний или продвинутый уровень, что позволяет провести тонкую оценку ваших сильных сторон и областей для развития.
</p><p>
    Завершение самооценки создает персонализированный отчет, описывающий распределение ваших навыков в различных областях SQL. Этот отчет становится ценным активом для вашего профессионального профиля, демонстрируя ваши навыки потенциальным работодателям или коллегам. Кроме того, полученные знания могут направлять ваш учебный процесс и помочь вам сосредоточиться на областях, требующих дальнейшего внимания.
</p>
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