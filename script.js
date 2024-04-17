function switchTheme(e) {
    const currentTheme = e.target.checked ?  'dark' : 'light';
    window.sql_editor.setTheme(currentTheme === 'dark' ? 'ace/theme/github_dark' : 'ace/theme/xcode');
    document.documentElement.setAttribute('data-theme', currentTheme);
    window.UIConfig.theme = currentTheme;
    saveUIConfig();
    if (document.getElementById('yandex_rtb_R-A-4716552-2')) {
      Ya.Context.AdvManager.render({
        "blockId": "R-A-4716552-2",
        "renderTo": "yandex_rtb_R-A-4716552-2",
        darkTheme: window.UIConfig.theme === 'dark'
      })
    }
}

function setLoader() {
  return document.getElementById('code-result').innerHTML = '<div class="loader">Loading...</div>';
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
        method: "GET", // *GET, POST, PUT, DELETE, etc.
        mode: "cors", // no-cors, *cors, same-origin
        cache: "default", // *default, no-cache, reload, force-cache, only-if-cached
        credentials: "same-origin", // include, *same-origin, omit
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
        htmlTable += "<tr><td>" + (++rn) +"</td><td>" + r.join('</td><td>') + "</td></tr>";
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
    setLoader();
    fetch(`/${lang}/question/${questionId}/query-help`, {
        method: "GET", // *GET, POST, PUT, DELETE, etc.
        mode: "cors", // no-cors, *cors, same-origin
        cache: "default", // *default, no-cache, reload, force-cache, only-if-cached
        credentials: "same-origin", // include, *same-origin, omit
      })
      .then((async response=>{
        if (!response.ok) throw Error('SOmething went wrong.');
        return await response.text();
      }))
      .then((message)=>{
        document.getElementById('code-result').innerHTML = message;
      });
}

function runQuery(lang, questionId) {
  setLoader();
  let formData = new FormData();
  formData.append('query', window.sql_editor.getValue());
  fetch(`/${lang}/question/${questionId}/query-run`, {
    method: "POST", // *GET, POST, PUT, DELETE, etc.
    mode: "cors", // no-cors, *cors, same-origin
    cache: "default", // *default, no-cache, reload, force-cache, only-if-cached
    credentials: "same-origin", // include, *same-origin, omit
    body: formData,
  })
  .then((async response=>{
    if (!response.ok) throw Error('SOmething went wrong.');
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

function testQuery(lang, questionId) {
    setLoader();
    let formData = new FormData();
    formData.append('query', window.sql_editor.getValue());
    fetch(`/${lang}/question/${questionId}/query-test`, {
        method: "POST", // *GET, POST, PUT, DELETE, etc.
        mode: "cors", // no-cors, *cors, same-origin
        cache: "default", // *default, no-cache, reload, force-cache, only-if-cached
        credentials: "same-origin", // include, *same-origin, omit
        body: formData,
    })
    .then((async response=>{
      if (response.ok) {
          [...document.getElementsByClassName("button test")].map(el=>el.classList.toggle("hidden"));
      }
      //throw Error('Something went wrong.');
      return await response.text();
    }))
    .then((message)=>{
        document.getElementById('code-result').innerHTML = message;
    })
    .catch(err=>{
        document.getElementById('code-result').innerHTML = 'Something went wrong. Please review your query and try again.';
    });
}
function rateQuestion(questionId, rate) {
    let formData = new FormData();
    formData.append('rate', rate);
    fetch(`/${lang}/question/${questionId}/rate`, {
        method: "POST", // *GET, POST, PUT, DELETE, etc.
        mode: "cors", // no-cors, *cors, same-origin
        cache: "default", // *default, no-cache, reload, force-cache, only-if-cached
        credentials: "same-origin", // include, *same-origin, omit
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
function scrollQuestionPanel() {
    const activePanel = document.getElementsByClassName("panel active")[0];
    const qurrentQuestion = document.getElementsByClassName("current-question")[0];
    if (activePanel && qurrentQuestion) {
        activePanel.scrollTop = qurrentQuestion.offsetTop - activePanel.offsetTop;
    }
}
function openGitHubLoginPopUp() {
    window.open(
        `https://github.com/login/oauth/authorize?client_id=9a1910d2a6c658fdffc3&redirect_uri=${window.location.protocol}//${window.location.host}/login/github/&scope=user`, 'GitHub Login', 
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
  console.log(window.UIConfig);
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
}

setMenuEventListeners();
setEventListeners();
applyUIConfig();
window.sql_editor = ace.edit("sql-code", {
    mode: "ace/mode/mysql",
    selectionStyle: "text",
    dragEnabled: false,
    useWorker: false
});

window.sql_editor.setTheme(window.UIConfig.theme === 'dark' ? 'ace/theme/github_dark' : 'ace/theme/xcode');
window.sql_editor.setShowPrintMargin(false);
window.sql_editor.setOptions({enableBasicAutocompletion: true});

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