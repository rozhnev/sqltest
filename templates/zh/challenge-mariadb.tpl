<section class="mariadb-hero">
    <p class="hero-eyebrow">MariaDB Foundation × SQLTest.online · OPEN SOURCE INDIA</p>
    <h1>MariaDB Foundation 挑战赛<br>与 SQLTest.online</h1>
    <p class="hero-subtitle">
        <a href="https://www.opensourceindia.in/" target="_blank" rel="noreferrer">2026 年 10 月 7–8 日</a>
        · OPEN SOURCE INDIA · NIMHANS Convention Center，班加罗尔 · MariaDB Foundation 展位
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
        <span class="hero-note">MariaDB 测验 + SQL 任务 · 大奖：MariaDB 认证券 · 中奖者将通过邮件通知</span>
    </div>
</section>

<section class="mariadb-highlight">
    <div>
        <h2>你以为自己了解 MariaDB 吗？来证明一下。</h2>
        <p>
            这是一个简短的 MariaDB 知识测验，涵盖事实、能力和真实用例，同时还有三道实战 SQL 任务，你可以在现场直接解答并立即获得检查结果。
            每位参与者都会得到一些奖励，表现最好的参与者会得到更多。
        </p>
        <ul class="mariadb-list">
            <li>测试你对 MariaDB 功能、历史和实际应用场景的了解程度。</li>
            <li>在展位上完成 SQL 任务，并立即获得反馈。</li>
            <li>至少回答 5 道题即可获得参与奖，完成 SQL 任务即可角逐大奖。</li>
            <li>可在会议期间任意时间参与，若需暂停可以稍后继续。</li>
        </ul>
    </div>
    <div class="floating-card">
        <h3>实践挑战</h3>
        <p>
            该测验结合了 MariaDB 知识检查与真实 SQL 练习，适合好奇的访客和经验丰富的数据库专业人士。
        </p>
        <p>
            只需注册一次，即可在活动期间随时继续，按自己的节奏完成挑战并继续参观会议。
        </p>
    </div>
</section>

<section class="mariadb-grid">
    <article>
        <h3>如何参与</h3>
        <ol class="mariadb-list">
            <li>扫描 MariaDB Foundation 展位上的二维码，或在设备上打开此页面。</li>
            <li>注册后可在会议期间任意时间完成测验；也可以暂停后再继续。</li>
            <li>完成测验，至少回答 5 道题，并在展位展示结果即可领取参与奖。</li>
            <li>正确完成 SQL 任务即可角逐大奖。</li>
            <li>大奖：价值 150 美元的 MariaDB 认证券。中奖者将通过电子邮件收到通知。</li>
        </ol>
    </article>
</section>

<section class="mariadb-prizes">
    <h2>奖品</h2>
    <div class="prize-grid">
        <div class="prize-card">
            <h4>大奖</h4>
            <p>前 3 名获奖者将获得价值 150 美元的 MariaDB 认证券，可任选我们的一门课程。</p>
        </div>
        <div class="prize-card">
            <h4>参与奖</h4>
            <p>至少回答 5 道题的参与者均可获得参与奖（请到展位领取）。</p>
        </div>
    </div>
</section>

<section class="mariadb-final">
    <p>
        如果你正在参加 OPEN SOURCE INDIA，欢迎来到 MariaDB Foundation 展位，完成测验，并亲自测试你的 MariaDB 技能。
        <a class="external-link" href="https://www.opensourceindia.in/" target="_blank" rel="noreferrer">
            了解更多关于 OPEN SOURCE INDIA
        </a>
    </p>
    <p class="hero-note">
        我们会用你的邮箱通知中奖者。只有在你勾选上方选项时，才会将邮箱共享给 MariaDB Foundation 用于其新闻通讯。详情请见隐私政策。
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
