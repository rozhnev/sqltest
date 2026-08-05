(function () {
    var form = document.getElementById('lesson-form');
    if (!form) {
        return;
    }

    var LANGUAGES = ['en', 'ru', 'pt', 'fr'];
    var statusBar = document.getElementById('statusBar');

    function showStatus(message, isError) {
        if (!statusBar) {
            return;
        }
        statusBar.textContent = message;
        statusBar.style.color = isError ? 'red' : '';
    }

    function field(id) {
        var el = document.getElementById(id);
        return el ? el.value : '';
    }

    form.addEventListener('submit', function (event) {
        event.preventDefault();

        var lessonId = parseInt(form.getAttribute('data-lesson-id'), 10) || 0;
        var payload = {
            slug: field('lesson-slug'),
            module_id: parseInt(field('lesson-module'), 10) || 0,
            localizations: {}
        };

        LANGUAGES.forEach(function (lang) {
            payload.localizations[lang] = {
                title: field('lesson-title-' + lang),
                description: field('lesson-description-' + lang),
                content: field('lesson-content-' + lang)
            };
        });

        var submitBtn = form.querySelector('button[type="submit"]');
        if (submitBtn) {
            submitBtn.disabled = true;
        }

        var method = lessonId > 0 ? 'PUT' : 'POST';
        var url = lessonId > 0 ? '/admin/lesson/' + lessonId : '/admin/lesson';

        fetch(url, {
            method: method,
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
            .then(function (data) {
                showStatus('Lesson saved', false);
                if (lessonId === 0 && data.lesson && data.lesson.id) {
                    window.location.href = '/admin/lesson/' + data.lesson.id;
                }
            })
            .catch(function (error) {
                showStatus(error.message || 'Save failed', true);
            })
            .finally(function () {
                if (submitBtn) {
                    submitBtn.disabled = false;
                }
            });
    });
})();
