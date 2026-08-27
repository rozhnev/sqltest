<div id="db-description" class="db-description">
    <div>
        <h2>¿Quién es un Ingeniero de Datos?</h2>
        <p>Un Ingeniero de Datos diseña y mantiene sistemas que recopilan, transforman y entregan datos para análisis y decisiones comerciales.</p>

        <h3>¿Qué hace un Ingeniero de Datos?</h3>
        <ul>
            <li>Construye tuberías ETL/ELT confiables a partir de múltiples fuentes de datos.</li>
            <li>Prepara conjuntos de datos limpios y estructurados para analistas y científicos de datos.</li>
            <li>Diseña esquemas de almacén de datos (tablas de hechos y dimensiones).</li>
            <li>Monitorea la calidad de los datos, la frescura y las fallas de las tuberías.</li>
            <li>Optimiza el rendimiento de las consultas y los costos de procesamiento de datos.</li>
        </ul>

        <h3>¿Qué debe saber un Ingeniero de Datos?</h3>
        <ul>
            <li>SQL sólido: uniones, agregaciones, funciones de ventana y ajuste de consultas.</li>
            <li>Modelado de datos: normalización, desnormalización, esquemas en estrella y copo de nieve.</li>
            <li>Principios de orquestación y programación de tuberías.</li>
            <li>Conceptos de procesamiento por lotes y en streaming, carga incremental e idempotencia.</li>
            <li>Almacenamiento en la nube, almacenes de datos y conceptos básicos de observabilidad.</li>
        </ul>

        <p>Esta página te ayuda a practicar preguntas de Ingeniería de Datos estilo entrevista en SQLTest.online.</p>
    </div>

    {if $User->showAd()}
        {include file='es/donation_goal_widget.tpl'}
        <div class="referal-add-block">
            {if $Book}
                {include file='book_card.tpl'}
            {/if}
        </div>
    {/if}
</div>