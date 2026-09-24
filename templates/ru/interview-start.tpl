{if $InterviewLoginRequired}
    <div style="max-width: 720px; margin: 1rem auto 0; padding: 1rem 1.25rem; border-radius: 12px; background: #FEF3C7; color: #92400E; text-align: center;">
        Войдите, чтобы начать собеседование на выбранную позицию и грейд.
    </div>
{/if}
{if $ActiveInterviewSession}
    <div class="interview-notice">
        У вас уже есть незавершённое собеседование.
        <a class="interview-start-btn" href="/{$Lang}/interview/{$ActiveInterviewSession.id}">Продолжить интервью</a>
    </div>
{/if}
<div class="interview-page">
<section class="interview-hero">
    <div class="interview-hero-logo">
        <img src="/images/interview/meridian-logistics-logo.svg" alt="Логотип Meridian Logistics">
    </div>
    <div class="interview-hero-text">
        <h1>Мы — Meridian Logistics</h1>
        <p class="interview-hero-tagline">Логистика, которая работает на данных.</p>
        <p>
            Мы — логистическая компания, работающая на трёх континентах. Каждый день наша
            платформа отслеживает тысячи отправлений, сотни перевозчиков и растущую сеть
            складов — и всё это держится на SQL. Пока мы растём, нам нужны люди, которым
            так же комфортно с JOIN, как и с дедлайном доставки.
        </p>
        <div class="interview-quote">
            <img src="/images/interview/meridian-logistics-representative.jpeg" alt="Елена Чо">
            <div>
                <blockquote>«Наши склады держатся на погрузчиках. Наши решения — на SQL».</blockquote>
                <cite>Елена Чо, руководитель отдела данных и разработки</cite>
            </div>
        </div>
    </div>
</section>

<p class="interview-disclaimer" role="note"><strong>Обратите внимание:</strong> это учебная симуляция, а не настоящее собеседование. Компания Meridian Logistics, её сотрудники и вакансии вымышлены. Прохождение интервью не ведёт к предложению о работе или трудоустройству — результат и отзыв служат только учебной самооценкой ваших навыков SQL.</p>

<h2 style="color:#0F172A; margin-bottom: 1rem;">Открытые позиции</h2>

<section class="interview-positions">
    <article class="interview-position-card">
        <h2>SQL Developer</h2>
        <p>
            Вы будете проектировать и поддерживать базы данных нашей транспортной системы
            управления (TMS) — отслеживание отправлений, контракты с перевозчиками, данные
            о маршрутах и биллинг. Вас ждут проектирование схем, оптимизация запросов и
            тесное взаимодействие с командой разработки.
        </p>
        <div class="interview-grades">
            <div class="interview-grade-card">
                <h3>Junior</h3>
                <ul>
                    <li>Уверенно пишете SELECT-запросы с JOIN и агрегациями.</li>
                    <li>Готовы учиться проектированию схем и индексации.</li>
                    <li>Есть опыт работы хотя бы с одной реляционной СУБД.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=sql_developer&amp;grade=2">Начать собеседование</a>
            </div>
            <div class="interview-grade-card">
                <h3>Middle</h3>
                <ul>
                    <li>Можете спроектировать нормализованную схему с нуля.</li>
                    <li>Пишете эффективные запросы к таблицам с миллионами строк.</li>
                    <li>Понимаете компромиссы при выборе индексов, разбирали медленный запрос в проде.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=sql_developer&amp;grade=3">Начать собеседование</a>
            </div>
            <div class="interview-grade-card">
                <h3>Senior</h3>
                <ul>
                    <li>Полностью отвечаете за архитектурные решения по БД.</li>
                    <li>Уверенно работаете с оптимизацией запросов, партиционированием и репликацией.</li>
                    <li>Наставляете других разработчиков и аргументированно останавливаете рискованные изменения схемы.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=sql_developer&amp;grade=4">Начать собеседование</a>
            </div>
        </div>
    </article>

    <article class="interview-position-card">
        <h2>Data Analyst</h2>
        <p>
            Вы будете превращать сырые данные об отправлениях и складах в конкретные
            ответы: какие маршруты убыточны, какие перевозчики стабильно укладываются в
            сроки, и где стоит открыть следующий склад. Вы будете тесно работать с
            операционным и финансовым отделами, превращая SQL-запросы в решения.
        </p>
        <div class="interview-grades">
            <div class="interview-grade-card">
                <h3>Junior</h3>
                <ul>
                    <li>Пишете SQL-запросы с GROUP BY, HAVING и базовыми оконными функциями.</li>
                    <li>Умеете превратить бизнес-вопрос в запрос.</li>
                    <li>Есть опыт презентации цифр нетехническим коллегам.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=data_analyst&amp;grade=2">Начать собеседование</a>
            </div>
            <div class="interview-grade-card">
                <h3>Middle</h3>
                <ul>
                    <li>Работаете с неоднозначными запросами от разных заинтересованных сторон.</li>
                    <li>Используете оконные функции, CTE и оптимизацию запросов для надёжных регулярных отчётов.</li>
                    <li>Можете отстоять методологию при вопросах.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=data_analyst&amp;grade=3">Начать собеседование</a>
            </div>
            <div class="interview-grade-card">
                <h3>Senior</h3>
                <ul>
                    <li>Задаёте аналитические стандарты для других аналитиков.</li>
                    <li>Полностью отвечаете за определения метрик.</li>
                    <li>Готовы аргументированно оспорить предположения стейкхолдера, опираясь на данные.</li>
                </ul>
                <a class="interview-start-btn" href="/{$Lang}/interview/create?position=data_analyst&amp;grade=4">Начать собеседование</a>
            </div>
        </div>
    </article>
</section>
</div>
