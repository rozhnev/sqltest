{include file='short-header.tpl'}
<body>
    <style>
        :root {
            --mdb-surface: #030a18;
            --mdb-card: rgba(255, 255, 255, 0.06);
            --mdb-card-strong: rgba(255, 255, 255, 0.12);
            --mdb-border: rgba(255, 255, 255, 0.25);
            --mdb-highlight: #15d0ff;
            --mdb-emerald: #64f3bd;
        }

        body {
            margin: 0;
            background-color: var(--mdb-surface);
            color: #f5fbff;
            font-family: 'Space Grotesk', 'Inter', 'Segoe UI', system-ui, sans-serif;
        }

        .mariadb-shell {
            min-height: 100vh;
            background:
                radial-gradient(circle at 25% 25%, rgba(21, 208, 255, 0.25), transparent 45%),
                radial-gradient(circle at 80% 5%, rgba(100, 243, 189, 0.2), transparent 40%),
                linear-gradient(180deg, rgba(2, 9, 28, 0.9), rgba(3, 10, 24, 1));
            display: flex;
            flex-direction: column;
        }

        .mariadb-header {
            width: 100%;
            padding: 0.9rem 1.5rem 0.75rem;
            background: linear-gradient(180deg, rgba(3, 10, 24, 0.95), rgba(3, 10, 24, 0.75));
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
            box-shadow: 0 20px 35px rgba(0, 0, 0, 0.55);
            position: sticky;
            top: 0;
            z-index: 20;
            backdrop-filter: blur(16px);
        }

        .mariadb-header-inner,
        .mariadb-footer-inner {
            width: min(1200px, 100%);
            margin: 0 auto;
        }

        .mariadb-header-inner {
            display: flex;
            justify-content: center;
        }

        .mariadb-header .top-menu-left .site-name,
        .mariadb-header .top-menu-center .site-description,
        .mariadb-header .top-menu-left a,
        .mariadb-header .top-menu-center,
        .mariadb-header .top-menu-switchers,
        .mariadb-header .top-menu-buttons a,
        .mariadb-header .top-menu-buttons span {
            color: #f5fbff;
        }
        .mariadb-header .top-menu-left 
        {
            min-width: 9vw;
        }
        .mariadb-header .top-menu-center
        {
            max-width: 53%;
        }
        .mariadb-header .divider
        {
            border: 0;
        }
        .mariadb-header .divider {
            background-color: rgba(255, 255, 255, 0.25);
        }

        header,
        footer {
            padding: 0 1rem;
        }

        main {
            flex: 1;
        }

        .mariadb-wrapper {
            width: min(1200px, 100%);
            margin: 0 auto;
            padding: 1.5rem 1.25rem 3rem;
        }

        .mariadb-page {
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }

        .mariadb-hero {
            padding: 2.5rem;
            border-radius: 20px;
            border: 1px solid var(--mdb-border);
            background: linear-gradient(135deg, rgba(27, 177, 255, 0.25), rgba(100, 243, 189, 0.15));
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }

        .hero-eyebrow {
            text-transform: uppercase;
            letter-spacing: 0.4rem;
            font-size: 0.8rem;
            color: rgba(245, 255, 255, 0.85);
            margin-bottom: 0.6rem;
        }

        .mariadb-hero h1 {
            margin: 0;
            font-size: clamp(2rem, 4vw, 3rem);
            letter-spacing: -0.02em;
        }

        .hero-subtitle {
            margin: 0.75rem 0 0.5rem;
            font-size: 1rem;
            color: rgba(245, 255, 255, 0.85);
        }

        .hero-subtitle a {
            color: #f5b13d;
            text-decoration: none;
        }

        .hero-cta {
            margin-top: 1.5rem;
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            align-items: center;
        }

        .mariadb-button {
            background: var(--mdb-highlight);
            color: #04101e;
            padding: 0.9rem 1.8rem;
            border-radius: 999px;
            font-weight: 600;
            text-decoration: none;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .mariadb-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(21, 208, 255, 0.4);
        }

        .hero-cta {
            margin-top: 1.5rem;
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            align-items: center;
        }

        .mariadb-highlight {
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        }

        .mariadb-highlight > div,
        .mariadb-grid article {
            padding: 1.75rem;
            border-radius: 18px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .mariadb-highlight h2 {
            margin-top: 0;
        }

        .mariadb-list {
            padding-left: 1.1rem;
            margin: 1rem 0 0;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            color: rgba(255, 255, 255, 0.85);
        }

        .mariadb-list li::marker {
            color: var(--mdb-emerald);
        }

        .floating-card {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 18px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.45);
        }

        .floating-card h3 {
            margin-top: 0;
        }

        .mariadb-grid article {
            background: linear-gradient(180deg, rgba(255, 255, 255, 0.04), rgba(25, 46, 84, 0.7));
        }

        .mariadb-prizes {
            padding: 1.75rem;
            border-radius: 22px;
            border: 1px solid rgba(255, 255, 255, 0.12);
            background: rgba(12, 24, 45, 0.7);
        }

        .mariadb-prizes h2 {
            margin-top: 0;
        }

        .prize-grid {
            margin-top: 1rem;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1rem;
        }

        .prize-card {
            padding: 1.25rem;
            border-radius: 16px;
            background: rgba(22, 32, 70, 0.85);
            border: 1px solid rgba(255, 255, 255, 0.08);
            display: flex;
            flex-direction: column;
            gap: 0.6rem;
        }

        .prize-card h4 {
            margin: 0;
            color: var(--mdb-highlight);
        }

        .prize-note {
            margin-top: 1rem;
            color: rgba(255, 255, 255, 0.75);
        }

        .mariadb-final {
            padding: 1.75rem;
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.12);
            background: linear-gradient(135deg, rgba(100, 243, 189, 0.08), rgba(27, 177, 255, 0.1));
            display: flex;
            flex-direction: column;
            gap: 1rem;
            align-items: flex-start;
        }

        .mariadb-final p {
            margin: 0;
        }

        .external-link {
            color: var(--mdb-highlight);
            text-decoration: underline;
        }

        .mariadb-footer {
            padding: 2rem 1.25rem 3rem;
            background: linear-gradient(180deg, rgba(3, 10, 24, 0.92), rgba(3, 10, 24, 0.98));
            border-top: 1px solid rgba(255, 255, 255, 0.12);
        }

        .mariadb-footer-inner {
            background: rgba(7, 16, 34, 0.75);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 20px;
            padding: 2rem;
            display: flex;
            flex-direction: column;
            gap: 1rem;
            box-shadow: 0 25px 40px rgba(0, 0, 0, 0.45);
            backdrop-filter: blur(14px);
        }

        .mariadb-footer-inner .footer-links {
            border-bottom: 1px solid rgba(255, 255, 255, 0.06);
            padding-bottom: 1rem;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 0.75rem;
            color: rgba(245, 251, 255, 0.85);
        }

        .mariadb-footer-inner .footer-links:last-of-type {
            border-bottom: none;
            padding-bottom: 0;
        }

        .mariadb-auth-popup {
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.75);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.35s ease, visibility 0.35s ease;
            z-index: 40;
        }

        .mariadb-auth-popup.visible {
            opacity: 1;
            visibility: visible;
        }

        .mariadb-auth-card {
            background: rgba(6, 16, 36, 0.9);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 2rem;
            max-width: 420px;
            width: 100%;
            box-shadow: 0 30px 65px rgba(0, 0, 0, 0.55);
            position: relative;
        }

        .mariadb-auth-card h3 {
            margin-top: 0;
            margin-bottom: 1rem;
        }

        .mariadb-auth-card form {
            display: flex;
            flex-direction: column;
            gap: 0.85rem;
        }

        .mariadb-auth-input {
            border-radius: 12px;
            border: 1px solid rgba(255, 255, 255, 0.25);
            background: rgba(255, 255, 255, 0.05);
            padding: 0.85rem 1rem;
            color: #f5fbff;
            font-size: 1rem;
            width: 100%;
        }

        .mariadb-auth-input::placeholder {
            color: rgba(255, 255, 255, 0.65);
        }

        .mariadb-auth-close {
            position: absolute;
            top: 0.75rem;
            right: 0.75rem;
            border: none;
            background: transparent;
            color: rgba(255, 255, 255, 0.6);
            font-size: 1.25rem;
            cursor: pointer;
        }

        .mariadb-auth-feedback {
            margin: 0;
            font-size: 0.95rem;
            color: rgba(255, 255, 255, 0.85);
            min-height: 1.25rem;
        }

        .mariadb-auth-feedback.error {
            color: #ffbaba;
            margin: 10px 0;
        }

        @media (max-width: 768px) {
            .hero-subtitle {
                font-size: 0.95rem;
            }

            .mariadb-shell {
                padding-top: 1rem;
            }

            header,
            footer {
                padding: 0 0.5rem;
            }

            .mariadb-wrapper {
                padding: 1rem 1rem 2rem;
            }
        }
    </style>
    <div class="mariadb-shell">
            <header class="mariadb-header">
                <div class="mariadb-header-inner">
                    {if $MobileView}
                        {include file='m.top-menu.tpl' path="/challenge-mariadb"}
                    {else}
                        {include file='top-menu.tpl' path="/challenge-mariadb"}
                    {/if}
                </div>
            </header>
        <main>
            <div class="mariadb-wrapper">
                <div class="mariadb-page">
                    {include file="{$Lang}/challenge-mariadb.tpl"}
                </div>
            </div>
        </main>
        <div id="mariadb-registration-popup" class="mariadb-auth-popup" role="dialog" aria-modal="true" aria-labelledby="mariadb-registration-title">
            <div class="mariadb-auth-card">
                <button type="button" class="mariadb-auth-close" aria-label="Close registration form">&times;</button>
                <h3 id="mariadb-registration-title">Registration</h3>
                <form id="mariadb-registration-form">
                    <input type="email" name="email" class="mariadb-auth-input" placeholder="Email" required autocomplete="email">
                    <input type="password" name="password" class="mariadb-auth-input" placeholder="Password" required minlength="8" autocomplete="new-password">
                    <input type="password" name="password_confirm" class="mariadb-auth-input" placeholder="Confirm password" required minlength="8" autocomplete="new-password">
                    <button type="submit" class="mariadb-button">Register</button>
                </form>
                <p class="mariadb-auth-feedback" role="status"></p>
            </div>
        </div>
        <div id="mariadb-login-popup" class="mariadb-auth-popup" role="dialog" aria-modal="true" aria-labelledby="mariadb-login-title">
            <div class="mariadb-auth-card">
                <button type="button" class="mariadb-auth-close" aria-label="Close login form">&times;</button>
                <h3 id="mariadb-login-title">Login</h3>
                <form id="mariadb-login-form">
                    <input type="email" name="email" class="mariadb-auth-input" placeholder="Email" required autocomplete="email">
                    <input type="password" name="password" class="mariadb-auth-input" placeholder="Password" required autocomplete="current-password">
                    <input type="hidden" name="ajax" value="1">
                    <button type="submit" class="mariadb-button">Login</button>
                </form>
                <p class="mariadb-auth-feedback" role="status"></p>
            </div>
        </div>
            <footer class="mariadb-footer">
                <div class="mariadb-footer-inner">
                    {if $MobileView}
                        {include file='m.footer.tpl'}
                    {else}
                        {include file='footer.tpl'}
                    {/if}
                </div>
            </footer>
    </div>
    {include file='counters.tpl'}
    <script>
        (function () {
            const registerBtn = document.querySelector('.mariadb-register-btn');
            const loginBtn = document.querySelector('.mariadb-login-btn');
            const registerPopup = document.getElementById('mariadb-registration-popup');
            const loginPopup = document.getElementById('mariadb-login-popup');
            const registerForm = document.getElementById('mariadb-registration-form');
            const loginForm = document.getElementById('mariadb-login-form');
            const registerClose = registerPopup?.querySelector('.mariadb-auth-close');
            const loginClose = loginPopup?.querySelector('.mariadb-auth-close');
            const registerFeedback = registerPopup?.querySelector('.mariadb-auth-feedback');
            const loginFeedback = loginPopup?.querySelector('.mariadb-auth-feedback');
            const registerPassword = registerForm?.querySelector('[name=password]');
            const registerConfirm = registerForm?.querySelector('[name=password_confirm]');
            const registerUrl = '/{$Lang}/register';
            const loginUrl = '/login/password/?lang={$Lang}';

            function togglePopup(popup, show) {
                if (!popup) return;
                popup.classList.toggle('visible', show);
                if (show) {
                    const firstInput = popup.querySelector('input');
                    firstInput?.focus();
                }
            }

            function createFeedbackSetter(element) {
                return function (message, isError = false) {
                    if (!element) return;
                    element.textContent = message;
                    element.classList.toggle('error', isError);
                };
            }

            const setRegisterFeedback = createFeedbackSetter(registerFeedback);
            const setLoginFeedback = createFeedbackSetter(loginFeedback);

            registerBtn?.addEventListener('click', (event) => {
                event.preventDefault();
                togglePopup(registerPopup, true);
            });

            loginBtn?.addEventListener('click', (event) => {
                event.preventDefault();
                togglePopup(loginPopup, true);
            });

            registerClose?.addEventListener('click', () => togglePopup(registerPopup, false));
            loginClose?.addEventListener('click', () => togglePopup(loginPopup, false));
            registerPopup?.addEventListener('click', event => event.target === registerPopup && togglePopup(registerPopup, false));
            loginPopup?.addEventListener('click', event => event.target === loginPopup && togglePopup(loginPopup, false));

            registerForm?.addEventListener('submit', async (event) => {
                event.preventDefault();
                if (!registerPassword || !registerConfirm) return;
                if (registerPassword.value !== registerConfirm.value) {
                    setRegisterFeedback('Passwords do not match', true);
                    return;
                }

                const data = new FormData(registerForm);
                setRegisterFeedback('Submitting…');

                try {
                    const response = await fetch(registerUrl, {
                        method: 'POST',
                        body: data
                    });
                    const body = await response.json();
                    if (body.status === 'ok') {
                        setRegisterFeedback('Registration complete! Reloading…');
                        window.setTimeout(() => window.location.reload(), 700);
                        return;
                    }
                    setRegisterFeedback(body.message || 'Failed to register', true);
                } catch (error) {
                    setRegisterFeedback(error.message || 'Failed to register', true);
                }
            });

            loginForm?.addEventListener('submit', async (event) => {
                event.preventDefault();
                const data = new FormData(loginForm);
                data.append('ajax', '1');
                data.append('lang', '{$Lang}');
                setLoginFeedback('Submitting…');

                try {
                    const response = await fetch(loginUrl, {
                        method: 'POST',
                        body: data
                    });
                    const body = await response.json();
                    if (body.status === 'ok') {
                        setLoginFeedback('Login complete! Reloading…');
                        window.setTimeout(() => window.location.reload(), 500);
                        return;
                    }
                    setLoginFeedback(body.message || 'Login failed', true);
                } catch (error) {
                    setLoginFeedback(error.message || 'Login failed', true);
                }
            });
        })();
    </script>
</body>
</html>
