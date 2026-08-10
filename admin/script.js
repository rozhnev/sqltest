const state = {
    questions: [],
    lessons: [],
    modules: [],
    selectedQuestion: null,
    currentQuestionHasAnswers: false,
    answerDraft: [],
    selectedAnswerIndex: -1,
    activeAnswerLanguage: 'en',
    selectedLessonId: null,
    statusTimer: null,
    initialLessonId: parseInt(window.ADMIN_CONFIG.lessonId ?? 0, 10) || 0
};

const LANGUAGE_LABELS = {
    EN: 'English',
    RU: 'Russian',
    PT: 'Portuguese',
    FR: 'French',
    ZH: 'Chinese'
};

const SUPPORTED_LANGUAGES = ['en', 'ru', 'pt', 'fr', 'zh'];

function setFieldValue(id, value) {
    const field = document.getElementById(id);
    if (!field) {
        return;
    }
    field.value = value || '';
}

function getFieldValue(id) {
    const field = document.getElementById(id);
    if (!field) {
        return '';
    }
    return field.value.trim();
}

function escapeHtml(value) {
    return String(value || '')
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#39;');
}

function populateQuestionForm(question) {
    setFieldValue('questionDb', question.db || 'sakila');
    setFieldValue('questionDbTemplate', question.db_template || 'sakila');
    setFieldValue('questionSolution', question.solution_query || '');
    setFieldValue('questionMatch', question.query_match || '');
    setFieldValue('questionNotMatch', question.query_not_match || '');
    setFieldValue('questionResult', question.query_valid_result || '');
    setFieldValue('questionPreCheck', question.query_pre_check || '');
    setFieldValue('questionCheck', question.query_check || '');

    const localizations = question.localizations || {};
    SUPPORTED_LANGUAGES.forEach((language) => {
        const languageUpper = language.toUpperCase();
        const localization = localizations[language] || {};
        setFieldValue(`questionTitle${languageUpper}`, localization.title || '');
        setFieldValue(`questionTask${languageUpper}`, localization.task || '');
        setFieldValue(`questionHint${languageUpper}`, localization.hint || '');
    });

    const hiddenQuestionId = document.querySelector('input[name="question[id]"]');
    if (hiddenQuestionId) {
        hiddenQuestionId.value = question.id || '';
    }
    state.currentQuestionHasAnswers = Boolean(question.have_answers);
    setAnswersDraft(question.answers || []);
    updateQuestionModeUI();

    const checkStates = {};
    (question.query_checks || []).forEach((check) => {
        checkStates[check.id] = Boolean(check.checked);
    });
    document.querySelectorAll('[data-query-check-row]').forEach((row) => {
        const checkbox = row.querySelector('input[type="checkbox"]');
        if (!checkbox) {
            return;
        }
        const id = row.dataset.checkId;
        checkbox.checked = Boolean(checkStates[id]);
    });

    const categoryStates = {};
    (question.categories || []).forEach((category) => {
        if (!category.category_id) {
            return;
        }
        categoryStates[category.category_id] = Boolean(category.checked);
    });
    document.querySelectorAll('[data-question-category-row]').forEach((row) => {
        const checkbox = row.querySelector('input[type="checkbox"]');
        if (!checkbox) {
            return;
        }
        const id = row.dataset.categoryId;
        checkbox.checked = Boolean(categoryStates[id]);
    });
}

function clearQuestionForm() {
    const form = document.getElementById('questionForm');
    if (form) {
        form.reset();
    }
    state.selectedQuestion = null;
    state.currentQuestionHasAnswers = false;
    document.querySelectorAll('[data-query-check-row] input[type="checkbox"]').forEach((checkbox) => {
        checkbox.checked = false;
    });
    document.querySelectorAll('[data-question-category-row] input[type="checkbox"]').forEach((checkbox) => {
        checkbox.checked = false;
    });
    setAnswersDraft([]);
    updateQuestionModeUI();
}

