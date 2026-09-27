{* Text of the AI tokens page, see templates/tokens.tpl *}
{if $part == 'title'}Jetons d'IA
{elseif $part == 'intro'}
    <p>Les jetons d'IA paient les fonctions d'IA de SQLTest.online :</p>
    <ul>
        <li>l'assistant de leçon, qui répond aux questions sur la leçon que vous lisez</li>
        <li>la vérification par IA des réponses libres</li>
    </ul>
    <p>Un pack vous donne <b>{$TokensPack}</b> jetons. C'est un paiement unique, et les jetons n'expirent jamais.</p>
{elseif $part == 'login_prompt'}Les jetons sont ajoutés à votre compte, veuillez donc d'abord vous connecter.
{elseif $part == 'login_button'}Se connecter
{elseif $part == 'payment_success'}Paiement reçu ! Les jetons seront ajoutés dans quelques secondes ; cette page se rafraîchit automatiquement.
{elseif $part == 'payment_failed'}Le paiement n'a pas abouti. Réessayez ou utilisez une autre carte.
{elseif $part == 'payment_cancelled'}Le paiement a été annulé. Vous pouvez acheter des jetons à tout moment.
{elseif $part == 'balance'}Votre solde : <b>{$AiQuota.remaining_text}</b> jetons d'IA
{elseif $part == 'unavailable'}Le paiement est temporairement indisponible. Contactez-nous pour acheter des jetons.
{elseif $part == 'email_prompt'}Lava.top, notre prestataire de paiement, envoie les reçus par e-mail. Ajoutez d'abord un e-mail à votre compte.
{elseif $part == 'email_placeholder'}vous@exemple.com
{elseif $part == 'email_save'}Enregistrer l'e-mail
{elseif $part == 'promo_code_label'}Vous avez un code promo ?
{elseif $part == 'promo_code_placeholder'}Code promo
{elseif $part == 'buy_button'}Acheter {$TokensPack} jetons
{elseif $part == 'checkout_note'}Paiement unique sécurisé via Lava.top en USD.
{elseif $part == 'history_title'}Vos achats
{elseif $part == 'history_date'}Date
{elseif $part == 'history_tokens'}Jetons
{elseif $part == 'history_amount'}Payé
{/if}
