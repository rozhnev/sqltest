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
                    <span class="lang-swith"><a href="/en/books" target="_self">EN</a></span>
                </div>
            </div>
            <div class="container3">
                <h2>Хотите стать настоящим гуру SQL?</h2>
                <h3>
                    Мы подготовили для вас подборку лучших книг, которые помогут освоить язык SQL с нуля и довести свои навыки до совершенства.
                    <p>Мы тщательно изучили множество изданий и отобрали только самые полезные и актуальные.</p>
                    В нашей подборке найдутся книги как для новичков, так и для опытных разработчиков.
                </h3>
                <div style="display: flex; gap: 1em;">
                    <div style="display: flex; flex-direction: row;">
                    <!-- admitad.banner: x9f7rh3y3yfec845fb2fa804937a48 Читай-город -->
                        <a target="_blank" rel="nofollow" href="https://kjuzv.com/g/x9f7rh3y3yfec845fb2fa804937a48/?i=4&subid=books-banner&erid=LatgBXwff"><img width="160" height="600" border="0" src="https://aflink.ru/b/x9f7rh3y3yfec845fb2fa804937a48/" alt="Читай-город"/></a>
                    <!-- /admitad.banner -->
                    </div>
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
                </div>
                <p>
                    Поддержите наш проект!<br>
                    Приобретая книги по нашим ссылкам, вы не только пополните свою библиотеку, но и поможете развитию проекта sqltest.online.
                </p>
                <div style="text-align: center; margin: 36px;">
                    <a style="display:inline-block;width:240px; color: white;" href="/ru/question/db-theory/what-is-sql" title="Перейти к тестам" class="button green">Перейти к тестам</a>
                </div>
            </div>
{if $MobileView}
    {include file='m.footer.tpl'}
{else}
    {include file='footer.tpl'}
{/if}