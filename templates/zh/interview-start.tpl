{if $InterviewLoginRequired}
    <div style="max-width: 720px; margin: 1rem auto 0; padding: 1rem 1.25rem; border-radius: 12px; background: #FEF3C7; color: #92400E; text-align: center;">
        请登录，以开始所选职位和等级的面试。
    </div>
{/if}
{if $ActiveInterviewSession}
    <div class="interview-notice">
        您有一场尚未完成的面试。
        <a class="interview-start-btn" href="/{$Lang}/interview/{$ActiveInterviewSession.id}">继续面试</a>
    </div>
{/if}
<div class="interview-page">
<section class="interview-hero">
    <div class="interview-hero-logo">
        <img src="/images/interview/meridian-logistics-logo.svg" alt="Meridian Logistics 标志">
    </div>
    <div class="interview-hero-text">
        <h1>我们是 Meridian Logistics</h1>
        <p class="interview-hero-tagline">运送货物，由数据驱动。</p>
        <p>
            我们是一家业务遍及三大洲的货运与供应链公司。我们的平台每天追踪数千批货物、数百家承运商以及不断扩大的仓库网络——这一切都运行在 SQL 之上。随着业务扩张，我们在寻找既能驾驭 JOIN、又能按时交付的人。
        </p>
        <div class="interview-quote">
            <img src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">
            <div>
                <blockquote>“我们的仓库靠叉车运转，我们的决策靠 SQL 驱动。”</blockquote>
                <cite>Elena Cho，数据与工程部负责人</cite>
            </div>
        </div>
    </div>
</section>

<p class="interview-disclaimer" role="note"><strong>请注意：</strong>这只是一次练习用的模拟面试，并非真实的求职面试。Meridian Logistics 及其员工和职位均为虚构。完成本次面试不会带来任何工作邀约或录用——结果和反馈仅作为您 SQL 技能的学习性自我评估。</p>

<h2 style="color:#0F172A; margin-bottom: 1rem;">开放职位</h2>

<section class="interview-positions">
    <article class="interview-position-card">
        <h2>SQL Developer</h2>
        <p>
            您将设计并维护我们运输管理系统背后的数据库——货运追踪、承运商合同、路线数据和计费。工作内容包括模式设计、查询优化，并与基于您的成果进行开发的工程团队紧密合作。
        </p>
        <div class="interview-grades">
            <div class="interview-grade-card">
                <h3>Junior</h3>
                <ul>
                    <li>能熟练编写带 JOIN 和聚合的 SELECT 查询。</li>
                    <li>渴望学习模式设计和索引。</li>
                    <li>有一定的关系型数据库实践经验（任意 DBMS）。</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=sql_developer&amp;grade=2">开始面试</a>
            </div>
            <div class="interview-grade-card">
                <h3>Middle</h3>
                <ul>
                    <li>能够从零设计规范化的模式。</li>
                    <li>能针对数百万行的表编写高效查询。</li>
                    <li>理解索引的利弊权衡，并排查过生产环境中的慢查询。</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=sql_developer&amp;grade=3">开始面试</a>
            </div>
            <div class="interview-grade-card">
                <h3>Senior</h3>
                <ul>
                    <li>端到端负责数据库架构决策。</li>
                    <li>熟悉查询优化、分区以及复制方案的权衡。</li>
                    <li>指导其他开发者，并对有风险的模式变更提出异议。</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=sql_developer&amp;grade=4">开始面试</a>
            </div>
        </div>
    </article>

    <article class="interview-position-card">
        <h2>Data Analyst</h2>
        <p>
            您将把原始的货运和仓储数据转化为答案：哪些路线在亏损，哪些承运商一贯准时，下一个仓库应该建在哪里。您将与运营和财务团队紧密合作，把 SQL 查询变成决策。
        </p>
        <div class="interview-grades">
            <div class="interview-grade-card">
                <h3>Junior</h3>
                <ul>
                    <li>能编写带 GROUP BY、HAVING 和基础窗口函数的 SQL 查询。</li>
                    <li>能把业务问题转化为查询。</li>
                    <li>有向非技术人员展示数据的经验。</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=data_analyst&amp;grade=2">开始面试</a>
            </div>
            <div class="interview-grade-card">
                <h3>Middle</h3>
                <ul>
                    <li>能处理来自多方干系人的模糊需求。</li>
                    <li>运用窗口函数、CTE 和查询优化来生成可靠的周期性报表。</li>
                    <li>能在质疑面前为自己的方法论辩护。</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=data_analyst&amp;grade=3">开始面试</a>
            </div>
            <div class="interview-grade-card">
                <h3>Senior</h3>
                <ul>
                    <li>制定其他分析师遵循的分析标准。</li>
                    <li>端到端负责指标定义。</li>
                    <li>敢于用数据挑战干系人的假设。</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=data_analyst&amp;grade=4">开始面试</a>
            </div>
        </div>
    </article>
</section>
</div>
