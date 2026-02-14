<link rel="stylesheet" type="text/css" href="/about.css?{$VERSION}" media="all">
<style>
.about .colored {
    color: var(--ligth-h2-color);
}
.rank-table {
    width: 100%;
    border-collapse: collapse;
    margin: 1.5rem 0;
}
.rank-table th, .rank-table td {
    padding: 1rem;
    border: 1px solid var(--border-color);
    text-align: left;
}
</style> 
<div class="about">
    <div class="section top colored">
        <div>
            <h2>Testez vos connaissances SQL !</h2>
        </div>
    </div>
    <div class="section not-colored">
        <div>
            <p>Notre test se compose de 12 tâches de différents niveaux de difficulté, sélectionnées au hasard dans la base de données des tâches du site. La difficulté des tâches est déterminée par les résultats des votes des utilisateurs du site.</p>
            Structure du test :
            <ul class="difficulty-list">
                <li class="difficulty-item">4 tâches de niveau "Facile" (Easy)</li>
                <li class="difficulty-item">3 tâches de niveau "Facile" (Easy)</li>
                <li class="difficulty-item">2 tâches de niveau "Moyen" (Average)</li>
                <li class="difficulty-item">2 tâches de niveau "Difficile" (Difficult)</li>
                <li class="difficulty-item">1 tâche de niveau "Difficile" (Difficult)</li>
                </ul>
            </div>
        </div>
        <div class="section colored">
            <div>
                <h2>Temps et grades</h2>
                Trois heures sont allouées pour le test. À la fin du temps (ou avant), vous pourrez obtenir l'un des grades SQL suivants :
                <table class="rank-table">
                    <tr>
                        <th>Grade</th>
                        <th>Exigences</th>
                    </tr>
                    <tr>
                        <td>Intern</td>
                        <td>Résoudre au moins 6 tâches (de n'importe quelle difficulté)</td>
                    </tr>
                    <tr>
                        <td>Junior</td>
                        <td>Résoudre toutes les tâches faciles et simples</td>
                    </tr>
                    <tr>
                        <td>Middle</td>
                        <td>Résoudre toutes les tâches faciles et simples + 2/3 des tâches restantes</td>
                    </tr>
                    <tr>
                        <td>Senior</td>
                        <td>Résoudre toutes les tâches</td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="section not-colored">
            <div>
                <h2>Bonus et Pénalités</h2>
                Résoudre une tâche dès le premier essai apporte des points supplémentaires, et un grand nombre de tentatives sur une tâche peut entraîner une réduction de la note.
                <div class="note-section">
                    <strong>Note :</strong> Le système de notation peut être ajusté en fonction des résultats des tests et des retours des participants.
                </div>
            </div>
        </div>
        <div class="section bottom colored">    {if $User->logged()}
            {if isset($LastTest)}
                {if $LastTest.closed}
                    {if $LastTest.rate eq 1}
                        <h2>Excellent début ! D'après les résultats du test, votre niveau est Intern.</h2>Cela en dit long sur votre potentiel. Voulez-vous progresser davantage et passer au niveau suivant ?
                    {elseif $LastTest.rate eq 2}
                        <h2>Vous êtes sur la bonne voie ! Votre niveau actuel est Junior.</h2>C'est un excellent résultat. Êtes-vous prêt à approfondir vos connaissances et vos compétences ?
                    {elseif $LastTest.rate eq 3}
                        <h2>Vous avez atteint le niveau Middle !</h2>C'est formidable ! Mais il y a toujours une marge de progression, n'est-ce pas ? Prêt à vous mettre au défi et à améliorer vos résultats ?
                    {elseif $LastTest.rate eq 4}
                        <h2>Félicitations ! Vous êtes maintenant Senior !</h2>Prêt à confirmer votre statut ?
                    {else}
                        <h2>Le temps de votre dernier test est écoulé.</h2>Prêt à réessayer ?
                    {/if}
                    <div style="text-align: center;">
                        <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/create" title="Démarrer le test" class="button green">Démarrer le test</a>
                    </div>
                {else}
                    {* Continuer le test ouvert *}
                    <div style="text-align: center;">
                        <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/{$LastTest.id}/question/" title="Continuer le test" class="button green">Continuer le test</a>
                    </div>
                {/if}
            {else}
                <h2>Bonne chance !</h2>
                <div style="text-align: center;">
                    <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/create" title="Démarrer le test" class="button green">Démarrer le test</a>
                </div>
            {/if}
        {else}
            <h2><span class='warning'>
                Cette page n'est pas disponible pour les utilisateurs non inscrits. Veuillez vous connecter pour continuer.
            </span></h2>
            <div style="text-align: center;">
                <button class="button green" onClick="toggleLoginWindow()">Se connecter</button>
            </div>
        {/if}
    </div>
</div>
