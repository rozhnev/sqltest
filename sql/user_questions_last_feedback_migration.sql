-- QUESTION_PAGE_UX_TODO.md, item 27: the last AI check of a free answer, shown when the user comes back to the task.
-- {"ok": bool, "score": int|null, "comment": string}, written by User::saveFreeAnswerFeedback().
--
-- Run BEFORE deploying the code: Question::get() selects this column, so the question page fails without it.
ALTER TABLE public.user_questions ADD COLUMN IF NOT EXISTS last_feedback jsonb;
