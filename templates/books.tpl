{assign var="PageTitle" value="{translate}books_page_title{/translate}"}
{assign var="PageDescription" value="{translate}books_page_description{/translate}"}
{include file='short-header.tpl'}
<body>
    <div class="container">

        <header>
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/about"}
            {else}
                {include file='top-menu.tpl' path="/about"}
            {/if}
        </header>
        <main>
            <h2>{translate}books_title{/translate}</h2>
            <h3>{translate}books_description{/translate}</h3>
            </h3>
            <div class="books-container" style="display: flex; flex-flow: wrap; gap: 1em;">
                {foreach $Books as $book}
                    <div class="book-card">
                        <a href="{{$book.referral_link}}" target="_blank" style="text-decoration: none; color: var(--question-color);">
                            <div style="display: flex; flex-direction: row;     border: 1px solid var(--text-block-border-color);
    color: var(--question-text);
    border-radius: 6px; padding: 0.3em; width: 98%;">
                            <div  style = "width: 25%;">
                                <img style="width: 100%;" src="{{$book.picture_link}}" alt="{{$book.title|escape:"html"}}">
                            </div>
                            <div style="font-size: 1em;  width: 75%;  padding: 0 0.7em; font-weight: 100; height: 250px; overflow: auto;">
                                <div>{{$book.title|escape:"html"}}</div>
                                <div style="font-size: small; padding-top: 0.5em;">{{$book.description|escape:"html"}}</div>
                            </div>
                            </div>
                        </a>
                    </div>
                {/foreach}
            </div>
            <p>{translate}books_support{/translate}</p>
            </p>
            <div style="text-align: center; margin: 36px;">
                <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/question/db-theory/what-is-sql" title="Start quiz" class="button green">{translate}books_start_quiz{/translate}</a>
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
</body>
</html>