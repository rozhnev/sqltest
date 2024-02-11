function translate(from_lang, to_lang, source, destination) {
    
    let formData = new FormData();
    formData.append('from_lang', from_lang);
    formData.append('to_lang', to_lang);
    formData.append('text', document.getElementById(source).value);

    fetch(`/admin/translate`, {
        method: "POST", // *GET, POST, PUT, DELETE, etc.
        mode: "cors", // no-cors, *cors, same-origin
        cache: "default", // *default, no-cache, reload, force-cache, only-if-cached
        credentials: "same-origin", // include, *same-origin, omit
        body: formData,
    })
    .then((async response=>{
      return await response.text();
    }))
    .then((message)=>{
        document.getElementById(destination).value = message;
    })
    .catch(err=>{
        document.getElementById(destination).value = 'Something went wrong. Please try again.';
    });
}