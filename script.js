
let windowObjectReference = null; // global variable
const externalScriptPromises = {};

function loadExternalScriptOnce(src) {
    if (externalScriptPromises[src]) {
        return externalScriptPromises[src];
    }

    externalScriptPromises[src] = new Promise((resolve, reject) => {
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

    return externalScriptPromises[src];
}

function runWhenBrowserIdle(callback, timeout = 2000) {
    if ('requestIdleCallback' in window) {
        window.requestIdleCallback(callback, { timeout });
        return;
    }

    window.setTimeout(callback, 1500);
}
function lazyInitShareThis() {
    if (!document.querySelector('.sharethis-inline-share-buttons')) {
        return;
    }

    const loadShareThis = () => {
        runWhenBrowserIdle(() => {
            loadExternalScriptOnce('https://platform-api.sharethis.com/js/sharethis.js#property=685bb6a18ca9160019f294e2&product=sop')
                .catch(error => console.error(error));
        });
    };

    if (document.readyState === 'complete') {
        loadShareThis();
        return;
    }

    window.addEventListener('load', loadShareThis, { once: true });
}

function openRequestedTab(href) {
    if (windowObjectReference === null || windowObjectReference.closed) {
        // const url = `${href}_${window.UIConfig.theme === 'dark' ?  'dark' : 'light'}.png`;
        const url = `${href}?theme=${window.UIConfig.theme === 'dark' ? 'dark' : 'light'}`;
        const popUpParams = `scrollbars=no,resizable=yes,status=no,location=no,toolbar=no,menubar=no,width=0,height=0,left=-1000,top=-1000`;
        windowObjectReference = window.open(url, 'Sakila DB ER Diagram', popUpParams);
    } else {
        windowObjectReference.focus();
    }
}

function switchTheme(e) {
    const currentTheme = e.target.checked ?  'dark' : 'light';
    if (window.sql_editor) {
        window.sql_editor.setTheme(getAceTheme(currentTheme));
    }
    document.documentElement.setAttribute('data-theme', currentTheme);
    window.UIConfig.theme = currentTheme;
    saveUIConfig();
}

function getAceTheme(theme) {
    return theme === 'dark' ? 'ace/theme/github_dark' : 'ace/theme/xcode';
}

function formatCode() {
    const beautify = ace.require("ace/ext/beautify");
    const editor_session = window.sql_editor.session;
    beautify.beautify(editor_session);
}
function setLoader(id) {
    return document.getElementById(id).innerHTML = '<div class="loader">Loading...</div>';
}

function showToast(state, msg) {
    const toast = document.getElementById("toast");
    if (state !== "error") {
        toast.classList.remove("error");
        state = "info";
    }
    toast.innerText = msg || "...";
    toast.classList.remove("info");
    toast.classList.add(state);
    toast.classList.toggle("visible");
    const showTime = state === "error" ? 5000 : 2000;
    setTimeout((function() {
        toast.classList.toggle("visible");
    }
    ), showTime)
}
function loadMenu(questionnire) {
    fetch(`/${lang}/menu?questionnire=${questionnire}`, {
        method: "GET",
        mode: "cors",
        cache: "default",
        credentials: "same-origin",
    })
    .then((async response=>{
        if (!response.ok) throw Error('Something went wrong.');
        return await response.text();
    }))
    .then((message)=>{
        // The response is the whole <nav id="menu">: replace the element, don't nest it
        const menu = document.getElementById('menu');
        menu.insertAdjacentHTML('afterend', message);
        menu.remove();
        menuGroupsRequest = null;
        window.UIConfig.questionnire = questionnire;
        saveUIConfig();
        setMenuEventListeners(document.getElementById('menu'));
    })
    .catch(err=>{
        console.log(err)
    });;
}
function copyCode(msg) {
    const editor = window.sql_editor;
    navigator.clipboard && navigator.clipboard.writeText(editor.getValue()),
    showToast('info', msg)
}

function clearEditor() {
    const editor = window.sql_editor;
    editor.setValue('');
    editor.focus();
    editor.session.selection.clearSelection();
}

function clearFreeAnswer() {
    stopVoiceInput();
    const textarea = document.getElementById('free-answer-input');
    if (!textarea) return;
    textarea.value = '';
    textarea.focus();
}

function toggleLoginWindow() {
    const popup = document.getElementById('login-menu');
    popup.classList.toggle("hidden");
    // const loginWindow = document.getElementById("login-popup");
    // setTimeout((function() {
    //     loginWindow.classList.toggle("visible");
    // }
    // ), 333)
}

function toggleMobileMenu() {
    const dropdown = document.getElementById('mobileMenuDropdown');
    dropdown.classList.toggle("hidden");
}

/**
 * User menu in the top menu (#userMenuBtn, top-menu.tpl / m.top-menu.tpl): opens the profile and achievements popup.
 * Clicks inside the popup don't close it; the button, Esc or a click outside do.
 */
function toggleAchievements(lang) {
    const popup = document.getElementById('achievements-popup');
    const button = document.getElementById('userMenuBtn');

    if (!popup.classList.contains('hidden')) {
        closeAchievements();
        return;
    }
    popup.classList.remove('hidden');
    button?.setAttribute('aria-expanded', 'true');
    document.addEventListener('click', closeAchievementsOutside, true);
    document.addEventListener('keydown', closeAchievementsOnEscape);

    setLoader('achievements-popup');
    // Load achievements when opening popup
    fetch(`/${lang}/user/achievements`)
        .then((async response=>{
            if (!response.ok) throw Error('Something went wrong.');
            return await response.text();
        }))
        .then((message)=>{
            popup.innerHTML = message;
        })
        .catch(error => {
            popup.innerHTML = '<p>Something went wrong.</p>';
        });
}

function closeAchievements() {
    document.getElementById('achievements-popup')?.classList.add('hidden');
    document.getElementById('userMenuBtn')?.setAttribute('aria-expanded', 'false');
    document.removeEventListener('click', closeAchievementsOutside, true);
    document.removeEventListener('keydown', closeAchievementsOnEscape);
}

function closeAchievementsOutside(event) {
    const popup = document.getElementById('achievements-popup');
    const button = document.getElementById('userMenuBtn');
    if (!popup.contains(event.target) && !button?.contains(event.target)) {
        closeAchievements();
    }
}

function closeAchievementsOnEscape(event) {
    if (event.key === 'Escape') {
        closeAchievements();
        document.getElementById('userMenuBtn')?.focus();
    }
}
function jsonToTable(jsonObject) {
    let htmlTable = '';
    let rn = 0;
    try {
        htmlTable = "<table class='result-table'><tr><th></th><th>" + jsonObject.headers.map(h=>h.header).join('</th><th>') + "</th></tr>";
        for (let r of jsonObject.data) {
            htmlTable += "<tr><td>" + (++rn) +"</td><td>" + r.map(el=>el === null ? '[null]' : el).join('</td><td>') + "</td></tr>";
        }
        htmlTable += "</table>";
    } catch(e) {
        htmlTable = 'Something went wrong. Please review your query and try again.'
    }
    return htmlTable;
}

function errorToTable(jsonObject) {
    const error = document.createElement('span');
    error.className = 'sql_error';
    error.textContent = jsonObject.error;
    return error.outerHTML;
}

// SQL errors under the editor (runQuery, testQuery, the playground's executeQuery): where the error is, marked
// in the message and in the editor, and the "Explain the error" AI button: on task pages it calls
// Controller::explain_error (data-explain-url), in the playground it asks the playground AI chat
// (data-explain-question). Both are paid from the AI tokens.
// Settings and labels come from the data-* attributes of #code-result (index.tpl, m.index.tpl, playground templates).

/**
 * Where an engine's error message points in the query: {row, column, length} (0-based), or null.
 * Formats: PostgreSQL/DuckDB "LINE 2: ... ^", Firebird "line 2, column 10", MySQL "near '...' at line 2",
 * otherwise the first quoted name ('foo', "foo", no such table: foo) searched in the query.
 */
function sqlErrorLocation(error, sql) {
    const lines = sql.replace(/\r\n?/g, '\n').split('\n');
    const wordAt = (row, column) => {
        const match = (lines[row] || '').slice(column).match(/^[\w$.]+|^\S/);
        return match ? match[0].length : 1;
    };
    const at = (row, column) => (row >= 0 && row < lines.length && column >= 0 && column <= lines[row].length)
        ? {row, column, length: wordAt(row, column)}
        : null;
    const find = (text, row) => {
        if (!text) return null;
        const escaped = text.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
        const pattern = new RegExp((/^\w/.test(text) ? '(^|[^\\w$])' : '()') + '(' + escaped + ')' + (/\w$/.test(text) ? '(?![\\w$])' : ''), 'i');
        const rows = row === undefined ? lines.map((_, i) => i) : [row];
        for (const r of rows) {
            const match = (lines[r] || '').match(pattern);
            if (match) return {row: r, column: match.index + match[1].length, length: text.length};
        }
        return null;
    };

    let match = error.match(/LINE (\d+): ([^\n]*)\n( *)\^/);
    if (match) {
        const row = parseInt(match[1]) - 1;
        let column = match[3].length - ('LINE ' + match[1] + ': ').length;
        // A long line is shown cut: "...fragment..."; find the fragment in the line
        if (match[2].startsWith('...')) {
            const fragment = match[2].slice(3).replace(/\.\.\.$/, '');
            const offset = (lines[row] || '').indexOf(fragment);
            column = offset < 0 ? -1 : offset + column - 3;
        }
        const location = at(row, column);
        if (location) return location;
    }
    match = error.match(/line (\d+), column (\d+)/i);
    if (match) {
        const location = at(parseInt(match[1]) - 1, parseInt(match[2]) - 1);
        if (location) return location;
    }
    match = error.match(/near '([\s\S]*)' at line (\d+)/);
    if (match) {
        const row = parseInt(match[2]) - 1;
        const fragment = match[1].split('\n')[0].trim();
        if (fragment === '') {
            // Unexpected end of the query: mark its last word
            const lastRow = Math.min(row, lines.length - 1);
            const lastWord = lastRow >= 0 ? lines[lastRow].match(/[\w$.]+\s*$|\S\s*$/) : null;
            return lastWord ? at(lastRow, lastWord.index) : null;
        }
        const location = find(fragment, row) || find(fragment);
        if (location) return {...location, length: wordAt(location.row, location.column)};
    }
    match = error.match(/['"`]([^'"`\n]{1,64})['"`]|no such (?:table|column): ([\w$.]+)/);
    if (match) {
        const name = match[1] || match[2];
        return find(name) || find(name.split('.').pop());
    }
    return null;
}

function clearSqlErrorMarker() {
    const marker = window.sqlErrorMarker;
    if (marker && window.sql_editor) {
        window.sql_editor.session.removeMarker(marker.id);
        window.sql_editor.session.removeGutterDecoration(marker.row, 'sql-error-gutter');
    }
    window.sqlErrorMarker = null;
}

function markSqlErrorInEditor(location) {
    clearSqlErrorMarker();
    if (!window.sql_editor) return;
    const Range = ace.require('ace/range').Range;
    const session = window.sql_editor.session;
    window.sqlErrorMarker = {
        id: session.addMarker(new Range(location.row, location.column, location.row, location.column + location.length), 'sql-error-marker', 'text'),
        row: location.row
    };
    session.addGutterDecoration(location.row, 'sql-error-gutter');
    // Remove the mark once the query is edited
    session.once('change', clearSqlErrorMarker);
}

/**
 * Adds the location and the AI button to each .sql_error in container
 *
 * @param {HTMLElement} container #code-result
 * @param {string} sql The query that produced the result
 */
function enhanceSqlErrors(container, sql) {
    const settings = document.getElementById('code-result')?.dataset || {};
    container.querySelectorAll('.sql_error').forEach(errorElement => {
        const error = errorElement.textContent;
        const location = sqlErrorLocation(error, sql);
        const tools = document.createElement('div');
        tools.className = 'sql-error-tools';

        if (location) {
            markSqlErrorInEditor(location);
            const goTo = document.createElement('button');
            goTo.type = 'button';
            goTo.className = 'text-button blue sql-error-goto';
            goTo.title = settings.gotoLabel || '';
            goTo.textContent = (settings.locationLabel || 'Line {line}, column {column}')
                .replace('{line}', location.row + 1)
                .replace('{column}', location.column + 1);
            goTo.addEventListener('click', () => {
                if (!window.sql_editor) return;
                window.sql_editor.selection.setRange(new (ace.require('ace/range').Range)(location.row, location.column, location.row, location.column + location.length));
                window.sql_editor.scrollToLine(location.row, true, true);
                window.sql_editor.focus();
            });
            tools.appendChild(goTo);
        }

        const chatMode = settings.explainQuestion && typeof window.aiAssistantAsk === 'function';
        if (!chatMode && !settings.explainUrl) {
            errorElement.after(tools);
            return;
        }
        const explain = sqlErrorExplainButton(settings);
        tools.appendChild(explain);
        const answer = document.createElement('div');
        answer.className = 'sql-error-explanation hidden';
        errorElement.after(tools, answer);

        explain.addEventListener('click', () => {
            if (settings.logged !== '1') {
                showSqlErrorLoginPrompt(settings, answer, sql);
            } else if (chatMode) {
                // Playground: the question goes to its AI chat panel (js/ai-assistant.js), which sees the error itself
                window.aiAssistantAsk(settings.explainQuestion);
            } else {
                explainSqlError(settings, explain, answer, sql, error);
            }
        });

        // Back from the login started by the guest prompt: point at the button
        if (window.sqlErrorExplainResumed) {
            window.sqlErrorExplainResumed = false;
            explain.scrollIntoView({block: 'center', behavior: 'smooth'});
            explain.classList.add('ai-attention');
        }
    });
}

// Guests: say why the AI needs an account, right under the error, with a button that opens the login menu.
// The query is kept in sessionStorage, so after the login (the page reloads) it is run again.
const SQL_ERROR_EXPLAIN_PENDING = 'sqlErrorExplainPending';

function showSqlErrorLoginPrompt(settings, container, sql) {
    container.classList.remove('hidden');
    if (container.querySelector('.sql-error-login')) return;
    const prompt = document.createElement('div');
    prompt.className = 'sql-error-login';
    const text = document.createElement('p');
    text.textContent = settings.loginText;
    const button = document.createElement('button');
    button.type = 'button';
    button.className = 'button green';
    button.textContent = settings.loginButton;
    button.addEventListener('click', event => {
        // Keep the document click handlers from closing the menu right away
        event.stopPropagation();
        try {
            sessionStorage.setItem(SQL_ERROR_EXPLAIN_PENDING, JSON.stringify({path: location.pathname, sql}));
        } catch (e) {}
        openLoginMenu();
    });
    prompt.append(text, button);
    container.appendChild(prompt);
}

function openLoginMenu() {
    const menu = document.getElementById('login-menu');
    if (!menu) return;
    menu.classList.remove('hidden');
    (menu.closest('header') || menu).scrollIntoView({block: 'start', behavior: 'smooth'});
    // Restart the highlight animation
    menu.classList.remove('ai-attention');
    void menu.offsetWidth;
    menu.classList.add('ai-attention');
}

// After the login: put the query back and run it, so the error and the explain button show up again
function resumeSqlErrorExplain() {
    let pending = null;
    try {
        pending = JSON.parse(sessionStorage.getItem(SQL_ERROR_EXPLAIN_PENDING) || 'null');
    } catch (e) {}
    const settings = document.getElementById('code-result')?.dataset;
    if (!pending || !settings || settings.logged !== '1' || !window.sql_editor) return;
    try {
        sessionStorage.removeItem(SQL_ERROR_EXPLAIN_PENDING);
    } catch (e) {}
    if (pending.path !== location.pathname || !pending.sql) return;

    window.sql_editor.setValue(pending.sql, 1);
    window.sqlErrorExplainResumed = true;
    if (typeof executeQuery === 'function') {
        executeQuery();
    } else if (questionId && questionId !== 'null') {
        runQuery(lang, questionId);
    }
}
// After the playground's own editor setup on DOMContentLoaded (shared snippets)
window.addEventListener('load', () => setTimeout(resumeSqlErrorExplain, 300));

function sqlErrorExplainButton(settings) {
    const button = document.createElement('button');
    button.type = 'button';
    button.className = 'text-button blue sql-error-explain';
    button.title = settings.explainHint || '';
    button.textContent = '✨ ' + settings.explainLabel;
    return button;
}

function explainSqlError(settings, button, answer, sql, error) {
    if (button.disabled) return;
    const label = button.textContent;
    button.disabled = true;
    button.textContent = settings.explainLoading;
    let formData = new FormData();
    formData.append('sql', sql);
    formData.append('error', error);
    fetch(settings.explainUrl, {
        method: "POST",
        credentials: "same-origin",
        body: formData,
    })
    .then(response => response.json())
    .then(data => {
        answer.classList.remove('hidden');
        if (data.answer_html) {
            answer.innerHTML = data.answer_html;
            if (data.quota && settings.tokensLeftLabel) {
                const quota = document.createElement('div');
                quota.className = 'sql-error-quota';
                quota.textContent = settings.tokensLeftLabel + ' ' + data.quota.remaining_text;
                answer.appendChild(quota);
            }
            button.remove();
            return;
        }
        // Server messages are site translations, some with links (buy tokens, log in)
        answer.innerHTML = data.message || 'Something went wrong.';
        button.disabled = false;
        button.textContent = label;
    })
    .catch(() => {
        answer.classList.remove('hidden');
        answer.textContent = 'Something went wrong.';
        button.disabled = false;
        button.textContent = label;
    });
}

/**
 * "Get hint": the hint goes to #hint-panel (hint_panel.tpl) above the editor, so the query result stays.
 * The button toggles the panel; the hint is loaded once. Pages without the panel show it in #code-result.
 */
function getHelp(lang, questionId) {
    const panel = document.getElementById('hint-panel');
    const content = document.getElementById('hint-panel-content');
    if (panel && !panel.classList.contains('hidden')) {
        closeHint();
        return;
    }
    if (panel && content.dataset.loaded) {
        showHint(panel);
        return;
    }
    const target = panel ? content : document.getElementById('code-result');
    if (panel) {
        showHint(panel);
    }
    setLoader(target.id);
    fetch(`/${lang}/question/${questionId}/query-help`, {
          method: "GET",
          mode: "cors",
          cache: "default",
          credentials: "same-origin",
      })
      .then((async response=>{
          if (!response.ok) throw Error('Something went wrong.');
          return await response.text();
      }))
      .then((message)=>{
          target.innerHTML = message;
          if (panel) {
              content.dataset.loaded = '1';
          }
      })
      .catch(()=>{
          target.textContent = 'Something went wrong. Please try again.';
      });
}

function showHint(panel) {
    panel.classList.remove('hidden');
    document.getElementById('getHelpBtn')?.setAttribute('aria-expanded', 'true');
    panel.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
}

function closeHint() {
    document.getElementById('hint-panel')?.classList.add('hidden');
    document.getElementById('getHelpBtn')?.setAttribute('aria-expanded', 'false');
}

function runQuery(lang, questionId) {
  setLoader('code-result');
  clearSqlErrorMarker();
  const sql = window.sql_editor.getValue();
  let formData = new FormData();
  formData.append('query', sql);
  fetch(`/${lang}/question/${questionId}/query-run`, {
      method: "POST",
      mode: "cors",
      cache: "default",
      credentials: "same-origin",
      body: formData,
  })
  .then((async response=>{
      if (!response.ok) throw Error('Something went wrong.');
      return await response.text();
  }))
  .then(JSON.parse)
  .then((JSONmessage)=>{
      let html = '✓ (Done)';
      if (JSONmessage && JSONmessage[0]) {
          const jsonObject = JSONmessage[0];
          html = jsonObject.error 
            ? errorToTable(jsonObject) 
            : jsonToTable(jsonObject);
      }
      document.getElementById('code-result').innerHTML = html;
      enhanceSqlErrors(document.getElementById('code-result'), sql);
  })
  .catch(err=>{
    document.getElementById('code-result').innerHTML = 'Something went wrong. Please review your query and try again or contact us by email: <a href="mailto:support@sqltest.online">support@sqltest.online</a>.';
  });
}
function checkAnswers(lang, questionId) {
    setLoader('code-result');
    const answers = [...document.querySelectorAll('input[name=answers]:checked')]
        .reduce(
            (res, el)=>{res.push(parseInt(el.value)); return res;}, 
            []
        )
        .toSorted();

    let formData = new FormData();
    formData.append('answers', JSON.stringify(answers));
    fetch(`/${lang}/question/${questionId}/check-answers`, {
        method: "POST",
        mode: "cors",
        cache: "default",
        credentials: "same-origin",
        body: formData,
    })
    .then((async response=>{
        if (response.ok) {
        if (response.ok) {
            showSolvedProgress(response);
        }
        if (response.ok && document.getElementById("nextTaskBtn")) {
            document.getElementById("nextTaskBtn").classList.remove("hidden");
            setTimeout(()=>{
                document.getElementById("main3").scrollTo({
                    top: document.getElementById("nextTaskBtn").offsetTop,
                    behavior: "smooth" 
                })
            }, 300)
        }
        }
        return await response.text();
    }))
    .then((message)=>{
        document.getElementById('code-result').innerHTML = message;
        placeNewAchievement(document.getElementById('code-result'));
    })
    .catch(err=>{
        document.getElementById('code-result').innerHTML = 'Something went wrong. Please review your query and try again or contact us by email: <a href="mailto:support@sqltest.online">support@sqltest.online</a>.';
    });
}
function checkFreeAnswer(lang, questionId) {
    // One check at a time: each check is paid from the AI token balance
    const checkBtn = document.getElementById('checkFreeAnswerBtn');
    if (checkBtn?.disabled) {
        return;
    }
    if (checkBtn) {
        checkBtn.disabled = true;
    }
    setLoader('code-result');
    let formData = new FormData();
    formData.append('answer', document.getElementById('free-answer-input').value);
    fetch(`/${lang}/question/${questionId}/check-free-answer`, {
        method: "POST",
        mode: "cors",
        cache: "default",
        credentials: "same-origin",
        body: formData,
    })
    .then((async response=>{
        // The check is paid from the AI token balance: refresh the counter and the buy button
        const remaining = response.headers.get('X-AI-Tokens-Remaining');
        if (remaining !== null && document.getElementById('free-answer-tokens-remaining')) {
            document.getElementById('free-answer-tokens-remaining').textContent = decodeURIComponent(remaining);
            document.getElementById('buyTokensBtn')?.classList.toggle('hidden', response.headers.get('X-AI-Tokens-Low') !== '1');
        }
        if (response.ok) {
            showSolvedProgress(response);
        }
        if (response.ok && document.getElementById("nextTaskBtn")) {
            document.getElementById("nextTaskBtn").classList.remove("hidden");
            setTimeout(()=>{
                if (document.getElementById("main3")) {
                    document.getElementById("main3").scrollTo({
                        top: document.getElementById("nextTaskBtn").offsetTop,
                        behavior: "smooth"
                    })
                } else {
                    window.scrollTo({
                        top: document.getElementById("db-description").offsetTop - window.outerHeight,
                        behavior: "smooth"
                    })
                }
            }, 300)
        }
        return await response.text();
    }))
    .then((message)=>{
        document.getElementById('code-result').innerHTML = message;
        placeNewAchievement(document.getElementById('code-result'));
    })
    .catch(err=>{
        document.getElementById('code-result').innerHTML = 'Something went wrong. Please review your answer and try again or contact us by email: <a href="mailto:support@sqltest.online">support@sqltest.online</a>.';
    })
    .finally(()=>{
        if (checkBtn) {
            checkBtn.disabled = false;
        }
    });
}
// Maps site interface language codes to BCP-47 locale tags the Web Speech API expects.
const VOICE_INPUT_LANG_MAP = {
    en: 'en-US',
    ru: 'ru-RU',
    pt: 'pt-BR',
    fr: 'fr-FR',
    zh: 'zh-CN',
};

let voiceRecognition = null;
let voiceInputActive = false;

function getSpeechRecognitionClass() {
    return window.SpeechRecognition || window.webkitSpeechRecognition || null;
}

function toggleVoiceInput(lang) {
    if (voiceInputActive) {
        stopVoiceInput();
        return;
    }
    const SpeechRecognitionClass = getSpeechRecognitionClass();
    if (!SpeechRecognitionClass) {
        showToast('error', 'Voice input is not supported in this browser.');
        return;
    }
    startVoiceInput(SpeechRecognitionClass, lang);
}

function startVoiceInput(SpeechRecognitionClass, lang) {
    const textarea = document.getElementById('free-answer-input');
    const btn = document.getElementById('voiceInputBtn');
    if (!textarea) return;

    voiceRecognition = new SpeechRecognitionClass();
    voiceRecognition.lang = VOICE_INPUT_LANG_MAP[lang] || 'en-US';
    // continuous:true is unreliable on mobile Chrome — it can re-emit already-finalized
    // results, duplicating whatever was just spoken. Instead we recognize one utterance
    // at a time and auto-restart in onend, which behaves consistently on desktop and mobile.
    voiceRecognition.continuous = false;
    voiceRecognition.interimResults = true;

    // Recognized speech is appended after whatever was already in the textarea
    // (typed text or a previously saved answer) rather than overwriting it. Each
    // finished utterance gets folded into this once it's final, before the next
    // utterance's (fresh, zero-indexed) results start arriving.
    let baseValue = textarea.value;

    voiceRecognition.onresult = function(event) {
        let transcript = '';
        for (let i = 0; i < event.results.length; i++) {
            transcript += event.results[i][0].transcript;
        }
        textarea.value = (baseValue + ' ' + transcript).trim();
        if (event.results[event.results.length - 1].isFinal) {
            baseValue = textarea.value;
        }
    };

    voiceRecognition.onerror = function(event) {
        if (event.error === 'no-speech' || event.error === 'aborted') {
            // Not fatal — onend fires right after and restarts listening if still active.
            return;
        }
        showToast('error', 'Voice input error: ' + event.error);
        stopVoiceInput();
    };

    voiceRecognition.onend = function() {
        // Each utterance ends the recognizer on its own (continuous is off), so keep
        // dictation going by restarting — unless the user already clicked stop.
        if (voiceInputActive) {
            try {
                voiceRecognition.start();
            } catch (e) {
                stopVoiceInput();
            }
        }
    };

    voiceInputActive = true;
    if (btn) btn.classList.add('listening');
    voiceRecognition.start();
}

function stopVoiceInput() {
    voiceInputActive = false;
    const btn = document.getElementById('voiceInputBtn');
    if (btn) btn.classList.remove('listening');
    if (voiceRecognition) {
        const recognitionToStop = voiceRecognition;
        voiceRecognition = null;
        recognitionToStop.onend = null;
        recognitionToStop.onresult = null;
        recognitionToStop.onerror = null;
        recognitionToStop.stop();
    }
}

/**
 * New-achievement line (new_achievement.tpl): opening a link in it (the achievement page or a share link) or closing
 * it (× or Esc) marks the achievement viewed, so it isn't shown again.
 */
function initNewAchievement(block) {
    const viewUrl = block.dataset.achievementViewUrl;
    let isMarkedViewed = false;

    const markViewed = function () {
        if (isMarkedViewed || !viewUrl) {
            return;
        }
        isMarkedViewed = true;
        fetch(viewUrl, { method: 'GET', credentials: 'same-origin', keepalive: true })
            .catch(function () {
                // Best effort: at worst the achievement is shown once more
            });
    };
    const closeOnEscape = function (event) {
        if (event.key === 'Escape') {
            close();
        }
    };
    const close = function () {
        markViewed();
        block.remove();
        document.removeEventListener('keydown', closeOnEscape);
    };

    block.addEventListener('click', function (event) {
        if (event.target.closest('a')) {
            markViewed();
            return;
        }
        if (event.target.closest('.new-achievement__close')) {
            close();
        }
    });
    document.addEventListener('keydown', closeOnEscape);
}

/**
 * A correct check response may start with a new-achievement line (Controller::sendSolvedProgress()): move it above
 * the task, replacing the one shown on page load. The mobile page has no main column: it stays in the result there.
 */
function placeNewAchievement(container) {
    const block = container.querySelector('.new-achievement');
    if (!block) {
        return;
    }
    const mainColumn = document.querySelector('main.column');
    if (mainColumn) {
        document.querySelectorAll('.new-achievement').forEach(el => el !== block && el.remove());
        mainColumn.prepend(block);
    }
    initNewAchievement(block);
}

/**
 * After a correct check: mark the task solved in the menu and refresh "My progress" (my_progress.tpl)
 * from the X-Solved-Count / X-Questions-Count headers (Controller::sendSolvedProgress()).
 */
function showSolvedProgress(response) {
    document.querySelectorAll('.question-link.current-question:not(.solved)').forEach(el => {
        el.classList.add('solved');
        // "12 / 40" in the header of the task's menu group
        const count = el.closest('.panel')?.previousElementSibling?.querySelector('.accordion-count');
        if (count) {
            count.dataset.solved = parseInt(count.dataset.solved || '0', 10) + 1;
            count.textContent = `${count.dataset.solved}\u2009/\u2009${count.dataset.total}`;
        }
    });

    const solved = parseInt(response.headers.get('X-Solved-Count'), 10);
    const total = parseInt(response.headers.get('X-Questions-Count'), 10);
    if (isNaN(solved) || !total) {
        return;
    }
    const percent = solved / total * 100;
    document.querySelectorAll('.progress-bar').forEach(el => el.style.width = `${percent}%`);
    document.querySelectorAll('.progress-count').forEach(el => el.textContent = `${solved}/${total}`);
    document.querySelectorAll('.progress-percentage').forEach(el => el.textContent = `${Math.round(percent * 10) / 10}%`);
}

function testQuery(lang, questionId) {
    setLoader('code-result');
    clearSqlErrorMarker();
    const sql = window.sql_editor.getValue();
    let formData = new FormData();
    formData.append('query', sql);
    fetch(`/${lang}/question/${questionId}/query-test`, {
        method: "POST",
        mode: "cors",
        cache: "default",
        credentials: "same-origin",
        body: formData,
    })
    .then((async response=>{
        if (response.ok) {
            showSolvedProgress(response);
        }
        if (response.headers.get('X-Sample-Rows') === 'available') {
            unlockSampleRows();
        }
        if (response.ok && document.getElementById("nextTaskBtn")) {
            document.getElementById("nextTaskBtn").classList.remove("hidden");
            setTimeout(()=>{
                if (document.getElementById("main3")) {
                    document.getElementById("main3").scrollTo({
                        top: document.getElementById("nextTaskBtn").offsetTop,
                        behavior: "smooth" 
                    })
                } else {
                    window.scrollTo({
                        top: document.getElementById("db-description").offsetTop - window.outerHeight,
                        behavior: "smooth" 
                    })
                }
            }, 300)
        }
        return await response.text();
    }))
    .then((message)=>{
        document.getElementById('code-result').innerHTML = message;
        placeNewAchievement(document.getElementById('code-result'));
        enhanceSqlErrors(document.getElementById('code-result'), sql);
    })
    .catch(err=>{
        document.getElementById('code-result').innerHTML = 'Something went wrong. Please review your query and try again or contact us by email: <a href="mailto:support@sqltest.online">support@sqltest.online</a>.';
    });
}
// Expected result block (expected_result.tpl): the sample rows became available after a wrong check
function unlockSampleRows() {
    const block = document.getElementById('expected-result');
    if (!block) {
        return;
    }
    const locked = block.querySelector('[data-sample-state="locked"]');
    if (locked) {
        locked.remove();
        block.querySelector('[data-sample-state="available"]')?.classList.remove('hidden');
    }
}
// Load the first rows of the expected result into its block and open it
function showSampleRows(lang, questionId) {
    const block = document.getElementById('expected-result');
    if (!block) {
        return;
    }
    block.open = true;
    const reveal = () => block.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    if (block.dataset.sampleLoaded) {
        reveal();
        return;
    }
    fetch(`/${lang}/question/${questionId}/expected-sample`, { credentials: 'same-origin' })
    .then(response => response.ok ? response.text() : Promise.reject(response.status))
    .then(html => {
        document.getElementById('expected-result-rows').innerHTML = html;
        block.dataset.sampleLoaded = '1';
        block.querySelector('[data-sample-state="available"]')?.remove();
        block.querySelector('[data-sample-state="shown"]')?.classList.remove('hidden');
        reveal();
    })
    .catch(err => console.error(err));
}
function toggleFavorites(lang, questionId) {
    let formData = new FormData();
    fetch(`/${lang}/question/${questionId}/favorite`, {
        method: "POST",
        mode: "cors",
        cache: "default",
        credentials: "same-origin",
        body: formData,
    })
    .then((async response=>{
        if (response.ok) {
            if (document.getElementById("favoriteStar")) {
                const message =  await response.text();
                showToast('info', message);
                const favored = document.getElementById("favoriteStar").classList.toggle("favored");
                document.getElementById("favoriteStar").setAttribute("aria-pressed", favored ? "true" : "false");
                // document.getElementById("favoriteStar").title = 'Favored'
            } 
        }
    }))
    .catch(err=>{
        showToast('error', 'Something went wrong. Please ask admin for help.');
    });
}
function moveQuestionPosition(questionId, categoryId, direction) {
    fetch(`/admin/question-category-position`, {
        method: "POST",
        mode: "cors",
        cache: "default",
        credentials: "same-origin",
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            question_id: questionId,
            category_id: categoryId,
            direction: direction
        }),
    })
    .then((async response=>{
        const data = await response.json();
        if (response.ok && data.ok) {
            loadMenu(window.UIConfig.questionnire);
        } else {
            showToast('error', data.error || 'Something went wrong.');
        }
    }))
    .catch(err=>{
        showToast('error', 'Something went wrong. Please ask admin for help.');
    });
}
function showMySolutions(questionId) {
    showSolutions(questionId, 'my');
}
function showOthersSolutions(questionId) {
    showSolutions(questionId, 'others');
}
function showSolutions(questionId, whom) {
    document.getElementById('right-panel').innerHTML = '<div id="pre-loader" style="width: 21vw;"></div>';
    setLoader('pre-loader');
    const url = whom === 'my' ? `/${lang}/question/${questionId}/my-solutions` : `/${lang}/question/${questionId}/solutions`;
    fetch(url, {
        method: "GET",
        mode: "cors",
        cache: "default",
        credentials: "same-origin",
    })
    .then((async response=>{
        if (!response.ok) throw Error('Something went wrong.');
        return await response.text();
    }))
    .then((message)=>{
        document.getElementById('right-panel').innerHTML = message;
    })
    .then(()=>{
      [...document.getElementsByClassName("solution-block")].map(el=>{
        ace
                    .edit(el.id, {
                            mode: "ace/mode/mysql",
                            theme: getAceTheme(window.UIConfig.theme),
                            dragEnabled: false,
                            useWorker: false,
                            readOnly: true
                    });
      });
    })
    .catch(err=>{
        document.getElementById('right-panel').innerHTML = 'Something went wrong.';
    });
}
function solutionUpdate(solutionId, action) {
    return fetch(`/${lang}/solution/${solutionId}/${action}`, {
        method: "POST",
        mode: "cors",
        cache: "default",
        credentials: "same-origin",
    })
    .then((async response=>{
        if (response.ok) {
            const message =  await response.text();
            showToast('info', message);
        }
    }))
    .catch(err=>{
        showToast('error', 'Something went wrong. Please ask admin for help.');
    });
}
function solutionLike(solutionId) {
    return solutionUpdate(solutionId, 'like')
    .then(()=>{
            [...document.getElementById(`solution-likes-${solutionId}`).children].map(el=>el.classList.toggle("hidden"));
            document.getElementById(`solution-likes-count-${solutionId}`).innerText = parseInt(document.getElementById(`solution-likes-count-${solutionId}`).innerText) + 1;
    });
}
function solutionUnlike(solutionId) {
    return solutionUpdate(solutionId, 'unlike')
    .then(()=>{
        [...document.getElementById(`solution-likes-${solutionId}`).children].map(el=>el.classList.toggle("hidden"));
        document.getElementById(`solution-likes-count-${solutionId}`).innerText = parseInt(document.getElementById(`solution-likes-count-${solutionId}`).innerText) - 1;
    });
}
// Cookie helpers and welcome-page handlers
function setCookie(name, value, days) {
    let expires = '';
    if (days) {
        const date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = '; expires=' + date.toUTCString();
    }
    document.cookie = name + '=' + (value || '') + expires + '; path=/';
}
function hideWelcome(hide) {
    if (hide) {
        setCookie('HideWelcome', '1', 365);
    } else {
        setCookie('HideWelcome', '', -1); // Remove cookie
    }
}
function solutionReport(lang, questionId, solutionId) {
    solutionUpdate(solutionId, 'report')
    .then(()=>showOthersSolutions(questionId));
}
function solutionDelete(lang, questionId, solutionId) {
    return fetch(`/${lang}/solution/${solutionId}/delete`, {
        method: "POST",
        mode: "cors",
        cache: "default",
        credentials: "same-origin",
    })
    .then((async response=>{
      if (response.ok) {
        const message =  await response.text();
        showToast('info', message);
      }
    }))
    .then(()=>showMySolutions(questionId))
    .catch(err=>{
        showToast('error', 'Something went wrong. Please ask admin for help.');
    });
}
function solutionRun(lang, questionId, solutionId) {
    const solution = ace.edit(`solution-${solutionId}`).getValue();
    window.sql_editor.setValue(solution);
    return runQuery(lang, questionId);
}

function rateQuestion(questionId, rate) {
    let formData = new FormData();
    formData.append('rate', rate);
    fetch(`/${lang}/question/${questionId}/rate`, {
        method: "POST",
        mode: "cors",
        cache: "default",
        credentials: "same-origin",
        body: formData,
    })
    .then((async response=>{
        if (response.ok) {
            const message =  await response.text();
            showToast('info', message);
        }
    }))
    .catch(err=>{
        showToast('error', 'Something went wrong. Please ask admin for help.');
    });
}
function toggleSolvedTasks(e) {
    // CSS hides the solved tasks and swaps the eye icons, also in the groups loaded later
    document.documentElement.classList.toggle('hide-solved-tasks');
    window.UIConfig.hideSolvedTasks = !window.UIConfig.hideSolvedTasks;
    saveUIConfig();
    return false;
}
function toggleNotFavoritsTasks(e) {
    document.getElementById('toggleNotFavoritTasks').classList.toggle("favored");
    [...document.getElementsByClassName("question-link solved")].map(el=>{
        el.parentNode.classList.toggle("invisible")
    });
    window.UIConfig.hidenotFavoredTasks = !window.UIConfig.hidenotFavoredTasks;
    saveUIConfig();
    return false;
}

function toggleInfoPanel() {
    document.getElementsByClassName("right")[0].classList.toggle("hidden");
    document.getElementsByClassName("main")[0].classList.toggle("wide");
    [...document.getElementsByClassName("splitter")[0].children].map(el=>el.classList.toggle("hidden"));
    window.UIConfig.hideInfoPanel = !window.UIConfig.hideInfoPanel;
    saveUIConfig();
    return false;
}

function scrollQuestionPanel() {
    const activePanel = document.getElementsByClassName("panel active")[0];
    const qurrentQuestion = document.getElementsByClassName("current-question")[0];
    if (activePanel && qurrentQuestion) {
        activePanel.scrollTop = qurrentQuestion.offsetTop - activePanel.offsetTop;
    }
}
function openLinkedinLoginPopUp() {
    window.open(
        `https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=77scnm5m8z804e&redirect_uri=${window.location.protocol}//${window.location.host}/login/linkedin/&state=SignupAuth&scope=openid%20email%20profile`, 
        'LinkedIn Login', 
        `scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=530,height=950,left=${(window.outerWidth - 530) / 2},top=${(window.outerHeight - 950) / 2}`
    );
}
function openGitHubLoginPopUp() {
    const githubClientId = window.AppConfig?.githubClientId || '';
    if (!githubClientId) {
        showToast('error', 'GitHub login is not configured.');
        return;
    }

    window.open(
        `https://github.com/login/oauth/authorize?client_id=${encodeURIComponent(githubClientId)}&redirect_uri=${window.location.protocol}//${window.location.host}/login/github/&scope=user`, 
        'GitHub Login', 
        `scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=530,height=950,left=${(window.outerWidth - 530) / 2},top=${(window.outerHeight - 950) / 2}`
    );
}
function openVKLoginPopUp() {
    const uuid = '29890eb2-6a16-0613-190f-250e54537e18'; // Generate a random string. We recommend using at least 36 characters. This string will be used to verify that the request is coming from your app.
    const appId = 51931966; // Your app identifier.
    // const redirect_uri = `${window.location.protocol}//${window.location.host}/login/vk/`;
    const redirect_uri = `${window.location.protocol}//${window.location.host}/login/vk/?lang=${lang}`;
    const redirect_state = 'login'; // Your app's state or any arbitrary string that will be added to the URL after authentication.

    const query = `uuid=${uuid}&app_id=${appId}&response_type=silent_token&redirect_uri=${redirect_uri}&redirect_state=${redirect_state}`;

    window.open(
        `https://id.vk.com/auth?${query}`,
        'VK Login',
        `scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=530,height=950,left=${(window.outerWidth - 530) / 2},top=${(window.outerHeight - 950) / 2}`
    );
}

// Email/Password Login Functions
function openEmailLoginPopUp() {
    document.getElementById('emailLoginPopup').style.display = 'flex';
    document.getElementById('loginFormContainer').style.display = 'block';
    document.getElementById('registerFormContainer').style.display = 'none';
}

function closeEmailLoginPopUp() {
    document.getElementById('emailLoginPopup').style.display = 'none';
    document.getElementById('emailLoginForm').reset();
    document.getElementById('emailRegisterForm').reset();
    hideLoginError();
    hideRegisterError();
}

function showLoginError(message) {
    const errorDiv = document.getElementById('loginErrorMessage');
    errorDiv.textContent = message;
    errorDiv.style.display = 'block';
}

function hideLoginError() {
    const errorDiv = document.getElementById('loginErrorMessage');
    errorDiv.style.display = 'none';
    errorDiv.textContent = '';
}

function showRegisterError(message) {
    const errorDiv = document.getElementById('registerErrorMessage');
    errorDiv.textContent = message;
    errorDiv.style.display = 'block';
}

function hideRegisterError() {
    const errorDiv = document.getElementById('registerErrorMessage');
    errorDiv.style.display = 'none';
    errorDiv.textContent = '';
}

function switchToRegister(event) {
    event.preventDefault();
    hideLoginError();
    document.getElementById('loginFormContainer').style.display = 'none';
    document.getElementById('registerFormContainer').style.display = 'block';
}

function switchToLogin(event) {
    event.preventDefault();
    hideRegisterError();
    document.getElementById('registerFormContainer').style.display = 'none';
    document.getElementById('loginFormContainer').style.display = 'block';
}

function handleEmailLogin(event) {
    event.preventDefault();
    hideLoginError();
    
    const email = document.getElementById('loginEmail').value;
    const password = document.getElementById('loginPassword').value;
    
    // Send login request to server
    const ajax = 1;
    fetch('/login/password/', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
        body: new URLSearchParams({ email, password, ajax, lang }).toString()
    })
    .then(response => response.json())
    .then(data => {
        if (data.status && data.status === 'ok') {
            window.location.reload(); // Reload page on successful login
        } else {
            showLoginError(data.message || 'Login failed. Please check your credentials.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showLoginError('An error occurred during login. Please try again.');
    });
}

function handleForgotPassword(event) {
    event.preventDefault();
    hideLoginError();

    const email = document.getElementById('loginEmail').value.trim();
    if (!email) {
        showLoginError('Please enter your email address first.');
        return;
    }

    fetch(`/${lang}/forgot-password/`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
        body: new URLSearchParams({ email }).toString()
    })
    .then(response => response.json())
    .then(data => showLoginError(data.message || 'If an account exists, a temporary password has been sent.'))
    .catch(error => {
        console.error('Error:', error);
        showLoginError('An error occurred. Please try again later.');
    });
}

function handleEmailRegister(event) {
    event.preventDefault();
    hideRegisterError();
    
    const full_name = document.getElementById('registerName').value;
    const email = document.getElementById('registerEmail').value;
    const password = document.getElementById('registerPassword').value;
    const passwordConfirm = document.getElementById('registerPasswordConfirm').value;
    
    if (password !== passwordConfirm) {
        showRegisterError('Passwords do not match!');
        return;
    }
    
    // Send registration request to server
    const ajax = 1;
    fetch(`/${lang}/register/`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
        body: new URLSearchParams({ full_name, email, password, ajax, lang }).toString()
    })
    .then(response => response.json())
    .then(data => {
        if (data.status && data.status === 'ok') {
            switchToLogin(event);
        } else {
            showRegisterError(data.message || 'Registration failed. Please try again.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showRegisterError('An error occurred during registration. Please try again.');
    });
}

function openGoogleLoginPopUp() {
    const googleClientId = window.AppConfig?.googleClientId || document.querySelector('meta[name="google-signin-client_id"]')?.content || '';
    if (!googleClientId) {
        showToast('error', 'Google login is not configured.');
        return;
    }

    const params = {
        response_type: 'code',
        client_id: googleClientId,
        redirect_uri: `${window.location.protocol}//${window.location.host}/login/google/`,
        scope:'openid email',
        state: ''
    };
    window.open(
        'https://accounts.google.com/o/oauth2/v2/auth?' + new URLSearchParams(params).toString(), 
        'Google Login', 
        `scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=530,height=600,left=${(window.outerWidth - 530) / 2},top=${(window.outerHeight - 950) / 2}`
    );
}

function saveUIConfig() {
    localStorage.setItem("UIConfig", JSON.stringify(window.UIConfig));
}
function applyUIConfig() {
    if (window.UIConfig.hideSolvedTasks) {
        window.UIConfig.hideSolvedTasks = !window.UIConfig.hideSolvedTasks;
        toggleSolvedTasks();
    }

    if (window.UIConfig.hideInfoPanel) {
        window.UIConfig.hideInfoPanel = !window.UIConfig.hideInfoPanel;
        toggleInfoPanel();
    }
    document.querySelector('#theme-switch-checkbox').checked = (window.UIConfig.theme === 'dark' ? 1 : 0);
}

/**
 * Accordions (the task menu groups, the database tables in the right panel), the "hide solved" eyes and the
 * menu search. scope: the element whose accordions to bind (the menu after loadMenu() replaced it).
 */
function setMenuEventListeners(scope = document) {
    scope.querySelectorAll(".accordion").forEach(el=>{
      el.addEventListener ('click', function() {
          const parentElement = this.parentElement;
          const wasActive = this.classList.contains("active");
          if (parentElement.id === 'menu-content') {
            //close all panels
            for (let el of parentElement.getElementsByClassName("panel")) el.classList.remove("active");
            for (let el of parentElement.getElementsByClassName("accordion")) el.classList.remove("active");
          }
          this.classList.toggle("active", !wasActive);
          const panel = this.nextElementSibling;
          panel.classList.toggle("active", !wasActive);
          if (!wasActive && panel.dataset.group && !panel.children.length) {
              loadMenuGroups(panel.dataset.group);
          }
      });
    });

    scope.querySelectorAll(".eye-btn").forEach(el=>{
      el.addEventListener ('click', e=>{
          e.preventDefault();
          // Don't collapse the group under the button
          e.stopPropagation();
          toggleSolvedTasks()
      });
    });

    const search = scope.querySelector('#menu-search-input');
    if (search) {
        let timer = null;
        search.addEventListener('input', () => {
            clearTimeout(timer);
            timer = setTimeout(() => searchMenu(search.value), 150);
        });
    }
}

// Task menu groups other than the current one come without their task lists (menu.tpl); load one group,
// or 'all' for the search. Resolves when the lists are in place.
let menuGroupsRequest = null;
function loadMenuGroups(group) {
    const content = document.getElementById('menu-content');
    if (!content) return Promise.resolve();
    if (group === 'all' && menuGroupsRequest) return menuGroupsRequest;
    const questionnire = document.querySelector('input[name=menu_groups]:checked')?.value || 'category';
    const request = fetch(`/${lang}/menu?questionnire=${encodeURIComponent(questionnire)}&group=${encodeURIComponent(group)}`, {
        credentials: "same-origin",
    })
    .then(response => {
        if (!response.ok) throw Error('Something went wrong.');
        return response.text();
    })
    .then(html => {
        const fill = (id, listHtml) => {
            const panel = content.querySelector(`.panel[data-group="${id}"]`);
            if (panel && !panel.children.length) panel.innerHTML = listHtml;
        };
        if (group === 'all') {
            const holder = document.createElement('div');
            holder.innerHTML = html;
            holder.querySelectorAll(':scope > [data-group]').forEach(el => fill(el.dataset.group, el.innerHTML));
        } else {
            fill(group, html);
        }
    })
    .catch(err => {
        if (group === 'all') menuGroupsRequest = null;
        console.log(err);
    });
    if (group === 'all') menuGroupsRequest = request;
    return request;
}

// Search by task title or number: shows the matching tasks in all groups, hides the rest
function searchMenu(query) {
    const content = document.getElementById('menu-content');
    const empty = document.querySelector('.menu-search-empty');
    if (!content) return;
    const words = query.trim().toLowerCase().split(/\s+/).filter(Boolean);
    if (!words.length) {
        content.classList.remove('searching');
        content.querySelectorAll('.search-match, .search-hit').forEach(el => el.classList.remove('search-match', 'search-hit'));
        empty?.classList.add('hidden');
        return;
    }
    loadMenuGroups('all').then(() => {
        // The query may have changed while the lists were loading
        if (document.getElementById('menu-search-input')?.value.trim().toLowerCase().split(/\s+/).join(' ') !== words.join(' ')) return;
        content.classList.add('searching');
        let found = 0;
        content.querySelectorAll('.panel').forEach(panel => {
            let panelFound = 0;
            panel.querySelectorAll('li').forEach(li => {
                const text = li.textContent.replace(/\s+/g, ' ').toLowerCase();
                const hit = words.every(word => text.includes(word));
                li.classList.toggle('search-hit', hit);
                if (hit) panelFound++;
            });
            panel.classList.toggle('search-match', panelFound > 0);
            panel.previousElementSibling?.classList.toggle('search-match', panelFound > 0);
            found += panelFound;
        });
        empty?.classList.toggle('hidden', found > 0);
    });
}

function setEventListeners() {
    [...document.querySelectorAll(".db-description .sql")].map(el=>{
        el.addEventListener ('dblclick', e=>{
            e.preventDefault();
            window.sql_editor.session.insert(window.sql_editor.getCursorPosition(), ` ${el.innerText} `);
            window.sql_editor.focus();
        });
    })
    const toggleSwitch = document.querySelector('#theme-switch-checkbox');
    toggleSwitch.addEventListener('change', switchTheme, false);

    const link = document.querySelector("a[target='ERDWindow']");
    if (link) {
        link.addEventListener(
            "click",
            (event) => {
                openRequestedTab(link.href);
                event.preventDefault();
            },
            false,
        );
    }
}

setMenuEventListeners();
setEventListeners();
document.querySelectorAll('.new-achievement').forEach(initNewAchievement);
applyUIConfig();
lazyInitShareThis();
if (document.getElementById("sql-code")) {

    window.sql_editor = ace.edit("sql-code", {
        mode: "ace/mode/mysql",
        theme: getAceTheme(window.UIConfig.theme),
        selectionStyle: "text",
        dragEnabled: false,
        useWorker: false
    });

    window.sql_editor.setShowPrintMargin(false);
    window.sql_editor.setOptions({enableBasicAutocompletion: true});
    // Shown while the editor is empty (data-placeholder: index.tpl, m.index.tpl)
    const editorPlaceholder = document.getElementById("sql-code").dataset.placeholder;
    if (editorPlaceholder) {
        window.sql_editor.setOption("placeholder", editorPlaceholder);
    }
}

window.onload = function() {
    scrollQuestionPanel();
    if (!getSpeechRecognitionClass() && document.getElementById('voiceInputBtn')) {
        document.getElementById('voiceInputBtn').classList.add('hidden');
    }
    document.addEventListener('keydown', function(event) {
        if (event.ctrlKey && event.key === 'Enter' && window.sql_editor) {
            runQuery(lang, questionId);
        }
        // if (event.altKey && event.key === 'Enter') {
        //     testQuery(lang, questionId);
        // }
    });

    // Close mobile menu when clicking outside
    document.addEventListener('click', function(event) {
        const mobileMenuDropdown = document.getElementById('mobileMenuDropdown');
        const mobileMenuToggle = document.getElementById('mobileMenuToggle');
        
        if (mobileMenuDropdown && mobileMenuToggle && 
            !mobileMenuDropdown.contains(event.target) && 
            !mobileMenuToggle.contains(event.target)) {
            mobileMenuDropdown.classList.add('hidden');
        }
    });

    if (document.getElementById('yandexLogin') && window.YaAuthSuggest) {
        window.YaAuthSuggest.init(
        {
            client_id: '6a7ad9d0d23a496987255a596b83b9db',
            response_type: 'code',
            redirect_uri: `${window.location.protocol}//${window.location.host}/login/yandex/?lang=${lang}&db=${db}&questionId=${questionId}`
        },
        `${window.location.protocol}//${window.location.host}/login/yandex/?lang=${lang}&db=${db}&questionId=${questionId}`,
        {
            view: "button",
            parentId: "yandexLogin",
            buttonSize: 'xl',
            buttonView: 'main',
            buttonTheme: 'light',
            buttonBorderRadius: "6",
            buttonIcon: 'ya',
        }
        )
        .then(({handler}) => handler())
        .catch(error => alert('Обработка ошибки', error));
    }

};