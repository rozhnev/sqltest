    {include file='short-header.tpl'}
    <link rel="stylesheet" type="text/css" href="/about.css?{$VERSION}" media="all">
    <body>
        <div class="container">
            <header>
                {if $MobileView}
                    {include file='m.top-menu.tpl' path="/"}
                {else}
                    {include file='top-menu.tpl' path="/"}
                {/if}
            </header>
            <main>
                <div class="about">
                    {if $TestResult.ok}
                        {$grades = ['','Intern','Junior','Middle','Senior']}
                        {assign var="Grade" value="{$grades[$TestResult.grade]}"}
                        <div class="section top colored">
                            <div>
                                <h2>{translate}test_done_with_grade{/translate}</h2>
                            </div>
                        </div>
                        <div class="section not-colored" style="height: 100%;">
                            <div style="display: flex;">
                                <img src="/images/user_grade_{$Grade}.jpeg" title="{$Grade}" style="margin: 0 auto;" alt="Your grade is {$Grade}">
                            </div>
                        </div>
                    {else}
                        <div class="section top colored">
                            <div>
                                <h2>The test did not done. You can not be graded.</h2>
                            </div>
                        </div>
                    {/if}
                    <div class="section bottom colored">
                        <div style="text-align: center; margin: 36px;">
                            <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/question/db-theory/what-is-sql" title="Start quiz" class="button green">{translate}continue_practice{/translate}</a>
                        </div>
                    </div>
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