            {if $Languages|@count > 1}
                <div class="language-selector">
                    <label class="visually-hidden" for="language-select">Language</label>
                    <select id="language-select" class="language-selector__control" onchange="window.location.href=this.value">
                        {foreach $Languages as $l => $name}
                            <option value="/{$l}{$path}"{if $l === $Lang} selected{/if}>{$name}</option>
                        {/foreach}
                    </select>
                </div>
            {/if}