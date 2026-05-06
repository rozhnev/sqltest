# SQLtest.online — Application Database Schema

This document describes the application's own PostgreSQL database (not the Sakila/sample databases used for exercises).

---

## Content Domain

### `modules`
Top-level course groupings (e.g. "SQL Basics", "Joins").

| Column              | Type      | Notes                       |
|---------------------|-----------|-----------------------------|
| `id`                | serial PK |                             |
| `slug`              | varchar   | URL-friendly identifier     |
| `sequence_position` | int       | Display order               |
| `deleted`           | boolean   |                             |

### `modules_localization`
Translated titles for modules.

| Column      | Type    | Notes              |
|-------------|---------|--------------------|
| `module_id` | int FK  | → `modules.id`     |
| `language`  | varchar | e.g. `en`, `ru`    |
| `title`     | text    |                    |

### `lessons`
Individual lesson pages within a module.

| Column              | Type      | Notes                   |
|---------------------|-----------|-------------------------|
| `id`                | serial PK |                         |
| `slug`              | varchar   | URL-friendly identifier |
| `module_id`         | int FK    | → `modules.id`          |
| `sequence_position` | int       | Order within module     |
| `deleted`           | boolean   |                         |

### `lessons_localization`
Translated content for lessons. Source files are Markdown with optional YAML frontmatter (`title`, `description`, `keywords`, `teaches`, `about`).

| Column      | Type    | Notes                      |
|-------------|---------|----------------------------|
| `lesson_id`  | int FK    | → `lessons.id`             |
| `language`   | varchar   |                            |
| `title`      | text      |                            |
| `content`    | text      | Markdown source & metadata |
| `updated_at` | timestamp | Auto-set on INSERT/UPDATE  |

---

## Exercise Domain

### `questionnires`
Named exercise sets (e.g. "by category", "by difficulty").

| Column | Type      | Notes |
|--------|-----------|-------|
| `id`   | serial PK |       |
| `name` | varchar   |       |

### `categories`
Groups of questions within a questionnaire (e.g. "SQL Basics", "Joins").

| Column           | Type      | Notes                       |
|------------------|-----------|-----------------------------|
| `id`             | serial PK |                             |
| `title_sef`      | varchar   | URL slug                    |
| `questionnire_id`| int FK    | → `questionnires.id`        |
| `deleted`        | boolean   |                             |

### `categories_localization`

| Column        | Type    | Notes               |
|---------------|---------|---------------------|
| `category_id` | int FK  | → `categories.id`   |
| `language`    | varchar |                     |
| `title`       | text    |                     |

### `questions`
A single exercise (SQL task or quiz).

| Column               | Type      | Notes                                     |
|----------------------|-----------|-------------------------------------------|
| `id`                 | serial PK |                                           |
| `title_sef`          | varchar   | URL slug                                  |
| `db`                 | varchar   | Runtime DB name used for query execution  |
| `db_template`        | varchar   | Template DB identifier shown to user      |
| `dbms`               | varchar   | e.g. `MySQL`, `PostgreSQL`                |
| `rate`               | int FK    | Difficulty → `question_rates.id`          |
| `query_pre_check`    | text      | SQL prepended before user query           |
| `query_check`        | text      | SQL appended after user query             |
| `query_valid_result` | jsonb     | Expected result for comparison            |
| `pre_check_sort`     | boolean   |                                           |
| `best_query_cost`    | numeric   |                                           |
| `deleted`            | boolean   |                                           |

### `questions_localization`

| Column        | Type    | Notes             |
|---------------|---------|-------------------|
| `question_id` | int FK  | → `questions.id`  |
| `language`    | varchar |                   |
| `title`       | text    |                   |
| `hint`        | text    |                   |

### `question_categories`
Many-to-many: questions ↔ categories.

| Column              | Type   | Notes                  |
|---------------------|--------|------------------------|
| `question_id`       | int FK | → `questions.id`       |
| `category_id`       | int FK | → `categories.id`      |
| `sequence_position` | int    | Order within category  |

