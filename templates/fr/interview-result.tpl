{assign var="session" value=$InterviewResult.session}
<section class="interview-score">
    <h2 style="margin-top: 0;">Résultat de l'entretien</h2>
    <div class="value">{$InterviewResult.final_percent}%</div>
    <div class="meta">
        Meridian Logistics &middot; {$session.position_label|escape} &middot; {$session.grade_label|escape}
        &middot; {$InterviewResult.closed_at|date_format:"%d.%m.%Y"}
    </div>
</section>
<p class="interview-disclaimer" role="note">Une simulation d'entraînement, et non un véritable entretien d'embauche : Meridian Logistics est fictive et ce résultat n'est pas une offre d'emploi — c'est une auto-évaluation pédagogique de vos compétences SQL.</p>

{if $InterviewResult.report}
    {assign var="report" value=$InterviewResult.report}
    <section class="interview-report">
        <div class="interview-dialog">
            <div class="dialog-row">
                <img class="dialog-avatar" src="/images/interview/meridian-logistics-representative.jpeg" alt="Elena Cho">
                <div class="dialog-message">
                    <p class="dialog-author">Elena Cho, directrice Données et Ingénierie</p>
                    <div class="dialog-bubble">
                        <p class="pre-wrap">{$report.summary|escape}</p>
                        {if $report.strengths}
                            <h4>Points forts</h4>
                            <ul>{foreach $report.strengths as $point}<li>{$point|escape}</li>{/foreach}</ul>
                        {/if}
                        {if $report.improvements}
                            <h4>Axes d'amélioration</h4>
                            <ul>{foreach $report.improvements as $point}<li>{$point|escape}</li>{/foreach}</ul>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </section>
{/if}

<section>
    <h3>Résultats par thème</h3>
    {foreach $InterviewResult.topics as $topic}
        <div class="interview-topic {if $topic.weak}weak{/if}">
            <div class="interview-topic-head">
                <span>{if $topic.key === 'soft_skills'}Compétences professionnelles{elseif $topic.key === 'other'}Autres{else}{$topic.title|escape}{/if}</span>
                <span>{$topic.percent}%</span>
            </div>
            <div class="interview-topic-bar"><span style="width: {$topic.percent}%;"></span></div>
            {if $topic.lessons}
                <ul>
                    {foreach $topic.lessons as $lesson}
                        <li>À revoir : <a href="/{$Lang}/lesson/{$lesson.module_slug|escape:'url'}/{$lesson.lesson_slug|escape:'url'}">{$lesson.title|escape}</a></li>
                    {/foreach}
                </ul>
            {/if}
        </div>
    {/foreach}
</section>

<section>
    <h3>Déroulé de l'entretien</h3>
    {if $session.self_intro}
        <div class="interview-transcript-item">
            <h4>Présentation</h4>
            <p style="white-space: pre-wrap;">{$session.self_intro|escape}</p>
            {if $session.self_intro_analysis.interviewer_message|default:''}
                <p class="feedback">&ldquo;{$session.self_intro_analysis.interviewer_message|escape}&rdquo;</p>
            {/if}
            {if $session.self_intro_analysis.followup.answer|default:''}
                <p><strong>Question de précision :</strong> {$session.self_intro_analysis.followup.question|escape}</p>
                <p style="white-space: pre-wrap;"><strong>Votre réponse :</strong> {$session.self_intro_analysis.followup.answer|escape}</p>
            {/if}
        </div>
    {/if}
    {foreach $InterviewResult.transcript as $item}
        <div class="interview-transcript-item">
            <h4>
                <span>{$item.sequence}. {$item.title|escape}{if $item.attempt_number > 1} <small class="interview-muted">({$item.attempt_number} tentatives)</small>{/if}</span>
                {if $item.question_type === 'free_answer' && $item.llm_score !== null}
                    <span class="{if $item.auto_check_ok}verdict-ok{else}verdict-bad{/if}">{$item.llm_score}/100</span>
                {elseif $item.auto_check_ok}
                    <span class="verdict-ok">✓</span>
                {else}
                    <span class="verdict-bad">✗</span>
                {/if}
            </h4>
            <div class="question">{$item.task}</div>
            {if $item.question_type === 'query'}
                <pre>{$item.last_query|escape}</pre>
            {elseif $item.question_type === 'answer'}
                <ul>
                    {foreach $item.options as $option}
                        <li class="{if $option.is_valid}option-valid{/if}">
                            {if $option.selected}☑{else}☐{/if} {$option.answer}{if $option.is_valid} &mdash; bonne réponse{/if}
                        </li>
                    {/foreach}
                </ul>
            {else}
                <p style="white-space: pre-wrap;">{$item.answer_text|escape}</p>
            {/if}
            {if $item.llm_feedback}
                <p class="feedback">{$item.llm_feedback|escape}</p>
            {/if}
        </div>
    {/foreach}
</section>

<p style="text-align: center;">
    <a class="button blue" href="/{$Lang}/interview-start">Retour aux offres de Meridian Logistics</a>
</p>