function gatherQuestionPayload() {
    const queryChecks = {};
    document.querySelectorAll('[data-query-check-row] input[type="checkbox"]').forEach((checkbox) => {
        const row = checkbox.closest('[data-query-check-row]');
        if (!row?.dataset.checkId) {
            return;
        }
        queryChecks[row.dataset.checkId] = checkbox.checked;
    });
    const questionCategories = {};
    document.querySelectorAll('[data-question-category-row] input[type="checkbox"]').forEach((checkbox) => {
        const row = checkbox.closest('[data-question-category-row]');
        if (!row?.dataset.categoryId) {
            return;
        }
        questionCategories[row.dataset.categoryId] = checkbox.checked;
    });
    const localizations = {};
    SUPPORTED_LANGUAGES.forEach((language) => {
        const languageUpper = language.toUpperCase();
        localizations[language] = {
            title: getFieldValue(`questionTitle${languageUpper}`),
            task: getFieldValue(`questionTask${languageUpper}`),
            hint: getFieldValue(`questionHint${languageUpper}`)
        };
    });

    return {
        db: getFieldValue('questionDb') || 'sakila',
        db_template: getFieldValue('questionDbTemplate') || 'sakila',
        solution_query: getFieldValue('questionSolution'),
        query_checks: queryChecks,
        categories: questionCategories,
        query_match: getFieldValue('questionMatch'),
        query_not_match: getFieldValue('questionNotMatch'),
        query_valid_result: getFieldValue('questionResult'),
        query_pre_check: getFieldValue('questionPreCheck'),
        query_check: getFieldValue('questionCheck'),
        localizations
    };
}

async function saveQuestion() {
    try {
        const payload = gatherQuestionPayload();
        const method = state.selectedQuestion ? 'PUT' : 'POST';
        const url = state.selectedQuestion ? `/admin/question/${state.selectedQuestion.id}` : '/admin/question';
        const response = await safeFetch(url, {
            method,
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });
        state.selectedQuestion = response.question;
        populateQuestionForm(state.selectedQuestion);
        updateSelectedQuestionLabel();
        showStatus('Question saved', 'success');
        loadQuestions();
    } catch (error) {
        console.error(error);
    }
}

async function deleteQuestion() {
    if (!state.selectedQuestion) {
        showStatus('Select a question before deleting', 'info');
        return;
    }
    if (!confirm('Delete this question?')) {
        return;
    }
    try {
        await safeFetch(`/admin/question/${state.selectedQuestion.id}`, { method: 'DELETE' });
        showStatus('Question removed', 'success');
        state.selectedQuestion = null;
        clearQuestionForm();
        updateSelectedQuestionLabel();
        loadQuestions();
    } catch (error) {
        console.error(error);
    }
}

function updateSelectedQuestionLabel() {
    const label = document.getElementById('selectedQuestionLabel');
    if (state.selectedQuestion) {
        label.textContent = `Editing question #${state.selectedQuestion.id}`;
    } else {
        label.textContent = 'No question selected';
    }
}

function populateModuleSelect() {
    const select = document.getElementById('lessonModule');
    select.innerHTML = '';
    const placeholder = document.createElement('option');
    placeholder.value = '';
    placeholder.textContent = 'Choose module';
    placeholder.disabled = true;
    placeholder.selected = true;
    select.appendChild(placeholder);
    state.modules.forEach((module) => {
        const option = document.createElement('option');
        option.value = module.id;
        option.textContent = module.title;
        select.appendChild(option);
    });
}

async function selectLesson(id) {
    try {
        const response = await safeFetch(`/admin/lesson/${id}`);
        state.selectedLessonId = id;
        populateLessonForm(response.lesson);
        updateSelectedLessonLabel();
        renderLessonList();
    } catch (error) {
        console.error(error);
    }
}

function populateLessonForm(lesson) {
    document.getElementById('lessonModule').value = lesson.module_id;
    document.getElementById('lessonTitleEn').value = lesson.localizations?.en?.title || '';
    document.getElementById('lessonDescriptionEn').value = lesson.localizations?.en?.description || '';
    document.getElementById('lessonContentEn').value = lesson.localizations?.en?.content || '';
    document.getElementById('lessonTitleRu').value = lesson.localizations?.ru?.title || '';
    document.getElementById('lessonDescriptionRu').value = lesson.localizations?.ru?.description || '';
    document.getElementById('lessonContentRu').value = lesson.localizations?.ru?.content || '';
}

function clearLessonForm() {
    document.getElementById('lessonForm').reset();
    state.selectedLessonId = null;
}

function gatherLessonPayload() {
    return {
        module_id: parseInt(document.getElementById('lessonModule').value, 10) || 0,
        localizations: {
            en: {
                title: document.getElementById('lessonTitleEn').value.trim(),
                description: document.getElementById('lessonDescriptionEn').value.trim(),
                content: document.getElementById('lessonContentEn').value.trim()
            },
            ru: {
                title: document.getElementById('lessonTitleRu').value.trim(),
                description: document.getElementById('lessonDescriptionRu').value.trim(),
                content: document.getElementById('lessonContentRu').value.trim()
            }
        }
    };
}

