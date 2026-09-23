<div style="max-width: 640px; margin: 15vh auto; text-align: center;">
    <h2>Доступ к симуляции собеседования</h2>
    <p>Симуляция собеседования — платная функция. Оплатите доступ через Lava.top, чтобы продолжить.</p>
    {if $InterviewPaymentUrl}
        <p><a class="button blue" href="{$InterviewPaymentUrl|escape}" target="_blank" rel="noopener noreferrer">Оплатить через Lava.top</a></p>
        <p style="font-size: 0.9em;">После оплаты доступ будет открыт вручную в течение короткого времени.</p>
    {else}
        <p>Оплата временно недоступна. Напишите нам, чтобы получить доступ.</p>
    {/if}
</div>