### `answers`
Answer options for quiz-type questions.

| Column        | Type      | Notes             |
|---------------|-----------|-------------------|
| `id`          | serial PK |                   |
| `question_id` | int FK    | → `questions.id`  |
| `is_valid`    | boolean   |                   |

### `answers_localization`

| Column      | Type    | Notes           |
|-------------|---------|-----------------|
| `answer_id` | int FK  | → `answers.id`  |
| `language`  | varchar |                 |
| `title`     | text    |                 |

### `query_checks`
Reusable structural query validation rules.

| Column | Type      | Notes |
|--------|-----------|-------|
| `id`   | serial PK |       |

### `query_checks_localization`

| Column           | Type    | Notes                |
|------------------|---------|----------------------|
| `query_check_id` | int FK  | → `query_checks.id`  |
| `language`       | varchar |                      |
| `hint`           | text    |                      |

### `question_query_checks`
Many-to-many: questions ↔ query_checks.

| Column           | Type   | Notes                 |
|------------------|--------|-----------------------|
| `question_id`    | int FK | → `questions.id`      |
| `query_check_id` | int FK | → `query_checks.id`   |

### `question_rates`
Difficulty levels (1–5).

| Column | Type      | Notes |
|--------|-----------|-------|
| `id`   | serial PK |       |

### `question_rates_localization`

| Column | Type    | Notes |
|--------|---------|-------|
| `id`   | int FK  |       |
| `language` | varchar | |
| `rate_title` | text |  |

---

## User Domain

### `users`

| Column                       | Type         | Notes                              |
|------------------------------|--------------|------------------------------------|
| `id`                         | uuid PK      |                                    |
| `login`                      | varchar      | OAuth login / username             |
| `email`                      | varchar      |                                    |
| `password_hash`              | varchar      | NULL for OAuth-only users          |
| `full_name`                  | varchar      |                                    |
| `nickname`                   | varchar      |                                    |
| `grade`                      | int          | 1=Intern … 4=Senior                |
| `graded_at`                  | timestamp    |                                    |
| `admin`                      | boolean      |                                    |
| `last_login_at`              | timestamp    |                                    |
| `last_path`                  | varchar      |                                    |
| `hide_ad_till`               | date         |                                    |
| `created_at`                 | timestamp    |                                    |
| `email_verified_at`          | timestamp    | NULL = unverified                  |
| `user_agreement_accepted_at` | timestamp    |                                    |

### `user_email_verification_codes`

| Column       | Type      | Notes                      |
|--------------|-----------|----------------------------|
| `id`         | serial PK |                            |
| `user_id`    | uuid FK   | → `users.id` ON DELETE CASCADE |
| `email`      | varchar   |                            |
| `code_hash`  | varchar   |                            |
| `created_at` | timestamp |                            |
| `expires_at` | timestamp |                            |
| `used_at`    | timestamp | NULL = unused              |

### `user_questions`
Tracks per-user question attempts.

| Column        | Type      | Notes             |
|---------------|-----------|-------------------|
| `user_id`     | uuid FK   | → `users.id`      |
| `question_id` | int FK    | → `questions.id`  |
| `solved_at`   | timestamp | NULL = unsolved   |
| `attempts`    | int       |                   |

### `user_solutions`
Saved correct solutions.

| Column        | Type      | Notes             |
|---------------|-----------|-------------------|
| `id`          | serial PK |                   |
| `user_id`     | uuid FK   | → `users.id`      |
| `question_id` | int FK    | → `questions.id`  |
| `query`       | text      |                   |
| `likes`       | int       |                   |
| `reported`    | boolean   |                   |
| `created_at`  | timestamp |                   |

### `solution_likes`

| Column        | Type      | Notes                    |
|---------------|-----------|--------------------------|
| `user_id`     | uuid FK   | → `users.id`             |
| `solution_id` | int FK    | → `user_solutions.id`    |
| `created_at`  | timestamp |                          |

