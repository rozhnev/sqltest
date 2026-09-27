<div style="max-width: 640px; margin: 15vh auto; text-align: center;">
    <h2>Accès à la simulation d'entretien</h2>
    <p>La simulation d'entretien est une fonctionnalité payante. Payez l'accès via Lava.top pour continuer.</p>
    {if $InterviewPaymentUrl}
        <p><a class="button blue" href="{$InterviewPaymentUrl|escape}" target="_blank" rel="noopener noreferrer">Payer avec Lava.top</a></p>
        <p style="font-size: 0.9em;">L'accès est accordé manuellement peu après la confirmation du paiement.</p>
    {else}
        <p>Le paiement est temporairement indisponible. Contactez-nous pour obtenir l'accès.</p>
    {/if}
</div>
