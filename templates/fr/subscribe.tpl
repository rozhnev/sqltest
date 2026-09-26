{* Text of the subscribe page, see templates/subscribe.tpl *}
{if $part == 'title'}Abonnement SQLTest.online
{elseif $part == 'intro'}
    <p>L'abonnement mensuel soutient le projet et débloque :</p>
    <ul>
        <li>Un site sans publicité</li>
        <li>Un budget d'IA {$SubscriptionAiMultiplier}× plus élevé, renouvelé chaque mois : l'assistant des leçons et la vérification des réponses par IA</li>
    </ul>
{elseif $part == 'login_prompt'}L'abonnement est lié à votre compte, veuillez donc d'abord vous connecter.
{elseif $part == 'login_button'}Se connecter
{elseif $part == 'payment_success'}Paiement reçu ! Votre abonnement sera activé dans quelques secondes ; cette page se rafraîchit automatiquement.
{elseif $part == 'payment_failed'}Le paiement n'a pas abouti. Réessayez ou utilisez une autre carte.
{elseif $part == 'payment_cancelled'}Le paiement a été annulé. Vous pouvez vous abonner à tout moment.
{elseif $part == 'status_active'}Votre abonnement est actif jusqu'au <b>{$SubscriptionActiveThrough}</b> inclus et se renouvelle automatiquement chaque mois.
{elseif $part == 'status_cancelled'}Votre abonnement est actif jusqu'au <b>{$SubscriptionActiveThrough}</b> inclus. Le renouvellement automatique est annulé, il ne sera donc pas renouvelé.
{elseif $part == 'status_manual'}Votre abonnement est actif jusqu'au <b>{$SubscriptionActiveThrough}</b> inclus.
{elseif $part == 'renewal_failed'}Nous n'avons pas pu débiter votre carte pour le mois suivant. L'abonnement se termine après le <b>{$SubscriptionActiveThrough}</b> si le paiement n'aboutit pas ; vérifiez votre carte sur Lava.top ou abonnez-vous à nouveau après son expiration.
{elseif $part == 'status_free'}Vous êtes sur l'offre gratuite.
{elseif $part == 'budget_subscriber'}Budget d'IA : {$AiQuota.percent_used} % utilisé · renouvelé le {$AiQuota.resets_at}
{elseif $part == 'budget_free'}Quota d'IA gratuit : {$AiQuota.percent_used} % utilisé · unique, non renouvelable
{elseif $part == 'budget_final'}Budget d'IA : {$AiQuota.percent_used} % utilisé
{elseif $part == 'cancel_button'}Annuler le renouvellement automatique
{elseif $part == 'cancel_confirm'}Annuler le renouvellement automatique ? L'abonnement reste actif jusqu'à la fin de la période payée.
{elseif $part == 'unavailable'}Le paiement est temporairement indisponible. Contactez-nous pour vous abonner.
{elseif $part == 'email_prompt'}Lava.top, notre prestataire de paiement, envoie les reçus par e-mail. Ajoutez d'abord un e-mail à votre compte.
{elseif $part == 'email_placeholder'}vous@exemple.com
{elseif $part == 'email_save'}Enregistrer l'e-mail
{elseif $part == 'subscribe_button'}S'abonner
{elseif $part == 'subscribe_again_button'}Se réabonner
{elseif $part == 'checkout_note'}Paiement sécurisé via Lava.top en USD. L'abonnement se renouvelle chaque mois ; vous pouvez annuler le renouvellement automatique ici à tout moment.
{/if}
