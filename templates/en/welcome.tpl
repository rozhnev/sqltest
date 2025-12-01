<div class="welcome-container">
    <div class="welcome-page-header">
        <h2 style="margin: 0">Welcome to SQLTest.online</h2>
    </div>

    <section>
        <p>SQLTest.online is an interactive learning platform that helps you build practical, real-world SQL and database skills. The best way to learn is by solving real problems, so we give you hands-on tasks and instant feedback.</p>
        <p>Our motto: <b>Master SQL — one query at a time.</b></p>
    </section>

    <section>
        <h3>How it works</h3>
        <div class="welcome-card">
            <p>
                Our question database contains {$QuestionsCount} tasks ranging from simple <code class="sql">SELECT</code> queries to complex analytical problems that mirror real-world scenarios.
                Tasks are grouped by difficulty, topic, and the database used.
            </p>
            <p style="margin-top: 1em;">Each problem includes tests that validate your query results and any task-specific conditions.</p>
        </div>
    </section>

    <section>
        <h3>Getting started</h3>

        <div class="step-card">
            <div class="step-icon">📂</div>
            <div class="step-content">
                <h4>Choose a challenge</h4>
                <p>Explore by topic or difficulty level.</p>
            </div>
        </div>

        <div class="step-card">
            <div class="step-icon">✍️</div>
            <div class="step-content">
                <h4>Write your query</h4>
                <p>Use the built-in editor to craft your solution.</p>
            </div>
        </div>

        <div class="step-card">
            <div class="step-icon">✅</div>
            <div class="step-content">
                <h4>Run and iterate</h4>
                <p>Get instant feedback and improve your query until it passes the tests.</p>
            </div>
        </div>
    </section>

    <section>
        <h3>Login is optional</h3>
        <p>You can start solving challenges immediately without creating an account. Signing in is not required, but it unlocks features such as saving progress, earning and storing achievements, and viewing others' solutions. We recommend signing in for the full experience.</p>
    </section>

    <section>
        <h3>Benefits for logged‑in users</h3>
        <ul>
            <li>Save your progress and resume challenges anytime</li>
            <li>Earn and display achievements as you learn</li>
            <li>Track your personal learning history and stats</li>
            <li>View and compare solutions from other users</li>
        </ul>
    </section>

    <section>
        <h3>View other users' solutions</h3>
        <p>After you correctly solve a challenge you will be able to view solutions submitted by other users. Comparing different approaches is one of the fastest ways to learn new techniques and optimize your queries. <em>(Viewing solutions is available to logged‑in users.)</em></p>
    </section>

    <section>
        <h3>Achievements & progress</h3>
        <p>Earn achievements as you complete tasks, master topics, and improve efficiency. Achievements and personal progress tracking are saved for logged‑in users so you can build a persistent record of your learning.</p>
    </section>

    <section>
        <h3>Take the SQL Skill Test</h3>
        <p>When you feel ready, try the test. The test is designed to evaluate your SQL skills through a series of practical challenges. The rank you achieve is not official, but it reflects your proficiency and understanding of SQL concepts.</p>
    </section>

    <section>
        <h3>Quick tips</h3>
        <ul>
            <li>Try multiple approaches — different solutions can have very different performance characteristics.</li>
            <li>Read the task conditions carefully — some problems require a specific statement or result shape.</li>
            <li>Use the estimated query cost (when available) to learn about efficiency, but focus on correctness first.</li>
        </ul>
    </section>

    <section>
        <h3>Community</h3>
        <p>Join our community of learners to share ideas and ask questions. English-speaking users can join our <a style="color: #FFA500;" href="https://t.me/sqltest_online" target="_blank">Telegram group</a>.</p>
    </section>

    <section>
        <h3>Support</h3>
        <p>If you need help, have feedback, or want to report a problem, email us at <a style="color: #FFA500;" href="mailto:support@sqltest.online">support@sqltest.online</a>.</p>
    </section>

    <div id="welcome-page" class="welcome-page">
        <div class="welcome-controls">
            <label style="display:inline-flex; align-items:center; gap:8px;">
                <input type="checkbox" id="welcome-dont-show" onchange="hideWelcome(this.checked)" />
                <span>Do not show this page again</span>
            </label>
        </div>
    </div>

    <p style="display:flex; align-items:center; gap:12px; margin-top:1em;">
        <strong>Ready to start?</strong> Pick your first challenge and begin coding!
        <a class="button green" href="/{$Lang}/question/sql-basics/get-the-actors" title="Start practicing">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" clip-rule="evenodd" d="M19.266 10.4837C20.2579 11.2512 20.2579 12.7486 19.266 13.5161C16.2685 15.8355 12.9213 17.6637 9.34979 18.9321L8.69732 19.1639C7.44904 19.6072 6.13053 18.7627 5.96154 17.4741C5.48938 13.8739 5.48938 10.1259 5.96154 6.52574C6.13053 5.23719 7.44905 4.39263 8.69732 4.83597L9.34979 5.06771C12.9213 6.33619 16.2685 8.16434 19.266 10.4837ZM18.3481 12.3298C18.5639 12.1628 18.5639 11.837 18.3481 11.67C15.4763 9.44796 12.2695 7.69648 8.84777 6.4812L8.1953 6.24947C7.87035 6.13406 7.49691 6.35401 7.44881 6.72079C6.99363 10.1915 6.99363 13.8083 7.44881 17.2791C7.49691 17.6458 7.87035 17.8658 8.19529 17.7504L8.84777 17.5187C12.2695 16.3034 15.4763 14.5519 18.3481 12.3298Z" fill="white"></path>
            </svg>
            <span>Start practicing</span>
        </a>
    </p>
</div>