{assign var="PageTitle" value="{translate}share_achievement_page_title{/translate}"}
{assign var="PageDescription" value="{translate}share_achievement_page_description{/translate}"}
{assign var="PageOGTitle" value="{translate}share_achievement_og_title{/translate}"}

{* Make OG description informative + long enough for LinkedIn *}
{assign var="BaseOGDescription" value="{translate}share_achievement_og_description{/translate}"}
{if isset($ShareUserName) && $ShareUserName && isset($AchievementTitle) && $AchievementTitle}
    {assign var="PageOGDescription" value="{$ShareUserName|escape} unlocked “{$AchievementTitle|escape}” on SQLtest.online. {$BaseOGDescription}"}
{elseif isset($AchievementTitle) && $AchievementTitle}
    {assign var="PageOGDescription" value="Achievement unlocked: “{$AchievementTitle|escape}” on SQLtest.online. {$BaseOGDescription}"}
{else}
    {assign var="PageOGDescription" value=$BaseOGDescription}
{/if}

{* Add publication/updated time for LinkedIn cards *}
{if isset($PageOGPublishedTime) && $PageOGPublishedTime}
    <meta property="article:published_time" content="{$PageOGPublishedTime|escape}" />
{/if}

{if isset($ShareImageUrl) && $ShareImageUrl}
    {assign var="PageOGImage" value=$ShareImageUrl}
{else}
    {assign var="PageOGImage" value="https://sqltest.online/favicons/android-chrome-512x512.png"}
{/if}
{assign var="PageOGImageAlt" value="{$AchievementTitle}"}
{assign var="PageOGImageWidth" value="1200"}
{assign var="PageOGImageHeight" value="627"}
{include file='short-header.tpl'}
<body>
    <div class="container">
        <header>
            {if $MobileView}
                {include file='m.top-menu.tpl' path="/achievement/{$AchievementID}"}
            {else}
                {include file='top-menu.tpl' path="/achievement/{$AchievementID}"}
            {/if}
        </header>
        <main>

                {if isset($ImageUrl) && $ImageUrl}
                    <div style="margin: 1rem 0; display: flex; justify-content: center;">
                        <img
                            src="{$ImageUrl|escape}"
                            alt="{$AchievementTitle|escape}"
                            loading="lazy"
                        />
                    </div>
                {else}
                    <div class="text-block" style="margin: 2rem auto; max-width: 700px;">
                        <h2 style="margin-top: 0;">{translate}share_achievement_heading{/translate}</h2>
                        <p style="margin: 0.5rem 0;">
                            <strong>{$ShareUserName}</strong>
                            {translate}share_achievement_earned{/translate}
                            <strong>{$AchievementTitle}</strong>
                            <span style="opacity: 0.8;">({$EarnedAt})</span>
                        </p>
                    </div>
                {/if}

                {if $SolvedTasksRates}
                    <div style="max-width: 700px; margin: 0 auto 2rem; padding: 0 1rem; width: 100%;">
                        <div style="display: flex; height: 16px; width: 100%; border-radius: 8px; overflow: hidden; margin: 1.5rem 0 1rem; background-color: #e9ecef; box-shadow: inset 0 1px 2px rgba(0,0,0,0.1);">
                            {foreach $SolvedTasksRates as $rate}
                                {assign var="color" value="#6c757d"}
                                {if $rate.rate == 1}{assign var="color" value="#28a745"}
                                {elseif $rate.rate == 2}{assign var="color" value="#ffc107"}
                                {elseif $rate.rate == 3}{assign var="color" value="#fd7e14"}
                                {elseif $rate.rate == 4}{assign var="color" value="#dc3545"}
                                {elseif $rate.rate == 5}{assign var="color" value="#212529"}
                                {/if}
                                <div style="width: {$rate.count}%; background-color: {$color};" title="{$rate.rate_title}: {$rate.count}"></div>
                            {/foreach}
                        </div>
                        <div style="display: flex; flex-wrap: wrap; gap: 1rem 2rem; justify-content: center; font-size: 0.85rem; color: var(--question-text);">
                            {foreach $SolvedTasksRates as $rate}
                                {assign var="color" value="#6c757d"}
                                {if $rate.rate == 1}{assign var="color" value="#28a745"}
                                {elseif $rate.rate == 2}{assign var="color" value="#ffc107"}
                                {elseif $rate.rate == 3}{assign var="color" value="#fd7e14"}
                                {elseif $rate.rate == 4}{assign var="color" value="#dc3545"}
                                {elseif $rate.rate == 5}{assign var="color" value="#212529"}
                                {/if}
                                <div style="display: flex; align-items: center; gap: 0.4rem;">
                                    <span style="display: inline-block; width: 10px; height: 10px; border-radius: 50%; background-color: {$color};"></span>
                                    <span style="font-weight: 500;">{$rate.rate_title}:</span>
                                    <strong style="font-weight: 700;">{$rate.count}</strong>
                                </div>
                            {/foreach}
                        </div>
                    </div>
                {/if}

                <div style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: center; justify-content: center;">
                    {if isset($LinkedinShareUrl) && $LinkedinShareUrl}
                        <a class="button blue" target="_blank" rel="noopener noreferrer"
                           href="{$LinkedinShareUrl}">
                            <span>{translate}share_to_linkedin{/translate}</span>
                        </a>
                    {/if}

                    {if isset($FacebookShareUrl) && $FacebookShareUrl}
                        <a class="button" target="_blank" rel="noopener noreferrer"
                           style="background:#1877F2; border-color:#1877F2;"
                           href="{$FacebookShareUrl}">
                            <span>{translate}share_to_facebook{/translate}</span>
                        </a>
                    {/if}

                    {if isset($VKShareUrl) && $VKShareUrl}
                        <a class="button" target="_blank" rel="noopener noreferrer"
                           style="background:#0077FF; border-color:#0077FF;"
                           href="{$VKShareUrl}">
                            <span>{translate}share_to_vk{/translate}</span>
                        </a>
                    {/if}
                </div>
        </main>
        <footer>
            {if $MobileView}
                {include file='m.footer.tpl'}
            {else}
                {include file='footer.tpl'}
            {/if}
        </footer>
    </div>
</body>
</html>
