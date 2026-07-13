<div id="db-description" class="db-description">
    {if $User->showAd()}
        {include file='ru/donation_goal_widget.tpl'}
        {if $Book}        
            <div class="referal-add-block">
                {include file='book_card.tpl'}
            </div>
        {/if}
    {/if} 
</div>