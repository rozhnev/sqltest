<div class="welcome-container">

    <div class="welcome-page-header">
        <h2 style="margin: 0">Bem-vindo ao SQLTest.online</h2>
    </div>

    <section>
        <p>O SQLTest.online é uma plataforma de aprendizagem interativa que ajuda você a desenvolver habilidades práticas em SQL e bancos de dados. A melhor forma de aprender é resolvendo problemas reais; por isso oferecemos exercícios práticos com feedback instantâneo.</p>
        <p>Nosso lema: <b>Domine suas habilidades em SQL — uma consulta por vez.</b></p>
    </section>

    <section>
        <h3>Como funciona</h3>
        <div class="welcome-card">
            <p>
                Nossa base de questões contém centenas de tarefas, desde consultas simples <code class="sql">SELECT</code> até problemas analíticos complexos que simulam cenários do mundo real.
                As tarefas são agrupadas por dificuldade, tópico e pelo banco de dados utilizado.
            </p>
            <p style="margin-top: 1em;">Cada problema inclui testes que validam os resultados da sua consulta e quaisquer condições específicas da tarefa.</p>
        </div>
    </section>

    <section>
        <h3>Como começar</h3>

        <div class="step-card">
            <div class="step-icon">📂</div>
            <div class="step-content">
                <h4>Escolha um desafio</h4>
                <p>Explore por tópico ou nível de dificuldade.</p>
            </div>
        </div>

        <div class="step-card">
            <div class="step-icon">✍️</div>
            <div class="step-content">
                <h4>Escreva sua consulta</h4>
                <p>Use o editor integrado para criar sua solução.</p>
            </div>
        </div>

        <div class="step-card">
            <div class="step-icon">✅</div>
            <div class="step-content">
                <h4>Execute e itere</h4>
                <p>Receba feedback instantâneo e melhore sua consulta até que os testes sejam aprovados.</p>
            </div>
        </div>
    </section>

    <section>
        <h3>Login é opcional</h3>
        <p>Você pode começar a resolver desafios imediatamente sem criar uma conta. Fazer login não é obrigatório, mas libera funcionalidades como salvar progresso, obter e armazenar conquistas e visualizar soluções de outros usuários. Recomendamos fazer login para ter a experiência completa.</p>
    </section>

    <section>
        <h3>Benefícios para usuários logados</h3>
        <ul>
            <li>Salve seu progresso e retome desafios a qualquer momento</li>
            <li>Ganhe e mostre conquistas ao aprender</li>
            <li>Acompanhe suas estatísticas e histórico de aprendizagem</li>
            <li>Visualize e compare soluções de outros usuários</li>
        </ul>
    </section>

    <section>
        <h3>Visualizar soluções de outros usuários</h3>
        <p>Depois de resolver corretamente um desafio, você poderá ver soluções enviadas por outros usuários. Comparar abordagens distintas é uma das formas mais rápidas de aprender novas técnicas e otimizar suas consultas. <em>(Visualização de soluções disponível apenas para usuários logados.)</em></p>
    </section>

    <section>
        <h3>Conquistas e progresso</h3>
        <p>Ganhe conquistas conforme você completa tarefas, domina tópicos e melhora a eficiência. Conquistas e o registro de progresso são salvos para usuários logados, permitindo manter um histórico contínuo de aprendizagem.</p>
    </section>

    <section>
        <h3>Faça o Teste de Habilidade em SQL</h3>
        <p>Quando estiver pronto, faça o teste. O teste avalia suas habilidades em SQL por meio de uma série de desafios práticos. A classificação obtida não é oficial, mas reflete sua proficiência e compreensão dos conceitos de SQL.</p>
    </section>

    <section>
        <h3>Dicas rápidas</h3>
        <ul>
            <li>Experimente várias abordagens — diferentes soluções podem ter características de desempenho muito distintas.</li>
            <li>Leia atentamente as condições da tarefa — algumas exigem um formato de resultado específico ou o uso de um operador concreto.</li>
            <li>Use a estimativa de custo da consulta (quando disponível) para aprender sobre eficiência, mas priorize a correção primeiro.</li>
        </ul>
    </section>

    <section>
        <h3>Comunidade</h3>
        <p>Junte-se à nossa comunidade de aprendizes para compartilhar ideias e tirar dúvidas. Usuários que falam inglês podem entrar em nosso <a style="color: #FFA500;" href="https://t.me/sqltest_online" target="_blank">grupo no Telegram</a>.</p>
    </section>

    <section>
        <h3>Suporte</h3>
        <p>Se precisar de ajuda, tiver sugestões ou quiser reportar um problema, entre em contato pelo e-mail <a style="color: #FFA500;" href="mailto:support@sqltest.online">support@sqltest.online</a>.</p>
    </section>

    <div id="welcome-page" class="welcome-page">
        <div class="welcome-controls">
            <label style="display:inline-flex; align-items:center; gap:8px;">
                <input type="checkbox" id="welcome-dont-show" onchange="hideWelcome(this.checked)" />
                <span>Não mostrar esta página novamente</span>
            </label>
        </div>
    </div>

    <p style="display:flex; align-items:center; gap:12px; margin-top:1em;">
        <strong>Pronto para começar?</strong> Escolha seu primeiro desafio e comece a codar!
        <a class="button green" href="/{$Lang}/question/sql-basics/get-the-actors" title="Começar a praticar">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd" clip-rule="evenodd" d="M19.266 10.4837C20.2579 11.2512 20.2579 12.7486 19.266 13.5161C16.2685 15.8355 12.9213 17.6637 9.34979 18.9321L8.69732 19.1639C7.44904 19.6072 6.13053 18.7627 5.96154 17.4741C5.48938 13.8739 5.48938 10.1259 5.96154 6.52574C6.13053 5.23719 7.44905 4.39263 8.69732 4.83597L9.34979 5.06771C12.9213 6.33619 16.2685 8.16434 19.266 10.4837ZM18.3481 12.3298C18.5639 12.1628 18.5639 11.837 18.3481 11.67C15.4763 9.44796 12.2695 7.69648 8.84777 6.4812L8.1953 6.24947C7.87035 6.13406 7.49691 6.35401 7.44881 6.72079C6.99363 10.1915 6.99363 13.8083 7.44881 17.2791C7.49691 17.6458 7.87035 17.8658 8.19529 17.7504L8.84777 17.5187C12.2695 16.3034 15.4763 14.5519 18.3481 12.3298Z" fill="white"></path>
            </svg>
            <span>Começar a praticar</span>
        </a>
    </p>
</div>