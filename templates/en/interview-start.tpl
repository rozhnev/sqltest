{if $InterviewLoginRequired}
    <div style="max-width: 720px; margin: 1rem auto 0; padding: 1rem 1.25rem; border-radius: 12px; background: #FEF3C7; color: #92400E; text-align: center;">
        Sign in to start the interview for the position and grade you selected.
    </div>
{/if}
{if $ActiveInterviewSession}
    <div class="interview-notice">
        You already have an unfinished interview session.
        <a class="interview-start-btn" href="/{$Lang}/interview/{$ActiveInterviewSession.id}">Continue interview</a>
    </div>
{/if}
<div class="interview-page">
<section class="interview-hero">
    <div class="interview-hero-logo">
        <img src="/images/interview/meridian-logistics-logo.svg" alt="Meridian Logistics logo">
    </div>
    <div class="interview-hero-text">
        <h1>We are Meridian Logistics</h1>
        <p class="interview-hero-tagline">Moving freight. Powered by data.</p>
        <p>
            We are a freight and supply-chain company operating across three continents.
            Every day, our platform tracks thousands of shipments, hundreds of carriers,
            and a growing network of warehouses — and all of it runs on SQL. As we scale,
            we're looking for people who are as comfortable with a JOIN as they are with
            a delivery deadline.
        </p>
        <div class="interview-quote">
            <img src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">
            <div>
                <blockquote>"Our warehouses run on forklifts. Our decisions run on SQL."</blockquote>
                <cite>Elena Cho, Head of Data &amp; Engineering</cite>
            </div>
        </div>
    </div>
</section>

<p class="interview-disclaimer" role="note"><strong>Please note:</strong> this is a practice simulation, not a real job interview. Meridian Logistics, its employees and its vacancies are fictional. Completing the interview does not lead to a job offer or any form of employment — the result and the feedback are only an educational self-assessment of your SQL skills.</p>

<h2 style="color:#0F172A; margin-bottom: 1rem;">Open positions</h2>

<section class="interview-positions">
    <article class="interview-position-card">
        <h2>SQL Developer</h2>
        <p>
            You'll design and maintain the databases behind our transportation management
            system — shipment tracking, carrier contracts, route data, and billing. Expect
            schema design, query optimization, and close collaboration with the engineering
            team building on top of what you ship.
        </p>
        <div class="interview-grades">
            <div class="interview-grade-card">
                <h3>Junior</h3>
                <ul>
                    <li>Comfortable writing SELECT queries with JOINs and aggregations.</li>
                    <li>Eager to learn schema design and indexing.</li>
                    <li>Some hands-on exposure to a relational database (any DBMS).</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=sql_developer&amp;grade=2">Start Interview</a>
            </div>
            <div class="interview-grade-card">
                <h3>Middle</h3>
                <ul>
                    <li>Can design a normalized schema from scratch.</li>
                    <li>Writes efficient queries against tables with millions of rows.</li>
                    <li>Understands indexing trade-offs and has debugged a slow query in production.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=sql_developer&amp;grade=3">Start Interview</a>
            </div>
            <div class="interview-grade-card">
                <h3>Senior</h3>
                <ul>
                    <li>Owns database architecture decisions end-to-end.</li>
                    <li>Comfortable with query optimization, partitioning, and replication trade-offs.</li>
                    <li>Mentors other developers and pushes back on risky schema changes.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=sql_developer&amp;grade=4">Start Interview</a>
            </div>
        </div>
    </article>

    <article class="interview-position-card">
        <h2>Data Analyst</h2>
        <p>
            You'll turn raw shipment and warehouse data into answers: which routes are
            losing money, which carriers are reliably on time, and where the next warehouse
            should go. You'll work closely with operations and finance to turn SQL queries
            into decisions.
        </p>
        <div class="interview-grades">
            <div class="interview-grade-card">
                <h3>Junior</h3>
                <ul>
                    <li>Can write SQL queries with GROUP BY, HAVING, and basic window functions.</li>
                    <li>Comfortable turning a business question into a query.</li>
                    <li>Some experience presenting numbers to non-technical people.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=data_analyst&amp;grade=2">Start Interview</a>
            </div>
            <div class="interview-grade-card">
                <h3>Middle</h3>
                <ul>
                    <li>Handles ambiguous requests from multiple stakeholders.</li>
                    <li>Uses window functions, CTEs, and query optimization for reliable recurring reports.</li>
                    <li>Can defend a methodology under scrutiny.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=data_analyst&amp;grade=3">Start Interview</a>
            </div>
            <div class="interview-grade-card">
                <h3>Senior</h3>
                <ul>
                    <li>Builds the analytical standards other analysts follow.</li>
                    <li>Owns metric definitions end-to-end.</li>
                    <li>Comfortable pushing back on a stakeholder's assumptions with data.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=data_analyst&amp;grade=4">Start Interview</a>
            </div>
        </div>
    </article>
</section>
</div>