async function saveLesson() {
    try {
        const payload = gatherLessonPayload();
        const method = state.selectedLessonId ? 'PUT' : 'POST';
        const url = state.selectedLessonId ? `/admin/lesson/${state.selectedLessonId}` : '/admin/lesson';
        const response = await safeFetch(url, {
            method,
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });
        state.selectedLessonId = response.lesson.id;
        populateLessonForm(response.lesson);
        updateSelectedLessonLabel();
        showStatus('Lesson saved', 'success');
        loadLessons();
    } catch (error) {
        console.error(error);
    }
}

async function deleteLesson() {
    if (!state.selectedLessonId) {
        showStatus('Select a lesson before deleting', 'info');
        return;
    }
    if (!confirm('Delete this lesson?')) {
        return;
    }
    try {
        await safeFetch(`/admin/lesson/${state.selectedLessonId}`, { method: 'DELETE' });
        showStatus('Lesson removed', 'success');
        state.selectedLessonId = null;
        clearLessonForm();
        updateSelectedLessonLabel();
        loadLessons();
    } catch (error) {
        console.error(error);
    }
}

function updateSelectedLessonLabel() {
    const label = document.getElementById('selectedLessonLabel');
    if (state.selectedLessonId) {
        label.textContent = `Editing lesson #${state.selectedLessonId}`;
    } else {
        label.textContent = 'No lesson selected';
    }
}

function handleTranslateClick(event) {
    const button = event.target.closest('[data-translate]');
    if (!button) return;
    const source = document.getElementById(button.dataset.source);
    const target = document.getElementById(button.dataset.target);
    const from = button.dataset.from || 'English';
    const to = button.dataset.to || 'Russian';
    if (!source || !target) return;
    translateField(source.value, from, to)
        .then((text) => {
            target.value = text;
            showStatus(`Translated to ${to}`, 'success');
        })
        .catch(() => {});
}

async function translateField(text, from, to) {
    if (!text.trim()) {
        throw new Error('Provide text to translate first');
    }
    const { result } = await safeFetch('/admin/llm', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            task: 'translate',
            from_lang: from,
            to_lang: to,
            text
        })
    });
    return result || '';
}

function updateLLMOptions() {
    // const task = document.getElementById('llmTask').value;
    // const translateOptions = document.getElementById('llmTranslateOptions');
    // translateOptions.style.display = task === 'translate' ? 'flex' : 'none';
    // document.getElementById('llmStyle').disabled = task === 'translate';
}

async function questionReview(language) {
    const normalizedLanguage = (language || '').toUpperCase();
    if (!normalizedLanguage) {
        showStatus('Language is required', 'error');
        return;
    }

    const title = document.getElementById(`questionTitle${normalizedLanguage}`).value.trim();
    const task = document.getElementById(`questionTask${normalizedLanguage}`).value.trim();
    const hint = document.getElementById(`questionHint${normalizedLanguage}`).value.trim();
    const solution = document.getElementById('questionSolution').value.trim();

    if (!title && !task && !hint) {
        showStatus('Provide at least a title, task, or hint before requesting a review', 'info');
        return;
    }

    try {
        const { result } = await safeFetch('/admin/llm', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                task: 'question-review',
                language: LANGUAGE_LABELS[normalizedLanguage] || normalizedLanguage,
                context: { title, question: task, hint, solution }
            })
        });
        document.getElementById(`questionLLMResult${normalizedLanguage}`).innerHTML = result || 'No response';
    } catch (error) {
        console.error(error);
    }
}

async function questionTranslateTo(sourceLanguage) {
    const normalizedLanguage = (sourceLanguage || '').toUpperCase();
    if (!normalizedLanguage) {
        showStatus('Language is required', 'error');
        return;
    }

    const targetLabel = LANGUAGE_LABELS[normalizedLanguage] || normalizedLanguage;
    const targetLanguage = document.getElementById(`translate${normalizedLanguage}ToLang`)?.value.trim() || '';
    const title = document.getElementById(`questionTitle${normalizedLanguage}`)?.value.trim();
    const task  = document.getElementById(`questionTask${normalizedLanguage}`)?.value.trim();
    const hint  = document.getElementById(`questionHint${normalizedLanguage}`)?.value.trim() || '';

    if (!title || !task) {
        showStatus('Provide title and task in Source language before translating.', 'info');
        return;
    }

    const toTranslate = `Title: ${title}\nTask: ${task}\nHint: ${hint}`.trim();

    try {
        const translated = await translateField(toTranslate, sourceLanguage, targetLanguage);
        const container = document.getElementById(`questionLLMResult${targetLanguage.toUpperCase()}`);
        if (container) {
            container.innerHTML = translated.replace(/\n/g, '<br>');
        }
        showStatus(`Translation to ${targetLabel} ready`, 'success');
    } catch (error) {
        console.error(error);
    }
}