### `favorites`

| Column        | Type   | Notes             |
|---------------|--------|-------------------|
| `user_id`     | uuid FK| → `users.id`      |
| `question_id` | int FK | → `questions.id`  |

### `user_task_submissions`
User-submitted question proposals for moderation.

| Column                | Type      | Notes                                              |
|-----------------------|-----------|----------------------------------------------------|
| `id`                  | serial PK |                                                    |
| `user_id`             | uuid FK   | → `users.id` ON DELETE CASCADE                     |
| `status`              | varchar   | `pending` \| `approved` \| `rejected`              |
| `title`               | varchar   |                                                    |
| `task`                | text      |                                                    |
| `hint`                | text      |                                                    |
| `solution_query`      | text      |                                                    |
| `db_template`         | varchar   |                                                    |
| `db`                  | varchar   |                                                    |
| `moderation_note`     | text      |                                                    |
| `approved_question_id`| int FK    | → `questions.id` ON DELETE SET NULL                |
| `approved_by_user_id` | uuid FK   | → `users.id` ON DELETE SET NULL                    |
| `approved_at`         | timestamp |                                                    |
| `rejected_at`         | timestamp |                                                    |
| `created_at`          | timestamp |                                                    |
| `updated_at`          | timestamp |                                                    |

---

## Test Domain

### `tests`

| Column           | Type      | Notes                              |
|------------------|-----------|------------------------------------|
| `id`             | varchar PK|                                    |
| `user_id`        | uuid FK   | → `users.id`                       |
| `questionnire_id`| int FK    | → `questionnires.id`               |
| `rate`           | int       |                                    |
| `closed_at`      | timestamp | Expires 3 hours after creation     |

### `test_questions`

| Column        | Type   | Notes                    |
|---------------|--------|--------------------------|
| `test_id`     | FK     | → `tests.id`             |
| `question_id` | int FK | → `questions.id`         |
| `max_attempts`| int    |                          |

---

## Achievement Domain

### `achievements`

| Column    | Type      | Notes   |
|-----------|-----------|---------|
| `id`      | serial PK |         |
| `title`   | varchar   | Key used in code (`'registration'`, `'first_task_solved'`, etc.) |
| `deleted` | boolean   |         |

### `achievements_localization`

| Column           | Type    | Notes                   |
|------------------|---------|-------------------------|
| `achievement_id` | int FK  | → `achievements.id`     |
| `language`       | varchar |                         |
| `title`          | text    |                         |
| `recommended`    | boolean |                         |

### `user_achievements`

| Column               | Type      | Notes                   |
|----------------------|-----------|-------------------------|
| `user_id`            | uuid FK   | → `users.id`            |
| `achievement_id`     | int FK    | → `achievements.id`     |
| `earned_at`          | timestamp |                         |
| `user_achievement_id`| varchar   | Unique share identifier |

### `user_completed_achievements`
Tracks fully-completed (not just earned) achievement milestones.

| Column           | Type   | Notes                   |
|------------------|--------|-------------------------|
| `achievement_id` | int FK | → `achievements.id`     |

---

## Misc

### `referral_links`

| Column | Type      | Notes |
|--------|-----------|-------|
| `id`   | serial PK |       |

### `referral_links_daily_stats`

| Column    | Type   | Notes                      |
|-----------|--------|----------------------------|
| `link_id` | int FK | → `referral_links.id`      |
| `date`    | date   |                            |
| `shows`   | int    |                            |

### `books`
Recommended SQL books shown in the /books page.

| Column   | Type      | Notes |
|----------|-----------|-------|
| `id`     | serial PK |       |
| `dbms`   | varchar   |       |

### `quizes`
Maps quiz-type questions separately (used in stats queries).

| Column        | Type   | Notes             |
|---------------|--------|-------------------|
| `question_id` | int FK | → `questions.id`  |
