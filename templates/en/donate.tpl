<link rel="stylesheet" type="text/css" href="/about.css?{$VERSION}" media="all">
<div class="about">
    <div class="section top colored">
        <div>
            <h2>❤️ Support SQLtest.online</h2>
        </div>
        <div style="display: block; text-align: left;">
            <p>
                SQLtest.online is a free SQL learning platform used by students, developers, and professionals preparing for technical interviews.
                Your support keeps the project alive - covering server costs, funding new lessons, and helping us build more interactive SQL exercises.
            </p>
        </div>
    </div>
    <div class="section" style="height: 100%;">
        <div style="display: block;">      
            <h2 style="color: var(--ligth-h2-color);">💳 Choose How to Support</h2>
            <div class="donation-methods">
                <div class="donation-method">
                    <h3>Ko‑fi (Bank Card / PayPal)</h3>
                    <p style="margin: 1.5rem 0;">
                    <script type='text/javascript' src='https://storage.ko-fi.com/cdn/widget/Widget_2.js'></script>
                    <script type='text/javascript'>
                        kofiwidget2.init('Support us on Ko-fi', 'revert-layer', 'D1D76X1T1');
                        kofiwidget2.draw();
                    </script>
                    </p>
                    <p>Simple and secure payments available in most regions.</p>
                    <p class="donation-fallback">If the widget does not load, use the direct link: <a href="https://ko-fi.com/D1D76X1T1" target="_blank" rel="noopener noreferrer">ko-fi.com/D1D76X1T1</a>.</p>
                </div>
                <div class="donation-method">
                    <h3>Crypto Donations</h3>
                    <p>Prefer crypto? Use the widget below.:</p>
                    <iframe src="https://nowpayments.io/embeds/donation-widget?api_key=8881e1d0-aaef-46c4-9a60-298bb6f26c3b" width="346" height="623" frameborder="0" scrolling="no" style="overflow-y: hidden;">
                        Can't load widget
                    </iframe>
                    <p class="donation-fallback">If it’s blocked by your browser, try disabling content blockers or use Ko‑fi instead.</p>
                </div>
            </div>
            <h3 style="color: var(--ligth-h2-color);">🎯 How Your Support Helps</h3>
            <div class="donation-method donations-history">
            <ul class="donation-suggested">
                <li>$3-5 helps cover part of the monthly server bill.</li>
                <li>$10-15 helps fund new lessons and exercises.</li>
                <li>$25+ meaningfully speeds up new development.</li>
            </ul>
            <p class="donation-helper">
                Every contribution, no matter the size, is greatly appreciated. Thank you for helping us make SQLtest.online even better!
            </p>
            </div>
            <h3 style="color: var(--ligth-h2-color); margin-top: 2rem;">💬 Recent Support</h3>
            <div class="donation-method donations-history">
                {if $LatestDonations|@count > 0}
                    <table class="donations-history-table">
                        <thead>
                            <tr>
                                <th>User</th>
                                <th>Date</th>
                                <th class="align-right">Amount</th>
                                <th class="align-right">USD</th>
                                <th>Note</th>
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
                    <p class="donations-history-empty">No donations to display yet.</p>
                {/if}
            </div>
            <h3 style="color: var(--ligth-h2-color);">🙏 Thank You</h3>
            <div class="donation-method donations-history">
                Hi, I’m Slava — I created SQLtest.online to help people learn SQL for free.
                I build and maintain this project myself, and your support directly helps me
                keep servers running, publish new lessons, and develop more interactive exercises.
                Thank you for helping SQL learning stay accessible to everyone.
            </div>
        </div>
    </div>
    <div class="section bottom colored">
        <div>
            <h4>
                Thank you for being an amazing part of the SQLtest.online community!
                Your support makes a real difference. ❤️
                Together, we're making SQL learning more accessible and enjoyable for everyone.
            </h4>
        </div>
    </div>
</div>