async function questionGenerateTaskFromQuery(questionId) {
    const solutionQuery = document.getElementById('questionSolution')?.value.trim();
    const languageSelect = document.getElementById('generateTaskLanguage');
    const languageCode = languageSelect ? languageSelect.value : 'en';
    const languageLabel = LANGUAGE_LABELS[languageCode.toUpperCase()] || 'English';
    
    if (!solutionQuery) {
        showStatus('Provide a solution query first', 'info');
        return;
    }

    try {
        const response = await runLLM('generate-task-from-query', solutionQuery, languageLabel);
        const resultContainerId = `questionLLMResult${languageCode.toUpperCase()}`;
        const resultContainer = document.getElementById(resultContainerId);
        if (resultContainer) {
            resultContainer.innerHTML = response.replace(/\n/g, '<br>');
        }
        showStatus(`Task generated successfully in ${languageLabel}`, 'success');
    } catch (error) {
        console.error(error);
    }
}

async function questionLocalizationSave(questionId, language) {
    const id = parseInt(questionId, 10);
    if (!id) {
        showStatus('Save the question before saving a localization.', 'info');
        return;
    }
    const normalizedLanguage = (language || '').toUpperCase();
    if (!normalizedLanguage) {
        showStatus('Language is required', 'error');
        return;
    }

    const title = document.getElementById(`questionTitle${normalizedLanguage}`)?.value.trim();
    const task  = document.getElementById(`questionTask${normalizedLanguage}`)?.value.trim();
    const hint  = document.getElementById(`questionHint${normalizedLanguage}`)?.value.trim();
    const theoryMode = isTheoryMode();

    if (!title || title === '') {
        showStatus('Title is required', 'error');
        return;
    }
    if (!theoryMode && (!task || task === '')) {
        showStatus('Task is required for SQL query questions', 'error');
        return;
    }
    const payload = {
        question_id: id,
        language: normalizedLanguage,
        title,
        task,
        hint
    };
    try {
        const response = await safeFetch('/admin/question-localization', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });
        showStatus(`Localization saved (${language})`, 'success');
        // const saved = response.localization || {};
        // if (state.selectedQuestion) {
        //     state.selectedQuestion.localizations = state.selectedQuestion.localizations || {};
        //     state.selectedQuestion.localizations[normalizedLanguage] = {
        //         title: saved.title ?? payload.title,
        //         task: saved.task ?? payload.task,
        //         hint: saved.hint ?? payload.hint
        //     };
        // }
    } catch (error) {
        console.error(error);
    }
}

function getCurrentQuestionId() {
    if (state.selectedQuestion && state.selectedQuestion.id) {
        return parseInt(state.selectedQuestion.id, 10) || 0;
    }
    const hidden = document.querySelector('input[name="question[id]"]');
    if (hidden && hidden.value) {
        return parseInt(hidden.value, 10) || 0;
    }
    const form = document.getElementById('questionForm');
    if (form && form.dataset.questionId) {
        return parseInt(form.dataset.questionId, 10) || 0;
    }
    return 0;
}

function getLanguageLabel(language) {
    return LANGUAGE_LABELS[language.toUpperCase()] || language.toUpperCase();
}

function makeEmptyAnswer() {
    const localizations = {};
    SUPPORTED_LANGUAGES.forEach((language) => {
        localizations[language] = { title: '' };
    });
    return {
        id: 0,
        is_valid: false,
        localizations
    };
}

function cloneAnswer(answer = {}) {
    const localizations = {};
    SUPPORTED_LANGUAGES.forEach((language) => {
        localizations[language] = {
            title: (answer.localizations?.[language]?.title || '').trim()
        };
    });
    return {
        id: parseInt(answer.id || '0', 10) || 0,
        is_valid: Boolean(answer.is_valid),
        localizations
    };
}

