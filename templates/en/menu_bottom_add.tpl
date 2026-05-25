            <div class="menu-ad">
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
                    {math equation="floor(x / 3600) % 4" x=$smarty.now assign="coursera_slot"}
                    <div style="margin-top: 1rem;">
                        <div style="font-weight: 700; font-size: 0.95rem; color: var(--question-text); margin-bottom: 0.75rem;">
                            🚀 Level up your data skills — top Coursera picks
                        </div>
                        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 0.75rem;">

                            {if $coursera_slot == 0}
                                {* Pair 0: Meta + IBM — SQL for data science *}
                                <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3AzzCuAEa2Ee6WbA6Rm9OQgw&amp;u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Fdata-analysis-with-spreadsheets-and-sql&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                    <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/76/bd563a41474d8e91932a98f56de86c/Logo_5.png?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="Data Analysis with Spreadsheets and SQL" style="width: 100%; height: auto; display: block;">
                                    <div style="padding: 0.75rem; line-height: 1.4;">
                                        <div style="font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: var(--menu-link-color); margin-bottom: 0.3rem;">Meta</div>
                                        <div style="font-weight: 700; margin-bottom: 0.25rem;">Data Analysis with Spreadsheets and SQL</div>
                                        <div style="font-size: 0.85rem; opacity: 0.9;">Meta-certified skills. Master the SQL + spreadsheet combo that powers data teams at top tech companies.</div>
                                    </div>
                                </a>
                                <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3AGDQMSxDWEeitFhJL4G-A_g&amp;u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Fsql-data-science&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                    <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/bb/f59850318b11e88de79f6e54d6a7e2/184x184-SQL-for-DataScience.png?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="Databases and SQL for Data Science with Python" style="width: 100%; height: auto; display: block;">
                                    <div style="padding: 0.75rem; line-height: 1.4;">
                                        <div style="font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: var(--menu-link-color); margin-bottom: 0.3rem;">IBM</div>
                                        <div style="font-weight: 700; margin-bottom: 0.25rem;">Databases and SQL for Data Science with Python</div>
                                        <div style="font-size: 0.85rem; opacity: 0.9;">IBM-certified SQL + Python — the most in-demand skill pair for data analysts and data scientists.</div>
                                    </div>
                                </a>

                            {elseif $coursera_slot == 1}
                                {* Pair 1: IBM + Knowledge Accelerators — BI & warehousing *}
                                <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=spzn%3Al-LwwzNdEeyJAQoAQNSzoQ&amp;u=https%3A%2F%2Fwww.coursera.org%2Fspecializations%2Fbi-foundations-sql-etl-data-warehouse&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                    <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://d15cw65ipctsrr.cloudfront.net/27/a156f51493441cb45d0a9ec83b22f9/ETL-Specialization-1200x1200.jpg?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="BI Foundations with SQL, ETL and Data Warehousing" style="width: 100%; height: auto; display: block;">
                                    <div style="padding: 0.75rem; line-height: 1.4;">
                                        <div style="font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: var(--menu-link-color); margin-bottom: 0.3rem;">IBM · Specialization</div>
                                        <div style="font-weight: 700; margin-bottom: 0.25rem;">BI Foundations with SQL, ETL and Data Warehousing</div>
                                        <div style="font-size: 0.85rem; opacity: 0.9;">IBM Specialization. Build ETL and data warehouse skills used in enterprise BI at banks and tech firms.</div>
                                    </div>
                                </a>
                                <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=spzn%3AhZGfXW7VQ1egTUNFhYCxMA&amp;u=https%3A%2F%2Fwww.coursera.org%2Fspecializations%2Fxlpbi&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                    <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://d15cw65ipctsrr.cloudfront.net/9f/af2dc8a18548fea5a5ba7efe1a2fd6/Excel-PBI-Specialization.png?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="Excel to Power BI: Data Analysis &amp; Business Intelligence" style="width: 100%; height: auto; display: block;">
                                    <div style="padding: 0.75rem; line-height: 1.4;">
                                        <div style="font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: var(--menu-link-color); margin-bottom: 0.3rem;">Knowledge Accelerators · Specialization</div>
                                        <div style="font-weight: 700; margin-bottom: 0.25rem;">Excel to Power BI: Data Analysis &amp; Business Intelligence</div>
                                        <div style="font-size: 0.85rem; opacity: 0.9;">Excel → Power BI in one Specialization. Listed in 80%+ of analyst job postings — start or level up your BI career.</div>
                                    </div>
                                </a>

                            {elseif $coursera_slot == 2}
                                {* Pair 2: Finance & cloud SQL *}
                                <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3AXffgwxJHEfGQ2w5GCXwtVw&amp;u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Ffinancial-data-analysis-with-excel-python-and-power-bi&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                    <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/49/c0ec79434641fca5e2e157dfd6fc6c/Financial-Data-Transformation-and-Visualization.png?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="Financial Data Analysis with Excel, Python and Power BI" style="width: 100%; height: auto; display: block;">
                                    <div style="padding: 0.75rem; line-height: 1.4;">
                                        <div style="font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: var(--menu-link-color); margin-bottom: 0.3rem;">Coursera</div>
                                        <div style="font-weight: 700; margin-bottom: 0.25rem;">Financial Data Analysis with Excel, Python and Power BI</div>
                                        <div style="font-size: 0.85rem; opacity: 0.9;">The toolchain of financial analysts — Excel, Python, and Power BI. Turn raw data into business decisions.</div>
                                    </div>
                                </a>
                                <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3AYjKUTEBtEfCO_gr_yN6pEQ&amp;u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Fazure-data-engineering-cosmos-db-sql--analytics&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                    <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/a2/4419b6570e4201b74c4b8cecf28934/Thumbnail-1200-x-1200-px-1-.png?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="Azure Data Engineering: Cosmos DB, SQL &amp; Analytics" style="width: 100%; height: auto; display: block;">
                                    <div style="padding: 0.75rem; line-height: 1.4;">
                                        <div style="font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: var(--menu-link-color); margin-bottom: 0.3rem;">Coursera · Microsoft Azure</div>
                                        <div style="font-weight: 700; margin-bottom: 0.25rem;">Azure Data Engineering: Cosmos DB, SQL &amp; Analytics</div>
                                        <div style="font-size: 0.85rem; opacity: 0.9;">SQL on Microsoft Azure. Architect cloud-scale analytics with Cosmos DB, Azure SQL, and Synapse.</div>
                                    </div>
                                </a>

                            {else}
                                {* Pair 3: Advanced data engineering & AI *}
                                <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=spzn%3Akob9UAMxRBiXTUwUzylLhA&amp;u=https%3A%2F%2Fwww.coursera.org%2Fspecializations%2Fbuilding-smarter-data-pipelines-sql-spark-kafka-and-genai&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                    <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://d15cw65ipctsrr.cloudfront.net/f3/f60373551243b292fb8ed9402ea64f/pexels-thisisengineering-3861951.jpg?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="Building Smarter Data Pipelines: SQL, Spark, Kafka &amp; GenAI" style="width: 100%; height: auto; display: block;">
                                    <div style="padding: 0.75rem; line-height: 1.4;">
                                        <div style="font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: var(--menu-link-color); margin-bottom: 0.3rem;">Coursera · Specialization</div>
                                        <div style="font-weight: 700; margin-bottom: 0.25rem;">Building Smarter Data Pipelines: SQL, Spark, Kafka &amp; GenAI</div>
                                        <div style="font-size: 0.85rem; opacity: 0.9;">The modern data engineering stack — SQL to Spark to GenAI. Build production pipelines that process millions of records.</div>
                                    </div>
                                </a>
                                <a href="https://imp.i384100.net/c/5622383/1242836/14726?prodsku=crse%3AfyQ8ooAeEe-SQQ53QcJlAw&amp;u=https%3A%2F%2Fwww.coursera.org%2Flearn%2Fdatabase-to-ai-practical-data-analytics-integration&amp;intsrc=CATF_9419" target="_blank" rel="noopener noreferrer" style="display: block; background: var(--accordion-panel-bg-color); border: 1px solid var(--text-block-border-color); border-radius: 10px; overflow: hidden; color: var(--question-text); text-decoration: none;">
                                    <img src="https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://coursera-course-photos.s3.amazonaws.com/83/e4fb2ebb1a4474878db8d29e0dcdcd/MSIS-Coursera-Course-Card-1-.png?auto=format%2Ccompress&amp;dpr=1&amp;w=300&amp;h=300&amp;fit=crop" alt="Database to AI: Practical Data Analytics Integration" style="width: 100%; height: auto; display: block;">
                                    <div style="padding: 0.75rem; line-height: 1.4;">
                                        <div style="font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: var(--menu-link-color); margin-bottom: 0.3rem;">Northeastern University</div>
                                        <div style="font-weight: 700; margin-bottom: 0.25rem;">Database to AI: Practical Data Analytics Integration</div>
                                        <div style="font-size: 0.85rem; opacity: 0.9;">Northeastern University. Bridge your SQL skills into AI-powered analytics — the career path that's reshaping data roles.</div>
                                    </div>
                                </a>
                            {/if}

                        </div>
                    </div>
                {/if}
            </div>