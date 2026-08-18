<div id="db-description" class="db-description">
    <div>
        <h2>Who is a Data Engineer?</h2>
        <p>A Data Engineer designs and maintains systems that collect, transform, and deliver data for analytics and business decisions.</p>

        <h3>What does a Data Engineer do?</h3>
        <ul>
            <li>Builds reliable ETL/ELT pipelines from multiple data sources.</li>
            <li>Prepares clean and structured datasets for analysts and data scientists.</li>
            <li>Designs data warehouse schemas (fact and dimension tables).</li>
            <li>Monitors data quality, freshness, and pipeline failures.</li>
            <li>Optimizes query performance and data processing costs.</li>
        </ul>

        <h3>What should a Data Engineer know?</h3>
        <ul>
            <li>Strong SQL: joins, aggregations, window functions, and query tuning.</li>
            <li>Data modeling: normalization, denormalization, star and snowflake schemas.</li>
            <li>Pipeline orchestration and scheduling principles.</li>
            <li>Batch and streaming concepts, incremental loading, and idempotency.</li>
            <li>Cloud storage, data warehouses, and observability basics.</li>
        </ul>

        <p>This page helps you practice interview-style Data Engineering questions on SQLTest.online.</p>
    </div>

    {if $User->showAd()}
        {include file='en/donation_goal_widget.tpl'}
        <div class="referal-add-block">
            {if $Book}
                {include file='book_card.tpl'}
            {/if}
        </div>
    {/if}
</div>
