{foreach from=$Achievements item=$achievement}
    <div class="achievement">
        <div class="achievement-image">
            <img src="{$achievement.image}" alt="{$achievement.title}" />
        </div>
        <div class="achievement-info">
            <h3>{$achievement.earned_at}</h3>
            <h3>{translate}{$achievement.title}{/translate}</h3>
        </div>
    </div>
{/foreach}