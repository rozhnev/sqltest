
let windowObjectReference = null; // global variable
function openRequestedTab(href) {
    if (windowObjectReference === null || windowObjectReference.closed) {
        const url = `${href}_${window.UIConfig.theme === 'dark' ?  'dark' : 'light'}.png`;
        const popUpParams = `scrollbars=no,resizable=yes,status=no,location=no,toolbar=no,menubar=no,width=0,height=0,left=-1000,top=-1000`;
        windowObjectReference = window.open(url, 'Sakila DB ER Diagram', popUpParams);
    } else {
        windowObjectReference.focus();
    }
}

function switchTheme(e) {
    const currentTheme = e.target.checked ?  'dark' : 'light';
    if (window.sql_editor) {
        window.sql_editor.setTheme(currentTheme === 'dark' ? 'ace/theme/github_dark' : 'ace/theme/xcode');
    }
    document.documentElement.setAttribute('data-theme', currentTheme);
    window.UIConfig.theme = currentTheme;
    saveUIConfig();
    if (document.getElementById('yandex_rtb_R-A-4716552-2')) {
        Ya.Context.AdvManager.render({
            "blockId": "R-A-4716552-2",
            "renderTo": "yandex_rtb_R-A-4716552-2",
            darkTheme: window.UIConfig.theme === 'dark'
        });
    }
    if (document.getElementById('yandex_rtb_R-A-4716552-4')) {
        Ya.Context.AdvManager.render({
            "blockId": "R-A-4716552-4",
            "renderTo": "yandex_rtb_R-A-4716552-4",
            darkTheme: window.UIConfig.theme === 'dark'
        });
    }
}
function formatCode() {
    const beautify = ace.require("ace/ext/beautify");
    const editor_session = window.sql_editor.session;
    beautify.beautify(editor_session);
}
function setLoader(id) {
    return document.getElementById(id).innerHTML = '<div class="loader">Loading...</div>';
}

function showToast(msg) {
    const toast = document.getElementById("toast");
    toast.innerText = msg || "...";
    toast.classList.toggle("visible");
    setTimeout((function() {
        toast.classList.toggle("visible");
    }
    ), 1999)
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
        document.getElementById('menu').innerHTML = message;
        window.UIConfig.questionnire = questionnire;
        saveUIConfig();
        setMenuEventListeners();
    })
    .catch(err=>{
        console.log(err)
    });;
}
function copyCode(msg) {
    const editor = window.sql_editor;
    navigator.clipboard && navigator.clipboard.writeText(editor.getValue()),
    showToast(msg)
}

function clearEditor() {
    const editor = window.sql_editor;
    editor.setValue('');
    editor.focus();
    editor.session.selection.clearSelection();
}

function toggleLoginWindow() {
    const loginWindow = document.getElementById("login-popup");
    setTimeout((function() {
        loginWindow.classList.toggle("visible");
    }
    ), 333)
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
    return `<span class="sql_error">${jsonObject.error}</span>`;
}

function getHelp(lang, questionId) {
    setLoader('code-result');
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
          document.getElementById('code-result').innerHTML = message;
      });
}

