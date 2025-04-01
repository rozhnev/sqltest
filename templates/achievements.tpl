{$GradeColors = ['Intern'=>'#3F3F3F','Junior'=>'#00FF00','Middle'=>'#0000FF','Senior'=>'#FF0000']}
{assign var="GradeColor" value="{$GradeColors[$User->grade()]}"|default:'#FFFFFF'}
{assign var="Grade" value="{$User->grade()}"}
<div style="    display: flex;    gap: 1rem;    align-items: center;">
    <div class="button green" style="padding: 0; display: flex; align-items: center; justify-content: center;">
        <svg width="36" height="36" viewBox="0 0 64 64" fill="none" xmlns="http://www.w3.org/2000/svg">
            <circle cx="32" cy="22" r="10" fill="#FFFFFF"/>
            <path d="M32 40C20 40 10 48 10 58H54C54 48 44 40 32 40Z" fill="{$GradeColor}"/>
        </svg>
    </div>
    {if isset($User->grade())}<h4>{translate}hello{/translate}, {translate}graded_sql_developer{/translate}!</h4>{/if}
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
        <span>{$achievement.earned_at}</span>
        <span>{$achievement.title}</span>
    </div>
{/foreach}
<div style="display: flex; gap: 1rem;">
    <button class="button" onclick="location.href = '/{$Lang}/user/profile';"><span>👤︎ {translate}profile_page_title{/translate}</span></button>
    <button class="button" onclick="location.href = '/{$Lang}/logout';"><span>⇥ {translate}top_menu_logout{/translate}</span></button>
</div>