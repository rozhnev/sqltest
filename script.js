
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
  try {
      htmlTable = "<table class='result-table'><tr><th>" + jsonObject.headers.map(h=>h.header).join('</th><th>') + "</th></tr>";
      for (let r of jsonObject.data) {
        htmlTable += "<tr><td>" + r.join('</td><td>') + "</td></tr>";
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

function getHelp(lang, db, questionId) {
    setLoader();
    fetch(`/${lang}/${db}/${questionId}/query-help`, {
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

function runQuery(lang, db, questionId) {
  setLoader();
  let formData = new FormData();
  formData.append('query', window.sql_editor.getValue());
  fetch(`/${lang}/${db}/${questionId}/query-run`, {
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
    const jsonObject = JSONmessage[0];
    document.getElementById('code-result').innerHTML = jsonObject.error 
      ? errorToTable(jsonObject) 
      : jsonToTable(jsonObject);
  })
  .catch(err=>{
    document.getElementById('code-result').innerHTML = 'Something went wrong. Please review your query and try again.';
  });
}

function testQuery(lang, db, questionId) {
    setLoader();
    let formData = new FormData();
    formData.append('query', window.sql_editor.getValue());
    fetch(`/${lang}/${db}/${questionId}/query-test`, {
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
function toggleInfoPanel() {
  document.getElementsByClassName("right")[0].classList.toggle("hidden");
  document.getElementsByClassName("main")[0].classList.toggle("wide");
  [...document.getElementsByClassName("splitter")[0].children].map(el=>el.classList.toggle("hidden"));
  return false;
}
function openGitHubLoginPopUp() {
    window.open(
        'https://github.com/login/oauth/authorize?client_id=9a1910d2a6c658fdffc3&redirect_uri=https://sqltest.online/login/github/&scope=user', 'GitHub Login', 
        `scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=530,height=950,left=${(window.outerWidth - 530) / 2},top=${(window.outerHeight - 950) / 2}`
    );
}

const acc = document.getElementsByClassName("accordion");
for (let i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function () {
    for (let el of document.getElementsByClassName("panel")) el.classList.remove("active");
    this.classList.toggle("active");
    const panel = this.nextElementSibling;
    panel.classList.toggle("active");
  });
  if (i == 0) {
    const panel = acc[i].nextElementSibling;
    panel.classList.toggle("active");
  }
}
window.sql_editor = ace.edit("sql-code", {
    mode: "ace/mode/mysql",
    selectionStyle: "text",
    dragEnabled: false,
    useWorker: false
});
window.sql_editor.setShowPrintMargin(false);
window.sql_editor.setOptions({enableBasicAutocompletion: true});

function onSuccessGoogleLogin(googleUser) {
  console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
}
function onFailureGoogleLogin(error) {
  console.log(error);
}

window.onload = function() {
    document.addEventListener('keydown', function(event) {
        if (event.ctrlKey && event.key === 'Enter') {
            runQuery(lang, db, questionId);
        }
    });

    window.YaAuthSuggest.init(
      {
          client_id: '6a7ad9d0d23a496987255a596b83b9db',
          response_type: 'code',
          redirect_uri: `https://sqltest.online/login/yandex/?lang=${lang}&db=${db}&questionId=${questionId}`
      },
      `https://sqltest.online/login/yandex/?lang=${lang}&db=${db}&questionId=${questionId}`,
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

    gapi.signin2.render('googleLogin', {
      'scope': 'profile email',
      'width': 36,
      'height': 36,
      'longtitle': true,
      'theme': 'dark',
      'onsuccess': onSuccessGoogleLogin,
      'onfailure': onFailureGoogleLogin
    });
};