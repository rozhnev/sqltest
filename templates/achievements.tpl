{$GradeColors = [''=>null,'Intern'=>'#3F3F3F','Junior'=>'#00FF00','Middle'=>'#0000FF','Senior'=>'#FF0000']}
{assign var="GradeColor" value="{$GradeColors[$User->grade()]}"|default:'#FFFFFF'}
{assign var="Grade" value="{$User->grade()}"}
<div style="    display: flex;    gap: 1rem;    align-items: center;">
    <div class="button green" style="padding: 0; display: flex; align-items: center; justify-content: center;">
        <svg width="36" height="36" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
            <circle cx="32" cy="22" r="10" fill="#FFFFFF"/>
            <path d="M32 40C20 40 10 48 10 58H54C54 48 44 40 32 40Z" fill="{$GradeColor}"/>
        </svg>
    </div>
    <h4>
        {translate}hello{/translate}{if $User->nickname()}, {$User->nickname()}{elseif $User->grade()}, {translate}graded_sql_developer{/translate}{/if}!
    </h4>
</div>
{if $RecommendedAchievement}
<h4>{translate}recomended_achievement{/translate}:</h4>
<div class="achievement">
    <div class="achievement-image">
        <svg width="16" height="16" viewBox="0 0 128 128" xmlns="http://www.w3.org/2000/svg">
            <path d="M64 10 L81.87 52.63 L127 52.63 L90.5 80.88 L103.75 123 L64 100.5 L24.25 123 L37.5 80.88 L1 52.63 L46.13 52.63 Z" fill="#A0A0A0" stroke="#808080" stroke-width="3"/>
            <circle cx="64" cy="72" r="20" fill="#E0E0E0" />
            <text x="64" y="80" font-size="24" font-weight="bold" text-anchor="middle" fill="#606060">✓</text>
        </svg>
    </div>
    <span>{$RecommendedAchievement}</span>
</div>
{/if}
<h4>{translate}your_achievements{/translate}:</h4>
{foreach $Achievements as $achievement}
    <div class="achievement">
        <div class="achievement-image">
            <svg width="16" height="16" viewBox="0 0 128 128" xmlns="http://www.w3.org/2000/svg" style="cursor: pointer;">
                <defs>
                    <linearGradient id="gradient" x1="0%" y1="0%" x2="100%" y2="100%">
                    <stop offset="0%" style="stop-color:#FFD700;stop-opacity:1" />
                    <stop offset="100%" style="stop-color:#FF8C00;stop-opacity:1" />
                    </linearGradient>
                </defs>
                <path d="M64 10 L81.87 52.63 L127 52.63 L90.5 80.88 L103.75 123 L64 100.5 L24.25 123 L37.5 80.88 L1 52.63 L46.13 52.63 Z" fill="url(#gradient)" stroke="#D4AF37" stroke-width="3"/>
            </svg>
        </div>

        <span class="achievement-date">{$achievement.earned_at}</span>
        <span class="achievement-title">{$achievement.title}</span>

        {if isset($achievement.share_url)}
            <a class="achievement-view text-button blue" target="_blank" rel="noopener noreferrer"
               href="{$achievement.share_url}"
               title="{translate}view_achievement{/translate}"
               aria-label="{translate}view_achievement{/translate}">
                <svg width="16" height="16" viewBox="0 0 24 24" aria-hidden="true">
                    <path fill="currentColor" d="M12 5c-7 0-10 7-10 7s3 7 10 7 10-7 10-7-3-7-10-7Zm0 12a5 5 0 1 1 0-10 5 5 0 0 1 0 10Zm0-8a3 3 0 1 0 0 6 3 3 0 0 0 0-6Z"/>
                </svg>
            </a>
        {/if}
        {if isset($achievement.linkedin_share_url)}
            <a class="achievement-view text-button blue" target="_blank" rel="noopener noreferrer"
               href="{$achievement.linkedin_share_url}"
               title="{translate}share_to_linkedin{/translate}"
               aria-label="{translate}share_to_linkedin{/translate}">
                <svg width="16" height="16" viewBox="0 0 24 24" aria-hidden="true" style="vertical-align:middle;">
                    <rect x="0" y="0" width="24" height="24" rx="2" fill="#0077B5"/>
                    <path fill="#FFF" d="M6.94 8.5H4.5V19h2.44V8.5zM5.72 7.36a1.42 1.42 0 110-2.84 1.42 1.42 0 010 2.84zM11.5 13.5c0-2.26-1.2-3.32-2.8-3.32-1.4 0-2.02.77-2.37 1.31V8.5H4.5V19h2.44v-5.04c0-1.35.26-2.62 1.9-2.62 1.62 0 1.66 1.63 1.66 2.7V19H11.5v-5.5zM20 19h-2.44v-5.6c0-1.33-.02-3.04-1.85-3.04-1.85 0-2.13 1.44-2.13 2.95V19H11.5V8.5H13.9v1.4h.03c.2-.38.7-1.03 1.88-1.03 2.01 0 2.95 1.31 2.95 3.79V19z"/>
                </svg>
            </a>
        {/if}
    </div>
{/foreach}
<div style="display: flex; gap: 1rem;">
    <button class="button" onclick="location.href = '/{$Lang}/user/profile';"><span>{translate}profile_page_title{/translate}</span></button>
    <button class="button" onclick="location.href = '/{$Lang}/logout';"><span>{translate}top_menu_logout{/translate}</span></button>
</div>