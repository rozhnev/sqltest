<link rel="stylesheet" type="text/css" href="/about.css?{$VERSION}" media="all">
<div class="about">
    <div class="section top colored">
        <div>
            <h2>❤️ Apoya a SQLtest.online</h2>
        </div>
        <div style="display: block; text-align: left;">
            <p>
                SQLtest.online es una plataforma gratuita de aprendizaje de SQL utilizada por estudiantes, desarrolladores y profesionales que se preparan para entrevistas técnicas.
                Tu apoyo mantiene el proyecto vivo: cubriendo costos de servidor, financiando nuevas lecciones y ayudándonos a construir más ejercicios interactivos de SQL.
            </p>
        </div>
    </div>
    <div class="section" style="height: 100%;">
        <div style="display: block;">      
            <h2 style="color: var(--ligth-h2-color);">💳 Elige Cómo Apoyar</h2>
            <div class="donation-methods">
                <div class="donation-method">
                    <h3>Ko‑fi (Tarjeta Bancaria / PayPal)</h3>
                    <p style="margin: 1.5rem 0;">
                    <script type='text/javascript' src='https://storage.ko-fi.com/cdn/widget/Widget_2.js'></script>
                    <script type='text/javascript'>
                        kofiwidget2.init('Apóyanos en Ko-fi', 'revert-layer', 'D1D76X1T1');
                        kofiwidget2.draw();
                    </script>
                    </p>
                    <p>Pagos simples y seguros disponibles en la mayoría de las regiones.</p>
                    <p class="donation-fallback">Si el widget no se carga, utiliza el enlace directo: <a href="https://ko-fi.com/D1D76X1T1" target="_blank" rel="noopener noreferrer">ko-fi.com/D1D76X1T1</a>.</p>
                </div>
                <div class="donation-method">
                    <h3>Donaciones en Cripto</h3>
                    <p>¿Prefieres cripto? Usa el widget a continuación:</p>
                    <iframe src="https://nowpayments.io/embeds/donation-widget?api_key=8881e1d0-aaef-46c4-9a60-298bb6f26c3b" width="346" height="623" frameborder="0" scrolling="no" style="overflow-y: hidden;">
                        No se puede cargar el widget
                    </iframe>
                    <p class="donation-fallback">Si está bloqueado por tu navegador, intenta desactivar los bloqueadores de contenido o usa Ko‑fi en su lugar.</p>
                </div>
            </div>
            <h3 style="color: var(--ligth-h2-color);">🎯 Cómo Ayuda Tu Apoyo</h3>
            <div class="donation-method donations-history">
            <ul class="donation-suggested">
                <li>$3-5 ayuda a cubrir parte de la factura mensual del servidor.</li>
                <li>$10-15 ayuda a financiar nuevas lecciones y ejercicios.</li>
                <li>$25+ acelera significativamente el nuevo desarrollo.</li>
            </ul>
            <p class="donation-helper">
                Cada contribución, sin importar su tamaño, es muy apreciada. ¡Gracias por ayudarnos a hacer que SQLtest.online sea aún mejor!
            </p>
            </div>
            <h3 style="color: var(--ligth-h2-color); margin-top: 2rem;">💬 Apoyo Reciente</h3>
            <div class="donation-method donations-history">
                {if $LatestDonations|@count > 0}
                    <table class="donations-history-table">
                        <thead>
                            <tr>
                                <th>Usuario</th>
                                <th>Fecha</th>
                                <th class="align-right">Monto</th>
                                <th class="align-right">USD</th>
                                <th>Nota</th>
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
                    <p class="donations-history-empty">No hay donaciones para mostrar aún.</p>
                {/if}
            </div>
            <h3 style="color: var(--ligth-h2-color);">🙏 Gracias</h3>
            <div class="donation-method donations-history">
                Hola, soy Slava — creé SQLtest.online para ayudar a las personas a aprender SQL de forma gratuita.
                Yo construyo y mantengo este proyecto yo mismo, y tu apoyo me ayuda directamente a
                mantener los servidores funcionando, publicar nuevas lecciones y desarrollar más ejercicios interactivos.
                Gracias por ayudar a que el aprendizaje de SQL sea accesible para todos.
            </div>
        </div>
    </div>
    <div class="section bottom colored">
        <div>
            <h4>
                ¡Gracias por ser una parte increíble de la comunidad de SQLtest.online!
                Tu apoyo marca una verdadera diferencia. ❤️
                Juntos, estamos haciendo que el aprendizaje de SQL sea más accesible y agradable para todos.
            </h4>
        </div>
    </div>
</div>