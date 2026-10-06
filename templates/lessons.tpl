{* Lessons index /{lang}/lesson (Controller::lessonsIndex()): every chapter and lesson, rendered for search engines,
   with a search box that filters them on the page. The heading and intro are in {$Lang}/lessons.tpl ($LessonsText). *}
{include file='header.tpl'}
<body>
    <style>
        .lessons-index {
            box-sizing: border-box;
            /* vw, not %: <main> grows to its content's width on mobile */
            width: min(960px, 100vw);
            margin: 0 auto;
            padding: 1.5rem 16px 3rem;
            color: var(--question-text);
            line-height: 1.55;
        }
        .lessons-index h1 {
            margin: 0 0 0.75rem;
            font-size: clamp(1.6rem, 4vw, 2.2rem);
            line-height: 1.25;
        }
        .lessons-index a {
            color: var(--info-text-color);
        }
        .lessons-lead {
            max-width: 46rem;
            font-size: 1.05rem;
        }
        .lessons-search {
            position: sticky;
            top: 0;
            z-index: 2;
            margin: 1.25rem 0 1rem;
            padding: 0.5rem 0;
            background: var(--body-background-color);
        }
        .lessons-search input {
            box-sizing: border-box;
            width: 100%;
            padding: 0.7rem 1rem;
            border: 1px solid var(--text-block-border-color);
            border-radius: 10px;
            background: var(--text-block-background-color);
            color: var(--question-text);
            font: inherit;
        }
        .lessons-search input:focus-visible {
            outline: 2px solid var(--info-text-color);
            outline-offset: 1px;
        }
        .lessons-empty {
            margin: 1rem 0;
            font-style: italic;
        }
        .lessons-chapter {
            margin: 0 0 1.25rem;
            padding: 1rem 1.25rem;
            border: 1px solid var(--text-block-border-color);
            border-radius: 12px;
        }
        .lessons-chapter h2 {
            display: flex;
            align-items: center;
            gap: 0.6rem;
            margin: 0 0 0.5rem;
            font-size: 1.25rem;
        }
        .lessons-chapter-number {
            flex: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 1.9rem;
            height: 1.9rem;
            border-radius: 50%;
            background: var(--block-background-color);
            color: #fff;
            font-size: 0.95rem;
        }
        .lessons-index-list {
            margin: 0;
            padding: 0;
            list-style: none;
        }
        .lessons-index-list li {
            display: grid;
            grid-template-columns: 2.6rem 1fr auto;
            gap: 0 0.5rem;
            padding: 0.6rem 0;
            border-top: 1px solid var(--text-block-border-color);
        }
        .lessons-index-list li:first-child {
            border-top: 0;
        }
        .lessons-number,
        .lessons-minutes {
            font-variant-numeric: tabular-nums;
            opacity: 0.7;
        }
        .lessons-minutes {
            white-space: nowrap;
            font-size: 0.9rem;
        }
        .lessons-title {
            font-weight: 600;
        }
        .lessons-description {
            grid-column: 2 / 4;
            margin: 0.2rem 0 0;
            font-size: 0.92rem;
            opacity: 0.85;
        }
        .lessons-chapter[hidden],
        .lessons-index-list li[hidden] {
            display: none;
        }
        @media (max-width: 520px) {
            .lessons-chapter {
                padding: 0.75rem 0.9rem;
            }
            .lessons-index-list li {
                grid-template-columns: 2.4rem 1fr;
            }
            .lessons-minutes {
                grid-column: 2;
            }
            .lessons-description {
                grid-column: 2;
            }
        }
    </style>
    {include file='popups.tpl'}
    {capture name=lessons_index}
        <article class="lessons-index">
            {include file=$LessonsText}

            <div class="lessons-search" role="search">
                <input type="search" id="lessons-search" autocomplete="off"
                    placeholder="{translate}lessons_search_placeholder{/translate}" aria-label="{translate}lessons_search_placeholder{/translate}">
            </div>
            <p class="lessons-empty" id="lessons-empty" hidden>{translate}lessons_search_nothing{/translate}</p>

            {foreach $Chapters as $chapter}
                <section class="lessons-chapter" id="{$chapter.slug}">
                    <h2><span class="lessons-chapter-number">{$chapter.number}</span> <span class="lessons-chapter-title">{$chapter.title|escape}</span></h2>
                    <ol class="lessons-index-list">
                        {foreach $chapter.lessons as $lesson}
                            <li>
                                <span class="lessons-number">{$chapter.number}.{$lesson.number}</span>
                                <a class="lessons-title" href="/{$Lang}/lesson/{$chapter.slug}/{$lesson.slug}">{$lesson.title|escape}</a>
                                <span class="lessons-minutes">{$lesson.reading_minutes} {translate}lessons_minutes_short{/translate}</span>
                                {if $lesson.description}<p class="lessons-description">{$lesson.description|escape}</p>{/if}
                            </li>
                        {/foreach}
                    </ol>
                </section>
            {/foreach}
        </article>
    {/capture}
    {* Like about.tpl: .container is the desktop grid, mobile pages go without it *}
    {if $MobileView}
        <header>
            {include file='m.top-menu.tpl' path="/lesson"}
        </header>
        <main>{$smarty.capture.lessons_index}</main>
        <footer>
            {include file='m.footer.tpl'}
        </footer>
    {else}
        <div class="container">
            <header>
                {include file='top-menu.tpl' path="/lesson"}
            </header>
            <main>{$smarty.capture.lessons_index}</main>
            <footer>
                {include file='footer.tpl'}
            </footer>
        </div>
    {/if}
    <script>{literal}
        // Search: every word of the query must be in the lesson (title, description) or its chapter title.
        // Case, accents and ё/е don't matter. The query is kept in ?q= so a search can be shared.
        (function () {
            const input = document.getElementById('lessons-search');
            if (!input) {
                return;
            }
            const normalize = (text) => text.toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '').replace(/ё/g, 'е');
            const chapters = Array.from(document.querySelectorAll('.lessons-chapter')).map((section) => ({
                section,
                title: normalize(section.querySelector('.lessons-chapter-title').textContent),
                lessons: Array.from(section.querySelectorAll('.lessons-index-list li')).map((item) => ({
                    item,
                    text: normalize(item.textContent),
                })),
            }));
            const empty = document.getElementById('lessons-empty');

            function filter() {
                const words = normalize(input.value).split(/\s+/).filter(Boolean);
                let found = 0;
                chapters.forEach((chapter) => {
                    let visible = 0;
                    chapter.lessons.forEach((lesson) => {
                        const match = words.every((word) => lesson.text.includes(word) || chapter.title.includes(word));
                        lesson.item.hidden = !match;
                        visible += match ? 1 : 0;
                    });
                    chapter.section.hidden = visible === 0;
                    found += visible;
                });
                empty.hidden = found > 0;
                const url = new URL(window.location.href);
                if (input.value.trim()) {
                    url.searchParams.set('q', input.value.trim());
                } else {
                    url.searchParams.delete('q');
                }
                history.replaceState(null, '', url);
            }

            input.addEventListener('input', filter);
            input.addEventListener('keydown', (event) => {
                if (event.key === 'Escape') {
                    input.value = '';
                    filter();
                }
            });
            // "/" focuses the search, as on many documentation sites
            document.addEventListener('keydown', (event) => {
                if (event.key === '/' && document.activeElement !== input && !/^(INPUT|TEXTAREA|SELECT)$/.test(document.activeElement.tagName)) {
                    event.preventDefault();
                    input.focus();
                }
            });
            const query = new URLSearchParams(window.location.search).get('q');
            if (query) {
                input.value = query;
                filter();
            }
        })();
    {/literal}</script>
</body>
</html>
