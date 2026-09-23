<div style="max-width: 640px; margin: 15vh auto; text-align: center;">
    <h2>Interview simulation access</h2>
    <p>The interview simulation is a paid feature. Pay for access via Lava.top to continue.</p>
    {if $InterviewPaymentUrl}
        <p><a class="button blue" href="{$InterviewPaymentUrl|escape}" target="_blank" rel="noopener noreferrer">Pay with Lava.top</a></p>
        <p style="font-size: 0.9em;">Access is granted manually shortly after payment is confirmed.</p>
    {else}
        <p>Payment is temporarily unavailable. Please contact us to get access.</p>
    {/if}
</div>
