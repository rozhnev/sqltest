<div class="question-wrapper">
    <div class="progress-widget-header">
        <h3>{translate}my_progress{/translate}:</h3>
    </div>
    <div class="progress-widget-content">
        <div class="progress-bar-container">
            <div class="progress-bar" style="width: {if $QuestionsCount}{($SolvedQuestionsCount / $QuestionsCount * 100)}{else}0{/if}%"></div>
        </div>
        <div class="progress-stats">
            <span class="progress-count">{$SolvedQuestionsCount}/{$QuestionsCount}</span>
            <span class="progress-percentage">{if $QuestionsCount}{round(($SolvedQuestionsCount / $QuestionsCount * 100), 1)}{else}0{/if}%</span>
        </div>
    </div>
</div>