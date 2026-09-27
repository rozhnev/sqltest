<style>
    /* Interview dialog: interviewer on the left, candidate on the right. Shared by the
       self-presentation and question screens. Theme variables only -- the site's light
       theme sets --regular-text-color to white. */
    .interview-dialog { display: flex; flex-direction: column; gap: 1.25rem; }
    .dialog-row { display: flex; align-items: flex-start; gap: 0.9rem; }
    .dialog-row.candidate { flex-direction: row-reverse; }
    .dialog-avatar { flex: 0 0 auto; width: 56px; height: 56px; border-radius: 50%; object-fit: cover; }
    .dialog-avatar.candidate-avatar {
        display: flex; align-items: center; justify-content: center;
        background: var(--blue-btn-background); color: white; font-weight: 700; font-size: 0.9rem;
    }
    .dialog-message { flex: 1 1 auto; min-width: 0; max-width: 85%; }
    .dialog-row.candidate .dialog-message { display: flex; flex-direction: column; align-items: flex-end; }
    .dialog-author { font-size: 0.85rem; color: var(--question-date-color); margin: 0 0 0.3rem; }
    .dialog-bubble {
        position: relative; box-sizing: border-box; padding: 0.9rem 1.1rem; border-radius: 4px 16px 16px 16px;
        background: var(--text-block-background-color); border: 1px solid var(--text-block-border-color);
        color: var(--question-text); line-height: 1.55; text-align: left;
    }
    .dialog-bubble p { margin: 0 0 0.6rem; }
    .dialog-bubble p:last-child { margin-bottom: 0; }
    .dialog-row.candidate .dialog-bubble {
        border-radius: 16px 4px 16px 16px; width: 100%;
        background: rgba(0, 87, 204, 0.08); border-color: rgba(0, 87, 204, 0.35);
    }
    .dialog-bubble .pre-wrap { white-space: pre-wrap; }
    .dialog-bubble textarea {
        width: 100%; min-height: 170px; box-sizing: border-box; padding: 0.75rem; margin: 0;
        border-radius: 10px; border: 1px solid var(--text-block-border-color); font: inherit; resize: vertical;
        background: var(--text-block-background-color); color: var(--question-text);
    }
    .dialog-actions { display: flex; justify-content: flex-end; margin-top: 0.75rem; }
    /* .dialog-row sets display:flex, which would otherwise override the hidden attribute. */
    .dialog-row[hidden] { display: none; }

    /* "The interviewer is typing" indicator shown while the LLM reply is being prepared. */
    .typing-dots { display: inline-flex; gap: 0.3rem; align-items: center; height: 1.2em; }
    .typing-dots span {
        width: 0.5rem; height: 0.5rem; border-radius: 50%; background: var(--question-date-color);
        animation: typing-dot 1.2s infinite ease-in-out;
    }
    .typing-dots span:nth-child(2) { animation-delay: 0.2s; }
    .typing-dots span:nth-child(3) { animation-delay: 0.4s; }
    @keyframes typing-dot {
        0%, 60%, 100% { opacity: 0.3; transform: translateY(0); }
        30% { opacity: 1; transform: translateY(-0.25rem); }
    }
    @media (prefers-reduced-motion: reduce) {
        .typing-dots span { animation: none; opacity: 0.6; }
    }

    @media (max-width: 640px) {
        .dialog-avatar { width: 40px; height: 40px; }
        .dialog-message { max-width: none; }
    }
</style>
