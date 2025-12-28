{$GradeColors = [''=>null,'Intern'=>'#3F3F3F','Junior'=>'#00FF00','Middle'=>'#0000FF','Senior'=>'#FF0000']}
{assign var="GradeColor" value="{$GradeColors[$User->grade()]}"|default:'#FFFFFF'}
{assign var="Grade" value="{$User->grade()}"}
<style>
/* ...existing code... */

.achievement-row {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 8px 10px;
  border-radius: 12px;
}

.achievement-row:hover {
  background: var(--achievement-row-hover);
}

.achievement-row--recommended {
  background: var(--achievement-row-recommended-bg);
}

.achievement-row--recommended a {
  color: var(--question-text) !important;
}
.achievement-badge {
  flex: 0 0 auto;
  width: 22px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.achievement-main {
  flex: 1 1 auto;
  min-width: 0;
  display: flex;
  gap: 10px;
  align-items: baseline;
  text-decoration: none;
  color: inherit;
}

.achievement-date {
  flex: 0 0 auto;
  opacity: 0.9;
  font-variant-numeric: tabular-nums;
  white-space: nowrap;
}

.achievement-title {
  flex: 1 1 auto;
  min-width: 0;
  font-weight: 600;
  overflow-wrap: anywhere;
  color: var(--question-text-color) !important;
}

.achievement-actions {
  flex: 0 0 auto;
  display: flex;
  gap: 8px;
}

.icon-button {
  width: 32px;
  height: 32px;
  border-radius: 10px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  color: var(--achievement-icon-fg);
  background: var(--achievement-icon-bg);
  border: 1px solid var(--achievement-icon-border);
  text-decoration: none;
}

.icon-button:hover {
  background: color-mix(in srgb, var(--achievement-icon-bg) 70%, #fff 30%);
  border-color: color-mix(in srgb, var(--achievement-icon-border) 70%, #fff 30%);
}

.icon-button--linkedin {
  color: var(--achievement-linkedin-fg);
  background: var(--achievement-linkedin-bg);
  border-color: var(--achievement-linkedin-border);
}

.icon-button--linkedin:hover {
  background: color-mix(in srgb, var(--achievement-linkedin-bg) 70%, #fff 30%);
  border-color: color-mix(in srgb, var(--achievement-linkedin-border) 70%, #fff 30%);
}

/* Optional: clearer affordance on hover */
.achievement-main:hover .achievement-title {
  text-decoration: underline;
}
/* ...existing code... */
</style>
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

<h4>{translate}your_achievements{/translate}:</h4>

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

        {* Actions (icons) *}
        <div class="achievement-actions">
            <a class="icon-button icon-button--linkedin"
                target="_blank" rel="noopener noreferrer"
                href="{$achievement.linkedin_share_url}"
                title="{translate}share_your_achievement{/translate}"
                aria-label="{translate}share_your_achievement{/translate}">
                in
            </a>
        </div>
    </div>
{/foreach}

<div style="display:flex; gap:1rem;">
    <button class="button" onclick="location.href='/{$Lang}/user/profile';"><span>{translate}profile_page_title{/translate}</span></button>
    <button class="button" onclick="location.href='/{$Lang}/logout';"><span>{translate}top_menu_logout{/translate}</span></button>
</div>