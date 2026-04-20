<div class="menu-ad">
    {math equation="x % 2" x=$smarty.now assign="show_appeal"}
    {if !$User->showAd() || $show_appeal}
        <div style="
            margin: 0.5em 0 0 0;
            background-color: var(--accordion-panel-bg-color);
            border: 1px solid var(--text-block-border-color);
            color: var(--question-text);
            border-radius: 0 6px 0 0;">

            <div style="
                background-color: var(--menu-button-background-color);
                border-radius: 0 6px 0 0;
                padding: 0.5em;
                color: white;">
                🙏 Ajude o sqltest.online a crescer!
            </div>

            <div style="font-size: small; padding: 0.5em; line-height: 1.6;">
                <p>Olá!</p>

                <p>
                    Se o <strong>sqltest.online</strong> já te ajudou a aprender SQL, a preparar uma entrevista
                    ou simplesmente a satisfazer a sua curiosidade - adoraria saber.
                </p>

                <p>
                    Este projeto é algo que criei e mantenho sozinho, completamente <strong>gratuito</strong>,
                    porque acredito que as competências em SQL devem ser acessíveis a todos.
                    Sem subscrições, sem barreiras pagas — apenas uma ferramenta que genuinamente gosto de melhorar.
                </p>

                <p>Se o achaste útil, a melhor coisa que podes fazer é <strong>partilhar a tua opinião honesta</strong>:</p>

                <ul style="list-style: none; padding-left: 0.5em;">
                    <li>🟠 No <strong>Reddit</strong> - <a href="https://www.reddit.com/r/SQL/" target="_blank" style="color: var(--menu-link-color);">r/SQL</a>,
                        <a href="https://www.reddit.com/r/learnprogramming/" target="_blank" style="color: var(--menu-link-color);">r/learnprogramming</a>,
                        <a href="https://www.reddit.com/r/webdev/" target="_blank" style="color: var(--menu-link-color);">r/webdev</a></li>
                    <li>🔵 No <strong>Facebook</strong> ou em qualquer lugar onde a tua comunidade de programadores se reúna</li>
                </ul>

                <p>
                    E se publicares - envia-me o link para
                    <a href="mailto:rozhnev@gmail.com" style="color: var(--menu-link-color);">✉️&nbsp;rozhnev@gmail.com</a>.
                    Adoraria ler o que escreveste e agradecer-te pessoalmente.
                </p>

                <p>
                    ❤️ Obrigado por usares o sqltest.online. És a razão pela qual este projeto continua.<br><br>
                    Slava Rozhnev, criador do <a href="https://sqltest.online/pt" style="color: var(--menu-link-color);">sqltest.online</a>
                </p>
            </div>
        </div>
    {else}
        <div style="display: flex; gap: 1rem; flex-wrap: wrap; justify-content: center; margin-top: 1rem;">
            <a href="https://www.jdoqocy.com/click-101541078-17083149" target="_blank" class="talkpal-ad-container" style="background-color: #052d50; display: flex;">
                <img src="https://www.ftjcfx.com/image-101541078-17083149" width="250" height="360" alt="Contabo.com" style="max-width: 100%; height: auto;" border="0"/>
            </a>
            <a href="https://www.tkqlhce.com/click-101561323-17139054" target="_blank" class="talkpal-ad-container" style="padding: 15px 10px;">
                <img src="https://www.awltovhc.com/image-101561323-17139054" alt="Point" width="1" height="1" border="0"/>
                <img src="https://files.talkpal.ai/landing_images/talkpal-text-logo.svg" alt="Talkpal AI Logo" class="talkpal-ad-logo">
                <div class="talkpal-ad-text">A forma divertida e eficaz de aprender uma língua com IA!</div>
                <div class="talkpal-ad-subtext">Pratique a fala, a audição e a escrita.</div>
                <span class="talkpal-ad-button">Comece agora</span>
            </a>
        </div>
    {/if}
</div>
