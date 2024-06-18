<div class="menu" id="menu">
    <div class="selector">
        <div style="min-width: 8em;">Вопросы по:</div>
        <div class="selector-options">
            <div>
                <input type="radio" id="complexity_menu_groups" name="menu_groups" value="complexity" onClick="loadMenu(this.value)" {if $Questionnire.name == 'complexity'}checked{/if}>
                <label for="complexity_menu_groups">сложности</label>
            </div>
            <div>
                <input type="radio" id="category_menu_groups" name="menu_groups" value="category" onClick="loadMenu(this.value)" {if $Questionnire.name == 'category'}checked{/if}>
                <label for="category_menu_groups">категории</label>
            </div>
            <div>
                <input type="radio" id="database_menu_groups" name="menu_groups" value="database" onClick="loadMenu(this.value)" {if $Questionnire.name == 'database'}checked{/if}>
                <label for="database_menu_groups">базе данных</label>
            </div>
        </div>
    </div>
    <div style="height: 6em;">
        <div id="yandex_rtb_R-A-4716552-4">
        <p style="padding: 5px; font-size:12px;">
            Доходы от рекламы и пожертвования являются нашими единственными источниками финансирования. Пожалуйста, не отключайте рекламу или внесите <a href="/ru/donate" style="color: var(--special-text-color);">посильное пожертвование</a>.<br>
            Спасибо за Вашу поддержку! 🙏🌟
        </p>
        </div>
    </div>
    {foreach $Questionnire.menu as $categoryId => $panel}
    <button class="accordion {if $categoryId eq $QuestionCategoryID}active{/if}">
        {$panel.title}
        <span class="eye-btn" title="Скрыть решённые задания">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"/>
                <line x1="1" y1="1" x2="23" y2="23"/>
            </svg>
        </span>
        <span class="eye-btn hidden" title="Показать все задания">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                <circle cx="12" cy="12" r="3"/>
            </svg>
        </span>
    </button>
    <div class="panel {if $categoryId eq $QuestionCategoryID}active{/if}">
        <ol>
        {foreach $panel.questions as $question}
        <li>
            <a class="question-link {if $QuestionID == $question[1]} current-question{/if}{if $question[2]} solved{/if}" href="/{$Lang}/question/{$panel.sef}/{$question[3]}">
                {$question[0]}
            </a>
        </li>
        {/foreach}
        </ol>
    </div>
    {/foreach}
    <div class="menu-ad">
        <div id="yandex_rtb_R-A-4716552-2">
        <div class="question-wrapper">
            <div class="question-title">Помогите сделать SQLtest.online еще лучше!</div>
            <div style="font-size:small; padding: 0.5em;">
                <p>Приветствую, любители SQL!</p>

                <p>Я пишу вам сегодня, потому что мне нужна ваша помощь.</p>

                SQLtest.online – это бесплатная платформа, созданная для того, чтобы помочь людям всех уровней освоить SQL.<br>
                Мы предлагаем широкий спектр интерактивных тестов, задач и обучающих материалов, которые помогут вам улучшить свои навыки SQL.<br>
                Платформа уже помогла множеству людей, но мы хотим сделать ее еще лучше. И именно здесь вы можете нам помочь!

                <p>Как вы можете помочь:
                    <ul>
                    <li>Пригласите своих друзей и коллег присоединиться к SQLtest.online!</li>
                    <li>Расскажите о SQLtest.online своим друзьям и коллегам. Поделитесь ссылкой на наш сайт в социальных сетях, по электронной почте или лично.</li>
                    <li>Напишите статью или пост в блоге о SQLtest.online. Поделитесь своим опытом работы с платформой.</li>
                    <li>Вместе мы можем сделать SQLtest.online лучшим ресурсом для изучения SQL!</li>
                    </ul>
                </p>
                <p>
                Чем больше людей будет пользоваться платформой, тем лучше она станет. Мы сможем добавить больше контента, улучшить функции и создать лучшее сообщество для любителей SQL.
                </p>
                <p>
                Спасибо за вашу помощь!<br>
                Команда <a href='https://sqltest.online/ru'>SQLtest.online</a>
                </p>
            </div>
        </div>
        </div>
    </div>
</div>