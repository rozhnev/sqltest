{$GradeColors = [''=>null,'Intern'=>'#3F3F3F','Junior'=>'#00FF00','Middle'=>'#0000FF','Senior'=>'#FF0000']}
{assign var="GradeColor" value="{$GradeColors[$User->grade()]}"|default:'#FFFFFF'}
{assign var="Grade" value="{$User->grade()}"}
<div style="display:flex; gap:1rem; align-items:center;">
    <div class="button green" style="padding:0; display:flex; align-items:center; justify-content:center;">
        <svg width="36" height="36" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
            <circle cx="32" cy="22" r="10" fill="#FFFFFF"/>
            <path d="M32 40C20 40 10 48 10 58H54C54 48 44 40 32 40Z" fill="{$GradeColor}"/>
        </svg>
    </div>
    <h4>
        {translate}hello{/translate}{if $User->nickname()}, {$User->nickname()}{elseif $User->grade()}, {translate}graded_sql_developer{/translate}{/if}!
    </h4>
</div>
{* Profile links on top: the popup opens from the user icon in the top menu *}
<nav class="user-popup-links">
    <a href="/{$Lang}/user/profile#tasks">{translate}user_popup_my_tasks{/translate}</a>
    {if isset($AiQuota)}
        <a href="/{$Lang}/user/profile#ai">{translate}profile_ai_tab{/translate}: <b>{$AiQuota.remaining_text}</b></a>
    {/if}
</nav>
{if $RecommendedAchievement}
<h4>{translate}recomended_achievement{/translate}:</h4>
<div class="achievement-row achievement-row--recommended">
    <div class="achievement-badge" aria-hidden="true">
        <svg width="18" height="18" viewBox="0 0 128 128" xmlns="http://www.w3.org/2000/svg">
            <path d="M64 10 L81.87 52.63 L127 52.63 L90.5 80.88 L103.75 123 L64 100.5 L24.25 123 L37.5 80.88 L1 52.63 L46.13 52.63 Z" fill="#A0A0A0" stroke="#808080" stroke-width="3"/>
            <circle cx="64" cy="72" r="20" fill="#E0E0E0" />
            <text x="64" y="80" font-size="24" font-weight="bold" text-anchor="middle" fill="#606060">✓</text>
        </svg>
    </div>
    <span>{$RecommendedAchievement}</span>
</div>
{/if}

<h4>{translate}your_last_achievements{/translate}:</h4>

{foreach $Achievements as $achievement}
    {assign var="gradId" value="gradient-`$achievement.achievement_id`"}
    <div class="achievement-row">
        <div class="achievement-badge" aria-hidden="true">
            <svg width="18" height="18" viewBox="0 0 128 128" xmlns="http://www.w3.org/2000/svg">
                <defs>
                    <linearGradient id="{$gradId}" x1="0%" y1="0%" x2="100%" y2="100%">
                        <stop offset="0%" style="stop-color:#FFD700;stop-opacity:1" />
                        <stop offset="100%" style="stop-color:#FF8C00;stop-opacity:1" />
                    </linearGradient>
                </defs>
                <path d="M64 10 L81.87 52.63 L127 52.63 L90.5 80.88 L103.75 123 L64 100.5 L24.25 123 L37.5 80.88 L1 52.63 L46.13 52.63 Z"
                      fill="url(#{$gradId})" stroke="#D4AF37" stroke-width="3"/>
            </svg>
        </div>
            <span class="achievement-date">{$achievement.earned_at}</span>

        {* Main clickable area (view achievement) *}
        <a class="achievement-main"
           target="_blank" rel="noopener noreferrer"
           href="{$achievement.share_url}"
           title="{translate}view_achievement{/translate}">
            <span class="achievement-title">{$achievement.title}</span>
        </a>

    </div>
{/foreach}

<a class="user-popup-all" href="/{$Lang}/user/profile#achievements">{translate}user_popup_all_achievements{/translate} →</a>
<div class="user-popup-footer">
    <button class="button" onclick="location.href='/{$Lang}/user/profile';"><span>{translate}profile_page_title{/translate}</span></button>
    <a class="user-popup-logout" href="/{$Lang}/logout">{translate}top_menu_logout{/translate}</a>
</div>