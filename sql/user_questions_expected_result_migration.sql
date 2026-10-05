-- QUESTION_PAGE_UX_TODO.md, item 3: the expected result block on the question page.
-- failed_checks: wrong "Check it!" attempts, unlock the sample rows (Question::sampleRowsUnlockAfter()).
-- sample_rows_shown_at: when the user first opened the sample rows, to see whether solutions come after them:
--   SELECT count(*) FILTER (WHERE solved_at > sample_rows_shown_at), count(*) FILTER (WHERE solved_at IS NOT NULL)
--   FROM user_questions WHERE sample_rows_shown_at IS NOT NULL;
--
-- Run BEFORE deploying the code: Question::get() selects these columns, so the question page fails without them.
ALTER TABLE public.user_questions ADD COLUMN IF NOT EXISTS failed_checks smallint DEFAULT 0 NOT NULL;
ALTER TABLE public.user_questions ADD COLUMN IF NOT EXISTS sample_rows_shown_at timestamp without time zone;
