{if $InterviewLoginRequired}
    <div style="max-width: 720px; margin: 1rem auto 0; padding: 1rem 1.25rem; border-radius: 12px; background: #FEF3C7; color: #92400E; text-align: center;">
        Entre na sua conta para começar a entrevista para o cargo e o nível escolhidos.
    </div>
{/if}
{if $ActiveInterviewSession}
    <div class="interview-notice">
        Você já tem uma entrevista não concluída.
        <a class="interview-start-btn" href="/{$Lang}/interview/{$ActiveInterviewSession.id}">Continuar a entrevista</a>
    </div>
{/if}
<div class="interview-page">
<section class="interview-hero">
    <div class="interview-hero-logo">
        <img src="/images/interview/meridian-logistics-logo.svg" alt="Logotipo da Meridian Logistics">
    </div>
    <div class="interview-hero-text">
        <h1>Somos a Meridian Logistics</h1>
        <p class="interview-hero-tagline">Movemos cargas. Movidos por dados.</p>
        <p>
            Somos uma empresa de transporte de cargas e cadeia de suprimentos presente em três continentes. Todos os dias, nossa plataforma acompanha milhares de remessas, centenas de transportadoras e uma rede crescente de armazéns — e tudo isso funciona com SQL. À medida que crescemos, procuramos pessoas que se sintam tão à vontade com um JOIN quanto com um prazo de entrega.
        </p>
        <div class="interview-quote">
            <img src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">
            <div>
                <blockquote>«Nossos armazéns funcionam com empilhadeiras. Nossas decisões funcionam com SQL.»</blockquote>
                <cite>Elena Cho, diretora de Dados e Engenharia</cite>
            </div>
        </div>
    </div>
</section>

<p class="interview-disclaimer" role="note"><strong>Atenção:</strong> esta é uma simulação para praticar, não uma entrevista de emprego real. A Meridian Logistics, seus funcionários e suas vagas são fictícios. Concluir a entrevista não leva a uma oferta de emprego nem a qualquer forma de contratação — o resultado e o feedback servem apenas como autoavaliação educativa das suas habilidades em SQL.</p>

<h2 style="color:#0F172A; margin-bottom: 1rem;">Vagas abertas</h2>

<section class="interview-positions">
    <article class="interview-position-card">
        <h2>SQL Developer</h2>
        <p>
            Você vai projetar e manter os bancos de dados por trás do nosso sistema de gestão de transportes — rastreamento de remessas, contratos com transportadoras, dados de rotas e faturamento. Espere modelagem de esquemas, otimização de consultas e colaboração próxima com a equipe de engenharia que constrói sobre o que você entrega.
        </p>
        <div class="interview-grades">
            <div class="interview-grade-card">
                <h3>Junior</h3>
                <ul>
                    <li>Escreve com segurança consultas SELECT com JOINs e agregações.</li>
                    <li>Tem vontade de aprender modelagem de esquemas e indexação.</li>
                    <li>Alguma experiência prática com um banco de dados relacional (qualquer SGBD).</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=sql_developer&amp;grade=2">Iniciar entrevista</a>
            </div>
            <div class="interview-grade-card">
                <h3>Middle</h3>
                <ul>
                    <li>Consegue projetar um esquema normalizado do zero.</li>
                    <li>Escreve consultas eficientes em tabelas com milhões de linhas.</li>
                    <li>Entende os prós e contras dos índices e já depurou uma consulta lenta em produção.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=sql_developer&amp;grade=3">Iniciar entrevista</a>
            </div>
            <div class="interview-grade-card">
                <h3>Senior</h3>
                <ul>
                    <li>É responsável de ponta a ponta pelas decisões de arquitetura de banco de dados.</li>
                    <li>Domina otimização de consultas, particionamento e os compromissos da replicação.</li>
                    <li>Orienta outros desenvolvedores e questiona mudanças arriscadas no esquema.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=sql_developer&amp;grade=4">Iniciar entrevista</a>
            </div>
        </div>
    </article>

    <article class="interview-position-card">
        <h2>Data Analyst</h2>
        <p>
            Você vai transformar dados brutos de remessas e armazéns em respostas: quais rotas dão prejuízo, quais transportadoras são pontuais e onde deve ficar o próximo armazém. Você trabalhará em estreita colaboração com as áreas de operações e finanças para transformar consultas SQL em decisões.
        </p>
        <div class="interview-grades">
            <div class="interview-grade-card">
                <h3>Junior</h3>
                <ul>
                    <li>Escreve consultas SQL com GROUP BY, HAVING e funções de janela básicas.</li>
                    <li>Transforma com facilidade uma pergunta de negócio em uma consulta.</li>
                    <li>Alguma experiência apresentando números para pessoas não técnicas.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=data_analyst&amp;grade=2">Iniciar entrevista</a>
            </div>
            <div class="interview-grade-card">
                <h3>Middle</h3>
                <ul>
                    <li>Lida com pedidos ambíguos de várias partes interessadas.</li>
                    <li>Usa funções de janela, CTEs e otimização de consultas para relatórios recorrentes confiáveis.</li>
                    <li>Consegue defender uma metodologia quando questionado.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=data_analyst&amp;grade=3">Iniciar entrevista</a>
            </div>
            <div class="interview-grade-card">
                <h3>Senior</h3>
                <ul>
                    <li>Cria os padrões analíticos que outros analistas seguem.</li>
                    <li>É responsável de ponta a ponta pelas definições de métricas.</li>
                    <li>Questiona com dados, sem receio, as premissas das partes interessadas.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=data_analyst&amp;grade=4">Iniciar entrevista</a>
            </div>
        </div>
    </article>
</section>
</div>
