<div class="menu" id="menu">
    <div class="selector">
        <div style="min-width: 9em;">Group by:</div>
        <div class="selector-options">
            <div>
                <input type="radio" id="complexity_menu_groups" name="menu_groups" value="complexity" onClick="loadMenu(this.value)" {if $Questionnire.name == 'complexity'}checked{/if}>
                <label for="complexity_menu_groups">complexity</label>
            </div>
            <div>
                <input type="radio" id="category_menu_groups" name="menu_groups" value="category" onClick="loadMenu(this.value)" {if $Questionnire.name == 'category'}checked{/if}>
                <label for="category_menu_groups">category</label>
            </div>
            <div>
                <input type="radio" id="database_menu_groups" name="menu_groups" value="database" onClick="loadMenu(this.value)" {if $Questionnire.name == 'database'}checked{/if}>
                <label for="database_menu_groups">database</label>
            </div>
        </div>
    </div>
    <div style="height: 5em;">
        <div id="yandex_rtb_R-A-4716552-4">
            <p style="padding: 5px; font-size:12px;">
                Advertising income and donations are our sole funding sources. Please don’t disable ads or <a href="/en/donate" style="color: var(--special-text-color);">consider donating</a>.<br>
                Thank you for your support! 🙏🌟
            </p>
        </div>
    </div>
    {foreach $Questionnire.menu as $categoryId => $panel}
    <button class="accordion {if $categoryId eq $QuestionCategoryID}active{/if}">
        {$panel.title}
        <span class="eye-btn" title="Hide solved problems">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"/>
                <line x1="1" y1="1" x2="23" y2="23"/>
            </svg>
        </span>
        <span class="eye-btn hidden" title="Show all tasks">
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
                <div class="question-title">Help make SQLtest.online even better!</div>
                <div style="font-size:small; padding: 0.5em;">
                    <p>Greetings, SQL lovers!</p>

                    <p>I am writing to you today because I need your help.</p>

                    SQLtest.online is a free platform designed to help people of all levels master SQL.<br>
                    We offer a wide range of interactive tests, problems and training materials to help you improve your SQL skills.<br>
                    The platform has already helped a lot of people, but we want to make it even better. And this is where you can help us!

                    <p>How you can help:
                        <ul>
                            <li>Invite your friends and colleagues to join SQLtest.online!</li>
                            <li>Tell your friends and colleagues about SQLtest.online. Share a link to our site on social networks, by email or in person.</li>
                            <li>Write an article or blog post about SQLtest.online. Share your experience with the platform.</li>
                            <li>Together we can make SQLtest.online the best resource for learning SQL!</li>
                        </ul>
                    </p>
                    <p>
                        The more people use the platform, the better it will become. We'll be able to add more content, improve features, and create a better community for SQL enthusiasts.
                    </p>
                    <p>
                        Thanks for your help!<br>
                        Command <a href='https://sqltest.online/en'>SQLtest.online</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>