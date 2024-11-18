<style>
.rank-table {
    width: 100%;
    border-collapse: collapse;
    margin: 1.5rem 0;
}

.rank-table th, .rank-table td {
    padding: 1rem;
    border: 1px solid var(--border-color);
    text-align: left;
}

.rank-table th {
    background: var(--background-color-secondary);
}
</style> 

<div class="container800-header">
    <h1>Test your SQL knowledge!</h1>
</div>
<div class="container800-section">
    <p>Our test consists of 12 tasks of varying difficulty levels, randomly selected from the site's task database. The difficulty of the tasks is determined by the results of the site users' voting.</p>
    <h2>Test structure:</h2>
    <ul class="difficulty-list">
        <li class="difficulty-item">4 tasks of the "Easy" level</li>
        <li class="difficulty-item">3 tasks of the "Easy" level</li>
        <li class="difficulty-item">2 tasks of the "Average" level</li>
        <li class="difficulty-item">2 tasks of the "Difficult" level</li>
        <li class="difficulty-item">1 task of the "Difficult" level</li>
    </ul>
</div>
<div class="container800-section">
    <h2>Time and ranks</h2>
    <p>Three hours are allocated for the test. At the end of the time (or earlier) you will be able to get one of the ranks in SQL:</p>

    <table class="rank-table">
    <tr>
    <th>Rank</th>
    <th>Requirements</th>
    </tr>
    <tr>
    <td>Intern</td>
    <td>Solve at least 6 tasks (of any difficulty)</td>
    </tr>
    <tr>
    <td>Junior</td>
    <td>Solve all easy and simple tasks</td>
    </tr>
    <tr>
    <td>Middle</td>
    <td>Solve all easy and simple tasks + 2/3 of the remaining tasks</td>
    </tr>
    <tr>
    <td>Senior</td>
    <td>Solve all tasks</td>
    </tr>
    </table>
    </div>
    <div class="container800-section">
        <h2>Bonuses and Penalties</h2>
        <p>Successfully solving a task on the first try brings additional points, and a large number of attempts on one task may lead to a lower grade.</p>

        <div class="note-section">
            <strong>Note:</strong> The grading system may be adjusted depending on the test results and feedback from participants.
        </div>
    </div>
    <div class="container800-section">
    {if $User->logged()}
        {if isset($LastTest)}
            {if $LastTest.closed}
                {if $LastTest.rate eq 1}
                    <h2>Great start! According to the test results, your level is Intern.</h2>This speaks volumes about your potential. Do you want to develop further and move to the next level?
                {elseif $LastTest.rate eq 2}
                    <h2>You are on the right track! Your current level is Junior.</h2>That's a great result. Are you ready to expand your knowledge and skills?
                {elseif $LastTest.rate eq 3}
                    <h2>You've reached the Middle level!</h2>That's great! But there's always room for improvement, right? Ready to challenge yourself and improve your results?
                {elseif $LastTest.rate eq 4}
                    <h2>Congratulations! You're now a Senior!</h2>Ready to confirm your status?
                {else}
                    <h2>Your last test time is up.</h2>Ready to try again?
                {/if}
                <div style="text-align: center; margin: 36px;">
                    <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/create" title="Start test" class="button green">Start test</a>
                </div>
            {else}
                {* Continue open test *}
                <div style="text-align: center; margin: 36px;">
                    <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/{$LastTest.id}" title="Start test" class="button green">Continue test</a>
                </div>
            {/if}
        {else}
            <h2>Good luck!</h2>
            <div style="text-align: center; margin: 36px;">
                <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/create" title="Start Test" class="button green">Start Test</a>
            </div>
        {/if}
    {else}
        <h2><span class='warning'>
            This page is not available to unregistered users. Please log in to continue.
        </span></h2>
        <div style="text-align: center; margin: 36px;">
            <button class="button green" onClick="toggleLoginWindow()">Login</button>
        </div>
    {/if}
</div>