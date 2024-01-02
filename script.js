
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


function jsonToTable(jsonObject) {
  let htmlTable = '';
  try {
      //const jsonObject = JSON.parse(jsonString);
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
      if (!response.ok) throw Error('Something went wrong.');
      return await response.text();
    }))
    .then((message)=>{
      document.getElementById('code-result').innerHTML = message;
      [...document.getElementsByClassName("button test")].map(el=>el.classList.toggle("hidden"));
    })
    .catch(err=>{
      document.getElementById('code-result').innerHTML = 'Something went wrong. Please review your query and try again.';
    });
}

const acc = document.getElementsByClassName("accordion");
for (let i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function () {
    for (let el of document.getElementsByClassName("panel")) el.classList.remove("active");
    this.classList.toggle("active");
    const panel = this.nextElementSibling;
    panel.classList.toggle("active");
   
    // if (panel.style.maxHeight) {
    //   panel.style.maxHeight = null;
    // } else {
    //   panel.style.maxHeight = panel.scrollHeight + "px";
    // }
  });
  if (i == 0) {
    const panel = acc[i].nextElementSibling;
    panel.classList.toggle("active");
  //   if (panel.style.maxHeight) {
  //       panel.style.maxHeight = null;
  //     } else {
  //       panel.style.maxHeight = panel.scrollHeight + "px";
  //     }
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
