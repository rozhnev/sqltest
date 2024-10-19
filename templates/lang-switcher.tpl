            <div style="display: flex; justify-content: center;">
                {foreach $Languages as $l}
                    {if ($l !== $Lang)}
                        <a href="/{$l}/{$path}" target="_self">{$l|upper}</a>
                    {/if}
                {/foreach}
            </div>