{include file='short-header.tpl'}
    <body>
        <div class="{if $MobileView}mobile-container{else}full-container{/if}">
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/books"}
            {else}
                {include file='top-menu.tpl' path="/books"}
            {/if}
            <div class="container3">
                <h2>{translate}books_title{/translate}</h2>
                <h3>{translate}books_description{/translate}</h3>
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
                <p>{translate}books_support{/translate}</p>
                </p>
                <div style="text-align: center; margin: 36px;">
                    <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/question/db-theory/what-is-sql" title="Start quiz" class="button green">Start quiz</a>
                </div>
            </div>
{if $MobileView}
    {include file='m.footer.tpl'}
{else}
    {include file='footer.tpl'}
{/if}