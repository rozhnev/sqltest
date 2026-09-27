<div style="max-width: 640px; margin: 15vh auto; text-align: center;">
    <h2>Acesso à simulação de entrevista</h2>
    <p>A simulação de entrevista é um recurso pago. Pague o acesso pelo Lava.top para continuar.</p>
    {if $InterviewPaymentUrl}
        <p><a class="button blue" href="{$InterviewPaymentUrl|escape}" target="_blank" rel="noopener noreferrer">Pagar com Lava.top</a></p>
        <p style="font-size: 0.9em;">O acesso é liberado manualmente logo após a confirmação do pagamento.</p>
    {else}
        <p>O pagamento está temporariamente indisponível. Entre em contato conosco para obter acesso.</p>
    {/if}
</div>
