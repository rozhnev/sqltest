<div id="db-description" class="db-description">
    <div>
        <h2>Qui est un Data Engineer ?</h2>
        <p>Un Data Engineer conçoit et maintient les systemes qui collectent, transforment et livrent les donnees pour l'analyse et la prise de decision.</p>

        <h3>Que fait un Data Engineer ?</h3>
        <ul>
            <li>Construit des pipelines ETL/ELT fiables a partir de plusieurs sources.</li>
            <li>Prepare des jeux de donnees propres et structures pour les analystes et data scientists.</li>
            <li>Concoit des schemas de data warehouse (tables de faits et dimensions).</li>
            <li>Surveille la qualite, la fraicheur des donnees et les echecs des pipelines.</li>
            <li>Optimise les performances SQL et les couts de traitement.</li>
        </ul>

        <h3>Que doit connaitre un Data Engineer ?</h3>
        <ul>
            <li>SQL solide : jointures, agregations, fonctions fenetre et optimisation.</li>
            <li>Modelisation des donnees : normalisation, denormalisation, schemas en etoile et en flocon.</li>
            <li>Principes d'orchestration et de planification des pipelines.</li>
            <li>Concepts batch et streaming, chargements incrementaux et idempotence.</li>
            <li>Bases du cloud, des entrepots de donnees et de l'observabilite.</li>
        </ul>

        <p>Cette page vous aide a pratiquer des questions d'entretien Data Engineering sur SQLTest.online.</p>
    </div>

    {if $User->showAd()}
        {include file='fr/donation_goal_widget.tpl'}
        <div class="referal-add-block">
            {if $Book}
                {include file='book_card.tpl'}
            {/if}
        </div>
    {/if}
</div>
