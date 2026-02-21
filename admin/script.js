const state = {
    questions: [],
    lessons: [],
    modules: [],
    selectedQuestion: null,
    selectedLessonId: null,
    statusTimer: null,
    initialLessonId: parseInt(window.ADMIN_CONFIG.lessonId ?? 0, 10) || 0
};

const LANGUAGE_LABELS = {
    EN: 'English',
    RU: 'Russian',
    PT: 'Portuguese',
    FR: 'French'
};

function populateQuestionForm(question) {
    document.getElementById('questionDb').value = question.db || 'sakila';
    document.getElementById('questionDbTemplate').value = question.db_template || 'sakila';
    document.getElementById('questionSolution').value = question.solution_query || '';
    document.getElementById('questionMatch').value = question.query_match || '';
    document.getElementById('questionNotMatch').value = question.query_not_match || '';
    document.getElementById('questionResult').value = question.query_valid_result || '';

    const localizations = question.localizations || {};
    const en = localizations.en || {};
    const ru = localizations.ru || {};

    document.getElementById('questionTitleEn').value = en.title || '';
    document.getElementById('questionTaskEn').value = en.task || '';
    document.getElementById('questionHintEn').value = en.hint || '';

    document.getElementById('questionTitleRu').value = ru.title || '';
    document.getElementById('questionTaskRu').value = ru.task || '';
    document.getElementById('questionHintRu').value = ru.hint || '';

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
    document.getElementById('questionForm').reset();
    state.selectedQuestion = null;
    document.querySelectorAll('[data-query-check-row] input[type="checkbox"]').forEach((checkbox) => {
        checkbox.checked = false;
    });
    document.querySelectorAll('[data-question-category-row] input[type="checkbox"]').forEach((checkbox) => {
        checkbox.checked = false;
    });
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
    return {
        db: document.getElementById('questionDb').value.trim() || 'sakila',
        db_template: document.getElementById('questionDbTemplate').value.trim() || 'sakila',
        solution_query: document.getElementById('questionSolution').value.trim(),
        query_checks: queryChecks,
        categories: questionCategories,
        query_match: document.getElementById('questionMatch').value.trim(),
        query_not_match: document.getElementById('questionNotMatch').value.trim(),
        query_valid_result: document.getElementById('questionResult').value.trim(),
        query_pre_check: document.getElementById('questionPreCheck').value.trim(),
        query_check: document.getElementById('questionCheck').value.trim(),
        localizations: {
            en: {
                title: document.getElementById('questionTitleEn').value.trim(),
                task: document.getElementById('questionTaskEn').value.trim(),
                hint: document.getElementById('questionHintEn').value.trim()
            },
            ru: {
                title: document.getElementById('questionTitleRu').value.trim(),
                task: document.getElementById('questionTaskRu').value.trim(),
                hint: document.getElementById('questionHintRu').value.trim()
            }
        }
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

    const question = {
        language: normalizedLanguage,
        title: document.getElementById(`questionTitle${normalizedLanguage}`).value.trim(),
        task: document.getElementById(`questionTask${normalizedLanguage}`).value.trim(),
        hint: document.getElementById(`questionHint${normalizedLanguage}`).value.trim(),
        questionSolution: document.getElementById('questionSolution').value.trim(),
    };
    const input = `Review this question:

        Title: ${question.title}
        Task: ${question.task}
        Hint: ${question.hint}
        Solution query:  ${question.questionSolution}
        
        Return answer in language ${LANGUAGE_LABELS[normalizedLanguage] || normalizedLanguage}
        `;
    response = await runLLM('question-review', input, LANGUAGE_LABELS[normalizedLanguage]);
    document.getElementById(`questionLLMResult${normalizedLanguage}`).innerHTML = response;   
    // showStatus('Review completed', 'success');
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
    const hint  = document.getElementById(`questionHint${normalizedLanguage}`)?.value.trim();

    if (!title || !task || !hint) {
        showStatus('Provide title, task, and hint in Source language before translating.', 'info');
        return;
    }

    const toTranslate = `Title: ${title}\nTask: ${task}\nHint: ${hint}`.trim();

    try {
        const translated = await translateField(toTranslate, sourceLanguage, targetLanguage);
        const container = document.getElementById(`questionLLMResult${targetLanguage.toUpperCase()}`);
        if (container) {
            container.innerHTML = translated.replace(/\n/g, '<br>');
        }
        // showStatus(`Translation to ${targetLabel} ready`, 'success');
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

    if (!title || !task || !hint || title === '' || task === '' || hint === '') {
        showStatus('All fields are required', 'error');
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
        // showStatus(`Localization saved (${language})`, 'success');
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

function showStatus(message, type = 'info') {
    const bar = document.getElementById('statusBar');
    bar.textContent = message;
    bar.dataset.status = type;
    bar.classList.add('is-visible');
    clearTimeout(state.statusTimer);
    state.statusTimer = setTimeout(() => bar.classList.remove('is-visible'), 4500);
}
