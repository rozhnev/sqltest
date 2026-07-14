<div style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: center; justify-content: center;">
    <a class="button blue" target="_blank" rel="noopener noreferrer" href="https://www.linkedin.com/sharing/share-offsite/?url={$AchievementShareUrl|escape:'url'}">
        <span style="display: inline-flex; align-items: center; gap: 6px;">
            <svg width="16" height="16" viewBox="0 0 24 24" aria-hidden="true" focusable="false" fill="currentColor"><path d="M5.5 7.5h-3V18.5h3V7.5zM4 5.5C3.17 5.5 2.5 6.2 2.5 7c0 .81.67 1.5 1.5 1.5S5.5 7.81 5.5 7c0-.81-.67-1.5-1.5-1.5zM9.5 18.5h3V13c0-.81.06-1.84 1.25-1.84 1.21 0 1.23 1.05 1.23 1.9v5.44h3V12c0-3.07-1.63-4.25-3.26-4.25-1.5 0-2.18.78-2.56 1.33h.04V7.5h-3c.04 1.06 0 11 0 11z"/></svg>
            <span>{translate}share_to_linkedin{/translate}</span>
        </span>
    </a>
    <a class="button" target="_blank" rel="noopener noreferrer" style="background:#000000; border-color:#000000;" href="https://twitter.com/intent/tweet?url={$AchievementShareUrl|escape:'url'}">
        <span style="display: inline-flex; align-items: center; gap: 6px;">
            <svg width="16" height="16" viewBox="0 0 24 24" aria-hidden="true" focusable="false" fill="currentColor"><path d="M18.9 2H22l-6.95 7.94L23.2 22h-6.9l-5.4-6.63L4.5 22H1.4l7.44-8.5L.8 2h7.06l4.9 6.02L18.9 2Zm-1.2 18h1.72L7.14 3.97H5.3L17.7 20Z"/></svg>
            <span>{translate}share_to_x{/translate}</span>
        </span>
    </a>
    <a class="button" target="_blank" rel="noopener noreferrer" style="background:#1877F2; border-color:#1877F2;" href="https://www.facebook.com/sharer/sharer.php?u={$AchievementShareUrl|escape:'url'}">
        <span style="display: inline-flex; align-items: center; gap: 6px;">
            <svg width="16" height="16" viewBox="0 0 24 24" aria-hidden="true" focusable="false" fill="currentColor"><path d="M19 2.5H5C3.62 2.5 2.5 3.62 2.5 5v14c0 1.38 1.12 2.5 2.5 2.5h7V14.5h-2v-3h2V9c0-2 1.2-3 3-3 .86 0 1.14.06 1.34.09v2.52h-1.5c-1.17 0-1.4.56-1.4 1.38v1.78h2.8l-.37 3h-2.43V22h4.77c1.38 0 2.5-1.12 2.5-2.5V5C21.5 3.62 20.38 2.5 19 2.5Z"/></svg>
            <span>{translate}share_to_facebook{/translate}</span>
        </span>
    </a>
    <a class="button" target="_blank" rel="noopener noreferrer" style="background:#2AABEE; border-color:#2AABEE;" href="https://telegram.me/share/url?url={$AchievementShareUrl|escape:'url'}">
        <span style="display: inline-flex; align-items: center; gap: 6px;">
            <svg width="16" height="16" viewBox="0 0 24 24" aria-hidden="true" focusable="false" fill="currentColor"><path d="M9.04 15.88 8.9 19.9c.58 0 .83-.25 1.14-.56l2.77-2.65 5.75 4.2c1.05.58 1.79.28 2.07-.97L24 2.1h.01c.34-1.55-.56-2.16-1.58-1.8L1.2 9.94c-1.5.59-1.48 1.43-.25 1.82l5.86 1.83L19.4 4.5c.55-.37 1.05-.17.64.2L9.04 15.88Z"/></svg>
            <span>{translate}share_to_telegram{/translate}</span>
        </span>
    </a>
</div>