function getMissingAnswerLanguages(answer) {
    const missing = [];
    SUPPORTED_LANGUAGES.forEach((language) => {
        if (!answer.localizations?.[language]?.title) {
            missing.push(language.toUpperCase());
        }
    });
    return missing;
}

function loadInitialAnswersFromDom() {
    const container = document.getElementById('questionInitialAnswers');
    if (!container) {
        return [];
    }

    const initial = [];
    container.querySelectorAll('[data-initial-answer]').forEach((row) => {
        const answer = makeEmptyAnswer();
        answer.id = parseInt(row.dataset.answerId || '0', 10) || 0;
        answer.is_valid = row.dataset.answerValid === '1';
        row.querySelectorAll('[data-initial-lang]').forEach((cell) => {
            const language = cell.dataset.initialLang;
            if (!language || !SUPPORTED_LANGUAGES.includes(language)) {
                return;
            }
            answer.localizations[language].title = (cell.textContent || '').trim();
        });
        initial.push(answer);
    });

    return initial;
}

function setAnswersDraft(answers) {
    state.answerDraft = Array.isArray(answers) ? answers.map((answer) => cloneAnswer(answer)) : [];
    if (state.answerDraft.length === 0) {
        state.selectedAnswerIndex = -1;
    } else if (state.selectedAnswerIndex < 0 || state.selectedAnswerIndex >= state.answerDraft.length) {
        state.selectedAnswerIndex = 0;
    }
    if (!SUPPORTED_LANGUAGES.includes(state.activeAnswerLanguage)) {
        state.activeAnswerLanguage = 'en';
    }
    renderAnswersWorkspace();
}

function renderAnswersWorkspace() {
    renderAnswerList();
    renderAnswerEditor();
    updateQuestionModeUI();
}

function renderAnswerList() {
    const list = document.getElementById('questionAnswerList');
    const stats = document.getElementById('questionAnswerStats');
    if (!list) {
        return;
    }

    list.innerHTML = '';
    let incompleteCount = 0;
    state.answerDraft.forEach((answer, index) => {
        const missing = getMissingAnswerLanguages(answer);
        if (missing.length > 0) {
            incompleteCount += 1;
        }

        const item = document.createElement('button');
        item.type = 'button';
        item.className = 'answer-list-item' + (index === state.selectedAnswerIndex ? ' active' : '');
        item.dataset.answerSelect = String(index);

        const preview = (answer.localizations.en.title || '').trim();
        const previewText = preview ? preview.slice(0, 48) : '(no EN text yet)';
        const statusText = missing.length === 0 ? 'Complete' : 'Missing: ' + missing.join(', ');
        const correctText = answer.is_valid ? 'Correct' : 'Incorrect';

        item.innerHTML = '<span class="answer-list-item__index">#' + (index + 1) + '</span>' +
            '<span class="answer-list-item__meta">' +
            '<strong>' + escapeHtml(previewText) + '</strong>' +
            '<small>' + correctText + ' • ' + statusText + '</small>' +
            '</span>';
        list.appendChild(item);
    });

    if (stats) {
        stats.textContent = state.answerDraft.length + ' answers • ' + incompleteCount + ' incomplete';
    }
}

function renderAnswerEditor() {
    const panel = document.getElementById('questionAnswerEditorPanel');
    const empty = document.getElementById('questionAnswerEditorEmpty');
    const input = document.getElementById('questionAnswerTitleInput');
    const correctToggle = document.getElementById('questionAnswerCorrectToggle');
    const tabs = document.getElementById('questionAnswerLanguageTabs');
    const title = document.getElementById('questionAnswerEditorTitle');
    const missing = document.getElementById('questionAnswerMissingHint');

    const selected = state.answerDraft[state.selectedAnswerIndex];
    if (!selected) {
        if (panel) {
            panel.style.display = 'none';
        }
        if (empty) {
            empty.style.display = '';
        }
        return;
    }

    if (panel) {
        panel.style.display = '';
    }
    if (empty) {
        empty.style.display = 'none';
    }

    if (title) {
        title.textContent = 'Answer #' + (state.selectedAnswerIndex + 1);
    }
    if (correctToggle) {
        correctToggle.checked = Boolean(selected.is_valid);
    }
    if (input) {
        input.value = selected.localizations[state.activeAnswerLanguage]?.title || '';
    }
    if (missing) {
        const missingLanguages = getMissingAnswerLanguages(selected);
        missing.textContent = missingLanguages.length === 0
            ? 'All languages filled.'
            : 'Missing: ' + missingLanguages.join(', ');
    }

    if (tabs) {
        Array.from(tabs.querySelectorAll('[data-answer-language]')).forEach((tab) => {
            const language = tab.dataset.answerLanguage;
            if (!language) {
                return;
            }
            const isActive = language === state.activeAnswerLanguage;
            tab.classList.toggle('active', isActive);

            const languageMissing = !selected.localizations[language]?.title;
            tab.classList.toggle('missing', languageMissing);
            tab.textContent = language.toUpperCase() + (languageMissing ? ' *' : '');
        });
    }
}

