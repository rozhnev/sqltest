<section class="mariadb-hero">
    <p class="hero-eyebrow">MariaDB 日 · FOSDEM</p>
    <h2>MariaDB SQL 挑战</h2>
    <p class="hero-subtitle">
        <a href="https://mariadb.org/events/mariadb-day-brussels/" target="_blank" rel="noreferrer">2026年2月1日，星期天</a>
        · Silversquare delta, Avenue Arnaud Fraiteur 15-23, 1050 布鲁塞尔
    </p>
    <div class="hero-cta">
        {if $User->logged() === false}
            <button type="button" class="mariadb-button mariadb-register-btn">注册</button>
            <button type="button" class="mariadb-button mariadb-login-btn">登录</button>
        {else}
            {if !$LastTest || $LastTest.closed}
                <a class="mariadb-button" href="/{$Lang}/challenge-mariadb/start">开始测验</a>
            {else}
                <a class="mariadb-button" href="/{$Lang}/test/{$LastTest.id}/question/">继续测验</a>
            {/if}
        {/if}
        <span class="hero-note">10 道理论与实践问题 · FOSDEM 首批 10 名完成者将获得奖品</span>
    </div>
</section>
<section class="mariadb-highlight">
    <div>
        <h3>MariaDB 日布鲁塞尔亮点</h3>
        <p>
            MariaDB 日布鲁塞尔是一个全天的社区聚会，汇聚了维护者、贡献者、合作伙伴和用户，展示 MariaDB 的现在和未来。
            这是 FOSDEM 内部 MariaDB 主题的完美热身。
        </p>
        <ul class="mariadb-list">
            <li>来自 MariaDB 基金会维护者和贡献者的最新更新。</li>
            <li>关于核心开发、企业服务器 11.8 吞吐量和 12.3 LTS 路线图的会议。</li>
            <li>对插件 API、RAG、AI 集成、自动化和向量数据库场景的技术深入探讨。</li>
            <li>社区和合作伙伴的观点，以及与构建 MariaDB 的人面对面的对话。</li>
        </ul>
    </div>
    <div class="floating-card">
        <h4>演讲者和重点</h4>
        <p>
            Michael Widenius, Nikita Malyavin, Steve Shaw, Jan Lindström, Paul Clevett, Nick Denning, Alejandro Duarte, 
            Dirk Hillbrecht, Andrija Vučinić, Carl Schwan, Roman Agabekov 等等。
        </p>
        <p>
            主题包括 Meet 12.3 LTS、企业服务器 11.8 的 OLTP 吞吐量、MariaDB 是 MySQL 的未来、 
            通过插件 API 扩展 MariaDB、无需管道部署 RAG、架构 AI 优势、更安全的自动化，以及（几乎）无停机时间的升级。
        </p>
    </div>
</section>
<section class="mariadb-grid">
    {* <article>
        <h4>测验格式</h4>
        <p>
            十个精心策划的问题，反映 MariaDB 日的议程：关于平台路线图的理论见解和实践练习的混合，涉及查询编写、迁移和自动化。
        </p>
        <ul class="mariadb-list">
            <li>五个关于架构、发布决策和社区战略的理论检查。</li>
            <li>五个针对 MariaDB 语法、优化器提示和现实世界数据形状的实践任务。</li>
            <li>3 小时的提交答案窗口，让你消化会议演讲，然后证明掌握情况。</li>
        </ul>
    </article> *}
    <article>
        <h4>如何参与</h4>
        <ol class="mariadb-list">
            <li>在 MariaDB 展位获取测验链接（FOSDEM）。
                K 级 1（B 组） https://fosdem.org/2026/stands/
                扫描我们传单上的二维码。
            </li>
            <li>在 2026 年 1 月 31 日星期六的任何时间回答测验。
                你可以一次完成，也可以稍后再回来。
            </li>
            <li>在星期六结束前提交你的答案。
                只有完全提交的条目才算数。
            </li>
            <li>答对所有问题以进入抽奖。
                每个得分完美的人都将进入抽奖。
            </li>
            <li><a href="https://mariadb.org/events/mariadb-day-brussels/" target="_blank" rel="noreferrer">星期天中午 12:30 进行现场抽奖（MariaDB 日布鲁塞尔）。</a>
                我们将在 2026 年 2 月 1 日的 MariaDB 日上宣布获胜者。
                地址：Silversquare delta, Avenue Arnaud Fraiteur 15-23, 1050 布鲁塞尔 – 比利时
            </li>
        </ol>
        {* <p>
            测验在我们位于 FOSDEM 大厅附近的 MariaDB 日展位进行，让你有时间与演讲者比较笔记
            同时等待结果。你可以在笔记本电脑上暂停，查看记分板，并在主题演讲休息前开始新的问题集。
        </p>
        <p>
            每个完成的人都将获得一个关于他们与社区的比较快照和测验报告的链接。
        </p> *}
    </article>
</section>
{* <section class="mariadb-prizes">
    <h3>前 10 名获胜者的奖品</h3>
    <div class="prize-grid">
        <div class="prize-card">
            <h5>第 1–3 名</h5>
            <p>独家 MariaDB 硬件、建筑师签名书籍和下一个版本的培训券。</p>
        </div>
        <div class="prize-card">
            <h5>第 4–7 名</h5>
            <p>优先邀请参加 MariaDB 实验室、优质周边产品包和与工程师的后台对话。</p>
        </div>
        <div class="prize-card">
            <h5>第 8–10 名</h5>
            <p>MariaDB 周边产品包、工具的数字积分和在闭幕会议上的鸣谢。</p>
        </div>
    </div>
    <p class="prize-note">
        获胜者将在舞台上宣布，并在当天结束前通过测验仪表板通知。
    </p>
</section> *}
<section class="mariadb-final">
    <p>
        带上你的好奇心、笔记本电脑和对 MariaDB 的热情。 {*测验反映了你刚刚探索的议程中的演讲，给你一个机会在庆祝 FOSDEM 社区的同时赢得奖品。*}
        <a class="external-link" href="https://mariadb.org/events/mariadb-day-brussels/" target="_blank" rel="noreferrer">
            了解更多关于 MariaDB 日布鲁塞尔的信息
        </a>
    </p>
        {if $User->logged() === false}
            <button type="button" class="mariadb-button mariadb-register-btn">注册</button>
            <button type="button" class="mariadb-button mariadb-login-btn">登录</button>
        {else}
            {if !$LastTest || $LastTest.closed}
                <a class="mariadb-button" href="/{$Lang}/challenge-mariadb/start">开始测验</a>
            {else}
                <a class="mariadb-button" href="/{$Lang}/test/{$LastTest.id}/question/">继续测验</a>
            {/if}
        {/if}
</section>