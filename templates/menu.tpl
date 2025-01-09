<div class="menu" id="menu">
    <div class="selector">
        <div style="white-space: nowrap;">{translate}menu_groups{/translate}</div>
        <div class="selector-options">
            <div>
                <input type="radio" id="complexity_menu_groups" name="menu_groups" value="complexity" onClick="loadMenu(this.value)" {if $Questionnire.name == 'complexity'}checked{/if}>
                <label for="complexity_menu_groups">{translate}complexity{/translate}</label>
            </div>
            <div>
                <input type="radio" id="category_menu_groups" name="menu_groups" value="category" onClick="loadMenu(this.value)" {if $Questionnire.name == 'category'}checked{/if}>
                <label for="category_menu_groups">{translate}category{/translate}</label>
            </div>
            <div>
                <input type="radio" id="database_menu_groups" name="menu_groups" value="database" onClick="loadMenu(this.value)" {if $Questionnire.name == 'database'}checked{/if}>
                <label for="database_menu_groups">{translate}database{/translate}</label>
            </div>
        </div>
    </div>
    {if $User.show_ad}
        <div style="height: 5em;">
            <div id="yandex_rtb_R-A-4716552-4">
                <p style="padding: 5px; font-size:12px;">{translate}menu_small_add_placeholder{/translate}</p>
            </div>
        </div>
    {/if}
    {foreach $Questionnire.menu as $categoryId => $panel}
    <button class="accordion {if $categoryId eq $QuestionCategoryID}active{/if}">
        <span class="accordion-title">{$panel.title}</span>
        <span class="accordion-icons">
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
    {if $User.show_ad}
        {include file="{$Lang}/menu_bottom_add.tpl"}
    {/if}
</div>