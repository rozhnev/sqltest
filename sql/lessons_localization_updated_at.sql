-- Add updated_at to lessons_localization and keep it current automatically.
-- PostgreSQL does not support ON UPDATE clauses, so a trigger is required.

ALTER TABLE lessons_localization
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- Initialise existing rows to the current time (run once).
UPDATE lessons_localization SET updated_at = CURRENT_TIMESTAMP WHERE updated_at IS NULL;

-- Reusable trigger function (shared across tables if needed).
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER
LANGUAGE plpgsql AS
$$
BEGIN
    NEW.updated_at := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;

-- Trigger: fire before every INSERT or UPDATE on lessons_localization.
DROP TRIGGER IF EXISTS trg_lessons_localization_updated_at ON lessons_localization;

CREATE TRIGGER trg_lessons_localization_updated_at
BEFORE INSERT OR UPDATE ON lessons_localization
FOR EACH ROW EXECUTE FUNCTION set_updated_at();
