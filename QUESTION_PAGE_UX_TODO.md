# TODO: Question page UI/UX

Reviewed `/en/question/sql-basics/sort-penguins` (HTML of the live page, ~200 KB, and `templates/index.tpl`).
No visual check yet: desktop and mobile screenshots may reveal more layout issues.

Suggested order: 2 → 7 → 5 → 1 (biggest effect for the least work).

## High impact

- [ ] **1. Lighten the left menu** (`menu.tpl`). It renders 277 links in 17 accordions, ~64 KB of markup
      (a third of the page), and takes a whole column away from the task.
  - [ ] Render only the current category, load the others when expanded (reuse `loadMenu()`).
  - [ ] Progress in each group header: "12 / 40 solved".
  - [ ] Search by task title.
- [ ] **2. Focus the schema panel on the task** (right panel, `{$Lang}/{$DB}.tpl`). It shows all 5 tables of the
      database, but the task uses only `little_penguins`.
  - [ ] Expand and highlight the tables and columns mentioned in the task (they are already marked up as
        `<span class='sql'>` in the task text), collapse the rest.
  - [ ] Click on a table or column name (in the task or in the schema) inserts it into the editor.
  - [ ] Show 3–5 sample rows instead of 1, so data quirks (e.g. NULL in `sex`) are visible.
- [ ] **3. Show the expected result**: the expected columns in order, or the first 2–3 rows of the reference
      result. Reduces blind attempts.

## Texts and hints

- [x] **4. Merge the two italic instruction lines** under the task into one short line
      (`question_action_write_query`, `_mobile` for `m.index.tpl`).
  - [x] "Write your **request**…" → "query" (`question_action_write_your_request`, still used by the test pages).
  - [x] "…provided in the right pane" is wrong on mobile: the mobile line says "at the bottom of the screen".
  - [x] Show the dialect as a badge next to the title (`.question-dbms`, tooltip `question_action_use_syntax`).
- [ ] **5. Explain "Run query" vs "Check it!"**.
  - [ ] Show the shortcut on the button (`Run ⌃↵`), not only in `title`.
  - [ ] Add a shortcut for Check, e.g. Ctrl+Shift+Enter.
  - [ ] Short caption: "Run — see the result, Check — submit the solution".
- [ ] **6. Text badge for difficulty**. `question-level rateN` is a colored square, "Simple" is only in a tooltip.
      Badge line: "Simple · SQLite · 2 of 40".

## Behavior

- [ ] **7. "Get hint" must not wipe the query result**. `getHelp()` replaces `#code-result` entirely
      (`script.js`, `function getHelp`). Show the hint in its own block above the result or in a collapsible panel.
- [x] **8. Empty states** (question page, desktop and mobile).
  - [x] Editor: Ace `placeholder` from `data-placeholder` of `#sql-code` (`sql_editor_placeholder`).
  - [x] Result area: `.code-result-empty` inside `#code-result`, text per question type
        (`result_empty_query` / `_answers` / `_free_answer`), plus the Ctrl+Enter hint on desktop.
        Replaced by the first result, hint or error.
- [ ] **9. After a correct solution**, besides "Next": "View other solutions" (now shown only on a repeat visit),
      "Share", category progress.

## Noise around the task

- [ ] **10. Fewer competing banners**: donation banner on top, cookie banner at the bottom, achievement block.
      Don't show the donation banner on the first visit / on task pages; e.g. after 3–5 solved tasks.

## Accessibility and code quality

- [ ] **11. Real buttons**: "Get hint", "Copy code", "Clear editor", the favorites star are `<span onClick>`, not
      reachable from the keyboard or screen readers. Replace with `<button type="button">`.
- [ ] **12. Move inline styles to CSS**: urgent banner, new-achievement block, the warning in the right panel.
      Hard-coded colors (`#fff3cd`, `#00CED1`) don't follow the dark theme.

## SEO

- [ ] **13. Per-task `og:description` / `twitter:description`**. They are site-wide now; use the task's own
      description, as `meta description` already does.
