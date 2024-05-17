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
                    <span class="lang-swith"><a href="/ru/about" target="_self">RU</a></span>
                </div>
            </div>
            <div class="container3">
                <p>Welcome to SQLTest.online – your guide to the world of SQL and databases! Our project is designed to provide a unique platform for testing and improving your SQL skills.</p>
                <h2>What is SQLTest.online?</h2>
                <p>SQLTest.online is an interactive platform created for you to check and enhance your SQL skills. Whether you're a beginner or an experienced developer, we have something for you.</p></details>
                <h2>What We Offer:</h2>
                <ol>
                    <li><strong>Diverse Challenges:</strong> SQLTest.online offers a variety of tasks, allowing you to assess your skills at different levels of complexity. From simple queries to more advanced scenarios, we have something for everyone.</li>
                    <li><strong>Instant Start:</strong> No complex database setups – choose your language (English or Russian) and start solving tasks right away.</li>
                    <li><strong>Supportive Community:</strong> Join our community where you can share your experiences, discuss interesting points, and get assistance from fellow enthusiasts.</li>
                </ol>
                <h2>What's New:</h2>
                <p>At the moment, our website presents more then {floor(($QuestionsCount - 1)/10) * 10} tasks of varying complexity in {$CategoriesCount} categories, based on the Sakila (MySQL), Bookings (PostgreSQL) and EMPLOYEE (Firebird). We regularly add new tasks and aim to expand the number of databases to provide you with a broader learning experience.</p></details>

                <h2>Join Us:</h2>
                <p>No registration required – just visit <a href="https://sqltest.online">SQLTest.online</a> and start your SQL adventure. We also invite you to join our <a href="https://t.me/sqlize">Telegram chat</a>, where you can share your experiences and influence the future development of the project.</p></details>
                <p><strong>Let's develop SQL skills together on SQLTest.online!</strong> 🚀</p>
                <p>
                    Many thanks to <a href ="https://t.me/artlatyshev" target="_blank">Artem Latyshev</a> for his contribution to the development of the project.
                </p>
            </div>
{if $MobileView}
    {include file='m.footer.tpl'}
{else}
    {include file='footer.tpl'}
{/if}