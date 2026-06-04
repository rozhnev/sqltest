---
name: sql-lesson-authoring
description: "Use when creating, editing, reviewing, translating, or extending SQL course lessons in this repository. Covers lesson structure, tone, Sakila-based examples, multilingual consistency, and the required SVG illustration style for new lessons. Trigger when asked to write a new lesson, improve lesson wording, translate a lesson, add a lesson cover image, or keep lesson formatting consistent with the course."
---

# SQL Lesson Authoring

## Purpose

This skill is for authoring and maintaining lesson files in this repository.

Use it when you need to:

- write a new SQL lesson;
- revise an existing lesson;
- translate a lesson into English, French, or Portuguese;
- keep lessons consistent with the house style;
- add or update the SVG illustration for a lesson;
- preserve naming, formatting, and examples used across the course.

This skill is repository-specific. It reflects the structure and conventions already used in the `lessons/` and `images/lessons/` directories.

## Core Principles

Every lesson should be:

- understandable for beginner to intermediate readers;
- practical rather than abstract;
- compact in paragraph size but still sufficiently detailed;
- written in a calm, explanatory, professional tone;
- useful for analytical and applied SQL work.

The lesson should not only define a concept, but explain why it matters, how it works, and when to use it in practice.

## Required Lesson Structure

### 1. Intro paragraph before the H1

Start with a short paragraph before the main title.

That paragraph should:

- name the topic;
- explain what the learner will study;
- state the practical value;
- end with the expected learning outcome.

Typical pattern:

"This lesson introduces ... You will learn ... We will look at ... By the end of the lesson, you will be able to ..."

### 2. H1 title

Use this format:

```md
# Lesson X.Y: Topic Name
```

In Russian lessons:

```md
# Урок X.Y: Название темы
```

The title should be short, precise, and match the lesson topic.

### 3. Context after H1

After the H1, add 1-2 short paragraphs that explain:

- the connection to the previous lesson;
- where this topic fits in SQL as a whole;
- why this topic matters in practical work.

### 4. SVG illustration for new lessons

Every new lesson should include a dedicated SVG illustration.

Requirements:

- create the illustration in SVG format;
- save it in `images/lessons/`;
- use a lesson-specific filename such as `lesson9_4-sql-view.svg` or `lesson9_3-temporary-tables.svg`;
- place the image in the lesson after the context paragraphs and before the first main `##` section;
- embed it with:

```md
<img src="/images/lessons/lessonX_Y-topic.svg" alt="Lesson illustration" width="100%">
```

The illustration should support the lesson content rather than act as generic decoration. It should visually communicate the query idea, data flow, structure, or the key distinction discussed in the lesson.

### 5. Main H2 sections

Split lessons into clear `##` sections.

Do not number section headers. Use `## Topic Name`, not forms like `## 1. Topic Name`.

Useful section types include:

- definition or core idea;
- basic syntax;
- examples;
- comparison with related concepts;
- practical recommendations;
- practical use case;
- key takeaways.

### 6. H3 subsections

Use `###` when a section contains several distinct subtopics, especially for:

- comparing differences;
- step-by-step breakdowns;
- separate rules or caveats;
- usage scenarios.

Do not number subsection headers. Use `### Subtopic`, not forms like `### 3.1. Subtopic`.

### 7. Final takeaway block

End with:

```md
**Key takeaways from this lesson:**
```

In Russian:

```md
**Ключевые выводы этого урока:**
```

Follow it with 4-6 short bullets.

### 8. Transition to the next lesson

The last sentence should smoothly lead into the next topic.

Typical forms:

- "In the next lesson, we will look at ..."
- "Next, we will learn ..."

## Tone and Writing Style

The tone must be:

- explanatory;
- confident;
- neutral-professional;
- free from marketing language;
- free from excessive informality.

Prefer:

- "Now let’s look at ..."
- "This is useful when ..."
- "In practice, this approach is convenient if ..."

Avoid:

- overly promotional wording;
- academic dryness;
- overly long paragraphs;
- abrupt topic switching.

## Paragraphs

Prefer short paragraphs of roughly 2-4 lines.

If an idea can be split cleanly, prefer two short paragraphs over one dense block.

## SQL Terminology

Introduce terms gently:

- explain the idea simply first;
- then name the formal term;
- then show a practical example.

Keep SQL terms in English where appropriate, such as:

- `SELECT`
- `JOIN`
- `CTE`
- `TEMPORARY TABLE`
- `VIEW`

## SQL Example Rules

All SQL examples should use fenced code blocks:

```sql
SELECT column_name
FROM table_name;
```

Preferred formatting:

