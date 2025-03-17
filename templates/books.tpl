{assign var="PageTitle" value="{translate}books_page_title{/translate}"}
{assign var="PageDescription" value="{translate}books_page_description{/translate}"}
{include file='short-header.tpl'}
    <style>
    .book-card {
        display: flex;
        min-width:340px;
        max-width: 48%;
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
            <main>
                <link rel="stylesheet" type="text/css" href="/about.css?{$VERSION}" media="all">
                <div class="about">
                <div class="section top colored">
                <div>
                    <h2>{translate}books_title{/translate}</h2>
                    <h4>{translate}books_description{/translate}</h4>
                </div>
            </div>
            <div class="section" style="height: 100%;">
                <div>     
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
            </div>
            <div class="section bottom colored">
            <div>
                <h4>{translate}books_support{/translate}</h4>
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