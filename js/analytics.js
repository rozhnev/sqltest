(function () {
    if (window.__sqltestAnalyticsLoaderInitialized) {
        return;
    }
    window.__sqltestAnalyticsLoaderInitialized = true;

    const scriptPromises = {};

    function loadExternalScriptOnce(src) {
        if (scriptPromises[src]) {
            return scriptPromises[src];
        }

        scriptPromises[src] = new Promise((resolve, reject) => {
            const existingScript = document.querySelector(`script[src="${src}"]`);
            if (existingScript) {
                if (existingScript.dataset.loaded === 'true') {
                    resolve();
                    return;
                }

                existingScript.addEventListener('load', () => resolve(), { once: true });
                existingScript.addEventListener('error', () => reject(new Error(`Failed to load script: ${src}`)), { once: true });
                return;
            }

            const script = document.createElement('script');
            script.src = src;
            script.async = true;
            script.onload = () => {
                script.dataset.loaded = 'true';
                resolve();
            };
            script.onerror = () => reject(new Error(`Failed to load script: ${src}`));
            document.head.appendChild(script);
        });

        return scriptPromises[src];
    }

    function runWhenBrowserIdle(callback, timeout) {
        if ('requestIdleCallback' in window) {
            window.requestIdleCallback(callback, { timeout });
            return;
        }

        window.setTimeout(callback, 1500);
    }

    function initGoogleTagManager(googleTagManagerId) {
        if (!googleTagManagerId || window.__sqltestGtmInitialized) {
            return;
        }

        window.__sqltestGtmInitialized = true;
        window.dataLayer = window.dataLayer || [];
        window.gtag = window.gtag || function () {
            window.dataLayer.push(arguments);
        };
        window.gtag('js', new Date());
        window.gtag('config', googleTagManagerId);

        loadExternalScriptOnce(`https://www.googletagmanager.com/gtag/js?id=${encodeURIComponent(googleTagManagerId)}`)
            .catch((error) => console.error(error));
    }

    function initYandexMetrika(yandexMetrikaId) {
        if (!yandexMetrikaId || window.__sqltestMetrikaInitialized) {
            return;
        }

        window.__sqltestMetrikaInitialized = true;
        window.ym = window.ym || function () {
            (window.ym.a = window.ym.a || []).push(arguments);
        };
        window.ym.l = Date.now();
        window.ym(yandexMetrikaId, 'init', {
            clickmap: true,
            trackLinks: true,
            accurateTrackBounce: true,
            webvisor: false,
            trackHash: false
        });

        loadExternalScriptOnce('https://mc.yandex.ru/metrika/tag.js')
            .catch((error) => console.error(error));
    }

    function initAnalytics() {
        const googleTagManagerId = window.AppConfig?.googleTagManagerId || '';
        const yandexMetrikaId = window.AppConfig?.yandexMetrikaId || '';

        initGoogleTagManager(googleTagManagerId);
        initYandexMetrika(yandexMetrikaId);
    }

    function scheduleAnalyticsInit() {
        runWhenBrowserIdle(initAnalytics, 2500);
    }

    if (document.readyState === 'complete') {
        scheduleAnalyticsInit();
        return;
    }

    window.addEventListener('load', scheduleAnalyticsInit, { once: true });
})();