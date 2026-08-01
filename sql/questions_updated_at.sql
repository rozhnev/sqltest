-- Add updated_at to questions and keep it current automatically.
-- PostgreSQL does not support ON UPDATE clauses, so a trigger is required.

ALTER TABLE questions
    ADD COLUMN IF NOT EXISTS created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- Initialise existing rows to the current time (run once).
UPDATE questions SET 
created_at = COALESCE(created_at, CURRENT_TIMESTAMP),
updated_at = COALESCE(updated_at, CURRENT_TIMESTAMP);

CREATE TRIGGER trg_questions_updated_at
BEFORE INSERT OR UPDATE ON questions
FOR EACH ROW EXECUTE FUNCTION set_updated_at();
