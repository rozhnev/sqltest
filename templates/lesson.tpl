{include file='header.tpl'}
<link rel="stylesheet" href="/css/lesson.min.css?{$VERSION}" media="all">
{* <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/styles/xcode.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/highlight.min.js"></script> *}
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
            <nav class="column" aria-label="Lesson navigation">
                <div class="menu" id="menu">
                {if $User->showAd()}
                    <div style="height: 5em;">
                        {translate}menu_small_add_placeholder{/translate}
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
            </div>
            </nav>
            <main class="column" id="main-content">
                <article class="lesson-wrapper">
                    {$LessonData.content}
                </article>
                {if $RelevantTasks}
                <section class="lesson-relevant-tasks question-wrapper" aria-label="Relevant lesson tasks">
                    <h3 class="lesson-relevant-tasks-title">{translate}lesson_relevant_tasks{/translate}</h3>
                    <ol class="lesson-relevant-tasks-list">
                        {foreach $RelevantTasks as $task}
                        <li>
                            <a class="question-link {if $task.solved}solved{/if}" href="/{$Lang}/question/{$task.category_sef}/{$task.question_sef}">
                                {$task.title}
                            </a>
                        </li>
                        {/foreach}
                    </ol>
                </section>
                {/if}
                <div class="code-buttons" style="justify-content: space-between !important;">
                    <div>
                        {if $LessonData.prev_lesson_slug}
                        <a class="button" href="/{$Lang}/lesson/{$LessonData.prev_module_slug}/{$LessonData.prev_lesson_slug}" title="{translate}previous_lesson{/translate}">
                            <i class="run-icon" style="transform: scaleX(-1);"></i>
                            <span>{translate}previous_lesson{/translate}</span>
                        </a>
                        {/if}
                    </div>
                    <div>
                        <a class="button blue" href="/{$Lang}/" title="{translate}continue_practice{/translate}">
                            <span>{translate}continue_practice{/translate}</span>
                            <i class="run-icon" style="transform: rotate(90deg);"></i>
                        </a>
                    </div>
                    <div>
                        {if $LessonData.next_lesson_slug}
                        <a class="button green" href="/{$Lang}/lesson/{$LessonData.next_module_slug}/{$LessonData.next_lesson_slug}" title="{translate}next_lesson{/translate}">
                            <span>{translate}next_lesson{/translate}</span>
                            <i class="run-icon"></i>
                        </a>
                        {/if}
                    </div>
                </div>
            </main>
            <aside class="column db-description" id="right-panel" aria-label="Additional lesson information">            
                {if $User->showAd()}
                    {include file="{$Lang}/donation_goal_widget.tpl"}
                {/if} 
            </aside>
        </main3>
        <footer>
            {include file='footer.tpl'}
        </footer>
        </div>
        {include file='counters.tpl'}
        <script src="/js/sql-highlighter.min.js?{$VERSION}"></script>
        <script>
            SQLHighlighter.extend({
                functions: ['AGGREGATION_FUNCTION'],
            });
            SQLHighlighter.highlightCodeBlocks();
        </script>
    </body>
</html>