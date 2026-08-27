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
            <h2>¡Pon a prueba tus conocimientos de SQL!</h2>
        </div>
    </div>
    <div class="section not-colored">
        <div>
            <p>Nuestro test consta de 12 tareas de diferentes niveles de dificultad, seleccionadas al azar de la base de datos de tareas del sitio. La dificultad de las tareas se determina por los resultados de la votación de los usuarios del sitio.</p>
            Estructura del test:
            <ul class="difficulty-list">
                <li class="difficulty-item">4 tareas de nivel "Fácil"</li>
                <li class="difficulty-item">3 tareas de nivel "Fácil"</li>
                <li class="difficulty-item">2 tareas de nivel "Promedio"</li>
                <li class="difficulty-item">2 tareas de nivel "Difícil"</li>
                <li class="difficulty-item">1 tarea de nivel "Difícil"</li>
                </ul>
            </div>
        </div>
        <div class="section colored">
            <div>
                <h2>Tiempo y rangos</h2>
                Se asignan tres horas para el test. Al final del tiempo (o antes) podrás obtener uno de los rangos en SQL:
                <table class="rank-table">
                    <tr>
                        <th>Rango</th>
                        <th>Requisitos</th>
                    </tr>
                    <tr>
                        <td>Interno</td>
                        <td>Resolver al menos 6 tareas (de cualquier dificultad)</td>
                    </tr>
                    <tr>
                        <td>Junior</td>
                        <td>Resolver todas las tareas fáciles y simples</td>
                    </tr>
                    <tr>
                        <td>Middle</td>
                        <td>Resolver todas las tareas fáciles y simples + 2/3 de las tareas restantes</td>
                    </tr>
                    <tr>
                        <td>Senior</td>
                        <td>Resolver todas las tareas</td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="section not-colored">
            <div>
                <h2>Bonificaciones y Penalizaciones</h2>
                Resolver con éxito una tarea en el primer intento otorga puntos adicionales, y un gran número de intentos en una tarea puede llevar a una calificación más baja.
                <div class="note-section">
                    <strong>Nota:</strong> El sistema de calificación puede ajustarse dependiendo de los resultados del test y los comentarios de los participantes.
                </div>
            </div>
        </div>
        <div class="section bottom colored">    {if $User->logged()}
            {if isset($LastTest)}
                {if $LastTest.closed}
                    {if $LastTest.rate eq 1}
                        <h2>¡Gran comienzo! Según los resultados del test, tu nivel es Interno.</h2>Esto dice mucho sobre tu potencial. ¿Quieres desarrollarte más y pasar al siguiente nivel?
                    {elseif $LastTest.rate eq 2}
                        <h2>¡Vas por buen camino! Tu nivel actual es Junior.</h2>Ese es un gran resultado. ¿Estás listo para ampliar tus conocimientos y habilidades?
                    {elseif $LastTest.rate eq 3}
                        <h2>¡Has alcanzado el nivel Middle!</h2>¡Eso es genial! Pero siempre hay espacio para mejorar, ¿verdad? ¿Listo para desafiarte y mejorar tus resultados?
                    {elseif $LastTest.rate eq 4}
                        <h2>¡Felicidades! ¡Ahora eres un Senior!</h2>¿Listo para confirmar tu estatus?
                    {else}
                        <h2>Se acabó el tiempo de tu último test.</h2>¿Listo para intentarlo de nuevo?
                    {/if}
                    <div style="text-align: center;">
                        <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/create" title="Iniciar test" class="button green">Iniciar test</a>
                    </div>
                {else}
                    {* Continuar test abierto *}
                    <div style="text-align: center;">
                        <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/{$LastTest.id}/question/" title="Continuar test" class="button green">Continuar test</a>
                    </div>
                {/if}
            {else}
                <h2>¡Buena suerte!</h2>
                <div style="text-align: center;">
                    <a style="display:inline-block;width:240px; color: white;" href="/{$Lang}/test/create" title="Iniciar Test" class="button green">Iniciar Test</a>
                </div>
            {/if}
        {else}
            <h2><span class='warning'>
                Esta página no está disponible para usuarios no registrados. Por favor, inicia sesión para continuar.
            </span></h2>
            <div style="text-align: center;">
                <button class="button green" onClick="toggleLoginWindow()">Iniciar sesión</button>
            </div>
        {/if}
    </div>
</div>