{* New-achievement line: above the task on page load (index.tpl), or in a correct check response, from where
   placeNewAchievement() in script.js moves it above the task. initNewAchievement() marks it viewed when a link in it
   is opened or it is closed. *}
{assign var="AchievementViewUrl" value="/{$Lang}/achievement/{$NewAchievement.user_achievement_id}"}
{assign var="AchievementShareUrl" value="https://sqltest.online/{$Lang}/achievement/{$NewAchievement.user_achievement_id}"}
<div class="new-achievement" id="new-achievement" role="status" data-achievement-view-url="{$AchievementViewUrl|escape}">
    <span class="new-achievement__icon" aria-hidden="true">🏆</span>
    <span class="new-achievement__text">
        {translate}new_achievement_unlocked{/translate}:
        <a class="new-achievement__title" href="{$AchievementViewUrl|escape}">{$NewAchievement.title|escape}</a>
    </span>
    <details class="new-achievement__share">
        <summary>{translate}share{/translate}</summary>
        <div class="new-achievement__share-menu">
            {include file="{$Lang}/achievement_share_buttons.tpl" AchievementShareUrl=$AchievementShareUrl}
        </div>
    </details>
    <button type="button" class="new-achievement__close" aria-label="{translate}close{/translate}" title="{translate}close{/translate}">×</button>
</div>
