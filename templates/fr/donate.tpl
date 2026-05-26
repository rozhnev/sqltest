<link rel="stylesheet" type="text/css" href="/about.css?{$VERSION}" media="all">
<div class="about">
    <div class="section top colored">
        <div>
            <h2>Soutenez SQLtest.online</h2>
        </div>
        <div style="display: block; text-align: left;">
            <p>
                SQLtest.online est une plateforme d'apprentissage SQL gratuite qui aide les étudiants, les développeurs, et toute personne
                souhaitant maîtriser le langage de requête structuré et se préparer aux entretiens techniques.
            </p>
            <p>
                Nous nous efforçons de rendre l'apprentissage du SQL amusant et accessible à tous.
                Votre soutien nous aide à maintenir l'accès gratuit à la plateforme, à assurer le fonctionnement stable du serveur,
                à développer de nouveaux supports de formation et à créer davantage d'exercices SQL interactifs.
            </p>
        </div>
    </div>
    <div class="section" style="height: 100%;">
        <div style="display: block;">      
            <h2 style="color: var(--ligth-h2-color);">Façons de nous soutenir :</h2>
            <div class="donation-methods">
                <div class="donation-method">
                    <h3>Offrez un café en Euro</h3>
                    <p>Paiement simple et sécurisé via la plateforme Ko-fi :</p>
                    <script type='text/javascript' src='https://storage.ko-fi.com/cdn/widget/Widget_2.js'></script>
                    <script type='text/javascript'>
                        kofiwidget2.init('Soutenez-nous sur Ko-fi', 'revert-layer', 'D1D76X1T1');
                        kofiwidget2.draw();
                    </script>
                </div>
                <div class="donation-method">
                    <h3>Soutien en Crypto</h3>
                    <iframe src="https://nowpayments.io/embeds/donation-widget?api_key=8881e1d0-aaef-46c4-9a60-298bb6f26c3b" width="346" height="623" frameborder="0" scrolling="no" style="overflow-y: hidden;">
                        Impossible de charger le widget
                    </iframe>
                </div>
            </div>

            <h2 style="color: var(--ligth-h2-color); margin-top: 2rem;">Derniers dons</h2>
            <div class="donation-method donations-history">
                {if $LatestDonations|@count > 0}
                    <table class="donations-history-table">
                        <thead>
                            <tr>
                                <th>Utilisateur</th>
                                <th>Date</th>
                                <th class="align-right">Montant</th>
                                <th class="align-right">USD</th>
                                <th>Remarque</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$LatestDonations item=donation}
                                <tr>
                                    <td>{$donation.donor_name|escape}</td>
                                    <td>{$donation.donated_at|escape}</td>
                                    <td class="align-right">{$donation.amount|escape} {$donation.currency|escape}</td>
                                    <td class="align-right">$ {$donation.amount_usd|escape}</td>
                                    <td>{$donation.notes|default:'-'|escape}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                {else}
                    <p class="donations-history-empty">Aucun don a afficher pour le moment.</p>
                {/if}
            </div>
        </div>
    </div>
    <div class="section bottom colored">
        <div>
            <h4>
                Merci d'être un membre formidable de la communauté SQLtest.online ! Votre soutien fait une réelle différence. ❤️ 
                Ensemble, nous rendons l'apprentissage du SQL plus accessible et agréable pour tous.
            </h4>
        </div>
    </div>
</div>