- put `SELECT`, `FROM`, `WHERE`, `GROUP BY`, and `ORDER BY` on separate lines;
- keep alignment clean and predictable;
- avoid overly dense examples when the logic can be broken up.

### Example quality

Use practical examples based on familiar project tables. Sakila tables are preferred:

- `customer`
- `payment`
- `rental`
- `film`
- `category`
- related tables such as `inventory` and `film_category`

Each example should answer a practical question, not just demonstrate syntax in isolation.

### Commentary after examples

After important examples, add a short note that explains:

- what the query does;
- what the result is;
- why it is useful.

Typical forms:

```md
*Result: ...*
```

or

```md
*Note: ...*
```

## Visual Formatting

Use horizontal rules between major sections:

```md
---
```

Use bullet lists for:

- rules;
- recommendations;
- differences;
- summaries.

Keep lists short and logically grouped.

Use bold emphasis sparingly for:

- key terms;
- important contrasts;
- warnings;
- takeaway headers.

## Lesson Frontmatter For SEO/GEO

When authoring or updating lesson files, include YAML frontmatter fields used by page metadata and schema:

```md
---
title: "Keyword-rich page title"
description: "Direct answer and learning value in 120-155 characters"
keywords: ["primary keyword", "secondary keyword"]
teaches: ["learning outcome 1", "learning outcome 2", "learning outcome 3"]
about: ["Database", "DBMS", "SQL", "Relational database"]
---
```

Rules:

- `teaches` should be a short list of concrete outcomes the learner gets from this lesson.
- `about` should list topic entities for schema.org (it is converted to `Thing` entities automatically).
- Keep `teaches` and `about` aligned with the lesson language and actual content.

## Illustration Style

New lesson SVG covers should follow the current picture style already used in section 9 lessons.

Preferred characteristics:

- canvas around `1200 x 630`;
- light soft gradient background;
- simple decorative circular shapes;
- large dark left-side panel with the core topic;
- right side built from 2-4 light cards or small diagrams;
- limited text inside the image;
- accent color for the main SQL concept;
- modern technical visual language, not overly decorative.

If several lessons belong to the same topic sequence, keep the image language consistent:

- similar composition;
- related palette;
- similar title scale;
- matching card structure.

## Translation Rules

When translating lessons into English, French, and Portuguese, preserve:

- the same section structure;
- the same order of examples;
- the same SQL blocks;
- the same level of detail;
- the same practical focus.

You may adapt:

- natural phrasing for the target language;
- section titles;
- transitions between paragraphs.

Do not change:

- the meaning of examples;
- the lesson structure;
- the difficulty level;
- the teaching sequence.

## Repository Conventions

- lesson files live in `lessons/`;
- lesson filenames follow patterns like `lesson9_4_ru.md`, `lesson9_4_en.md`, `lesson9_4_fr.md`, `lesson9_4_pt.md`;
- lesson illustrations live in `images/lessons/`;
- image filenames should align with lesson numbers and topic names.

## Recommended Workflow

When asked to create or update a lesson:

1. Read the nearest lesson in the sequence to preserve continuity.
2. Read `lessons/lesson_style_guide.md` if you need the full source guidance.
3. Draft the lesson using the repository structure above.
4. Use practical Sakila-based SQL examples.
5. Add the SVG lesson illustration if this is a new lesson.
6. If translation is requested, preserve structure and SQL blocks exactly.
7. End with key takeaways and a forward transition.

## Output Checklist

Before finishing, verify that the lesson:

- has a short intro before the H1;
- has context paragraphs after the H1;
- contains the lesson SVG image in the correct place for new lessons;
- uses logical `##` sections;
- uses non-numbered `##` and `###` headings;
- includes practical SQL examples;
- contains short explanatory notes after important examples;
- ends with key takeaways;
- ends with a transition to the next lesson;
- matches existing repo naming conventions.

## Template

```md
Short intro paragraph: what the topic is, what the learner will study, why it matters.

# Lesson X.Y: Topic Name

Context paragraph(s): connection to the previous lesson and why the topic matters.

<img src="/images/lessons/lessonX_Y-topic.svg" alt="Lesson illustration" width="100%">

## What It Is

Short explanation of the concept.

## Basic Syntax

```sql
-- syntax example
```

## Main Features

- rule 1
- rule 2
- rule 3

---

## Examples

### Example 1: ...

```sql
-- example
```

*Result or note.*

### Example 2: ...

```sql
-- example
```

---

## What to Pay Attention To

- recommendation 1
- recommendation 2
- recommendation 3

---

## Practical Example

```sql
-- practical query
```

---

**Key takeaways from this lesson:**

*   Takeaway 1.
*   Takeaway 2.
*   Takeaway 3.
*   Takeaway 4.

In the next lesson, we will look at ...
```