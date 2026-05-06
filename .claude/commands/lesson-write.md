Generate a new SQL course lesson following the project style guide and SEO requirements.

## Usage

```
/lesson-write <lesson_id> "<topic>" [lang=en|ru|fr|pt] [keywords="kw1, kw2"]
```

Examples:
- `/lesson-write 2_1 "GROUP BY and Aggregation"` — English lesson, auto-keywords
- `/lesson-write 9_5 "Updatable Views" lang=ru` — Russian lesson
- `/lesson-write 3_2 "LEFT JOIN vs INNER JOIN" keywords="SQL JOIN, LEFT JOIN tutorial, JOIN types"`

## Steps to execute

**Step 1 — Parse arguments from `$ARGUMENTS`.**

Extract:
- `lesson_id` — e.g. `2_1`, `9_5` (used in filename and image path)
- `topic` — lesson topic string
- `lang` — language code, default `en` if not provided
- `keywords` — optional comma-separated SEO keywords; if not provided, derive 3–5 from the topic

**Step 2 — Read context files in parallel.**

1. Read the style guide: `lessons/lesson_style_guide.md`
2. Find and read one existing lesson in the same language for style reference. Search for files matching `lessons/lesson*.{lang}.md` and pick the most recent (highest lesson number). If none found, use `lessons/lesson1_1.en.md` as fallback.

**Step 3 — Derive SEO metadata.**

Using the topic and any user-supplied keywords:
- `title`: keyword-rich, ≤60 chars, do NOT start with "Lesson X.Y:"
- `description`: 120–155 chars, starts with a direct answer (not "In this lesson...")
- `keywords`: array of 4–6 strings covering primary term, abbreviation if any, long-tail variants
- `reading_time`: estimate based on planned content (~200 wpm; typical lesson = 6–10 min)

**Step 4 — Determine lesson context.**

- `prev_lesson`: lesson_id with last digit decremented by 1 (e.g. `2_1` → prev is last lesson of chapter 1)
- `next_lesson`: lesson_id with last digit incremented by 1
- Image path: `/images/lessons/lesson{lesson_id}-{slug}.svg` where slug is the topic in kebab-case

**Step 5 — Generate the full lesson file.**

Write the file to `lessons/lesson{lesson_id}.{lang}.md`.

Follow ALL rules from `lesson_style_guide.md`. Key requirements:

### Structure (in this exact order)

```
---
title: "{SEO title}"
description: "{SEO description}"
keywords: ["{kw1}", "{kw2}", ...]
---

_{Reading time: ~N min}_

{Opening paragraph — direct answer to "what is X", 3–5 sentences. Must contain the primary keyword in the first 2 sentences.}

# {SEO H1 heading — contains primary keyword, NOT "Lesson X.Y:"}

{Context paragraph: link to previous lesson, why this topic matters in SQL, real-world use case. 2–3 sentences.}

<img src="/images/lessons/lesson{lesson_id}-{slug}.svg" alt="{Specific description of what the illustration shows}" width="100%">

## What Is {Topic}? (H2 with keyword)

{Core definition. 2–4 short paragraphs.}

## {Syntax / How It Works} (H2 with keyword variation)

```sql
-- clean example using Sakila tables
```

*Result: brief note on what the query returns.*

## {Key Use Cases / When to Use} (H2)

{2–4 use cases with brief SQL examples. Use Sakila tables: customer, payment, rental, film, category, inventory, film_category.}

---

## {Comparison or Common Pitfalls} (H2 — if relevant)

{Comparison table or bullet list. Use markdown table if comparing 2+ items.}

---

## Practical Example (H2)

```sql
-- realistic analytical query using Sakila data
```

*Note: what this returns and why it's useful in practice.*

---

**Key Takeaways:**

- Takeaway 1 (definition/concept)
- Takeaway 2 (syntax rule)
- Takeaway 3 (when to use)
- Takeaway 4 (practical note)
- Takeaway 5 (optional — performance/gotcha)

## Frequently Asked Questions

### {Most searched question about this topic}?
{Direct answer in 2–4 sentences.}

### {Second common question}?
{Direct answer in 2–4 sentences.}

→ [Lesson {next_id}: {next_topic}](lesson{next_id}.{lang}.md)
```

### Style rules (from style guide)

- Short paragraphs: 2–4 lines. Split rather than combine.
- Tone: explaining, confident, neutral-professional. No marketing phrases, no "exciting".
- Bold: only for key terms, important distinctions, and final takeaways. Max 2 bold phrases per paragraph.
- H2 headings: answer a specific question or state the keyword. ≤70 chars.
- SQL code: keywords uppercase (`SELECT`, `FROM`, `WHERE`); each clause on its own line; Sakila tables preferred.
- After each SQL block: one line `*Result: ...*` or `*Note: ...*`
- Horizontal rules `---` between major thematic sections.
- Last sentence before takeaways: smooth transition to next lesson topic.

### Language-specific rules

- **en**: Plain English. Use "you" (second person). Terms stay in English.
- **ru**: Russian prose. SQL keywords stay uppercase in English. Technical terms (`CTE`, `JOIN`, `SELECT`) kept as-is.
- **fr** / **pt**: Adapt naturally. SQL stays in English.

**Step 6 — Report back.**

After writing the file, output a short summary:
- File path created
- SEO title and description used
- H2 headings list (so user can verify structure at a glance)
- Note if the SVG illustration file is missing and needs to be created at the listed path