function collectAnswerPayload() {
    return state.answerDraft.map((answer) => cloneAnswer(answer));
}

function isTheoryMode() {
    return state.answerDraft.length > 0;
}

function updateQuestionModeUI() {
    const theoryMode = isTheoryMode();
    const sqlFields = document.querySelectorAll('[data-query-fields]');
    sqlFields.forEach((section) => {
        section.style.display = theoryMode ? 'none' : '';
    });

    const answersSection = document.getElementById('questionAnswersSection');
    if (answersSection) {
        answersSection.style.display = theoryMode ? '' : 'none';
    }

    const modeBadge = document.getElementById('questionModeBadge');
    if (modeBadge) {
        modeBadge.textContent = theoryMode ? 'Mode: Theoretical (answers)' : 'Mode: SQL query';
    }

    const startTheoryBtn = document.getElementById('questionStartTheoryBtn');
    if (startTheoryBtn) {
        startTheoryBtn.style.display = theoryMode ? 'none' : '';
    }
}

async function questionAnswersSave(questionId) {
    const id = parseInt(questionId, 10) || getCurrentQuestionId();
    if (!id) {
        showStatus('Save the question before saving answers.', 'info');
        return;
    }

    const answers = collectAnswerPayload();
    if (answers.length > 0) {
        if (answers.length < 2) {
            showStatus('At least 2 answers are required', 'error');
            return;
        }
        if (!answers.some((answer) => answer.is_valid)) {
            showStatus('Mark at least 1 answer as correct', 'error');
            return;
        }
        for (let i = 0; i < answers.length; i += 1) {
            const answer = answers[i];
            for (let j = 0; j < SUPPORTED_LANGUAGES.length; j += 1) {
                const language = SUPPORTED_LANGUAGES[j];
                if (!answer.localizations[language].title) {
                    showStatus(`Answer #${i + 1}: ${language.toUpperCase()} text is required`, 'error');
                    return;
                }
            }
        }
    }

    try {
        const response = await safeFetch('/admin/question-answers', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                question_id: id,
                answers
            })
        });
        state.currentQuestionHasAnswers = Boolean(response.have_answers);
        setAnswersDraft(response.answers || []);
        showStatus('Answers saved', 'success');
    } catch (error) {
        console.error(error);
    }
}

