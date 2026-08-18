<div id="db-description" class="db-description">
    <div>
        <h2>什么是数据工程师？</h2>
        <p>数据工程师负责设计和维护数据系统，用于采集、转换并交付数据，支持分析和业务决策。</p>

        <h3>数据工程师做什么？</h3>
        <ul>
            <li>构建稳定的 ETL/ELT 数据管道，连接多个数据源。</li>
            <li>为数据分析师和数据科学家准备干净、结构化的数据集。</li>
            <li>设计数据仓库模型（事实表与维度表）。</li>
            <li>监控数据质量、时效性以及管道故障。</li>
            <li>优化 SQL 查询性能并控制处理成本。</li>
        </ul>

        <h3>数据工程师需要掌握什么？</h3>
        <ul>
            <li>扎实的 SQL：连接、聚合、窗口函数与查询优化。</li>
            <li>数据建模：规范化、反规范化、星型和雪花模型。</li>
            <li>管道编排与调度的基本原则。</li>
            <li>批处理与流处理、增量加载和幂等性。</li>
            <li>云存储、数据仓库与可观测性基础。</li>
        </ul>

        <p>该页面用于在 SQLTest.online 上练习数据工程师面试相关问题。</p>
    </div>

    {if $User->showAd()}
        {include file='zh/donation_goal_widget.tpl'}
        <div class="referal-add-block">
            {if $Book}
                {include file='book_card.tpl'}
            {/if}
        </div>
    {/if}
</div>
