
function setLoader() {
  return document.getElementById('code-result').innerHTML = '<div class="loader">Loading...</div>';
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
  .then((message)=>{
    document.getElementById('code-result').innerHTML = message;
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
    if (!response.ok) throw Error('SOmething went wrong.');
    return await response.text();
  }))
  .then((message)=>{
    document.getElementById('code-result').innerHTML = message;
  });}

const acc = document.getElementsByClassName("accordion");
for (let i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function () {
    this.classList.toggle("active");
    const panel = this.nextElementSibling;
    if (panel.style.maxHeight) {
      panel.style.maxHeight = null;
    } else {
      panel.style.maxHeight = panel.scrollHeight + "px";
    }
  });
  console.log(i, acc[i])
  if (i == 0) {
    const panel = acc[i].nextElementSibling;
    if (panel.style.maxHeight) {
        panel.style.maxHeight = null;
      } else {
        panel.style.maxHeight = panel.scrollHeight + "px";
      }
  }
}
window.sql_editor = ace.edit("sql-code", {
    mode: "ace/mode/mysql",
    selectionStyle: "text",
    dragEnabled: false,
    useWorker: false
});
// window.sql_editor.setTheme(`ace/theme/${currentTheme}`);
window.sql_editor.setShowPrintMargin(false);
window.sql_editor.setOptions({enableBasicAutocompletion: true});
