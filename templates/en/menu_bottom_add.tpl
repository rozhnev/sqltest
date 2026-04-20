            <div class="menu-ad">
                {* <div id="yandex_rtb_R-A-4716552-2">
                    <div style="
                    margin: 0.5em 0 0 0; 
                    background-color: var(--accordion-panel-bg-color);
                    border: 1px solid var(--text-block-border-color);
                    color: var(--question-text);
                    border-radius: 0 6px 0 0;">
                        <div style="
                            background-color: var(--menu-button-background-color);
                            border-radius: 0 6px 0 0;
                            padding: 0.5em;
                            color: white;">Help make SQLtest.online even better!</div>
                        <div style="font-size:small; padding: 0.5em;">
                            <p>Greetings, SQL lovers!</p>
        
                            <p>I am writing to you today because I need your help.</p>
        
                            SQLtest.online is a free platform designed to help people of all levels master SQL.<br>
                            We offer a wide range of interactive tests, problems and training materials to help you improve your SQL skills.<br>
                            The platform has already helped a lot of people, but we want to make it even better. And this is where you can help us!
        
                            <p>How you can help:
                                <ul>
                                    <li>Invite your friends and colleagues to join SQLtest.online!</li>
                                    <li>Tell your friends and colleagues about SQLtest.online. Share a link to our site on social networks, by email or in person.</li>
                                    <li>Write an article or blog post about SQLtest.online. Share your experience with the platform.</li>
                                    <li>Together we can make SQLtest.online the best resource for learning SQL!</li>
                                </ul>
                            </p>
                            <p>
                                The more people use the platform, the better it will become. We'll be able to add more content, improve features, and create a better community for SQL enthusiasts.
                            </p>
                            <p>
                                Thanks for your help!<br>
                                Command <a href='https://sqltest.online/en'>SQLtest.online</a>
                            </p>
                        </div>
                    </div>
                </div> *}
                {math equation="x % 2" x=$smarty.now assign="show_appeal"}
                {if !$User->showAd() || $show_appeal}
                    <div style="
                        margin: 0.5em 0 0 0;
                        background-color: var(--accordion-panel-bg-color);
                        border: 1px solid var(--text-block-border-color);
                        color: var(--question-text);
                        border-radius: 0 6px 0 0;">

                        <div style="
                            background-color: var(--menu-button-background-color);
                            border-radius: 0 6px 0 0;
                            padding: 0.5em;
                            color: white;">
                            🙏 Help sqltest.online grow!
                        </div>

                        <div style="font-size: small; padding: 0.5em; line-height: 1.6;">
                            <p>Hey there!</p>

                            <p>
                                If <strong>sqltest.online</strong> has ever helped you learn SQL, practice for an interview,
                                or just satisfy your curiosity. I'd love to hear about it.
                            </p>

                            <p>
                                This project is something I built and maintain on my own, completely <strong>free</strong>,
                                because I believe SQL skills should be accessible to everyone.
                                No subscriptions, no paywalls. Just a tool I genuinely enjoy making better.
                            </p>

                            <p>If you've found it useful, the best thing you can do is <strong>share your honest opinion</strong>:</p>

                            <ul style="list-style: none; padding-left: 0.5em;">
                                <li>🟠 <strong>Reddit:</strong> <a href="https://www.reddit.com/r/SQL/" target="_blank" style="color: var(--menu-link-color);">r/SQL</a>,
                                    <a href="https://www.reddit.com/r/learnprogramming/" target="_blank" style="color: var(--menu-link-color);">r/learnprogramming</a>,
                                    <a href="https://www.reddit.com/r/webdev/" target="_blank" style="color: var(--menu-link-color);">r/webdev</a></li>
                                <li>🔵 On <strong>Facebook</strong> or anywhere your developer community hangs out</li>
                            </ul>

                            <p>
                                And if you do post, please send me the link at
                                <a href="mailto:rozhnev@gmail.com" style="color: var(--menu-link-color);">✉️&nbsp;rozhnev@gmail.com</a>.
                                I'd love to read it and say thank you personally.
                            </p>

                            <p>
                                ❤️ Thank you for using sqltest.online. You're the reason it keeps going.<br><br>
                                Slava Rozhnev, creator of <a href="https://sqltest.online/en" style="color: var(--menu-link-color);">sqltest.online</a>
                            </p>
                        </div>
                    </div>
                {else}
                    <div style="display: flex; gap: 1rem; flex-wrap: wrap; justify-content: center; margin-top: 1rem;">
                        <a href="https://www.jdoqocy.com/click-101541078-17083149" target="_blank" class="talkpal-ad-container" style="background-color: #052d50; display: flex;">
                            <img src="https://www.ftjcfx.com/image-101541078-17083149" width="250" height="360" alt="Contabo.com" style="max-width: 100%; height: auto;" border="0"/>
                        </a>
                        <a href="https://www.tkqlhce.com/click-101561323-17139054" target="_blank" class="talkpal-ad-container" style="padding: 15px 10px;">
                            <img src="https://www.awltovhc.com/image-101561323-17139054" alt="Point" width="1" height="1" border="0"/>
                            <img src="https://files.talkpal.ai/landing_images/talkpal-text-logo.svg" alt="Talkpal AI Logo" class="talkpal-ad-logo">
                            <div class="talkpal-ad-text">The fun and effective way to learn a language with AI!</div>
                            <div class="talkpal-ad-subtext">Practice speaking, listening & writing.</div>
                            <span class="talkpal-ad-button">Start Learning Now</span>
                        </a>
                    </div>
                {/if}
            </div>