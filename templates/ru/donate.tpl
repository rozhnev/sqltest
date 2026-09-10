<link rel="stylesheet" type="text/css" href="/about.css?{$VERSION}" media="all">
<script type='text/javascript' src='https://storage.ko-fi.com/cdn/widget/Widget_2.js'></script>
<div class="about">
    <div class="section top colored">
        <div>
            <h2>Поддержите SQLtest.online</h2>
        </div>
        <div style="display: block; text-align: left;">
            <p>
                SQLtest.online - это бесплатная платформа для изучения SQL, которая помогает студентам, разработчикам и всем желающим 
                освоить язык структурированных запросов и подготовиться к техническим собеседованиям.
            </p>
            <p>
                Мы стремимся сделать изучение SQL увлекательным и доступным для каждого. 
                Ваша поддержка помогает нам поддерживать бесплатный доступ к платформе, обеспечивать стабильную работу серверов, 
                разрабатывать новые обучающие материалы и создавать больше интерактивных упражнений по SQL.
            </p>
            <p class="donation-helper donation-intro">
                Сейчас поддержка особенно важна: если вы пользуетесь SQLtest.online и хотите видеть новые уроки и функции,
                донат сегодня напрямую поможет проекту продолжить развитие в следующем месяце.
            </p>
            <ul class="donation-suggested">
                <li>$3-5 помогают покрыть часть серверных расходов.</li>
                <li>$10-15 поддерживают выпуск новых уроков и задач.</li>
                <li>$25+ заметно ускоряют развитие проекта.</li>
            </ul>
        </div>
    </div>
    <div class="section" style="height: 100%;">
        <div style="display: block;">      
            <h2 style="color: var(--ligth-h2-color);">Способы поддержки:</h2>
            <div class="donation-methods">
                <div class="donation-method">
                    <h3>В рублях:</h3>
                    <p style="margin: 1.5rem 0;">
                        <a href="https://pay.cloudtips.ru/p/60214a3d" target="_blank">
                        <img src="https://static.tildacdn.com/tild3431-6231-4938-b464-663831306266/Horiz.svg" 
                            alt="Оплата через CloudTips"
                            style="width: 200px;
                            background-color: white;
                            padding: 10px;
                            border-radius: 7px;">
                        </a>
                    </p>
                    <p>Быстрый и безопасный платёж через CloudTips:</p>
                    <div class="payment-method-hints" aria-label="Поддерживаемые способы оплаты в CloudTips">
                        <span class="hint-label">Доступна карта <span class="payment-badge mir"><span class="mir-logo" aria-hidden="true">МИР</span></span></span>
                    </div>
                    <p class="donation-fallback">Если виджет не открылся, используйте прямую ссылку: <a href="https://pay.cloudtips.ru/p/60214a3d" target="_blank" rel="noopener noreferrer">CloudTips</a>.</p>
                </div>
                
                <div class="donation-method">
                    <h3>В USD/EUR:</h3>
                    <script type='text/javascript'>
                        kofiwidget2.init('Поддержать на Ko-fi', 'revert-layer', 'D1D76X1T1');
                        kofiwidget2.draw();
                    </script>
                    <p>Удобный платёж через Ko-fi. Сервис принимает <span class="payment-badge"><span aria-hidden="true">💳</span>Карта</span> и <span class="payment-badge"><span aria-hidden="true">🅿️</span>PayPal</span></p>
                    <p class="donation-fallback">Если виджет не загрузился, откройте прямую ссылку: <a href="https://ko-fi.com/D1D76X1T1" target="_blank" rel="noopener noreferrer">ko-fi.com/D1D76X1T1</a>.</p>
                </div>
                <div class="donation-method">
                    <h3>lava.top:</h3>
                    <p>Оплата в евро через lava.top - сервис принимает карты российских банков, PayPal и другие способы оплаты.</p>
                    <iframe title="lava.top" style="border: none" width="270" height="60" src="https://widget.lava.top/f753dc3c-096e-40ca-afe4-c106fa194b18"></iframe>
                    <p class="donation-fallback">Если виджет не загрузился, используйте прямую ссылку: <a href="https://app.lava.top/products/2800c402-a8c3-404e-8e75-940937b813f9/e2ee84c7-d8e7-4521-98dc-cc336c001a45?currency=EUR&domainId=77569739-54ac-45a4-9efc-9c6fc8b454aa&domainName=sqltest.online" target="_blank" rel="noopener noreferrer">lava.top</a>.</p>
                </div>
                <div class="donation-method">
                    <h3>В криптовалюте</h3>
                    <p>Если вам удобнее донатить в криптовалюте, используйте виджет ниже:</p>
                    <iframe src="https://nowpayments.io/embeds/donation-widget?api_key=8881e1d0-aaef-46c4-9a60-298bb6f26c3b" width="346" height="623" frameborder="0" scrolling="no" style="overflow-y: hidden;">
                        Can't load widget
                    </iframe>
                    <p class="donation-fallback">Если виджет блокируется браузером, попробуйте отключить блокировщик контента или воспользуйтесь Ko-fi выше.</p>
                </div>
            </div>

            <h2 style="color: var(--ligth-h2-color); margin-top: 2rem;">Последние пожертвования</h2>
            <div class="donation-method donations-history">
                {if $LatestDonations|@count > 0}
                    <table class="donations-history-table">
                        <thead>
                            <tr>
                                <th>Пользователь</th>
                                <th>Дата</th>
                                <th class="align-right">Сумма</th>
                                <th class="align-right">USD</th>
                                <th>Примечание</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$LatestDonations item=donation}
                                <tr>
                                    <td>{$donation.donor_name|escape}</td>
                                    <td>{$donation.donated_at|escape}</td>
                                    <td class="align-right">
                                        {$donation.amount|escape} {$donation.currency|escape}
                                    </td>
                                    <td class="align-right">$ {$donation.amount_usd|escape}</td>
                                    <td>{$donation.notes|default:'-'|escape}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                {else}
                    <p class="donations-history-empty">Пока нет донатов для отображения.</p>
                {/if}
            </div>
        </div>
    </div>
    <div class="section bottom colored">
        <div>
            <h4>
                Спасибо, что вы с нами! Ваша поддержка помогает делать SQLtest.online лучше. ❤️ 
                Вместе мы делаем изучение SQL доступнее и увлекательнее для каждого.
            </h4>
        </div>
    </div>
</div>