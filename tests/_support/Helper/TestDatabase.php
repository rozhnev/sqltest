<?php
namespace Helper;

use PDO;

/**
 * Connection to a disposable test database for DB-backed unit tests.
 *
 * Settings come from tests/.env.testing (not the main .env, which may point at
 * production). Tests are skipped when it is missing, and the connection is refused
 * unless the database name contains "test", so a misconfigured file can't wipe real data.
 */
class TestDatabase
{
    public const PRODUCTION_HOSTS = ['sqltest.online'];

    /**
     * @return PDO|string PDO on success, otherwise the reason to skip the tests
     */
    public static function connect()
    {
        $path = dirname(__DIR__, 2) . '/.env.testing';
        if (!is_readable($path)) {
            return 'tests/.env.testing is not configured (see tests/.env.testing.example)';
        }
        $env = parse_ini_string((string)file_get_contents($path)) ?: [];
        $host = strtolower((string)($env['TEST_DB_HOST'] ?? ''));
        $name = (string)($env['TEST_DB_NAME'] ?? '');

        if ($host === '' || in_array($host, self::PRODUCTION_HOSTS, true)) {
            return "TEST_DB_HOST '{$host}' is empty or a production host";
        }
        if (stripos($name, 'test') === false) {
            return "TEST_DB_NAME '{$name}' must contain 'test'";
        }

        $dsn = "pgsql:host={$host};port=" . ($env['TEST_DB_PORT'] ?? 5432) . ";dbname={$name}";
        return new PDO($dsn, (string)($env['TEST_DB_USER'] ?? ''), (string)($env['TEST_DB_PASS'] ?? ''), [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        ]);
    }

    /**
     * Recreate the tables the AI quota code uses, from the project's own DDL:
     * users from sql/schema.sql and llm_usage_log from sql/llm_usage_log_ddl.sql.
     */
    public static function resetSchema(PDO $dbh): void
    {
        $root = dirname(__DIR__, 3);

        $schema = (string)file_get_contents($root . '/sql/schema.sql');
        if (!preg_match('/CREATE TABLE public\.users \(.*?\n\);/s', $schema, $users)) {
            throw new \RuntimeException('users DDL not found in sql/schema.sql');
        }

        // Ownership and grants refer to production roles that don't exist here
        $usageLog = preg_replace('/^\s*(ALTER TABLE .* OWNER TO|GRANT) .*$/mi', '', (string)file_get_contents($root . '/sql/llm_usage_log_ddl.sql'));

        $dbh->exec('DROP TABLE IF EXISTS public.llm_usage_log, public.users CASCADE');
        $dbh->exec($users[0]);
        $dbh->exec('ALTER TABLE public.users ADD PRIMARY KEY (id), ADD UNIQUE (login)');
        $dbh->exec($usageLog);
    }
}
