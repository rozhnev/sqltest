# TODO: Question page UI/UX

Reviewed `/en/question/sql-basics/sort-penguins` (HTML of the live page, ~200 KB, and `templates/index.tpl`).
The logged-in view (items 14–35) was reviewed from the code (the `$User->logged()` branches, the solution check
response `{$Lang}/query_test_result.tpl` and its JS) and then on the live site under an admin account
(2026-10-03): `sort-penguins` (Run query, one wrong check), a solved free-answer task, the user popup.
A correct solution was not submitted, so the success path is reviewed from the code only.
The new-achievement banner was reviewed live the same day ("First difficult task done" on `sort-penguins`).
No visual check yet: desktop and mobile screenshots may reveal more layout issues.

Open items first, by area; resolved ones are under "Done" at the end.

## Bugs

- [ ] **34. No new-achievement banner on mobile**: `$NewAchievement` is rendered in `index.tpl` only, not in
      `m.index.tpl`.
- [ ] **35. The banner shows the oldest unviewed achievement, not the one just earned**: `User::haveNewAchievement()`
      used `ORDER BY earned_at ASC LIMIT 1`, so "First difficult task done" shows up on a Simple task, one banner per
      page.
  - [x] The just-earned one comes with the check response (see 16); pages show the newest one (`DESC`).
  - [ ] "+N more" when several are unviewed.

## High impact

- [ ] **2. Focus the schema panel on the task** (right panel, `{$Lang}/{$DB}.tpl`). It shows all 5 tables of the
      database, but the task uses only `little_penguins`.
  - [ ] Expand and highlight the tables and columns mentioned in the task (they are already marked up as
        `<span class='sql'>` in the task text), collapse the rest.
  - [ ] Click on a table or column name (in the task or in the schema) inserts it into the editor.
  - [ ] Show 3–5 sample rows instead of 1, so data quirks (e.g. NULL in `sex`) are visible.
## Texts and hints

- [ ] **5. Explain "Run query" vs "Check it!"**.
  - [ ] Show the shortcut on the button (`Run ⌃↵`), not only in `title`.
  - [ ] Add a shortcut for Check, e.g. Ctrl+Shift+Enter.
  - [ ] Short caption: "Run — see the result, Check — submit the solution".
- [ ] **6. Text badge for difficulty**. `question-level rateN` is a colored square, "Simple" is only in a tooltip.
      Badge line: "Simple · SQLite · 2 of 40".

## Behavior

- [ ] **9. After a correct solution**: put "Next" (see 14) into the success block next to
      "Show me other solutions!", it is the main action; add "Share" and the category progress.

## Logged-in user

- [ ] **21. Menu for a logged-in user** (`menu.tpl`).
  - [ ] The "hide solved" eye is repeated in every group but works globally: one switch above the menu.
  - [x] Don't render an empty "Favorites" group (confirmed live: it is the first group with 0 tasks).
- [ ] **22. New-achievement block above the task** (`index.tpl`; bugs: 33–35).
  - [x] Too big: title, 4 large share buttons and a divider push the task ~150 px down. Now one compact line
        `.new-achievement`: "🏆 New achievement unlocked: <title> · Share ▾ · ×", share buttons in a `<details>` menu.
  - [x] Achievement link `#00CED1` on `#F6F6F6` had ~1.9:1 contrast: now `--achievement-link-color`
        (`#0057CC` light, `#58A6FF` dark, ~6:1).
  - [x] The red 32×32 close button (`#d93025`) read as an error: now a transparent "×" in the text color; Esc closes.
  - [ ] Share with text, not just the URL: `text=` for X and Telegram ("I unlocked "…" on SQLtest.online")
        (`{$Lang}/achievement_share_buttons.tpl`, also used by `share_achievement.tpl`). The achievement page already
        has its own OG title (`share_achievement_og_title`).
  - [x] `aria-hidden` on the 🏆 emoji; inline styles to CSS; the borrowed `user-solutions-count` class dropped.
  - [ ] The share menu doesn't close on an outside click (plain `<details>`).
- [ ] **28. AI check cost is unknown**: "AI tokens left: 43 560", but not how much one check costs. Add "≈ N tokens per
      check".

