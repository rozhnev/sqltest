            <div style="display: flex; flex-direction: column; align-items: center;">
                {foreach $Languages as $l => $name}
                    {if ($l !== $Lang)}
                        <span style="padding: 7px;">
                            <a href="/{$l}{$path}" title="{$name}" target="_self">{$l|upper}</a>
                        </span>
                    {/if}
                {/foreach}
            </div>