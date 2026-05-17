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

                            <p><strong>Recommended learning paths:</strong></p>
                            <ul style="padding-left: 1.2em;">
                                <li><strong>SQL analytics core</strong>
                                    <ul>
                                        <li>Master SQL for Data Analysis</li>
                                        <li>SQL Window Functions for Data</li>
                                        <li>Mastering Advanced SQL Queries</li>
                                        <li>Optimize SQL Queries: Uncover Performance Bottlenecks</li>
                                    </ul>
                                </li>
                                <li><strong>BI and dashboarding</strong>
                                    <ul>
                                        <li>Data Analysis and Visualization with Power BI</li>
                                        <li>Data Storytelling with Power BI</li>
                                        <li>Data Analysis and Dashboard Design with Tableau</li>
                                        <li>Tableau for Data-Driven Decision Making</li>
                                    </ul>
                                </li>
                                <li><strong>Cloud analytics / warehouse</strong>
                                    <ul>
                                        <li>BigQuery for Data Analysts</li>
                                        <li>How to Build a BI Dashboard Using Google Looker Studio and BigQuery</li>
                                    </ul>
                                </li>
                                <li><strong>Broader analyst skill expansion</strong>
                                    <ul>
                                        <li>Introduction to Data Analysis Using Excel</li>
                                        <li>Financial Data Analysis with Excel, Python and Power BI</li>
                                    </ul>
                                </li>
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
                    <div style="margin-top: 1rem;">
                        <div style="font-weight: 700; font-size: 0.95rem; color: var(--question-text); margin-bottom: 0.75rem;">
                            Recommended Coursera courses for sqltest.online readers
                        </div>

                        <div style="display: flex; flex-direction: column; gap: 1rem;">
                            <section>
                                <div style="font-weight: 700; margin: 0 0 0.5rem 0; color: var(--menu-button-background-color);">SQL analytics core</div>
                                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 0.75rem;">
                                    <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3ATTNdJzwFEfCvexL6Zx2PNQ&amp;u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Fpackt-master-sql-for-data-analysis-creek&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                        <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/a2/f1324ef4744fc2b8a26fbdba293e9c/V19683.jpg?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="Master SQL for Data Analysis" style="width: 100%; height: auto; display: block;">
                                        <div style="padding: 0.75rem; line-height: 1.4;">
                                            <div style="font-weight: 700; margin-bottom: 0.25rem;">Master SQL for Data Analysis</div>
                                            <div style="font-size: 0.85rem; opacity: 0.9;">Strong foundation for data analysis, filtering, joins, subqueries, and window functions.</div>
                                        </div>
                                    </a>

                                    <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3AX7Cr9MqfEfCGDQr_wTYZuQ&amp;u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Fsql-window-functions-for-data&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                        <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/a8/eb588bef744204ac629fc6e2c814d2/Logo-Image-1200-X-1200.png?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="SQL Window Functions for Data" style="width: 100%; height: auto; display: block;">
                                        <div style="padding: 0.75rem; line-height: 1.4;">
                                            <div style="font-weight: 700; margin-bottom: 0.25rem;">SQL Window Functions for Data</div>
                                            <div style="font-size: 0.85rem; opacity: 0.9;">Ranking, rolling metrics, and row-level analytics for advanced SQL work.</div>
                                        </div>
                                    </a>

                                    <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3A7eBsnGDPEfCy5w726iKh0Q&amp;u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Fmastering-advanced-sql-queries&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                        <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/a9/3398ca166547c4a1b0ac8e90e8d8a9/BC-4650_Coursera-Originals_-Data-Science-Essentials-Toolkit_CourseCard-1.png?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="Mastering Advanced SQL Queries" style="width: 100%; height: auto; display: block;">
                                        <div style="padding: 0.75rem; line-height: 1.4;">
                                            <div style="font-weight: 700; margin-bottom: 0.25rem;">Mastering Advanced SQL Queries</div>
                                            <div style="font-size: 0.85rem; opacity: 0.9;">Nested queries, CTEs, and AI-assisted optimization for harder problems.</div>
                                        </div>
                                    </a>

                                    <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3AUGyqldprEfCyZQ5rlh45lQ&amp;u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Foptimize-sql-queries-uncover-performance-bottlenecks&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                        <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/6c/cdf01ff2d64d0ca72bd2f5ad766266/Logo-Image-1200-X-1200.png?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="Optimize SQL Queries: Uncover Performance Bottlenecks" style="width: 100%; height: auto; display: block;">
                                        <div style="padding: 0.75rem; line-height: 1.4;">
                                            <div style="font-weight: 700; margin-bottom: 0.25rem;">Optimize SQL Queries</div>
                                            <div style="font-size: 0.85rem; opacity: 0.9;">Performance tuning and execution-plan thinking for analytical systems.</div>
                                        </div>
                                    </a>
                                </div>
                            </section>

                            <section>
                                <div style="font-weight: 700; margin: 0 0 0.5rem 0; color: var(--menu-button-background-color);">BI and dashboarding</div>
                                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 0.75rem;">
                                    <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3A2K-pi_e3Ee2VmA6uZNJ63w&amp;u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Fdata-analysis-and-visualization-with-power-bi&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                        <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/09/dfca8912e2441eb1795911a0e67d5e/Course-5.png?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="Data Analysis and Visualization with Power BI" style="width: 100%; height: auto; display: block;">
                                        <div style="padding: 0.75rem; line-height: 1.4;">
                                            <div style="font-weight: 700; margin-bottom: 0.25rem;">Data Analysis and Visualization with Power BI</div>
                                            <div style="font-size: 0.85rem; opacity: 0.9;">Reports, dashboards, and visual storytelling in Microsoft Power BI.</div>
                                        </div>
                                    </a>

                                    <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3AeZslrldoEe6rZAooU_uugw&amp;u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Fdata-storytelling-with-power-bi&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                        <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/36/b062715c75482a9e50303ad8c7a7e7/Logo_Data-Storytelling-with-PBI--course-part-of-the-PBI-s12n--.jpg?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="Data Storytelling with Power BI" style="width: 100%; height: auto; display: block;">
                                        <div style="padding: 0.75rem; line-height: 1.4;">
                                            <div style="font-weight: 700; margin-bottom: 0.25rem;">Data Storytelling with Power BI</div>
                                            <div style="font-size: 0.85rem; opacity: 0.9;">Turn structured data into clear stories, reports, and dashboards.</div>
                                        </div>
                                    </a>

                                    <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3A2_ZBfh3eEfG_GxIrFgVrjQ&amp;u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Fdata-analysis-dashboard-design-tableau&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                        <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/25/a888988a514601b12c7226f57076cb/Data-Analysis-and-Dashboard-Design-with-Tableau-100.jpg?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="Data Analysis and Dashboard Design with Tableau" style="width: 100%; height: auto; display: block;">
                                        <div style="padding: 0.75rem; line-height: 1.4;">
                                            <div style="font-weight: 700; margin-bottom: 0.25rem;">Data Analysis and Dashboard Design with Tableau</div>
                                            <div style="font-size: 0.85rem; opacity: 0.9;">Advanced Tableau analysis and scalable dashboard design.</div>
                                        </div>
                                    </a>

                                    <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3A_FTqKB3cEfGV9wr_z2Fh3w&amp;u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Ftableau-data-driven-decision-making&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                        <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/2d/927b05b7a3438eaaf415eb468d77c2/Tableau-for-Data-Driven-Decision-Making-100.jpg?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="Tableau for Data-Driven Decision Making" style="width: 100%; height: auto; display: block;">
                                        <div style="padding: 0.75rem; line-height: 1.4;">
                                            <div style="font-weight: 700; margin-bottom: 0.25rem;">Tableau for Data-Driven Decision Making</div>
                                            <div style="font-size: 0.85rem; opacity: 0.9;">BI foundations, data prep, and interactive visual analytics with Tableau.</div>
                                        </div>
                                    </a>
                                </div>
                            </section>

                            <section>
                                <div style="font-weight: 700; margin: 0 0 0.5rem 0; color: var(--menu-button-background-color);">Cloud analytics / warehouse</div>
                                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 0.75rem;">
                                    <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3Almx4OGjjEe6vIRJJdXRzxQ&amp;u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Fbigquery-for-data-analysts&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                        <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/d2/02da6886ed454a997f4b42d6437dc5/Logo-Image_GC-Projects-1-1-copy.png?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="BigQuery for Data Analysts" style="width: 100%; height: auto; display: block;">
                                        <div style="padding: 0.75rem; line-height: 1.4;">
                                            <div style="font-weight: 700; margin-bottom: 0.25rem;">BigQuery for Data Analysts</div>
                                            <div style="font-size: 0.85rem; opacity: 0.9;">Learn to ingest, transform, and query warehouse data in BigQuery.</div>
                                        </div>
                                    </a>

                                    <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3A2n0mLKktEeyxDg4ukgkVlw&amp;u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Fgooglecloud-how-to-build-a-bi-dashboard-using-google-data-studio-and-bigqu-cfi1a&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                        <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/40/35b51041a04b58ac739cf8e9e767f6/Logo-Image_GC-Projects.png?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="How to Build a BI Dashboard Using Google Looker Studio and BigQuery" style="width: 100%; height: auto; display: block;">
                                        <div style="padding: 0.75rem; line-height: 1.4;">
                                            <div style="font-weight: 700; margin-bottom: 0.25rem;">Google Looker Studio + BigQuery</div>
                                            <div style="font-size: 0.85rem; opacity: 0.9;">A low-ticket entry point for BI dashboards on Google Cloud.</div>
                                        </div>
                                    </a>
                                </div>
                            </section>

                            <section>
                                <div style="font-weight: 700; margin: 0 0 0.5rem 0; color: var(--menu-button-background-color);">Broader analyst skill expansion</div>
                                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 0.75rem;">
                                    <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3AOUTGOrvTEeWuCAqiwoZfSw&amp;u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Fexcel-data-analysis&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                        <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/60/d819005f0c11e6bc2b7945d34f43c3/ChartsGraphsTabletThumb.jpg?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="Introduction to Data Analysis Using Excel" style="width: 100%; height: auto; display: block;">
                                        <div style="padding: 0.75rem; line-height: 1.4;">
                                            <div style="font-weight: 700; margin-bottom: 0.25rem;">Introduction to Data Analysis Using Excel</div>
                                            <div style="font-size: 0.85rem; opacity: 0.9;">Useful spreadsheet skills for analysts who work across tools and teams.</div>
                                        </div>
                                    </a>

                                    <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3AXffgwxJHEfGQ2w5GCXwtVw&amp;u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Ffinancial-data-analysis-with-excel-python-and-power-bi&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                        <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/49/c0ec79434641fca5e2e157dfd6fc6c/Financial-Data-Transformation-and-Visualization.png?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="Financial Data Analysis with Excel, Python and Power BI" style="width: 100%; height: auto; display: block;">
                                        <div style="padding: 0.75rem; line-height: 1.4;">
                                            <div style="font-weight: 700; margin-bottom: 0.25rem;">Financial Data Analysis with Excel, Python and Power BI</div>
                                            <div style="font-size: 0.85rem; opacity: 0.9;">A cross-tool workflow for financial analysis, modeling, and dashboarding.</div>
                                        </div>
                                    </a>
                                </div>
                            </section>
                        </div>
                    </div>
                {/if}
            </div>