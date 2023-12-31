<?php
class DB 
{
    /**
     * @var PDO $connection The connection
     */
    private $connection;

    /**
     * @var string $engine The engine of connection
     */
    private $engine = 'sqlite:sqltest.db'; // sqlite::memory:

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
    public function __construct()
    {
        try {
            $this->connection = new PDO($this->engine, null, null, $this->options);
        }
        catch (\Throwable $error) {
            error_log("{$error->getMessage()}");
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