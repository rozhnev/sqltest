<h3>{translate}recomended_achievement{/translate}</h3>:
{$RecommendedAchievement}
<h3>{translate}your_achievements{/translate}:</h3>
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
