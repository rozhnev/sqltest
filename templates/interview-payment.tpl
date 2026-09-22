{include file='short-header.tpl'}
<body>
    <div class="container">
        <header>
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/interview-start"}
            {else}
                {include file='top-menu.tpl' path="/interview-start"}
            {/if}
        </header>
        <main>
            <div style="max-width: 640px; margin: 15vh auto; text-align: center;">
                <h2>{if $Lang === 'ru'}Доступ к симуляции собеседования{else}Interview simulation access{/if}</h2>
                <p>
                    {if $Lang === 'ru'}
                        Симуляция собеседования — платная функция. Оплатите доступ через Lava.top, чтобы продолжить.
                    {else}
                        The interview simulation is a paid feature. Pay for access via Lava.top to continue.
                    {/if}
                </p>
                {if $InterviewPaymentUrl}
                    <p><a class="button blue" href="{$InterviewPaymentUrl|escape}" target="_blank" rel="noopener noreferrer">
                        {if $Lang === 'ru'}Оплатить через Lava.top{else}Pay with Lava.top{/if}
                    </a></p>
                    <p style="font-size: 0.9em;">
                        {if $Lang === 'ru'}
                            После оплаты доступ будет открыт вручную в течение короткого времени.
                        {else}
                            Access is granted manually shortly after payment is confirmed.
                        {/if}
                    </p>
                {else}
                    <p>
                        {if $Lang === 'ru'}
                            Оплата временно недоступна. Напишите нам, чтобы получить доступ.
                        {else}
                            Payment is temporarily unavailable. Please contact us to get access.
                        {/if}
                    </p>
                {/if}
            </div>
        </main>
        <footer>
            {if $MobileView}
                {include file='m.footer.tpl'}
            {else}
                {include file='footer.tpl'}
            {/if}
        </footer>
    </div>
</body>
</html>
