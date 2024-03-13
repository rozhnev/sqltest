{include file='../short-header.tpl'}
    <body>
        <div class="{if $MobileView}mobile-container{else}full-container{/if}">
            <div class="header">
                <div class="top-menu">
                    {if $MobileView}
                        {include file='m.site-name.tpl'}
                    {else}
                        {include file='site-name.tpl'}
                    {/if}
                    <span class="lang-swith"><a href="/ru/privacy-policy" target="_self">RU</a></span>
                </div>
            </div>
            <div class="container3">
                <h2>Privacy Policy for SQLtest</h2>

                <p>This Privacy Policy describes how SQLtest ("we", "us", or "our") collects, uses, and shares personal information
                    when you use our SQLtest service.</p>

                <h3>1. Information We Collect:</h3>

                <ol>
                    <li><strong>Google OAuth2:</strong> When you use SQLtest, we may request access to your Google account
                        information via OAuth2. This may include, but is not limited to, your email address and profile information as specified during the authorization process.</li>
                </ol>

                <h3>2. How We Use the Information:</h3>

                <ol>
                    <li><strong>Authentication:</strong> We use the information obtained through Google OAuth2 to authenticate your
                        identity and provide you access to our services.</li>
                    <li><strong>Account Management:</strong> Your Google account information is used for managing your account within
                        SQLtest.</li>
                    <li><strong>Communication:</strong> We may use your email address to communicate with you regarding important
                        updates, notifications, or support-related matters.</li>
                </ol>

                <h3>3. Information Sharing:</h3>

                <ol>
                    <li><strong>Third-Party Services:</strong> We do not sell or share your personal information with third-party services.</li>
                    <li><strong>Legal Requirements:</strong> We may disclose your information if required to do so by law or in
                        response to valid requests from public authorities.</li>
                </ol>

                <h3>4. Security:</h3>

                <ol>
                    <li><strong>Data Security:</strong> We take reasonable precautions to protect your information. However, no
                        method of transmission over the internet or electronic storage is entirely secure, and we cannot guarantee
                        its absolute security.</li>
                </ol>

                <h3>5. Updates to This Privacy Policy:</h3>

                <ol>
                    <li><strong>Changes:</strong> We may update our Privacy Policy from time to time. Any changes will be effective
                        immediately upon posting the updated Privacy Policy on site <a href ="https://sqltest.online">SQLtest</a>.</li>
                </ol>

                <h3>6. Contact Us:</h3>

                <ol>
                    <li><strong>Questions:</strong> If you have any questions or concerns about our Privacy Policy, please contact
                        us at <a href="https://t.me/sqlize"> our telegram chat</a>.</li>
                </ol>

                <footer>
                    <p>This Privacy Policy was last updated on 2024-01-01.</p>
                </footer>
            </div>
{if $MobileView}
    {include file='../m.footer.tpl'}
{else}
    {include file='footer.tpl'}
{/if}