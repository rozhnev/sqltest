<div id="db-description" class="db-description">
    {if $User->showAd()}
    {include file='pt/donation_goal_widget.tpl'}
        <div class="referal-add-block">
        {if $Book}
                {include file='book_card.tpl'}
            {/if}
        </div>
    {/if} 
</div>