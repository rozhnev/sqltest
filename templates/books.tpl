{assign var="PageTitle" value="{translate}books_page_title{/translate}"}
{assign var="PageDescription" value="{translate}books_page_description{/translate}"}
{assign var="PageOGTitle" value="{translate}books_og_title{/translate}"}
{assign var="PageOGDescription" value="{translate}books_og_description{/translate}"}
{include file='short-header.tpl'}
    <style>
    .books-page .section {
        height: auto;
    }
    .books-page .section > div {
        width: 100%;
    }
    .books-page .top p,
    .books-page .section p {
        line-height: 1.65;
    }
    .books-summary {
        margin-top: 1rem;
    }
    .books-summary h2 {
        margin-bottom: 0.75rem;
    }
    .books-summary ul {
        margin: 0;
        padding-left: 1.25rem;
    }
    .books-summary li {
        margin-bottom: 0.5rem;
    }
    .books-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
        gap: 1rem;
    }
    .book-card {
        display: block;
        height: 100%;
    }
    .book-card-link {
        display: block;
        text-decoration: none;
        color: var(--question-color);
        height: 100%;
    }
    .book-card-inner {
        display: flex;
        flex-direction: row;
        gap: 0.9rem;
        border: 1px solid var(--text-block-border-color);
        color: var(--question-text);
        border-radius: 6px;
        padding: 0.75rem;
        background: var(--accordion-panel-bg-color);
        height: 100%;
        box-sizing: border-box;
    }
    .book-card-cover {
        width: 110px;
        min-width: 110px;
    }
    .book-card-cover img {
        width: 100%;
        height: auto;
        border-radius: 4px;
        display: block;
    }
    .book-card-content {
        font-size: 1em;
        width: 100%;
        font-weight: 100;
    }
    .book-card-content h3 {
        margin: 0 0 0.75rem;
        font-size: 1.05rem;
    }
    .book-card-content p {
        margin: 0;
        font-size: 0.95rem;
    }
    @media (max-width: 640px) {
        .book-card-inner {
            align-items: flex-start;
        }
        .book-card-cover {
            width: 84px;
            min-width: 84px;
        }
    }
    </style>
    <body>
        <div class="container">
            {include file='popups.tpl'}
            <header>
                {if $MobileView}
                    {include file='m.top-menu.tpl' path="/books"}
                {else}
                    {include file='top-menu.tpl' path="/books"}
                {/if}
            </header>
            <main class="books-page">
                <link rel="stylesheet" type="text/css" href="/about.css?{$VERSION}" media="all">
                <div class="about">
                    <section class="section top colored">
                        <div>
                            <h1>{translate}books_title{/translate}</h1>
                            <p>{translate}books_description{/translate}</p>
                        </div>
                    </section>
                    <section class="section books-summary">
                        <div>
                            <h2>{translate}books_content_title{/translate}</h2>
                            <p>{translate}books_content_intro{/translate}</p>
                            <ul>
                                <li>{translate}books_content_point_1{/translate}</li>
                                <li>{translate}books_content_point_2{/translate}</li>
                                <li>{translate}books_content_point_3{/translate}</li>
                            </ul>
                            <p>{translate}books_content_closing{/translate}</p>
                        </div>
                    </section>
                    <section class="section">
                        <div>
                            <div class="books-grid">
                                {foreach $Books as $book}
                                    <article class="book-card" itemscope itemtype="https://schema.org/Book">
                                        <a class="book-card-link" href="{{$book.referral_link}}" target="_blank" rel="nofollow sponsored noopener" itemprop="url">
                                            <div class="book-card-inner">
                                                <div class="book-card-cover">
                                                    <img src="{{$book.picture_link}}" alt="{{$book.title|escape:"html"}}" loading="lazy" itemprop="image">
                                                </div>
                                                <div class="book-card-content">
                                                    <h3 itemprop="name">{{$book.title|escape:"html"}}</h3>
                                                    <p itemprop="description">{{$book.description|escape:"html"}}</p>
                                                </div>
                                            </div>
                                        </a>
                                    </article>
                                {/foreach}
                            </div>
                        </div>
                    </section>
                    <section class="section bottom colored">
                        <div>
                            <h2>{translate}books_support_title{/translate}</h2>
                            <p>{translate}books_support{/translate}</p>
                        </div>
                    </section>
                </div>
            </main>
            <footer>               
                {if $MobileView}
                    {include file='m.footer.tpl'}
                {else}
                    {include file='footer.tpl'}
                {/if}
            </footer>
        </div>
        {include file='counters.tpl'}
    </body>
</html>