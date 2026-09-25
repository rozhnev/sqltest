{* Text of the lesson assistant panel, see templates/lesson-assistant.tpl *}
{if $part == 'title'}Une question sur cette leçon ?
{elseif $part == 'fab'}Demander à l'IA
{elseif $part == 'intro'}
    <p>Un point de la leçon vous bloque ? Demandez au tuteur IA : il connaît le texte de la leçon et répond avec des exemples SQL.</p>
{elseif $part == 'examples'}
    <button type="button" class="la-example" data-question="Explique l'idée principale de cette leçon avec des mots simples.">Expliquer l'idée principale simplement</button>
    <button type="button" class="la-example" data-question="Montre un autre exemple de requête pour cette leçon et explique-le.">Montrer un autre exemple de requête</button>
    <button type="button" class="la-example" data-question="Quelles sont les erreurs fréquentes des débutants sur ce sujet ?">Quelles sont les erreurs fréquentes ?</button>
{elseif $part == 'placeholder'}Posez une question sur la leçon…
{elseif $part == 'send'}Envoyer
{elseif $part == 'reset'}Effacer la conversation
{elseif $part == 'login'}Connectez-vous pour poser des questions
{elseif $part == 'quota_free'}Budget d'IA : <span class="la-percent">{$AiQuota.percent_used}</span> % utilisé · quota gratuit, non renouvelable · <a href="/{$Lang}/subscribe">S'abonner</a>
{elseif $part == 'quota_subscriber'}Budget d'IA : <span class="la-percent">{$AiQuota.percent_used}</span> % utilisé · renouvelé le {$AiQuota.resets_at}
{/if}
