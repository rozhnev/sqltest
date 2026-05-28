{include file='header.tpl'}
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/styles/xcode.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/highlight.min.js"></script>
<style>
.question-wrapper li {
    line-height: 1.5rem;
    margin: 0.75rem 0;
}

.lesson-wrapper {
    overflow-x: auto;
}
</style>
<body>
    <div class="mobile-container">
        {include file='popups.tpl'}
        <header>
            {include file='m.top-menu.tpl' path="/lesson/{$Lesson->moduleSlug()}/{$Lesson->slug()}"}
        </header>

        <main class="main" style="padding: 6px;" id="main-content">
            <nav class="question-wrapper" aria-label="Lesson navigation">
                <div class="menu">
                <div id="menu-content" class="menu-content">
                    {foreach $Lessons as $moduleSlug => $module}
                    <button class="accordion {if isset({$Lesson->moduleSlug()}) && $moduleSlug eq {$Lesson->moduleSlug()}}active{/if}">
                        <span class="lessons-list accordion-title" style="background-size: 20px; background-position: left 4px;">{$module.title}</span>
                    </button>
                    <div class="panel {if isset({$Lesson->moduleSlug()}) && $moduleSlug eq {$Lesson->moduleSlug()}}active{/if}">
                        <ol>
                        {foreach $module.lessons as $lesson}
                            <li>
                                <a class="question-link {if $Lesson->slug() == $lesson.slug} current-question{/if}" href="/{$Lang}/lesson/{$moduleSlug}/{$lesson.slug}#lesson-wrapper">
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
            </nav>
            <article class="lesson-wrapper" id="lesson-wrapper">
                {$LessonData.content}
            </article>
            <div class="question-wrapper">
                <div class="code-buttons" style="justify-content: space-between !important; gap: 8px; flex-wrap: wrap;">
                    <div id="prevTaskBtn">
                        {if $LessonData.prev_lesson_slug}
                        <a class="button" href="/{$Lang}/lesson/{$LessonData.prev_module_slug}/{$LessonData.prev_lesson_slug}#lesson-wrapper" title="{translate}previous_lesson{/translate}">
                            <i class="run-icon" style="transform: scaleX(-1);"></i>
                        </a>
                        {/if}
                    </div>
                    <div id="practiceBtn">
                        <a class="button blue" href="/{$Lang}/" title="{translate}continue_practice{/translate}">
                            <span>{translate}continue_practice{/translate}</span>
                            <i class="run-icon" style="transform: rotate(90deg);"></i>
                        </a>
                    </div>
                    <div id="nextTaskBtn">
                        {if $LessonData.next_lesson_slug}
                        <a class="button green" href="/{$Lang}/lesson/{$LessonData.next_module_slug}/{$LessonData.next_lesson_slug}#lesson-wrapper" title="{translate}next_lesson{/translate}">
                            <i class="run-icon"></i>
                        </a>
                        {/if}
                    </div>
                </div>
            </div>
        </main>

        <footer>
            {include file='m.footer.tpl'}
        </footer>
    </div>
    {include file='counters.tpl'}
    <script>hljs.highlightAll();</script>
</body>
</html>