## Admin

- [ ] **30. "Edit" pencil is invisible in the light theme**: `color: white` on the light title bar (`#E8F2FE`)
      (`index.tpl`, `question-navigate`).
- [ ] **31. Admin menu weighs ~300 KB** (guest ~64 KB) because of 552 ▲▼ reorder buttons. Show them on hover or in
      a separate reorder mode.

## Content

- [ ] **32. Typo in `de-etl-elt-pipeline-design`**: the task text ends with "…and reruns a?".

## Noise around the task

- [ ] **10. Fewer competing banners**: donation banner on top, cookie banner at the bottom, achievement block.
      Don't show the donation banner on the first visit / on task pages; e.g. after 3–5 solved tasks.

## Accessibility and code quality

- [ ] **12. Move inline styles to CSS**: urgent banner, new-achievement block, the warning in the right panel.
      Hard-coded colors (`#fff3cd`, `#00CED1`) don't follow the dark theme.

## SEO

- [ ] **13. Per-task `og:description` / `twitter:description`**. They are site-wide now; use the task's own
      description, as `meta description` already does.

## Done

### High impact

- [x] **1. Lighten the left menu** (`menu.tpl`). It rendered 277 links in 17 accordions, ~64 KB of markup
      (a third of the page).
  - [x] Only the current group's tasks come with the page (`menu-group.tpl`); the others are loaded when expanded
        (`GET /{lang}/menu?questionnire=…&group=<id>`, `loadMenuGroups()`), or all at once for the search
        (`&group=all`).
  - [x] Progress in each group header: "12 / 40" solved (guests: the task count), updated after a correct
        solution (`showSolvedProgress()`).
  - [x] Search by task title or number above the groups (`searchMenu()`): matching tasks in all groups,
        "Nothing found" otherwise.
  - [x] "Hide solved" is one class on `<html>` (CSS), so groups loaded later follow it; the current task stays
        visible. A second click on an open group now closes it; `loadMenu()` no longer nests `<nav id="menu">`
        in itself.

- [x] **3. Show the expected result** (deployed 2026-10-05), step by step, so the task doesn't get easier. A wrong check already reveals the
      column count / names, the row count and (25) the first differing row; this puts it in order.
      `expected_result.tpl` under the task (desktop and mobile), `Question::getExpectedResult()` / `getExpectedSample()`.
  - [x] Level 1, right away: a collapsed "Expected result ▸" block under the task with the column names in order and
        the row count, no data ("Columns: 2 · Rows: 10", the names as the table header).
  - [x] Level 2, after 2 wrong checks (Easy / Simple / Normal) or 3 (Difficult / Hard): "Show sample rows" in the block
        and in the check result (`expected_sample_link.tpl`); rows come from `GET /{lang}/question/{id}/expected-sample`,
        which checks the count itself. Before that the block says "Sample rows open after wrong checks: 1 of 2"; the
        `X-Sample-Rows` header of the check unlocks it without a reload. Once opened, the rows show on later visits.
        Opened by click only, for all difficulties.
  - [x] No sample rows while the task is in the user's open test (`User::hasOpenTestWithQuestion()`: tests pick
        random practice tasks, so the practice page could help to pass one); the block says so instead. The test page
        itself (`test.tpl`, `test_check()`) has no expected result block.
  - [x] No sample rows when the result has fewer than 5 rows (single value, aggregates, `COUNT`): 148 of 389 tasks.
  - [x] Never the full result: 2 rows for 5–9, 3 rows for 10+, i.e. at most 40%.
  - [x] Data: `query_valid_result` is stored JSON, not computed per check, so no cache. Wrong checks:
        `user_questions.failed_checks` (`saveQuestionAttempt()`), the session for guests.
  - [x] Track solutions made after the sample rows were shown: `user_questions.sample_rows_shown_at`, query in the
        migration.
  - [x] **Deploy**: run `sql/user_questions_expected_result_migration.sql` before the code (`Question::get()` selects
        the new columns) (migrated 2026-10-05).
  - [x] Checked live as a guest (2026-10-05, `sort-penguins`): the block renders ("Columns: 2 · Rows: 10",
        "…wrong checks: 0 of 2"), `expected-sample` answers 403 before the unlock, the minified CSS has the icon.
  - [ ] Still to check by hand: the unlock after wrong checks, a logged-in user, mobile, the dark theme.

