<div id="db-description" class="db-description">
    {if $User->showAd()}
        {if $Lang == 'ru'}
            <div class="referal-add-block">
                <a href="https://redirect.appmetrica.yandex.com/serve/606193546294247668?clid=14743932&appmetrica_js_redirect=0" target="_blank" rel="nofollow">
                    <img src="/images/banner_240x400.jpg" alt="Яндекс — с Алисой АI">
                    <p style="font-size: x-small;">ERID: 5jtCeReNx12oajxTXb1tjxc</p>
                </a>
            </div>
        {/if}
        {if $Book}        
            <div class="referal-add-block">
                <div class="book-card">
                    <a href="{{$Book.referral_link}}" target="_blank" style="text-decoration: none; color: var(--question-color);">
                        <div style="display: flex; flex-direction: row; border: 1px solid var(--text-block-border-color);color: var(--question-text); border-radius: 6px; padding: 0.3em; width: 98%;">
                        <div  style = "width: 25%;">
                            <img style="width: 100%;" src="{{$Book.picture_link}}" alt="{{$Book.title|escape:"html"}}">
                        </div>
                        <div style="font-size: 1em;  width: 75%;  padding: 0 0.7em; font-weight: 100; height: 250px; overflow: auto;">
                            <div>{{$Book.title|escape:"html"}}</div>
                            <div style="font-size: small; padding-top: 0.5em;">{{$Book.description|escape:"html"}}</div>
                        </div>
                        </div>
                    </a>
                </div>
            </div>
        {/if}
    {/if} 
</div>