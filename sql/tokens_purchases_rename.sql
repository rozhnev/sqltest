-- Rename token_purchases to tokens_purchases, with its constraints and index
-- (ALTER TABLE ... RENAME keeps their old names). Idempotent: renames only what still
-- has the old name, so it is safe on a database where the table is already renamed.

DO $$
DECLARE
    r record;
BEGIN
    IF to_regclass('public.token_purchases') IS NOT NULL THEN
        ALTER TABLE public.token_purchases RENAME TO tokens_purchases;
    END IF;

    -- Renaming the primary key also renames its index
    FOR r IN
        SELECT conname FROM pg_constraint
        WHERE conrelid = 'public.tokens_purchases'::regclass AND conname LIKE 'token\_purchases\_%'
    LOOP
        EXECUTE format('ALTER TABLE public.tokens_purchases RENAME CONSTRAINT %I TO %I',
            r.conname, 'tokens_' || substr(r.conname, length('token_') + 1));
    END LOOP;

    FOR r IN
        SELECT indexname FROM pg_indexes
        WHERE schemaname = 'public' AND tablename = 'tokens_purchases' AND indexname LIKE 'token\_purchases\_%'
    LOOP
        EXECUTE format('ALTER INDEX public.%I RENAME TO %I',
            r.indexname, 'tokens_' || substr(r.indexname, length('token_') + 1));
    END LOOP;
END
$$;

-- Check: every name should start with tokens_purchases_
-- SELECT conname FROM pg_constraint WHERE conrelid = 'public.tokens_purchases'::regclass
-- UNION ALL SELECT indexname FROM pg_indexes WHERE tablename = 'tokens_purchases';