### Bugs

- [x] **14. The "Next" button never shows after a correct solution** (desktop and mobile).
      Markup is `<div id="nextTaskBtn" class="hidden"><a class="button green hidden">` (`index.tpl`, `m.index.tpl`);
      the JS removes `hidden` from the `div` only (markup confirmed on the live page). It used to work because `.button` (`display: flex`) beat
      `.hidden`; since `787f976` (2026-09-29) `.code-buttons .button.hidden { display: none }` hides the link for good.
  - [x] Drop `hidden` from the inner `<a>`.
  - [x] `classList.toggle("hidden")` → `remove`: a second correct check (e.g. to lower the cost) hides the
        button again (`script.js`: `checkAnswers`, `checkFreeAnswer`, `testQuery`).
- [x] **15. "Use the hint" in the wrong-solution response asks for the hint in Russian**: `getHelp('ru', …)` is
      hard-coded in `en/query_test_result.tpl` and `pt/query_test_result.tpl`. Now `{$Lang}` in all six languages. The button also repeats
      `id="getHelpBtn"` of the page's own button (duplicate id): removed from the response.
- [x] **33. Sharing an achievement doesn't mark it viewed**: the banner script in `index.tpl` waits for
      `a[data-mark-achievement-viewed="1"]`, but the LinkedIn / X / Facebook / Telegram links in
      `{$Lang}/achievement_share_buttons.tpl` don't have the attribute. After sharing, the banner keeps showing on
      every page until closed with ×. Now any link in the banner (title or share) marks it viewed.

### Texts and hints

- [x] **4. Merge the two italic instruction lines** under the task into one short line
      (`question_action_write_query`, `_mobile` for `m.index.tpl`).
  - [x] "Write your **request**…" → "query" (`question_action_write_your_request`, still used by the test pages).
  - [x] "…provided in the right pane" is wrong on mobile: the mobile line says "at the bottom of the screen".
  - [x] Show the dialect as a badge next to the title (`.question-dbms`, tooltip `question_action_use_syntax`).

### Behavior

- [x] **7. "Get hint" must not wipe the query result**. `getHelp()` replaced `#code-result` entirely. Now the hint goes
      to its own panel above the editor (`hint_panel.tpl`, desktop and mobile): the button toggles it, × closes it,
      the hint is loaded once. Pages without the panel still use `#code-result`; acceptance tests updated.
- [x] **8. Empty states** (question page, desktop and mobile).
  - [x] Editor: Ace `placeholder` from `data-placeholder` of `#sql-code` (`sql_editor_placeholder`).
  - [x] Result area: `.code-result-empty` inside `#code-result`, text per question type
        (`result_empty_query` / `_answers` / `_free_answer`), plus the Ctrl+Enter hint on desktop.
        Replaced by the first result, hint or error.

### Logged-in user

- [x] **16. Update the page after a correct solution** without a reload: `Controller::sendSolvedProgress()` on a
      correct `query_test` / `check_answers` / `check_free_answer` of a logged-in user; `showSolvedProgress()` and
      `placeNewAchievement()` in `script.js`.
  - [x] Mark the task `solved` in the menu (`.question-link.current-question`).
  - [x] Refresh the "My progress" widget from the `X-Solved-Count` / `X-Questions-Count` headers.
  - [x] Show a new achievement right away: `new_achievement.tpl` (now a partial, also used by `index.tpl`) is
        rendered before the result and moved above the task (on mobile it stays in the result).
  - [x] Widget count: solved tasks counted all `user_questions`, the total only not deleted questions; the solved
        count now skips deleted questions too. Recheck live (3/460 vs 2 in the menu): the menu may hide more.
