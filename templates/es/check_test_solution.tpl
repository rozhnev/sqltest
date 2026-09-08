{if $QueryTestResult.ok}
    {assign var="successPhrases" value=[
        "¡Consulta brillante!",
        "¡Gran trabajo, este es perfecto!",
        "¡Estás en llamas, sigue así!",
        "¡Eso es un ganador!",
        "¡Bien hecho, sigue brillando!"
    ]}
    {assign var="successIndex" value=$successPhrases|@array_rand}
    {assign var="successPhrase" value=$successPhrases[$successIndex]}
    <style>
        .qts-celebration {
            position: relative;
            padding: 1.25rem 1.5rem 1rem;
            border-radius: 1rem;
            background:
                radial-gradient(circle at 25% -10%, rgba(255, 255, 255, 0.85), rgba(255, 255, 255, 0) 55%),
                linear-gradient(135deg, var(--text-block-background-color, #ffffff) 0%, var(--block-background-color, #466cbd) 70%);
            border: 1px solid var(--border-color, #0B4FCC);
            color: var(--question-text, #33196f);
            box-shadow: 0 15px 38px rgba(29, 7, 74, 0.18);
            overflow: hidden;
            margin-bottom: 1rem;
        }

        .qts-message {
            font-size: 1.35rem;
            font-weight: 700;
            color: inherit;
            letter-spacing: 0.02em;
            text-transform: none;
        }

        .qts-message-glimmer {
            display: inline-flex;
            margin-left: 0.5rem;
            animation: qts-glimmer 2.8s ease-in-out infinite;
            color: var(--achievement-linkedin-fg, #f7b733);
        }

        .qts-confetti {
            position: absolute;
            inset: 0;
            pointer-events: none;
        }

        .qts-confetti-piece {
            position: absolute;
            top: -20px;
            width: 8px;
            height: 18px;
            border-radius: 3px;
            background: var(--color, var(--achievement-icon-fg, #ffd166));
            animation: qts-confetti-drop var(--duration, 2.4s) linear infinite;
            animation-delay: var(--delay, 0s);
            left: var(--x-start, 10%);
            filter: drop-shadow(0 2px 2px rgba(0, 0, 0, 0.25));
        }

        .qts-confetti-piece::after {
            content: '';
            position: absolute;
            inset: 0;
            border-radius: inherit;
            background: inherit;
            opacity: 0.45;
            transform: translateY(6px) scaleY(0.4);
        }

        @keyframes qts-confetti-drop {
            0% {
                transform: translate3d(0, 0, 0) rotate(0deg);
                opacity: 1;
            }
            100% {
                transform: translate3d(var(--x-end, 60px), 280px, 0) rotate(360deg);
                opacity: 0;
            }
        }

        @keyframes qts-glimmer {
            0% {
                opacity: 0.4;
                transform: scale(0.9);
            }
            50% {
                opacity: 1;
                transform: scale(1.1);
            }
            100% {
                opacity: 0.4;
                transform: scale(0.9);
            }
        }

        @keyframes qts-bounce {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.08);
            }
            100% {
                transform: scale(1);
            }
        }

        .qts-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            margin-top: 0.5rem;
            padding: 0.25rem 0.75rem;
            border-radius: 999px;
            border: 1px solid var(--border-color, #0B4FCC);
            background: var(--text-block-background-color, rgba(255, 255, 255, 0.85));
            color: var(--question-text, #4b2d9f);
            font-size: 0.85rem;
            font-weight: 600;
            animation: qts-bounce 1.6s ease-in-out infinite;
        }
    </style>

    <div class="qts-celebration">
        <div class="qts-message">
            {$successPhrase}
            <span class="qts-message-glimmer">✨</span>
        </div>
        <div class="qts-badge">Misión: cumplida</div>
        <div class="qts-confetti" aria-hidden="true">
            <span class="qts-confetti-piece" style="--x-start:5%; --x-end:40px; --delay:0s; --duration:2s; --color:var(--achievement-icon-fg, #ff6262)"></span>
            <span class="qts-confetti-piece" style="--x-start:18%; --x-end:-20px; --delay:0.25s; --duration:2.2s; --color:var(--achievement-linkedin-fg, #f7b733)"></span>
            <span class="qts-confetti-piece" style="--x-start:32%; --x-end:60px; --delay:0.45s; --duration:2s; --color:var(--green-btn-background, #2ecc71)"></span>
            <span class="qts-confetti-piece" style="--x-start:47%; --x-end:-50px; --delay:0.15s; --duration:2.3s; --color:var(--blue-btn-background, #3498db)"></span>
            <span class="qts-confetti-piece" style="--x-start:60%; --x-end:30px; --delay:0.35s; --duration:1.9s; --color:var(--accordion-active, #9b59b6)"></span>
            <span class="qts-confetti-piece" style="--x-start:72%; --x-end:-15px; --delay:0.55s; --duration:2.1s; --color:var(--donate-btn-background, #ffb74d)"></span>
            <span class="qts-confetti-piece" style="--x-start:85%; --x-end:-35px; --delay:0.65s; --duration:2.4s; --color:var(--accordion-hover, #1abc9c)"></span>
        </div>
    </div>
    <div style="display: flex; flex-flow: row; flex-wrap: wrap; line-height: 1.5em;">
        {if $QueryTestResult.cost > 0}
            <div style="flex: 2 1;">
            El costo de ejecutar su consulta es {$QueryTestResult.cost} <span style="font-size: small;">(cuanto menor sea el costo, más efectiva es la consulta)</span>
            {if $QueryBestCost}
                <br>Costo de la mejor solución: {$QueryBestCost}<br>
                {if $QueryBestCost == $QueryTestResult.cost} ¡Felicidades! ¡Su solicitud está entre las mejores de nuestro sitio web!
                {elseif $QueryBestCost > $QueryTestResult.cost} ¡Felicidades por mejorar nuestro récord!
                {else} Desafortunadamente, su resultado está un poco por debajo del récord. ¡Tiene algo en lo que trabajar! {/if}
            {/if}
            </div>
        {/if}
        {if array_key_exists('answerResult', $QueryTestResult)}
            <p>La respuesta enviada será evaluada por el jurado.</p>
        {/if}
    </div>
{elseif array_key_exists('hints', $QueryTestResult) && array_key_exists('maxAttemptsReached', $QueryTestResult.hints)}
    {assign var="NextQuestion" value="{$QueryTestResult.nextQuestion}"}
    {translate}máximo_intentos_alcanzados{/translate}
    {if $QueryTestResult.nextQuestion} {translate}ir_a_la_siguiente_tarea{/translate}{/if}
{elseif array_key_exists('hints', $QueryTestResult) && array_key_exists('timeOut', $QueryTestResult.hints)}
    {translate}tiempo_de_prueba_agotado{/translate} {translate}ir_a_calificar{/translate}
{else}
    {assign var="errorPhrases" value=[
        "Inténtalo de nuevo, un pequeño ajuste, una gran victoria.",
        "¡Tan cerca! Pulir esto y será tuyo.",
        "Casi allí, ¡dale otra oportunidad!",
        "Un pequeño ajuste y darás en el blanco.",
        "Buen esfuerzo, vuelve a ejecutar con un pequeño cambio."
    ]}
    {assign var="errorIndex" value=$errorPhrases|@array_rand}
    {assign var="errorPhrase" value=$errorPhrases[$errorIndex]}
    <style>
        .qts-error-card {
            border: 1px solid var(--border-color, #0B4FCC);
            border-radius: 1rem;
            padding: 1.25rem 1.5rem;
            background:
                radial-gradient(circle at 30% 20%, rgba(255, 255, 255, 0.9), rgba(255, 255, 255, 0) 50%),
                linear-gradient(200deg, rgba(251, 125, 125, 0.3), rgba(173, 48, 64, 0.55));
            color: var(--regular-text-color, #f0f6fc);
            box-shadow: 0 18px 42px rgba(77, 9, 16, 0.35);
            animation: qts-breath 4s ease-in-out infinite;
            margin-bottom: 1rem;
            position: relative;
            overflow: hidden;
        }

        .qts-error-card::after {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at 70% 50%, rgba(255, 255, 255, 0.25), transparent 60%);
            opacity: 0.4;
            pointer-events: none;
        }

        .qts-wisp {
            position: absolute;
            left: 70%;
            top: 15%;
            width: 3px;
            height: 70px;
            background: linear-gradient(180deg, rgba(255, 255, 255, 0.75), rgba(255, 255, 255, 0));
            border-radius: 999px;
            filter: blur(0.5px);
            animation: qts-wisp-fade 3.6s ease-in-out infinite;
            pointer-events: none;
        }

        .qts-wisp::after {
            content: '';
            position: absolute;
            bottom: 12px;
            left: -5px;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            border: 1px solid rgba(255, 255, 255, 0.6);
        }

        .qts-error-body {
            position: relative;
            z-index: 1;
        }

        .qts-error-message {
            font-size: 1.3rem;
            font-weight: 700;
            letter-spacing: 0.04em;
            color: var(--accordion-hover-border, #F0F6FC);
            display: flex;
            align-items: center;
            gap: 0.35rem;
        }

        .qts-error-emoji {
            font-size: 1.5rem;
            animation: qts-hug 2.8s ease-in-out infinite;
        }

        .qts-error-helper {
            margin-top: 0.55rem;
            font-size: 0.95rem;
            color: var(--question-text, #f0f6fc);
        }

        .qts-error-cta {
            margin-top: 0.6rem;
            font-weight: 600;
            letter-spacing: 0.08em;
            color: var(--accordion-active, #006EF5);
        }

        .qts-error-hints {
            margin-top: 0.8rem;
            color: var(--question-text, #f0f6fc);
            line-height: 1.4;
        }

        .qts-error-hints p {
            margin: 0.3rem 0;
        }

        .qts-error-referral {
            margin-top: 0.85rem;
        }

        .qts-error-referral .referral-link {
            border-radius: 0.75rem;
            padding: 0.7rem 1.1rem;
            border: 1px dashed rgba(255, 255, 255, 0.5);
            background: rgba(255, 255, 255, 0.07);
            font-size: 0.9rem;
            text-align: center;
        }

        @keyframes qts-breath {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.01);
            }
            100% {
                transform: scale(1);
            }
        }

        @keyframes qts-wisp-fade {
            0% {
                opacity: 0.2;
                transform: translateY(0);
            }
            50% {
                opacity: 0.9;
                transform: translateY(-10px) scaleX(1.1);
            }
            100% {
                opacity: 0.2;
                transform: translateY(0);
            }
        }

        @keyframes qts-hug {
            0% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-3px);
            }
            100% {
                transform: translateY(0);
            }
        }
    </style>

    <div class="qts-error-card" role="status" aria-live="polite">
        <div class="qts-wisp" aria-hidden="true"></div>
        <div class="qts-error-body">
            <div class="qts-error-message">
                {$errorPhrase}
            </div>
            {if array_key_exists('hints', $QueryTestResult)}
                <div class="qts-error-hints">
                    {if array_key_exists('queryError', $QueryTestResult.hints)}
                        <p>Pista: la consulta devuelve el error: <span class="sql_error">{$QueryTestResult.hints.queryError}</span></p>
                    {/if}
                    {if array_key_exists('columnsCount', $QueryTestResult.hints)}
                        <p>Pista: la tabla de resultados debe constar de {$QueryTestResult.hints.columnsCount} columnas.</p>
                    {/if}
                    {if array_key_exists('columnsList', $QueryTestResult.hints)}
                        <p>Pista: la tabla resultante debe constar de las siguientes columnas: {$QueryTestResult.hints.columnsList}.</p>
                    {/if}
                    {if array_key_exists('rowsCount', $QueryTestResult.hints)}
                        <p>Pista: el resultado debe contener {$QueryTestResult.hints.rowsCount} filas.</p>
                    {/if}
                    {if array_key_exists('rowsData', $QueryTestResult.hints)}
                        <p>Pista: el número de fila {$QueryTestResult.hints.rowsData.rowNumber} de la tabla de resultados debe contener los siguientes valores:
                            {$QueryTestResult.hints.rowsData.rowTable}
                        </p>
                        <p>su resultado:
                            {$QueryTestResult.hints.rowsData.resultTable}
                        </p>
                    {/if}
                    {if array_key_exists('emptyQuery', $QueryTestResult.hints)}
                        <p>Pista: su consulta está vacía.</p>
                    {/if}
                </div>
            {/if}
            <div class="qts-error-cta">Sigue adelante, estás casi allí.</div>
            {if isset($ReferralLink)}
                <div class="qts-error-referral">
                    <a id="referral-link" target="_blank" href="{$ReferralLink.link}">
                        <div class="referral-link">
                            {$ReferralLink.content}
                        </div>
                    </a>
                </div>
            {/if}
        </div>
    </div>
{/if}