{include file='short-header.tpl'}
<style>
    /* main{} in the global stylesheet is a bare CSS grid; with several
       top-level children it stretches each one across the full viewport
       height. A single wrapper keeps this page's content top-aligned. */
    .interview-page {
        max-width: 1080px;
        margin: 0 auto;
        padding: 1rem;
    }
    .interview-hero {
        display: flex;
        align-items: center;
        gap: 2rem;
        flex-wrap: wrap;
        background: linear-gradient(135deg, #F7FAFC 0%, #E8F1F8 100%);
        border-radius: 24px;
        padding: 2.5rem;
        margin-bottom: 2rem;
    }
    .interview-hero-logo { flex: 0 0 auto; }
    .interview-hero-logo img { width: 220px; height: auto; }
    .interview-hero-text { flex: 1 1 320px; min-width: min(280px, 100%); }
    .interview-hero-text h1 { margin: 0 0 0.5rem; font-size: 1.9rem; color: #0F172A; }
    .interview-hero-tagline { font-size: 1.1rem; color: #1E3A8A; font-weight: 600; margin: 0 0 1rem; }
    .interview-hero-text p { color: #334155; line-height: 1.6; }

    .interview-quote {
        display: flex;
        align-items: center;
        gap: 1rem;
        background: #FFFFFF;
        border: 1px solid #93C5FD;
        border-radius: 16px;
        padding: 1rem 1.25rem;
        margin-top: 1.25rem;
    }
    .interview-quote img { width: 56px; height: 56px; border-radius: 50%; flex: 0 0 auto; }
    .interview-quote blockquote { margin: 0; font-style: italic; color: #0F172A; }
    .interview-quote cite { display: block; margin-top: 0.35rem; font-style: normal; font-size: 0.85rem; color: #334155; }

    .interview-positions {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(min(340px, 100%), 1fr));
        gap: 1.5rem;
        margin-bottom: 2rem;
    }
    .interview-position-card {
        background: #FFFFFF;
        border: 1px solid #E2E8F0;
        border-radius: 20px;
        padding: 1.75rem;
        box-shadow: 0 10px 24px rgba(15, 23, 42, 0.06);
    }
    .interview-position-card h2 { margin: 0 0 0.5rem; color: #0F172A; font-size: 1.35rem; }
    .interview-position-card > p { color: #334155; line-height: 1.55; margin: 0 0 1.25rem; }

    .interview-grades { display: flex; flex-direction: column; gap: 1rem; }
    .interview-grade-card {
        border: 1px solid #DBEAFE;
        border-radius: 14px;
        padding: 1rem 1.15rem;
        background: #F8FAFC;
    }
    .interview-grade-card h3 {
        margin: 0 0 0.5rem;
        font-size: 1rem;
        color: #1E3A8A;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 0.75rem;
    }
    .interview-grade-card ul { margin: 0 0 1rem; padding-left: 1.1rem; color: #334155; font-size: 0.92rem; line-height: 1.5; }
    .interview-grade-card li { margin-bottom: 0.35rem; }
    .interview-start-btn {
        display: inline-block;
        background: #1E3A8A;
        color: #FFFFFF !important;
        text-decoration: none;
        font-weight: 600;
        font-size: 0.9rem;
        padding: 0.55rem 1.1rem;
        border-radius: 10px;
        transition: background-color 0.15s ease;
    }
    .interview-start-btn:hover { background: #3B82F6; }

    @media (max-width: 640px) {
        .interview-hero { padding: 1.5rem; }
        .interview-hero-logo img { width: 160px; }
    }
</style>
<body>
    {include file='popups.tpl'}
    {if $ActiveInterviewSession}
        <div style="max-width: 720px; margin: 1rem auto 0; padding: 1rem 1.25rem; border-radius: 12px; background: #DBEAFE; color: #1E3A8A; text-align: center;">
            {if $Lang === 'ru'}
                У вас уже есть незавершённое собеседование.
            {else}
                You already have an unfinished interview session.
            {/if}
            <a class="interview-start-btn" href="/{$Lang}/interview/{$ActiveInterviewSession.id}">
                {if $Lang === 'ru'}Продолжить интервью{else}Continue interview{/if}
            </a>
        </div>
    {/if}
    {if $MobileView}
        <header>
            {include file='m.top-menu.tpl' path="/interview-start"}
        </header>
        <main>
            {include file="{$Lang}/interview-start.tpl"}
        </main>
        <footer>
            {include file='m.footer.tpl'}
        </footer>
    {else}
        <div class="container">
            <header>
                {include file='top-menu.tpl' path="/interview-start"}
            </header>
            <main>
               {if $InterviewLoginRequired}
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            if (typeof toggleLoginWindow === 'function') {
                                toggleLoginWindow();
                            }
                        });
                    </script>
                {/if}
                {include file="{$Lang}/interview-start.tpl"}
            </main>
            <footer>
                {include file='footer.tpl'}
            </footer>
        </div>
    {/if}
</body>
</html>
