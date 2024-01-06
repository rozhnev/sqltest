<?php
class DB 
{
    /**
     * @var PDO $connection The connection
     */
    private $connection;

    /**
     * @var string $dsn The dsn of connection
     */
    private $dsn;

    /**
     * @var array $options Default option to PDO connection
     */
    private $options = [
        PDO::ATTR_PERSISTENT => true,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ,
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_EMULATE_PREPARES => false
    ];

    /**
     * Private constructor to prevent instance
     * 
     * @throws \Throwable
     * @return void
     */
    public function __construct(array $env)
    {
        $this->dsn = $env['DB_ENGINE'] 
            ? "pgsql:host={$env['DB_HOST']};port={$env['DB_PORT']};dbname={$env['DB_NAME']};" 
            : 'sqlite:sqltest.db';

        try {
            $this->connection = new PDO($this->dsn, $env['DB_USER'], $env['DB_PASS'], $this->options);
        }
        catch (\Throwable $error) {
            throw new Exception($error->getMessage());
        }
    }

    /**
     * Get an instance of the Database
     * 
     * @return PDO
     */
    public function getInstance(): PDO
    {
        return $this->connection;
    }
}
?>