function runQuery(lang, questionId) {
  setLoader('code-result');
  let formData = new FormData();
  formData.append('query', window.sql_editor.getValue());
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
  })
  .catch(err=>{
      document.getElementById('code-result').innerHTML = 'Something went wrong. Please review your query and try again.';
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
            [...document.getElementsByClassName("button green")].map(el=>el.classList.toggle("hidden"));
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
function testQuery(lang, questionId) {
    setLoader('code-result');
    let formData = new FormData();
    formData.append('query', window.sql_editor.getValue());
    fetch(`/${lang}/question/${questionId}/query-test`, {
        method: "POST",
        mode: "cors",
        cache: "default",
        credentials: "same-origin",
        body: formData,
    })
    .then((async response=>{
        if (response.ok) {
            [...document.getElementsByClassName("button green")].map(el=>el.classList.toggle("hidden"));
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
    fetch(url, {
        method: "POST",
        mode: "cors",
        cache: "default",
        credentials: "same-origin",
        body: formData,
    })
    .then((async response=>{
        if (response.ok) {
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
function showSolutions(questionId) {
    fetch(`/${lang}/question/${questionId}/solutions`, {
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
          .edit(el.id, {mode: "ace/mode/mysql", dragEnabled: false,  useWorker: false, readOnly: true })
          .setTheme(window.UIConfig.theme === 'dark' ? 'ace/theme/github_dark' : 'ace/theme/xcode');
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
        showToast(message);
      }
    }))
    .catch(err=>{
    });
}
function solutionLike(solutionId) {
    return solutionUpdate(solutionId, 'like');
}
function solutionDislike(solutionId) {
    return solutionUpdate(solutionId, 'dislike');
}
function solutionReport(lang, questionId, solutionId) {
    solutionUpdate(solutionId, 'report')
    .then(()=>showSolutions(questionId));
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
            showToast(message);
        }
    }))
    .catch(err=>{
    });
}
function toggleSolvedTasks(e) {
    [...document.getElementsByClassName("eye-btn")].map(el=>el.classList.toggle("hidden"));
    [...document.getElementsByClassName("question-link solved")].map(el=>{
        el.parentNode.classList.toggle("invisible")
    });
    window.UIConfig.hideSolvedTasks = !window.UIConfig.hideSolvedTasks;
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
function scrollInfoPanel(ancor) {
    document.getElementById("db-description").scrollTo(
        { 
            top: (document.getElementById(ancor).offsetTop - document.getElementById("db-description").offsetTop), 
            behavior: "smooth" 
        }
   )
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
    window.open(
        `https://github.com/login/oauth/authorize?client_id=9a1910d2a6c658fdffc3&redirect_uri=${window.location.protocol}//${window.location.host}/login/github/&scope=user`, 'GitHub Login', 
        `scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=530,height=950,left=${(window.outerWidth - 530) / 2},top=${(window.outerHeight - 950) / 2}`
    );
}
function openVKLoginPopUp() {
    const uuid = '29890eb2-6a16-0613-190f-250e54537e18'; // Generate a random string. We recommend using at least 36 characters. This string will be used to verify that the request is coming from your app.
    const appId = 51931966; // Your app identifier.
    // const redirect_uri = `${window.location.protocol}//${window.location.host}/login/vk/`;
    const redirect_uri = `https://sqltest.online/login/vk/`;
    const redirect_state = 'login'; // Your app's state or any arbitrary string that will be added to the URL after authentication.

    const query = `uuid=${uuid}&app_id=${appId}&response_type=silent_token&redirect_uri=${redirect_uri}&redirect_state=${redirect_state}`;

    window.open(
        `https://id.vk.com/auth?${query}`,
        'VK Login',
        `scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=530,height=950,left=${(window.outerWidth - 530) / 2},top=${(window.outerHeight - 950) / 2}`
    );
}
function openGoogleLoginPopUp() {
    const params = {
        response_type: 'code',
        client_id: '340274762951-1d5m1pb8p9i2bhjbtuc4p8q9gveuk2ug.apps.googleusercontent.com',
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

function setMenuEventListeners() {
    [...document.getElementsByClassName("accordion")].map(el=>{
      el.addEventListener ('click', function() {
          for (let el of document.getElementsByClassName("panel")) el.classList.remove("active");
          for (let el of document.getElementsByClassName("accordion")) el.classList.remove("active");
          this.classList.toggle("active");
          const panel = this.nextElementSibling;
          panel.classList.toggle("active");
      });
    });

    [...document.getElementsByClassName("eye-btn")].map(el=>{
      el.addEventListener ('click', e=>{
          e.preventDefault();
          toggleSolvedTasks()
      });
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
                console.log(event.target.href);
                openRequestedTab(event.target.href);
                event.preventDefault();
            },
            false,
        );
    }
}

setMenuEventListeners();
setEventListeners();
applyUIConfig();
if (document.getElementById("sql-code")) {

    window.sql_editor = ace.edit("sql-code", {
        mode: "ace/mode/mysql",
        selectionStyle: "text",
        dragEnabled: false,
        useWorker: false
    });

    window.sql_editor.setTheme(window.UIConfig.theme === 'dark' ? 'ace/theme/github_dark' : 'ace/theme/xcode');
    window.sql_editor.setShowPrintMargin(false);
    window.sql_editor.setOptions({enableBasicAutocompletion: true});
}

window.onload = function() {
    scrollQuestionPanel();
    document.addEventListener('keydown', function(event) {
        if (event.ctrlKey && event.key === 'Enter') {
            runQuery(lang, db, questionId);
        }
    });

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
          buttonSize: 'm',
          buttonView: 'icon',
          buttonTheme: 'light',
          buttonBorderRadius: "0",
          buttonIcon: 'ya',
      }
    )
    .then(({handler}) => handler())
    .then(data => alert('Сообщение с токеном', data))
    .catch(error => alert('Обработка ошибки', error));
};