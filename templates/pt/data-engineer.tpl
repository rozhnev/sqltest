<div id="db-description" class="db-description">
    <div>
        <h2>Quem e um Data Engineer?</h2>
        <p>Um Data Engineer projeta e mantem sistemas que coletam, transformam e entregam dados para analise e tomada de decisao de negocio.</p>

        <h3>O que faz um Data Engineer?</h3>
        <ul>
            <li>Constroi pipelines ETL/ELT confiaveis a partir de varias fontes de dados.</li>
            <li>Prepara conjuntos de dados limpos e estruturados para analistas e cientistas de dados.</li>
            <li>Modela esquemas de data warehouse (tabelas fato e dimensao).</li>
            <li>Monitora qualidade, atualizacao dos dados e falhas de pipeline.</li>
            <li>Otimiza desempenho de consultas e custos de processamento.</li>
        </ul>

        <h3>O que um Data Engineer deve saber?</h3>
        <ul>
            <li>SQL forte: joins, agregacoes, funcoes de janela e tuning de consultas.</li>
            <li>Modelagem de dados: normalizacao, desnormalizacao, estrela e floco de neve.</li>
            <li>Principios de orquestracao e agendamento de pipelines.</li>
            <li>Conceitos de batch e streaming, carga incremental e idempotencia.</li>
            <li>Fundamentos de cloud, data warehouse e observabilidade.</li>
        </ul>

        <p>Esta pagina ajuda voce a praticar perguntas de entrevista de Data Engineering no SQLTest.online.</p>
    </div>

    {if $User->showAd()}
        {include file='pt/donation_goal_widget.tpl'}
        <div class="referal-add-block">
            {if $Book}
                {include file='book_card.tpl'}
            {/if}
        </div>
    {/if}
</div>
