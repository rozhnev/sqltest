<h2>Abonnement SQLTest.online</h2>
<p>L'abonnement mensuel soutient le projet et débloque :</p>
<ul>
    <li>Un site sans publicité</li>
    <li>Un budget d'IA {$SubscriptionAiMultiplier}× plus élevé, renouvelé chaque mois : l'assistant des leçons et la vérification des réponses par IA</li>
</ul>

{if !$User->logged()}
    <div class="subscribe-actions">
        <p>L'abonnement est lié à votre compte, veuillez donc d'abord vous connecter.</p>
        <p><a class="button green" href="" onClick="toggleLoginWindow(); return false;">Se connecter</a></p>
    </div>
{else}
    <div class="subscribe-status">
        {if $AiQuota.subscribed}
            <p>Votre abonnement est actif jusqu'au <b>{$SubscriptionActiveThrough}</b> inclus.</p>
            <p>Budget d'IA : {$AiQuota.percent_used} % utilisé · renouvelé le {$AiQuota.resets_at}</p>
        {else}
            <p>Vous êtes sur l'offre gratuite.</p>
            <p>Quota d'IA gratuit : {$AiQuota.percent_used} % utilisé · unique, non renouvelable</p>
        {/if}
        <div class="subscribe-meter"><div style="width: {$AiQuota.percent_used}%"></div></div>
    </div>
    <div class="subscribe-actions">
        {if $SubscriptionPaymentUrl}
            <p><a class="button blue" href="{$SubscriptionPaymentUrl|escape}" target="_blank" rel="noopener noreferrer">{if $AiQuota.subscribed}Renouveler avec Lava.top{else}S'abonner avec Lava.top{/if}</a></p>
            <p class="subscribe-note">
                L'abonnement est activé manuellement peu après la confirmation du paiement.
                {if $UserEmail}Veuillez payer avec l'e-mail de votre compte <b>{$UserEmail|escape}</b> afin que nous puissions associer le paiement.{else}Après le paiement, contactez-nous pour que nous associions le paiement à votre compte.{/if}
            </p>
        {else}
            <p>Le paiement est temporairement indisponible. Contactez-nous pour vous abonner.</p>
        {/if}
    </div>
{/if}