function initAnswerEditor() {
    const answersSection = document.getElementById('questionAnswersSection');
    const answerList = document.getElementById('questionAnswerList');
    const input = document.getElementById('questionAnswerTitleInput');
    const correctToggle = document.getElementById('questionAnswerCorrectToggle');
    const languageTabs = document.getElementById('questionAnswerLanguageTabs');

    if (!answersSection || !answerList || !input || !correctToggle || !languageTabs) {
        return;
    }

    const addButton = document.getElementById('questionAddAnswerBtn');
    if (addButton) {
        addButton.addEventListener('click', function () {
            state.answerDraft.push(makeEmptyAnswer());
            state.selectedAnswerIndex = state.answerDraft.length - 1;
            state.activeAnswerLanguage = 'en';
            renderAnswersWorkspace();
        });
    }

    const duplicateButton = document.getElementById('questionDuplicateAnswerBtn');
    if (duplicateButton) {
        duplicateButton.addEventListener('click', function () {
            const selected = state.answerDraft[state.selectedAnswerIndex];
            if (!selected) {
                showStatus('Select an answer to duplicate', 'info');
                return;
            }
            const duplicated = cloneAnswer(selected);
            duplicated.id = 0;
            duplicated.is_valid = false;
            state.answerDraft.splice(state.selectedAnswerIndex + 1, 0, duplicated);
            state.selectedAnswerIndex += 1;
            renderAnswersWorkspace();
        });
    }

    const deleteButton = document.getElementById('questionDeleteAnswerBtn');
    if (deleteButton) {
        deleteButton.addEventListener('click', function () {
            if (state.selectedAnswerIndex < 0 || state.selectedAnswerIndex >= state.answerDraft.length) {
                showStatus('Select an answer to delete', 'info');
                return;
            }
            state.answerDraft.splice(state.selectedAnswerIndex, 1);
            if (state.answerDraft.length === 0) {
                state.selectedAnswerIndex = -1;
            } else if (state.selectedAnswerIndex >= state.answerDraft.length) {
                state.selectedAnswerIndex = state.answerDraft.length - 1;
            }
            renderAnswersWorkspace();
        });
    }

    const startTheoryBtn = document.getElementById('questionStartTheoryBtn');
    if (startTheoryBtn) {
        startTheoryBtn.addEventListener('click', function () {
            state.answerDraft = [makeEmptyAnswer(), makeEmptyAnswer()];
            state.selectedAnswerIndex = 0;
            state.activeAnswerLanguage = 'en';
            renderAnswersWorkspace();
        });
    }

    answerList.addEventListener('click', function (event) {
        const target = event.target.closest('[data-answer-select]');
        if (!target) {
            return;
        }
        const index = parseInt(target.dataset.answerSelect || '-1', 10);
        if (Number.isNaN(index) || index < 0 || index >= state.answerDraft.length) {
            return;
        }
        state.selectedAnswerIndex = index;
        renderAnswersWorkspace();
    });

    correctToggle.addEventListener('change', function () {
        const selected = state.answerDraft[state.selectedAnswerIndex];
        if (!selected) {
            return;
        }
        selected.is_valid = Boolean(correctToggle.checked);
        renderAnswerList();
    });

    input.addEventListener('input', function () {
        const selected = state.answerDraft[state.selectedAnswerIndex];
        if (!selected) {
            return;
        }
        selected.localizations[state.activeAnswerLanguage].title = input.value.trim();
        renderAnswerList();
        renderAnswerEditor();
    });

    languageTabs.addEventListener('click', function (event) {
        const tab = event.target.closest('[data-answer-language]');
        if (!tab) {
            return;
        }
        const language = tab.dataset.answerLanguage;
        if (!language || !SUPPORTED_LANGUAGES.includes(language)) {
            return;
        }
        state.activeAnswerLanguage = language;
        renderAnswerEditor();
    });

    const copyEnButton = document.getElementById('questionCopyEnToEmptyBtn');
    if (copyEnButton) {
        copyEnButton.addEventListener('click', function () {
            const selected = state.answerDraft[state.selectedAnswerIndex];
            if (!selected) {
                return;
            }
            const enText = (selected.localizations.en.title || '').trim();
            if (!enText) {
                showStatus('EN text is empty', 'info');
                return;
            }
            SUPPORTED_LANGUAGES.forEach((language) => {
                if (language === 'en') {
                    return;
                }
                if (!selected.localizations[language].title) {
                    selected.localizations[language].title = enText;
                }
            });
            renderAnswersWorkspace();
        });
    }

    const translateToEmptyButton = document.getElementById('questionTranslateToEmptyBtn');
    if (translateToEmptyButton) {
        translateToEmptyButton.addEventListener('click', async function () {
            const selected = state.answerDraft[state.selectedAnswerIndex];
            if (!selected) {
                showStatus('Select an answer first', 'info');
                return;
            }

            const sourceLanguage = state.activeAnswerLanguage;
            const sourceText = (selected.localizations[sourceLanguage]?.title || '').trim();
            if (!sourceText) {
                showStatus('Source language text is empty', 'info');
                return;
            }

            const targets = SUPPORTED_LANGUAGES.filter((language) => {
                if (language === sourceLanguage) {
                    return false;
                }
                return !(selected.localizations[language]?.title || '').trim();
            });

            if (targets.length === 0) {
                showStatus('No empty languages to translate', 'info');
                return;
            }

            translateToEmptyButton.disabled = true;
            const originalLabel = translateToEmptyButton.textContent;
            translateToEmptyButton.textContent = 'Translating...';

            try {
                const fromLabel = getLanguageLabel(sourceLanguage);
                await Promise.all(targets.map(async (targetLanguage) => {
                    const toLabel = getLanguageLabel(targetLanguage);
                    const translated = await translateField(sourceText, fromLabel, toLabel);
                    selected.localizations[targetLanguage].title = (translated || '').trim();
                }));
                renderAnswersWorkspace();
                showStatus('Translated empty languages', 'success');
            } catch (error) {
                console.error(error);
            } finally {
                translateToEmptyButton.disabled = false;
                translateToEmptyButton.textContent = originalLabel;
            }
        });
    }

    const nextIncompleteButton = document.getElementById('questionNextIncompleteBtn');
    if (nextIncompleteButton) {
        nextIncompleteButton.addEventListener('click', function () {
            for (let i = 0; i < state.answerDraft.length; i += 1) {
                const missing = getMissingAnswerLanguages(state.answerDraft[i]);
                if (missing.length > 0) {
                    state.selectedAnswerIndex = i;
                    state.activeAnswerLanguage = missing[0].toLowerCase();
                    renderAnswersWorkspace();
                    return;
                }
            }
            showStatus('All answers are complete', 'success');
        });
    }

    const initialAnswers = loadInitialAnswersFromDom();
    if (state.answerDraft.length === 0 && initialAnswers.length > 0) {
        setAnswersDraft(initialAnswers);
        return;
    }

    renderAnswersWorkspace();
}

