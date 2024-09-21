{include file='../short-header.tpl'}
    <body>
        <div class="{if $MobileView}mobile-container{else}full-container{/if}">
            <div class="header">
                <div class="top-menu">
                    {if $MobileView}
                        {include file='m.site-name.tpl'}
                    {else}
                        {include file='site-name.tpl'}
                    {/if}
                    <span class="lang-swith"><a href="/ru/books" target="_self">RU</a></span>
                </div>
            </div>
            <div class="container3">
                <h2>Want to become a real SQL guru?</h2>
                <h3>
                    We have prepared for you a selection of the best books that will help you master the SQL language from scratch and improve your skills to perfection.
                    <p>We have carefully studied many publications and selected only the most useful and relevant ones. </p>
                    Our selection includes books for both beginners and experienced developers.
                </h3>
                <div class="books-container" style="display: flex; flex-flow: wrap; gap: 1em;">
                    {foreach $Books as $book}
                        <div style="display: flex; max-width: 30%; min-width:340px;">
                            <a href="{{$book.referral_link}}" target="_blank" style="text-decoration: none; color: white;">
                                <div style="display: flex; flex-direction: row; border: 1px solid white; padding: 0.3em; width: 98%;">
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
                <p>
                    Support our project!<br>
                    By purchasing books via our links, you will not only expand your library, but also help develop the sqltest.online project.
                </p>
                <div style="text-align: center; margin: 36px;">
                    <a style="display:inline-block;width:240px; color: white;" href="/en/question/db-theory/what-is-sql" title="Start quiz" class="button green">Start quiz</a>
                </div>
            </div>
{if $MobileView}
    {include file='m.footer.tpl'}
{else}
    {include file='footer.tpl'}
{/if}