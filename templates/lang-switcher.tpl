            <div class="lang-swith">
                {foreach $Languages as $l => $name}
                    {if ($l !== $Lang)}
                        <span>
                            <a href="/{$l}{$path}" title="{$name}" target="_self">{$l|upper}</a>
                        </span>
                    {/if}
                {/foreach}
            </div>