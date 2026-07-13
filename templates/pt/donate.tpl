<link rel="stylesheet" type="text/css" href="/about.css?{$VERSION}" media="all">
<div class="about">
    <div class="section top colored">
        <div>
            <h2>Suporte ao SQLtest.online</h2>
        </div>
        <div style="display: block; text-align: left;">
            <p>
                SQLtest.online é uma plataforma gratuita de aprendizado de SQL que ajuda estudantes, desenvolvedores e qualquer pessoa
                a dominar a linguagem de consulta estruturada e se preparar para entrevistas técnicas.
            </p>
            <p>
                Nos esforçamos para tornar o aprendizado de SQL divertido e acessível para todos.
                Seu apoio nos ajuda a manter o acesso gratuito à plataforma, garantir a operação estável do servidor,
                desenvolver novos materiais de treinamento e criar mais exercícios interativos de SQL.
            </p>
            <p class="donation-helper donation-intro">
                Seu apoio é especialmente importante agora. Se o SQLtest.online já ajudou você,
                uma doação hoje aumenta diretamente a chance de termos novas lições e recursos no próximo mês.
            </p>
            <ul class="donation-suggested">
                <li>US$ 3-5 ajudam a cobrir parte dos custos mensais de servidor.</li>
                <li>US$ 10-15 ajudam a financiar novas lições e exercícios.</li>
                <li>US$ 25+ aceleram de forma real o desenvolvimento do projeto.</li>
            </ul>
        </div>
    </div>
    <div class="section" style="height: 100%;">
        <div style="display: block;">      
            <h2 style="color: var(--ligth-h2-color);">Formas de Apoiar:</h2>
            <div class="donation-methods">
                <div class="donation-method">
                    <h3>Apoie com cartão via Ko-fi</h3>
                    <p>Pagamento simples e seguro via Ko-fi. Em muitos países, o serviço aceita cartões bancários e PayPal:</p>
                    <script type='text/javascript' src='https://storage.ko-fi.com/cdn/widget/Widget_2.js'></script>
                    <script type='text/javascript'>
                        kofiwidget2.init('Apoie-nos no Ko-fi', 'revert-layer', 'D1D76X1T1');
                        kofiwidget2.draw();
                    </script>
                    <p class="donation-fallback">Se o widget não carregar, use o link direto: <a href="https://ko-fi.com/D1D76X1T1" target="_blank" rel="noopener noreferrer">ko-fi.com/D1D76X1T1</a>.</p>
                </div>
                <div class="donation-method">
                    <h3>Apoie em Cripto</h3>
                    <p>Se for mais fácil doar com criptomoeda, use o widget abaixo:</p>
                    <iframe src="https://nowpayments.io/embeds/donation-widget?api_key=8881e1d0-aaef-46c4-9a60-298bb6f26c3b" width="346" height="623" frameborder="0" scrolling="no" style="overflow-y: hidden;">
                        Can't load widget
                    </iframe>
                    <p class="donation-fallback">Se o widget for bloqueado pelo navegador, desative o bloqueador de conteúdo ou use o Ko-fi acima.</p>
                </div>
            </div>

            <h2 style="color: var(--ligth-h2-color); margin-top: 2rem;">Últimas doações</h2>
            <div class="donation-method donations-history">
                {if $LatestDonations|@count > 0}
                    <table class="donations-history-table">
                        <thead>
                            <tr>
                                <th>Usuário</th>
                                <th>Data</th>
                                <th class="align-right">Valor</th>
                                <th class="align-right">USD</th>
                                <th>Observação</th>
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
                    <p class="donations-history-empty">Ainda não há doações para exibir.</p>
                {/if}
            </div>
        </div>
    </div>
    <div class="section bottom colored">
        <div>
            <h4>
                Obrigado por fazer parte da incrível comunidade SQLtest.online! Seu apoio faz uma grande diferença. ❤️ 
                Juntos, estamos tornando o aprendizado de SQL mais acessível e agradável para todos.
            </h4>
        </div>
    </div>
</div>