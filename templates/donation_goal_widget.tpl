{* Donation goal widget. Title, text and amount come from site_messages (edited in /admin/site-messages),
   see Controller::setLanguge(); the labels are translation keys. *}
{if $DonationGoal && $DonationGoal.html}
<div class="menu-ad donation-goal-widget">
    <div class="side-card">
        <div class="side-card-title">{$DonationGoal.title}</div>
        <div class="side-card-body">
            {$DonationGoal.html nofilter}

            <div class="donation-stats">
                <span>{translate}donation_received{/translate} ${$DonationGoal.received|string_format:"%.2f"}</span>
                <span>{translate}donation_goal{/translate} ${$DonationGoal.amount|string_format:"%.2f"}</span>
            </div>
            <div class="side-card-progress">
                <div class="side-card-progress-fill" style="width: {$DonationGoal.progress|string_format:'%.2f'}%"></div>
            </div>
            <div class="donation-percent">{translate}donation_progress{/translate} {$DonationGoal.progress|string_format:"%.0f"}%</div>
            <div class="donation-action">
                <a href="/{$Lang}/donate" target="_self">
                    <button class="button green side-card-button"><span>{translate}top_menu_donate{/translate}</span></button>
                </a>
            </div>
        </div>
    </div>
</div>
{/if}