- [x] **17. Success block texts** (`{$Lang}/query_test_result.tpl`, all six languages).
  - [x] "Your **request** is among the best" → "query" (en, es).
  - [x] "your result is a little low of the record" → "Your query costs more than the best solution, so there's room
        to optimize it" (en; same idea in pt, fr, es, where the old text was off too).
  - [x] "Before starting the next **test**, please rate…" → "task" (en, fr, es); ru punctuation.
  - [x] Inline styles of the block moved to CSS (`.query-success-*`, `.query-cost*`); colors are theme variables
        (`--cost-best-color`, `--danger-text-color`, `--info-text-color`), the note icons use `currentColor`.
  - [ ] Left as is: the VK share promo in `ru/query_test_result.tpl` (inline styles) and the wrong-solution branch.
- [x] **18. Solved date on a solved task**. The title showed only the last attempt date of an unsolved task; for a
      solved one it was empty. Now "Solved on …" (`question_solved_at`, en text "Solved at" → "Solved on").
  - [ ] The mobile title has no dates at all (commented out in `m.index.tpl`).
- [x] **19. "You already solved this task" line**: inline `style="… color: #2EA043 !important"` with a button inside a
      `span`. Now `.question-solved` (✓, `--cost-best-color`) on the question and test pages; "View solutions" is a
      link-like `text-button`, no longer as green as "Check it!".
- [x] **20. User icon in the top menu** (`top-menu.tpl`): a green `div` with a silhouette colored by grade, no name,
      `title` or `aria-label`; it opens the achievements popup. Now a real button `#userMenuBtn` (desktop and mobile)
      with `title` / `aria-label` "Profile and achievements · <grade>", `aria-expanded`, and the grade as a label on
      desktop. The popup no longer closes on clicks inside it; Esc and a click outside close it.
- [x] **23. `my_progress.tpl` divides by `$QuestionsCount`** without a zero check.
- [x] **24. Favorites star** is a `<span onClick>` too (see 11): done with 11.
- [x] **25. Wrong-solution row hint is hard to read**: it was "the row number 1 … should contain: `1 | MALE | 5550`",
      "your result: `1 | MALE | 5300`", without column headers. Now `row_diff.tpl`: one table with the column names,
      rows "Expected" / "Yours", differing cells highlighted, values escaped. `Question::checkQueryResult()` adds
      `columns` / `expected` / `actual` / `diff` to `hints.rowsData` (all six `{$Lang}/query_test_result.tpl`).
  - [x] Same table in the test (`check_test_solution.tpl`) and interview (`interview-answer-result.tpl`) results;
        hints saved before (no `columns`) still show the old `rowTable` / `resultTable`.
- [x] **26. Instructions name a button that doesn't exist**: free answer says "click the "Check!" button", the button is
      "Check answer"; choice questions say "Check!", the button is "Check answers"
      (`question_action_write_free_answer`, `question_action_choose_one_answer`, `question_action_mark_all_answers`).
      Now the instructions quote the real labels (`question_action_check_answers` /
      `question_action_check_free_answer`) in all six languages; the SQL line already matched "Check it!".
- [x] **27. Solved free-answer task on revisit** showed the old answer and "You already solved this task" only.
      The AI check was not stored (`llm_feedback` is the interview table). Now `user_questions.last_feedback`
      (`{ok, score, comment}`, `User::saveFreeAnswerFeedback()`) is shown in the result area until the next check:
      "Last AI check (date): passed · Score 85/100" + the comment (`free_answer_last_check.tpl`, desktop and mobile).
  - [x] **Deploy**: run `sql/user_questions_last_feedback_migration.sql` before the code, `Question::get()` selects
        the column (deployed 2026-10-03).
- [x] **29. User popup** (`/{lang}/user/achievements`, `achievements.tpl`): "User Profile" / "Logout" were at the very
      bottom after the achievements list.
  - [x] Links on top: Profile, "My tasks" (`/user/profile#tasks`), "AI tokens: N" (`#ai`).
  - [x] The last 3 achievements (was 5) plus "All achievements →" (`#achievements`).
  - [x] Logout as a quiet link at the bottom, not a big red button equal to Profile.

### Accessibility and code quality

- [x] **11. Real buttons**: "Get hint", "Copy code", "Clear editor", the favorites star were `<span onClick>`, not
      reachable from the keyboard or screen readers. Now `<button type="button">` (26 text buttons on the question,
      test and playground pages and in the check results; the star with `aria-pressed`). `.text-button.hidden` now
      really hides (`.text-button` set `display: flex` after `.hidden`).
