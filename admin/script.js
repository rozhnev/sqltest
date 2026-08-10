const state = {
    questions: [],
    lessons: [],
    modules: [],
    selectedQuestion: null,
    currentQuestionHasAnswers: false,
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
    renderAnswerRows(question.answers || []);
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
    clearAnswerRows();
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

function clearAnswerRows() {
    const body = document.getElementById('questionAnswersTableBody');
    if (body) {
        body.innerHTML = '';
    }
}

function renderAnswerRows(answers) {
    const body = document.getElementById('questionAnswersTableBody');
    if (!body) {
        return;
    }

    body.innerHTML = '';
    answers.forEach((answer) => {
        appendAnswerRow(answer || {});
    });

    updateAnswerRowNumbers();
}

function appendAnswerRow(answer = {}) {
    const body = document.getElementById('questionAnswersTableBody');
    if (!body) {
        return;
    }

    const row = document.createElement('tr');
    row.setAttribute('data-answer-row', '1');
    if (answer.id) {
        row.dataset.answerId = String(answer.id);
    }

    const numberCell = document.createElement('td');
    numberCell.setAttribute('data-answer-row-number', '1');
    row.appendChild(numberCell);

    const validCell = document.createElement('td');
    const validCheckbox = document.createElement('input');
    validCheckbox.type = 'checkbox';
    validCheckbox.checked = Boolean(answer.is_valid);
    validCheckbox.setAttribute('data-answer-valid', '1');
    validCell.appendChild(validCheckbox);
    row.appendChild(validCell);

    SUPPORTED_LANGUAGES.forEach((language) => {
        const languageCell = document.createElement('td');
        const input = document.createElement('input');
        input.type = 'text';
        input.setAttribute('data-answer-title', '1');
        input.setAttribute('data-lang', language);
        input.style.width = '100%';
        input.value = answer.localizations?.[language]?.title || '';
        languageCell.appendChild(input);
        row.appendChild(languageCell);
    });

    const removeCell = document.createElement('td');
    const removeBtn = document.createElement('button');
    removeBtn.type = 'button';
    removeBtn.className = 'button red';
    removeBtn.textContent = 'Remove';
    removeBtn.setAttribute('data-remove-answer', '1');
    removeCell.appendChild(removeBtn);
    row.appendChild(removeCell);

    body.appendChild(row);
}

function updateAnswerRowNumbers() {
    const rows = document.querySelectorAll('[data-answer-row]');
    rows.forEach((row, index) => {
        const numberCell = row.querySelector('[data-answer-row-number]');
        if (numberCell) {
            numberCell.textContent = String(index + 1);
        }
    });
}

function collectAnswerPayload() {
    const rows = Array.from(document.querySelectorAll('[data-answer-row]'));
    return rows.map((row) => {
        const answerId = parseInt(row.dataset.answerId || '0', 10) || 0;
        const isValid = Boolean(row.querySelector('[data-answer-valid]')?.checked);
        const localizations = {};

        SUPPORTED_LANGUAGES.forEach((language) => {
            const field = row.querySelector(`[data-answer-title][data-lang="${language}"]`);
            localizations[language] = {
                title: (field?.value || '').trim()
            };
        });

        return {
            id: answerId,
            is_valid: isValid,
            localizations
        };
    });
}

function isTheoryMode() {
    const rows = document.querySelectorAll('[data-answer-row]');
    return rows.length > 0;
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
        renderAnswerRows(response.answers || []);
        updateQuestionModeUI();
        showStatus('Answers saved', 'success');
    } catch (error) {
        console.error(error);
    }
}

function initAnswerEditor() {
    const answersSection = document.getElementById('questionAnswersSection');
    if (!answersSection) {
        return;
    }

    const addButton = document.getElementById('questionAddAnswerBtn');
    if (addButton) {
        addButton.addEventListener('click', function () {
            appendAnswerRow({});
            updateAnswerRowNumbers();
            updateQuestionModeUI();
        });
    }

    const startTheoryBtn = document.getElementById('questionStartTheoryBtn');
    if (startTheoryBtn) {
        startTheoryBtn.addEventListener('click', function () {
            appendAnswerRow({});
            appendAnswerRow({});
            updateAnswerRowNumbers();
            updateQuestionModeUI();
        });
    }

    answersSection.addEventListener('click', function (event) {
        const removeButton = event.target.closest('[data-remove-answer]');
        if (!removeButton) {
            return;
        }
        const row = removeButton.closest('[data-answer-row]');
        if (!row) {
            return;
        }
        row.remove();
        updateAnswerRowNumbers();
        updateQuestionModeUI();
    });

    updateAnswerRowNumbers();
    updateQuestionModeUI();
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
