<link rel="stylesheet" type="text/css" href="/about.css?{$VERSION}" media="all">
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
        </div>
    </div>
    <div class="section" style="height: 100%;">
        <div style="display: block;">      
            <h2 style="color: var(--ligth-h2-color);">Способы поддержки:</h2>
            <div class="donation-methods">
                <div class="donation-method">
                    <h3>Поддержать в рублях</h3>
                    <p>Быстрый и безопасный платёж через CloudTips:</p>
                    <p>
                        <a href="https://pay.cloudtips.ru/p/60214a3d" target="_blank">
                        <img src="https://static.tildacdn.com/tild3431-6231-4938-b464-663831306266/Horiz.svg" 
                            alt="Оплата через CloudTips"
                            style="width: 200px;
                            background-color: white;
                            padding: 10px;
                            border-radius: 7px;">
                        </a>
                    </p>
                </div>
                
                <div class="donation-method">
                    <h3>Купить кофе за евро</h3>
                    <p>Удобный платёж через платформу Ko-fi:</p>
                    <script type='text/javascript' src='https://storage.ko-fi.com/cdn/widget/Widget_2.js'></script>
                    <script type='text/javascript'>
                        kofiwidget2.init('Поддержать на Ko-fi', 'revert-layer', 'D1D76X1T1');
                        kofiwidget2.draw();
                    </script>
                </div>
                <div class="donation-method">
                    <h3>Помочь в криптовалюте</h3>
                    <iframe src="https://nowpayments.io/embeds/donation-widget?api_key=8881e1d0-aaef-46c4-9a60-298bb6f26c3b" width="346" height="623" frameborder="0" scrolling="no" style="overflow-y: hidden;">
                        Can't load widget
                    </iframe>
                </div>
            </div>

            <h2 style="color: var(--ligth-h2-color); margin-top: 2rem;">Последние 5 донатов</h2>
            <div class="donation-method" style="max-width: 100%; min-width: 20rem; text-align: left;">
                {if $LatestDonations|@count > 0}
                    <table style="width: 100%; border-collapse: collapse;">
                        <thead>
                            <tr>
                                <th style="text-align: left; padding: 0.5rem; border-bottom: 1px solid #ccc;">Пользователь</th>
                                <th style="text-align: left; padding: 0.5rem; border-bottom: 1px solid #ccc;">Дата</th>
                                <th style="text-align: left; padding: 0.5rem; border-bottom: 1px solid #ccc;">Сумма</th>
                                <th style="text-align: left; padding: 0.5rem; border-bottom: 1px solid #ccc;">USD</th>
                                <th style="text-align: left; padding: 0.5rem; border-bottom: 1px solid #ccc;">Примечание</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$LatestDonations item=donation}
                                <tr>
                                    <td style="padding: 0.5rem; border-bottom: 1px solid #eee;">{$donation.donor_name|escape}</td>
                                    <td style="padding: 0.5rem; border-bottom: 1px solid #eee;">{$donation.donated_at|escape}</td>
                                    <td style="padding: 0.5rem; border-bottom: 1px solid #eee;">
                                        {$donation.amount|escape} {$donation.currency|escape}
                                    </td>
                                    <td style="padding: 0.5rem; border-bottom: 1px solid #eee;">{$donation.amount_usd|escape}</td>
                                    <td style="padding: 0.5rem; border-bottom: 1px solid #eee;">{$donation.notes|default:'-'|escape}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                {else}
                    <p style="margin: 0;">Пока нет донатов для отображения.</p>
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