/**
 * Test pages (test.tpl, m.test.tpl): checking a solution, the countdown and the solved tasks bar of the status block
 * (test_overview.tpl). Loaded after script.js (setLoader()). Minified to test.min.js by CI (.github/workflows).
 */

/**
 * Test status block (test_overview.tpl): a countdown that drains a ring, from data-seconds-left (server time, so the
 * browser's time zone doesn't matter), and the solved tasks bar. The ring turns orange in the last 20% or 10 minutes
 * and red in the last 5 minutes; at zero the block shows the "time is over" template.
 */
function initTestOverview() {
    const block = document.getElementById('test-timer');
    const ring = document.getElementById('test-countdown-left');
    const label = document.getElementById('test-timer-time');
    if (!block || !ring || !label) {
        return;
    }
    const duration = Math.max(1, parseInt(block.dataset.duration, 10) || 1);
    const deadline = Date.now() + (parseInt(block.dataset.secondsLeft, 10) || 0) * 1000;
    const daysShort = block.dataset.daysShort || 'd';
    const pad = (n) => String(n).padStart(2, '0');

    const tick = () => {
        const left = Math.max(0, Math.round((deadline - Date.now()) / 1000));
        if (left === 0) {
            clearInterval(timer);
            const over = document.getElementById('test-time-over');
            block.classList.remove('is-warning', 'is-danger');
            block.replaceChildren(over ? over.content.cloneNode(true) : '');
            return;
        }
        const days = Math.floor(left / 86400);
        const hours = Math.floor(left % 86400 / 3600);
        const minutes = Math.floor(left % 3600 / 60);
        const seconds = left % 60;
        label.textContent = days > 0
            ? `${days} ${daysShort} ${pad(hours)}:${pad(minutes)}:${pad(seconds)}`
            : (hours > 0 ? `${hours}:${pad(minutes)}:${pad(seconds)}` : `${pad(minutes)}:${pad(seconds)}`);
        ring.setAttribute('stroke-dasharray', `${(left / duration * 100).toFixed(2)} 100`);
        block.classList.toggle('is-danger', left <= 300);
        block.classList.toggle('is-warning', left > 300 && (left <= 600 || left / duration <= 0.2));
    };
    const timer = setInterval(tick, 1000);
    tick();
}
document.addEventListener('DOMContentLoaded', initTestOverview);

/**
 * A correct check on a test page: the first time a task is solved, mark it in the menu and move the progress bar
 */
function markTestTaskSolved() {
    const block = document.getElementById('test-timer');
    const current = document.querySelector('.question-link.current-question');
    if (!block || !current || current.classList.contains('solved')) {
        return;
    }
    current.classList.add('solved');
    const number = current.querySelector('.question-number');
    if (number) {
        number.innerHTML = '<span class="qts-error-emoji" role="img" aria-label="sparkle">✨</span> &nbsp;';
    }
    const total = parseInt(block.dataset.total, 10) || 0;
    const solved = Math.min(total, (parseInt(block.dataset.solved, 10) || 0) + 1);
    block.dataset.solved = solved;
    const count = document.getElementById('test-progress-count');
    const fill = document.getElementById('test-progress-fill');
    const bar = fill && fill.parentElement;
    if (count) {
        count.textContent = `${solved} / ${total}`;
    }
    if (fill && total > 0) {
        fill.style.width = `${Math.round(solved * 100 / total)}%`;
        bar.setAttribute('aria-valuenow', solved);
    }
}

function checkSolution(url) {
    setLoader('code-result');
    let formData = new FormData();
    if (window.sql_editor) {
        formData.append('query', window.sql_editor.getValue());
    }
    if (document.getElementById('answers-list')) {
        const answers = [...document.querySelectorAll('input[name=answers]:checked')]
        .reduce(
            (res, el)=>{res.push(parseInt(el.value)); return res;}, 
            []
        )
        .toSorted();
        formData.append('answers', JSON.stringify(answers));
    }
    if (document.getElementById('free-answer-input')) {
        const freeAnswer = document.getElementById('free-answer-input').value;
        formData.append('free-answer', freeAnswer);
        console.log('Free answer:', freeAnswer);
    }
    fetch(url, {
        method: "POST",
        mode: "cors",
        cache: "default",
        credentials: "same-origin",
        body: formData,
    })
    .then((async response=>{
        if (response.ok) {
            markTestTaskSolved();
            document.getElementById("checkSolutionBtn") && document.getElementById("checkSolutionBtn").classList.toggle("hidden");
            document.getElementById("nextQuestionBtn") && document.getElementById("nextQuestionBtn").classList.toggle("hidden");
        } else {
            // decrease attempts counter
            let attempts = document.getElementById('attemptsCount').innerText;
            if (parseInt(attempts) > 0) {
                document.getElementById('attemptsCount').innerText = (attempts - 1).toString();
            }
        }
        return await response.text();
    }))
    .then((message)=>{
        document.getElementById('code-result').innerHTML = message;
    })
    .catch(err=>{
        document.getElementById('code-result').innerHTML = 'Something went wrong. Please review your query and try again.';
    });
}
