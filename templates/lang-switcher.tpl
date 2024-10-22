            <div style="display: flex; min-width: 50px; margin: 12px; align-items: center; justify-content: center; flex-flow: column;">
                {foreach $Languages as $l => $name}
                    {if ($l !== $Lang)}
                        <span style="padding-bottom: 7px;">
                            <a href="/{$l}{$path}" title="{$name}" target="_self">{$l|upper}</a>
                        </span>
                    {/if}
                {/foreach}
            </div>