<div>
    <h2>Your Skills and Showcase Your Expertise with SQLTest.online!</h2>
    <p>
        Beyond just practicing SQL queries, sqltest.online empowers you to assess and showcase your professional skill level. Our interactive platform features a unique self-assessment tool that lets you rate your proficiency across various SQL domains.
    </p><p>
    This self-assessment tool goes beyond a simple yes/no format. You'll delve into specific areas like data manipulation, querying techniques, joining tables, and more. For each domain, you can choose between beginner, intermediate, or advanced levels, allowing for a nuanced evaluation of your strengths and areas for development.
    </p><p>
    Completing the self-assessment generates a personalized report outlining your skill distribution across different areas of SQL. This report becomes a valuable asset for your professional profile, demonstrating your proficiency to potential employers or collaborators. Additionally, the insights gained can guide your learning journey and help you focus on areas that require further attention.
    </p>
</div>
{if $Logged}
    {if isset($LastTest)}
        {if $LastTest.closed}
            {if $LastTest.rate > 0}
                After last test you grade is {$LastTest.rate}! Do you want to improve the grate?
            {else}
                Your last test is time out. Want ot get a new chance?
            {/if}
            <div style="text-align: center; margin: 36px;">
                <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/create" title="Start quiz" class="button green">Start test</a>
            </div>
        {else}
            {* Continue open test *}
            <div style="text-align: center; margin: 36px;">
                <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/{$LastTest.id}" title="Start quiz" class="button green">Continue test</a>
            </div>
        {/if}
    {else}
        <div style="text-align: center; margin: 36px;">
            <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/create" title="Start quiz" class="button green">Start test</a>
        </div>
    {/if}
{else}
    <p class='warning'>
        This page unavaliable for not logged users. Please do login to continue.
    </p>
    <div style="text-align: center; margin: 36px;">
        <button class="button green" onClick="toggleLoginWindow()">Login</button>
    </div>
{/if}