<div class="question">
    {$Message}
</div>
{if $User->logged()}
    <div style="display: flex; padding: 1em; justify-content: space-evenly;  align-items: center;">
        <button 
        class="button-small green" title="" onClick="">I understood. Thank you!</button>
        <button 
        class="button-small red" title="" onClick="">Explain me better!</button>
    </div>
{/if}