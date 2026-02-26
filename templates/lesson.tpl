{include file='header.tpl'}
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/xcode.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js"></script>
<style>
.question-wrapper li {
    line-height: 1.5rem;
    margin: 0.75rem 0;
}
</style>
<body>
    <div class="container">
        {include file='popups.tpl'}
        <header>
        {if $MobileView}
            {include file='m.top-menu.tpl' path="/lesson/{$Lesson->moduleSlug()}/{$Lesson->slug()}"}
        {else}
            {include file='top-menu.tpl' path="/lesson/{$Lesson->moduleSlug()}/{$Lesson->slug()}"}
        {/if}
        </header>
        <main3 id="main3">
            <div class="column">
                <div class="menu" id="menu">
                {if $User->showAd()}
                    <div style="height: 5em;">
                        <div id="yandex_rtb_R-A-4716552-4">
                            {translate}menu_small_add_placeholder{/translate}
                        </div>
                    </div>
                {/if}
                <div class="question-wrapper">
                    <div id="menu-content" class="menu-content">     
                        {foreach $Lessons as $moduleSlug => $module}
                        <button class="accordion {if isset({$Lesson->moduleSlug()}) && $moduleSlug eq {$Lesson->moduleSlug()}}active{/if}">
                            <span class="lessons-list accordion-title" style="background-size: 20px;background-position: left 4px;">{$module.title}</span>
                        </button>
                        <div class="panel {if isset({$Lesson->moduleSlug()}) && $moduleSlug eq {$Lesson->moduleSlug()}}active{/if}">
                            <ol>
                            {foreach $module.lessons as $lesson}
                            <li>
                                <a class="question-link {if $Lesson->slug() == $lesson.slug} current-question{/if}" href="/{$Lang}/lesson/{$moduleSlug}/{$lesson.slug}">
                                    <span class="question-number">{$lesson.number}.&nbsp;</span>
                                    {$lesson.title}
                                </a>
                            </li>
                            {/foreach}
                            </ol>
                        </div>
                        {/foreach}
                    </div>
                </div>
                {if $User->showAd()}
                    {* {include file="{$Lang}/menu_bottom_add.tpl"} *}
                {/if}
            </div>
            </div>
            <div class="column">
                <div class="lesson-wrapper">
                    {$LessonData.content}
                </div>
                <div class="code-buttons" style="justify-content: space-between !important;">
                    <div id="prevTaskBtn">
                        <a class="button" href="/{$Lang}/lesson/{$NextLesson.moduleSlug}/{$NextLesson.slug}}" title="{translate}next_lesson{/translate}">
                            <i class="run-icon" style="transform: scaleX(-1);"></i>
                            <span>{translate}previous_lesson{/translate}</span>
                        </a>
                    </div>
                    <div id="nextTaskBtn">
                        <a class="button blue" href="/{$Lang}/" title="{translate}continue_practice{/translate}">
                            <span>{translate}continue_practice{/translate}</span>
                            <i class="run-icon" style="transform: rotate(90deg);"></i>
                        </a>
                    </div>
                    <div id="nextTaskBtn">
                        <a class="button green" href="/{$Lang}/lesson/{$NextLesson.moduleSlug}/{$NextLesson.slug}}" title="{translate}next_lesson{/translate}">
                            <span>{translate}next_lesson{/translate}</span>
                            <i class="run-icon"></i>
                        </a>
                    </div>
                </div>
            </div>
            <div class="column" id="right-panel">
                {if $User->showAd()}
                    <div class="referal-add-block">
                    {if $Lang == 'ru'}
                        <div class="referal-add-block">
                            <div id="yandex_rtb_R-A-4716552-7"></div>
                        </div>
                    {else}
                        <script async="async" data-cfasync="false" src="//pl26881648.profitableratecpm.com/93660caf229b7b6afe772e0ab435c7a9/invoke.js"></script>
                        <div id="container-93660caf229b7b6afe772e0ab435c7a9"></div>
                    {/if}
                    </div>
                {/if} 
            </div>
        </main3>
        <footer>
            {include file='footer.tpl'}
        </footer>
        </div>
        {include file='counters.tpl'}
        <script>hljs.highlightAll();</script>
    </body>
</html>