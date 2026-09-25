// Lesson assistant panel (see templates/lesson-assistant.tpl)
(function () {
    var root = document.getElementById('lesson-assistant');
    if (!root) {
        return;
    }

    var baseUrl = '/' + root.getAttribute('data-lang') + '/lesson/' + root.getAttribute('data-lesson-id');
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
    document.querySelectorAll('[data-lesson-assistant-toggle]').forEach(function (button) {
        button.addEventListener('click', function () {
            root.classList.toggle('open');
            if (root.classList.contains('open') && input && !input.disabled) {
                input.focus();
            }
        });
    });

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
        post('assistant-reset', new FormData()).then(function () {
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
        post('assistant-ask', body)
            .then(function (result) {
                if (result.ok) {
                    pending.classList.remove('la-pending');
                    // answer_html is sanitized on the server (LessonAssistant::renderAnswer)
                    pending.innerHTML = result.data.answer_html;
                    highlight(pending);
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
        return fetch(baseUrl + '/' + action, {
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

    function updateQuota(quota) {
        root.querySelectorAll('.la-percent').forEach(function (percent) {
            percent.textContent = quota.percent_used;
        });
        var meter = root.querySelector('.la-meter > div');
        if (meter) {
            meter.style.width = quota.percent_used + '%';
        }
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