function collectQuestionCheckStates() {
    const checks = [];
    document.querySelectorAll('[data-query-check-row]').forEach((row) => {
        const checkbox = row.querySelector('input[type="checkbox"]');
        const id = row.dataset.checkId;
        if (!checkbox || !id || !checkbox.checked) {
            return;
        }
        checks.push(parseInt(id, 10));
    });
    return checks;
}

async function questionChecksSave(questionId) {
    const id = parseInt(questionId, 10);
    if (!id) {
        showStatus('Save the question before toggling query checks.', 'info');
        return;
    }
    const checks = collectQuestionCheckStates();

    try {
        console.log('Saving question checks for question', id, checks);
        const response = await safeFetch('/admin/question-checks', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                question_id: id,
                checks
            })
        });
        if (response.ok) {
            showStatus('Query checks saved', 'success');
        } else {
            console.error('Failed to save query checks', response);
            showStatus('Failed to save query checks', 'error');
        }
    } catch (error) {
        console.error(error);
    }
}

function collectQuestionCategoryStates() {
    const categories = [];
    document.querySelectorAll('[data-question-category-row]').forEach((row) => {
        const checkbox = row.querySelector('input[type="checkbox"]');
        const id = row.dataset.categoryId;
        if (!checkbox || !id || !checkbox.checked) {
            return;
        }
        categories.push(parseInt(id, 10));
    });
    return categories;
}

async function questionCategoriesSave(questionId) {
    const id = parseInt(questionId, 10);
    if (!id) {
        showStatus('Save the question before toggling categories.', 'info');
        return;
    }
    const categories = collectQuestionCategoryStates();

    try {
        const response = await safeFetch('/admin/question-categories', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                question_id: id,
                categories
            })
        });
        if (response.ok) {
            showStatus('Question categories saved', 'success');
        } else {
            console.error('Failed to save question categories', response);
            showStatus('Failed to save question categories', 'error');
        }
    } catch (error) {
        console.error(error);
    }
}

async function runLLM(task, input, language = 'English') {
    const payload = { task, language };
    console.log(`Running LLM task: ${task} with input:`, input);
    if (task === 'translate') {
        payload.text = input;
        payload.from_lang = document.getElementById('llmFromLang').value.trim() || 'English';
        payload.to_lang = document.getElementById('llmToLang').value.trim() || 'Russian';
    } else {
        payload.context = { question: input };
        payload.style = 'clear and concise';
    }

    try {
        const response = await safeFetch('/admin/llm', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });
        return response.result || 'No response';
    } catch (error) {
        console.error(error);
    }
}

async function safeFetch(url, options = {}) {
    try {
        const headers = { Accept: 'application/json', ...(options.headers || {}) };
        const response = await fetch(url, { ...options, headers });
        const data = await response.json();
        if (!response.ok) {
            const message = data.error || 'Something went wrong';
            showStatus(message, 'error');
            throw new Error(message);
        }
        return data;
    } catch (error) {
        if (!error.message) {
            showStatus('Network error', 'error');
        }
        throw error;
    }
}

function showStatus(message, state = 'info') {
    const toast = document.getElementById("toast");
    if (state !== "error") {
        toast.classList.remove("error");
        state = "info";
    }
    toast.innerText = message || "...";
    toast.classList.remove("info");
    toast.classList.add(state);
    toast.classList.toggle("visible");
    const showTime = state === "error" ? 5000 : 2000;
    setTimeout((function() {
        toast.classList.toggle("visible");
    }
    ), showTime)
}

document.addEventListener('DOMContentLoaded', function () {
    initAnswerEditor();
});
