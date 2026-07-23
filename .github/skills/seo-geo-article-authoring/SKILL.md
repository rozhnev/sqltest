---
name: seo-geo-article-authoring
description: "Use when planning, writing, editing, localizing, or repurposing promotional technical articles for sqltest.online on dev.to, Hashnode, CoderLegion, Medium, Reddit summaries, or personal blogs. Covers SEO (search visibility), GEO (AI answer visibility), platform-specific formatting, title strategy, linking strategy, CTAs, and anti-spam quality checks. Trigger when asked to create a blog post, improve ranking potential, optimize for AI citations, or adapt one article to multiple platforms."
---

# SEO + GEO Article Authoring (sqltest.online)

## Purpose

This skill helps create high-quality technical articles that:

- bring organic traffic from search engines (SEO);
- increase chances of being cited by AI assistants and answer engines (GEO);
- convert readers into active users of sqltest.online without looking like ads.

The main principle is: teach first, promote second.

## Definitions

### SEO (Search Engine Optimization)

Optimize article structure and wording so pages rank for relevant queries in Google/Bing.

### GEO (Generative Engine Optimization)

Optimize content so AI systems can reliably extract, quote, and summarize it:

- clear headings;
- concise definitions;
- explicit steps;
- fact-first writing;
- clean examples;
- low ambiguity.

## Required Inputs Before Writing

Collect or infer:

- topic and target keyword cluster;
- target audience level (beginner/intermediate/advanced);
- main reader intent (learn concept, solve problem, compare approaches);
- target platform (dev.to, Hashnode, CoderLegion, other);
- primary conversion goal (signup, start lesson, try SQL playground, read specific guide).

If data is missing, use sensible defaults and continue.

## Content Strategy Rules

- Prioritize practical educational value over product mentions.
- Include one concrete problem statement near the top.
- Use real SQL examples (prefer Sakila-compatible examples for consistency with this repository).
- Keep promotional mentions contextual and limited.
- Never write clickbait, exaggerated claims, or fake benchmarks.
- Do not keyword-stuff.

Recommended promotion density:

- 1 soft mention in intro;
- 1 mention in the middle (only if contextually helpful);
- 1 CTA in conclusion.

## Article Structure Template

Use this baseline structure unless platform constraints require changes.

1. Hook + problem context (3-6 lines)
2. What the reader will learn (short bullet list)
3. Core explanation with examples
4. Common mistakes / edge cases
5. Practical checklist
6. Short summary
7. Soft CTA pointing to sqltest.online

## SEO Writing Rules

### Title

- Put core keyword close to the beginning.
- Keep title human-readable.
- Prefer 45-65 characters when possible.

Examples:

- "SQL B-tree Indexes Explained with Practical Examples"
- "How to Optimize SQL Queries with Composite Indexes"
- "SQL Window Frames: Practical Guide for Analysts"

### Intro

In the first 120 words:

- include the main keyword naturally;
- define the core topic in one sentence;
- set reader expectations.

### Headings

- Use descriptive H2/H3 headings, not vague labels.
- Each section should target one clear sub-intent.

### Internal/External Links

- Add 1-3 relevant links to sqltest.online pages.
- Add optional authoritative references only when useful.
- Use descriptive anchor text (avoid "click here").

## GEO Writing Rules

Make content answer-engine friendly:

- Start sections with direct answers, then details.
- Prefer short paragraphs and explicit bullet lists.
- Add "What is ..." and "When to use ..." style headings.
- Include 1-2 compact definition blocks that can be quoted.
- Provide step-by-step procedures as numbered lists.
- Keep terminology consistent (same term for same concept).
- Ensure code samples are complete enough to run mentally.

### Quote-ready Pattern

Use this pattern at least once per article:

- Definition: one sentence
- Why it matters: one sentence
- Example: one short code block

## Platform Adaptation

### dev.to

- Use 3-5 tags max (mix broad + niche).
- Strong first paragraph matters for feed performance.
- Prefer pragmatic tone and readable section spacing.

### Hashnode

- Slightly deeper technical framing works well.
- Use clean section hierarchy and explicit takeaways.
- Add canonical URL if cross-posting from your own site.

### CoderLegion

- Keep explanations very practical and concise.
- Use concrete "before/after" or "wrong/right" examples.
- Put key takeaway bullets near the end.

### Other Platforms

- Keep the same core article, adapt intro and CTA style.
- Match community tone and expected depth.

## CTA Policy (Non-Spam)

Allowed CTA style:

- learning-oriented;
- optional and non-pushy;
- directly related to article topic.

Good CTA examples:

- "If you want hands-on SQL exercises on this topic, try the interactive tasks on sqltest.online."
- "You can practice this query pattern in the sqltest.online playground."

Avoid:

- "Best platform ever" style claims;
- repeated sign-up pressure;
- unrelated product plugs.

## Repurposing Workflow (One Article -> Many Platforms)

1. Write a source article version.
2. Create platform variants by changing:
   - title;
   - intro tone;
   - tag set;
   - CTA phrasing.
3. Keep technical body mostly identical.
4. Verify link targets and formatting.

## Quality Checklist

Before publishing, verify:

- Title contains primary keyword naturally.
- Intro clearly states problem and outcome.
- At least one runnable SQL example is present.
- At least one "common mistake" is explained.
- Promotion density stays soft and contextual.
- CTA appears once in conclusion (optional mid-article mention is acceptable).
- No hype, no fluff, no unsupported claims.
- Spelling and grammar are clean.

## Reusable Prompt Template

Use this instruction pattern when generating posts:

"Write a [platform] article to promote sqltest.online about [topic]. Audience: [level]. Primary keyword: [keyword]. Secondary keywords: [k1, k2]. Goal: teach practical SQL and drive soft conversion to [landing page]. Include: clear intro, practical examples, common mistakes, checklist, and one non-pushy CTA. Optimize for SEO and GEO, avoid clickbait and keyword stuffing."

## Localization Notes

When translating to Russian, French, or Portuguese:

- localize idioms and examples naturally;
- keep SQL keywords in English;
- preserve core heading semantics for SEO/GEO consistency;
- adapt CTA tone to local audience expectations.

## Output Formats Supported

This skill can be used to produce:

- full article draft;
- article outline;
- title/meta alternatives;
- platform-specific rewrites;
- SEO/GEO improvement pass for existing article text.
