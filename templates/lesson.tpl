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
                        <span class="accordion-title">{$module.title}</span>
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
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" transform="scale(-1, 1)" transform-origin="center">
                                <path fill-rule="evenodd" clip-rule="evenodd" d="M19.266 10.4837C20.2579 11.2512 20.2579 12.7486 19.266 13.5161C16.2685 15.8355 12.9213 17.6637 9.34979 18.9321L8.69732 19.1639C7.44904 19.6072 6.13053 18.7627 5.96154 17.4741C5.48938 13.8739 5.48938 10.1259 5.96154 6.52574C6.13053 5.23719 7.44905 4.39263 8.69732 4.83597L9.34979 5.06771C12.9213 6.33619 16.2685 8.16434 19.266 10.4837ZM18.3481 12.3298C18.5639 12.1628 18.5639 11.837 18.3481 11.67C15.4763 9.44796 12.2695 7.69648 8.84777 6.4812L8.1953 6.24947C7.87035 6.13406 7.49691 6.35401 7.44881 6.72079C6.99363 10.1915 6.99363 13.8083 7.44881 17.2791C7.49691 17.6458 7.87035 17.8658 8.19529 17.7504L8.84777 17.5187C12.2695 16.3034 15.4763 14.5519 18.3481 12.3298Z" fill="white"/>
                            </svg>
                            <span>{translate}previous_lesson{/translate}</span>
                        </a>
                    </div>
                    <div id="nextTaskBtn">
                        <a class="button blue" href="/{$Lang}/" title="{translate}continue_practice{/translate}">
                            <span>{translate}continue_practice{/translate}</span>
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" transform="rotate(90)" transform-origin="center">
                                <path fill-rule="evenodd" clip-rule="evenodd" d="M19.266 10.4837C20.2579 11.2512 20.2579 12.7486 19.266 13.5161C16.2685 15.8355 12.9213 17.6637 9.34979 18.9321L8.69732 19.1639C7.44904 19.6072 6.13053 18.7627 5.96154 17.4741C5.48938 13.8739 5.48938 10.1259 5.96154 6.52574C6.13053 5.23719 7.44905 4.39263 8.69732 4.83597L9.34979 5.06771C12.9213 6.33619 16.2685 8.16434 19.266 10.4837ZM18.3481 12.3298C18.5639 12.1628 18.5639 11.837 18.3481 11.67C15.4763 9.44796 12.2695 7.69648 8.84777 6.4812L8.1953 6.24947C7.87035 6.13406 7.49691 6.35401 7.44881 6.72079C6.99363 10.1915 6.99363 13.8083 7.44881 17.2791C7.49691 17.6458 7.87035 17.8658 8.19529 17.7504L8.84777 17.5187C12.2695 16.3034 15.4763 14.5519 18.3481 12.3298Z" fill="white"/>
                            </svg>
                        </a>
                    </div>
                    <div id="nextTaskBtn">
                        <a class="button green" href="/{$Lang}/lesson/{$NextLesson.moduleSlug}/{$NextLesson.slug}}" title="{translate}next_lesson{/translate}">
                            <span>{translate}next_lesson{/translate}</span>
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd" clip-rule="evenodd" d="M19.266 10.4837C20.2579 11.2512 20.2579 12.7486 19.266 13.5161C16.2685 15.8355 12.9213 17.6637 9.34979 18.9321L8.69732 19.1639C7.44904 19.6072 6.13053 18.7627 5.96154 17.4741C5.48938 13.8739 5.48938 10.1259 5.96154 6.52574C6.13053 5.23719 7.44905 4.39263 8.69732 4.83597L9.34979 5.06771C12.9213 6.33619 16.2685 8.16434 19.266 10.4837ZM18.3481 12.3298C18.5639 12.1628 18.5639 11.837 18.3481 11.67C15.4763 9.44796 12.2695 7.69648 8.84777 6.4812L8.1953 6.24947C7.87035 6.13406 7.49691 6.35401 7.44881 6.72079C6.99363 10.1915 6.99363 13.8083 7.44881 17.2791C7.49691 17.6458 7.87035 17.8658 8.19529 17.7504L8.84777 17.5187C12.2695 16.3034 15.4763 14.5519 18.3481 12.3298Z" fill="white"/>
                            </svg>
                        </a>
                    </div>
                </div>
            </div>
            <div class="column" id="right-panel">
                {if $User->showAd()}
                    {if $Lang == 'ru'}
                        <div class="referal-add-block" style="height: 100%;">
                            <div id="yandex_rtb_R-A-4716552-7"></div>
                        </div>
                    {else}
                        <div class="referal-add-block">
                            <script async="async" data-cfasync="false" src="//pl26881648.profitableratecpm.com/93660caf229b7b6afe772e0ab435c7a9/invoke.js"></script>
                            <div id="container-93660caf229b7b6afe772e0ab435c7a9"></div>
                        </div>
                    {/if}
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