<div class="menu" id="menu">
    <div class="selector">
        <div style="white-space: nowrap; padding-left: 0.7em;">{translate}menu_groups{/translate}:</div>
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
    <div id="menu-content" class="menu-content">
        {foreach $Questionnire.menu as $categoryId => $panel}
        <button class="accordion {if isset($QuestionCategoryID) && $categoryId eq $QuestionCategoryID}active{/if}">
            <span class="accordion-title">{$panel.title}</span>
                <span class="accordion-icons">
                    <span class="eye-btn" title="{translate}hide_hide_solved_tasks{/translate}">
                        <svg width="24" height="24" viewBox="0 0 44 44" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M11.5 8.5H29C30.1046 8.5 31 9.39543 31 10.5V34M11.5 8.5H5.5C4.39543 8.5 3.5 9.39543 3.5 10.5V38.5C3.5 39.6046 4.39543 40.5 5.5 40.5H29C30.1046 40.5 31 39.6046 31 38.5V34M11.5 8.5V4.5C11.5 3.39543 12.3954 2.5 13.5 2.5H35.5C36.6046 2.5 37.5 3.39543 37.5 4.5V32C37.5 33.1046 36.6046 34 35.5 34H34.25M31 34H34.25M34.25 34L43 43L26.5 26.5M1 1L14.5 14.5M14.5 14.5H10C9.44772 14.5 9 14.9477 9 15.5V18C9 18.5523 9.44772 19 10 19H13.5C14.0523 19 14.5 18.5523 14.5 18V14.5ZM14.5 14.5L18.5 18.5M18 14.5H26.5M26.5 18.5H18.5M18.5 18.5L26.5 26.5M26.5 22.5H9M26.5 26.5H9M9 30H26.5M9 34H26.5" stroke="white" stroke-width="2"/>
                        </svg>
                    </span>
                    <span class="eye-btn hidden" title="{translate}show_all_tasks{/translate}">
                        <svg width="24" height="24" viewBox="0 0 37 41" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M9.5 7.5H27C28.1046 7.5 29 8.39543 29 9.5V33M9.5 7.5H3.5C2.39543 7.5 1.5 8.39543 1.5 9.5V37.5C1.5 38.6046 2.39543 39.5 3.5 39.5H27C28.1046 39.5 29 38.6046 29 37.5V33M9.5 7.5V3.5C9.5 2.39543 10.3954 1.5 11.5 1.5H33.5C34.6046 1.5 35.5 2.39543 35.5 3.5V31C35.5 32.1046 34.6046 33 33.5 33H32.25H29M16 13.5H24.5M24.5 21.5H7M7 29H24.5M7 33H24.5M24.5 18H16M7 25L24.5 25.2298M11.5 13.5H8C7.44772 13.5 7 13.9477 7 14.5V17C7 17.5523 7.44772 18 8 18H11.5C12.0523 18 12.5 17.5523 12.5 17V14.5C12.5 13.9477 12.0523 13.5 11.5 13.5Z" stroke="white" stroke-width="2"/>
                        </svg>
                    </span>
                </span>
        </button>
        <div class="panel {if isset($QuestionCategoryID) && $categoryId eq $QuestionCategoryID}active{/if}">
            <ol>
            {foreach $panel.questions as $question}
            <li>
                <a class="question-link {if $QuestionID == $question[1]} current-question{/if}{if $question[2]} solved{/if}" href="/{$Lang}/question/{$panel.sef}/{$question[3]}">
                    <span class="question-number">{$question[5]}.&nbsp;</span>
                    {$question[0]}
                    {if $question[4]}
                        <span class="question-star favored" title="{translate}favorite{/translate}">★</span>
                    {/if}
                </a>
            </li>
            {/foreach}
            </ol>
        </div>
        {/foreach}
    </div>
</div>