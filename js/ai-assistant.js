// AI assistant chat panel (see templates/ai-assistant.tpl), used on the lesson page and the playground.
// Page hooks (optional):
//   window.aiAssistantContext() - returns extra fields posted with each question
//   window.aiAssistantInsert(sql) - inserts SQL into the page's editor; enables "Insert" on code blocks
(function () {
    var root = document.querySelector('.ai-assistant');
    if (!root) {
        return;
    }

    var baseUrl = root.getAttribute('data-endpoint');
    var logged = root.getAttribute('data-logged') === '1';
    var messages = root.querySelector('.la-messages');
    var notice = root.querySelector('.la-notice');
    var form = root.querySelector('.la-form');
    var input = root.querySelector('.la-input');
    var sendButton = root.querySelector('.la-send');
    var resetButton = root.querySelector('.la-reset');
    var exhaustedMessage = root.querySelector('.la-exhausted-message');
    var busy = false;

    // Mobile: floating button and close button open/close the bottom sheet
    document.querySelectorAll('[data-ai-assistant-toggle]').forEach(function (button) {
        button.addEventListener('click', function () {
            root.classList.toggle('open');
            if (root.classList.contains('open') && input && !input.disabled) {
                input.focus();
            }
        });
    });

    // Example questions and quick actions fill the question box
    root.querySelectorAll('.la-example').forEach(function (button) {
        button.addEventListener('click', function () {
            if (!logged) {
                toggleLoginWindow();
                return;
            }
            if (input && !input.disabled) {
                input.value = button.getAttribute('data-question');
                input.focus();
            }
        });
    });

    messages.querySelectorAll('.la-assistant').forEach(addCodeActions);

    if (!form) {
        return;
    }

    scrollToBottom();

    form.addEventListener('submit', function (event) {
        event.preventDefault();
        ask();
    });

    // Enter sends, Shift+Enter adds a new line
    input.addEventListener('keydown', function (event) {
        if (event.key === 'Enter' && !event.shiftKey && !event.isComposing) {
            event.preventDefault();
            ask();
        }
    });

    resetButton.addEventListener('click', function () {
        if (busy) {
            return;
        }
        post('reset', new FormData()).then(function () {
            messages.querySelectorAll('.la-message').forEach(function (message) {
                message.remove();
            });
            hideNotice();
        });
    });

    function ask() {
        var question = input.value.trim();
        if (busy || question === '' || input.disabled) {
            return;
        }
        setBusy(true);
        hideNotice();

        var intro = messages.querySelector('.la-intro');
        if (intro) {
            intro.remove();
        }
        addMessage('user').textContent = question;
        var pending = addMessage('assistant la-pending');
        pending.innerHTML = '<div class="loader">…</div>';
        input.value = '';

        var body = new FormData();
        body.append('question', question);
        if (typeof window.aiAssistantContext === 'function') {
            var context = window.aiAssistantContext() || {};
            Object.keys(context).forEach(function (name) {
                body.append(name, context[name]);
            });
        }
        post('ask', body)
            .then(function (result) {
                if (result.ok) {
                    pending.classList.remove('la-pending');
                    // answer_html is sanitized on the server (AiAssistant::renderAnswer)
                    pending.innerHTML = result.data.answer_html;
                    highlight(pending);
                    addCodeActions(pending);
                } else {
                    pending.remove();
                    // Restore the question so it isn't lost
                    input.value = question;
                    showNotice(result.data.message || 'Something went wrong. Please try again.');
                }
                if (result.data.quota) {
                    updateQuota(result.data.quota);
                }
            })
            .catch(function () {
                pending.remove();
                input.value = question;
                showNotice('Something went wrong. Please try again.');
            })
            .finally(function () {
                setBusy(false);
                scrollToBottom();
            });
        scrollToBottom();
    }

    function post(action, body) {
        return fetch(baseUrl + '-' + action, {
            method: 'POST',
            credentials: 'same-origin',
            headers: { Accept: 'application/json' },
            body: body
        }).then(function (response) {
            return response.json().then(function (data) {
                return { ok: response.ok, data: data };
            });
        });
    }

    function addMessage(role) {
        var message = document.createElement('div');
        message.className = 'la-message la-' + role;
        messages.appendChild(message);
        return message;
    }

    // "Copy" and, when the page has an editor, "Insert" buttons under each code block of an answer
    function addCodeActions(message) {
        message.querySelectorAll('pre').forEach(function (pre) {
            var code = pre.querySelector('code') || pre;
            var actions = document.createElement('div');
            actions.className = 'la-code-actions';

            var copyLabel = root.getAttribute('data-copy-label') || 'Copy';
            var copy = actionButton(copyLabel, function () {
                if (navigator.clipboard) {
                    navigator.clipboard.writeText(code.textContent).then(function () {
                        copy.textContent = root.getAttribute('data-copied-label') || 'Copied';
                        setTimeout(function () { copy.textContent = copyLabel; }, 1500);
                    });
                }
            });
            actions.appendChild(copy);

            if (typeof window.aiAssistantInsert === 'function') {
                actions.appendChild(actionButton(root.getAttribute('data-insert-label') || 'Insert', function () {
                    window.aiAssistantInsert(code.textContent);
                    root.classList.remove('open');
                }));
            }
            pre.insertAdjacentElement('afterend', actions);
        });
    }

    function actionButton(label, onClick) {
        var button = document.createElement('button');
        button.type = 'button';
        button.className = 'la-code-action text-button';
        button.textContent = label;
        button.addEventListener('click', onClick);
        return button;
    }

    function updateQuota(quota) {
        root.querySelectorAll('.la-remaining').forEach(function (remaining) {
            remaining.textContent = quota.remaining_text;
        });
        if (quota.exhausted) {
            input.disabled = true;
            sendButton.disabled = true;
            if (notice.classList.contains('hidden') && exhaustedMessage) {
                showNotice(exhaustedMessage.innerHTML);
            }
        }
    }

    function setBusy(value) {
        busy = value;
        sendButton.disabled = value || input.disabled;
        resetButton.disabled = value;
    }

    // Messages come from the server's translations, not from user input
    function showNotice(html) {
        notice.innerHTML = html;
        notice.classList.remove('hidden');
    }

    function hideNotice() {
        if (!input.disabled) {
            notice.classList.add('hidden');
            notice.innerHTML = '';
        }
    }

    function highlight(element) {
        if (typeof SQLHighlighter === 'undefined') {
            return;
        }
        element.querySelectorAll('pre code').forEach(function (code) {
            SQLHighlighter.highlightCode(code);
        });
    }

    function scrollToBottom() {
        messages.scrollTop = messages.scrollHeight;
    }
})();
