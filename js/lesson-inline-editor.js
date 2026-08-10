(function () {
    var article = document.getElementById('lesson-content');
    var trigger = document.getElementById('lesson-edit-trigger');
    if (!article || !trigger) {
        return;
    }

    var lessonId = article.getAttribute('data-lesson-id');
    var lang = article.getAttribute('data-lang');

    var originalHtml = null;

    trigger.addEventListener('click', function () {
        if (originalHtml !== null) {
            return;
        }
        trigger.disabled = true;
        trigger.textContent = '…';

        fetch('/admin/lesson/' + lessonId, {
            headers: { Accept: 'application/json' }
        })
            .then(function (response) {
                if (!response.ok) {
                    throw new Error('Failed to load lesson content');
                }
                return response.json();
            })
            .then(function (data) {
                var localization = (data.lesson && data.lesson.localizations && data.lesson.localizations[lang]) || {};
                openEditor(localization.title || '', localization.content || '');
            })
            .catch(function (error) {
                console.error(error);
                alert('Could not load lesson content for editing.');
            })
            .finally(function () {
                trigger.disabled = false;
                trigger.textContent = 'Edit content';
            });
    });

    function openEditor(title, content) {
        originalHtml = article.innerHTML;

        var titleField = document.createElement('input');
        titleField.type = 'text';
        titleField.id = 'lesson-edit-title';
        titleField.value = title;
        titleField.placeholder = 'Lesson title';
        titleField.style.width = '100%';
        titleField.style.boxSizing = 'border-box';
        titleField.style.marginBottom = '0.75em';

        var textarea = document.createElement('textarea');
        textarea.id = 'lesson-edit-textarea';
        textarea.value = content;
        textarea.rows = 24;
        textarea.style.width = '100%';
        textarea.style.fontFamily = 'monospace';

        var saveBtn = document.createElement('button');
        saveBtn.type = 'button';
        saveBtn.className = 'button green';
        saveBtn.textContent = 'Save';

        var cancelBtn = document.createElement('button');
        cancelBtn.type = 'button';
        cancelBtn.className = 'button red';
        cancelBtn.textContent = 'Cancel';

        var errorBox = document.createElement('div');
        errorBox.className = 'lesson-edit-error';
        errorBox.style.color = 'red';
        errorBox.style.display = 'none';

        var actions = document.createElement('div');
        actions.className = 'lesson-edit-actions';
        actions.style.margin = '0.5em 0';
        errorBox.style.display = 'flex';
        errorBox.style.alignItems = 'center';
        errorBox.style.justifyContent = 'space-between';
        actions.appendChild(saveBtn);
        actions.appendChild(cancelBtn);

        article.innerHTML = '';
        article.appendChild(titleField);
        article.appendChild(textarea);
        article.appendChild(actions);
        article.appendChild(errorBox);
        titleField.focus();

        cancelBtn.addEventListener('click', closeEditor);

        saveBtn.addEventListener('click', function () {
            errorBox.style.display = 'none';
            saveBtn.disabled = true;
            saveBtn.textContent = 'Saving…';

            var payload = {
                language: lang,
                title: titleField.value,
                content: textarea.value
            };

            fetch('/admin/lesson/' + lessonId, {
                method: 'PATCH',
                headers: { 'Content-Type': 'application/json', Accept: 'application/json' },
                body: JSON.stringify(payload)
            })
                .then(function (response) {
                    return response.json().then(function (data) {
                        if (!response.ok) {
                            throw new Error(data.error || 'Save failed');
                        }
                        return data;
                    });
                })
                .then(function () {
                    location.reload();
                })
                .catch(function (error) {
                    saveBtn.disabled = false;
                    saveBtn.textContent = 'Save';
                    errorBox.textContent = error.message || 'Save failed';
                    errorBox.style.display = 'block';
                });
        });
    }

    function closeEditor() {
        if (originalHtml === null) {
            return;
        }
        article.innerHTML = originalHtml;
        originalHtml = null;
    }
})();
