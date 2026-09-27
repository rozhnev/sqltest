<div style="max-width: 640px; margin: 15vh auto; text-align: center;">
    <h2>Acceso a la simulación de entrevista</h2>
    <p>La simulación de entrevista es una función de pago. Paga el acceso a través de Lava.top para continuar.</p>
    {if $InterviewPaymentUrl}
        <p><a class="button blue" href="{$InterviewPaymentUrl|escape}" target="_blank" rel="noopener noreferrer">Pagar con Lava.top</a></p>
        <p style="font-size: 0.9em;">El acceso se concede manualmente poco después de confirmar el pago.</p>
    {else}
        <p>El pago no está disponible temporalmente. Ponte en contacto con nosotros para obtener acceso.</p>
    {/if}
</div>
