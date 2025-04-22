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
            <h2>Teste seus conhecimentos de SQL!</h2>
        </div>
    </div>
    <div class="section not-colored">
        <div>
            <p>Nosso teste consiste em 12 tarefas de diferentes níveis de dificuldade, selecionadas aleatoriamente do banco de dados do site. A dificuldade das tarefas é determinada pelos resultados da votação dos usuários do site.</p>
            Estrutura do Teste:
            <ul class="difficulty-list">
                <li class="difficulty-item">4 tarefas do nível "Fácil"</li>
                <li class="difficulty-item">3 tarefas do nível "Médio"</li>
                <li class="difficulty-item">2 tarefas do nível "Difícil"</li>
                <li class="difficulty-item">2 tarefas do nível "Muito Difícil"</li>
                <li class="difficulty-item">1 tarefa do nível "Muito Difícil"</li>
            </ul>
        </div>
    </div>
    <div class="section colored">
        <div>
            <h2>Tempo e Classificações</h2>
            São alocadas três horas para a realização do teste. Ao final do tempo (ou antes) você poderá obter uma das classificações em SQL:

            <table class="rank-table">
                <tr>
                    <th>Classificação</th>
                    <th>Requisitos</th>
                </tr>
                <tr>
                    <td>Estagiário</td>
                    <td>Resolver pelo menos 6 tarefas (de qualquer dificuldade)</td>
                </tr>
                <tr>
                    <td>Júnior</td>
                    <td>Resolver todas as tarefas fáceis e médias</td>
                </tr>
                <tr>
                    <td>Médio</td>
                    <td>Resolver todas as tarefas fáceis e médias + 2/3 das tarefas restantes</td>
                </tr>
                <tr>
                    <td>Sênior</td>
                    <td>Resolver todas as tarefas</td>
                </tr>
            </table>
            </div>
        </div>
    <div class="section not-colored">
        <div>
            <h3>Bônus e Penalidades</h3>
            Resolver uma tarefa com sucesso na primeira tentativa traz pontos adicionais, e um grande número de tentativas em uma tarefa pode levar a uma nota menor.
            <div class="note-section">
                <strong>Observação:</strong> O sistema de classificação pode ser ajustado dependendo dos resultados do teste e do feedback dos participantes.
            </div>
        </div>
    </div>
    <div class="section bottom colored">
        {if $User->logged()}
            {if isset($LastTest)}
                {if $LastTest.closed}
                    {if $LastTest.rate eq 1}
                        <h2>Ótimo começo! De acordo com o resultado do teste, seu nível é Estagiário.</h2>Isso diz muito sobre seu potencial. Quer se desenvolver e passar para o próximo nível?
                    {elseif $LastTest.rate eq 2}
                        <h2>Você está no caminho certo! Seu nível atual é Júnior.</h2>Isso é um ótimo resultado. Está pronto para expandir seus conhecimentos e habilidades?
                    {elseif $LastTest.rate eq 3}
                        <h2>Você atingiu o nível Médio!</h2>Isso é ótimo! Mas sempre há espaço para melhoria, certo? Pronto para se desafiar e melhorar seus resultados?
                    {elseif $LastTest.rate eq 4}
                        <h2>Parabéns! Você é agora um Sênior!</h2>Pronto para confirmar seu status?
                    {else}
                        <h2>Seu último teste expirou.</h2>Pronto para tentar novamente?
                    {/if}
                    <div style="text-align: center;">
                        <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/create" title="Iniciar teste" class="button green">Iniciar teste</a>
                    </div>
                {else}
                    {* Continue open test *}
                    <div style="text-align: center;">
                        <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/{$LastTest.id}/question/" title="Continuar teste" class="button green">Continuar teste</a>
                    </div>
                {/if}
            {else}
                <h2>Boa sorte!</h2>
                <div style="text-align: center;">
                    <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/create" title="Iniciar Teste" class="button green">Iniciar Teste</a>
                </div>
            {/if}
        {else}
            <h2><span class='warning'>
                Esta página não está disponível para usuários não registrados. Faça login para continuar.
            </span></h2>
            <div style="text-align: center;">
                <button class="button green" onClick="toggleLoginWindow()">Login</button>
            </div>
        {/if}
    </div>
</div>