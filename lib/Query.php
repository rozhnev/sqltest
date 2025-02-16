<?php
class Query 
{
    /**
     * SQL query
     *
     * @var string
     */
    private $sql;

    /**
     * Calculated query hash
     *
     * @var string|boolean
     */
    private $hash;

    public function __construct(string $sql)
    {
        $this->sql = $sql;
    }

    private function setHash(): void 
    {
        $ch = curl_init( "https://sqlize.online/hash.php" );
        if ($ch)
        {
            # Setup request to send json via POST.
            $payload = json_encode( [
                "language" => "sql", 
                "code" => $this->sql, 
                "sql_version" => "mysql80_sakila"
            ]);
            curl_setopt( $ch, CURLOPT_POSTFIELDS, $payload );
            curl_setopt( $ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
            # Return response instead of printing.
            curl_setopt( $ch, CURLOPT_RETURNTRANSFER, true );
            # Send request.
            $this->hash = curl_exec($ch);
            curl_close($ch);
        } else {
            throw new Exception('Can\'t qet query hash');
        }
    }
    /**
     * Get provided query in required format
     *
     * @param string $db
     * @param string $format
     * @return string
     */
    public function getResult(string $db, string $format) : string
    {
        $this->setHash();
        $ch = curl_init( "https://sqlize.online/sqleval.php" );
        if ($ch)
        {
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS, "sqlses={$this->hash}&sql_version={$db}&format={$format}");
            curl_setopt( $ch, CURLOPT_RETURNTRANSFER, true );
            # Send request.
            $result = curl_exec($ch);
            curl_close($ch);

            return preg_replace("/{$this->hash}\.?/", '', (string)$result);
        } else {
            throw new Exception('Can\'t qet query result');
        }
    }

    /**
     * Cleans the comments from the query.
     *
     * @return string The query string without comments.
     */
    public function cleanComments(): string
    {
        $inSingleQuoteString = false;
        $inDoubleQuoteString = false;
        $escaped = false;
        $cleaned = '';
        $length = strlen($this->sql);
    
        for ($i = 0; $i < $length; $i++) {
            $char = $this->sql[$i];
    
            if ($inSingleQuoteString) {
                if ($char === '\\' && !$escaped) {
                    $escaped = true;
                    $cleaned .= $char;
                    continue;
                } elseif ($char === '\'' && !$escaped) {
                    $inSingleQuoteString = false;
                } else {
                    $escaped = false;
                }
                $cleaned .= $char;
            } elseif ($inDoubleQuoteString) {
                if ($char === '\\' && !$escaped) {
                    $escaped = true;
                    $cleaned .= $char;
                    continue;
                } elseif ($char === '"' && !$escaped) {
                    $inDoubleQuoteString = false;
                } else {
                    $escaped = false;
                }
                $cleaned .= $char;
            } else {
                if ($char === '\'') {
                    $inSingleQuoteString = true;
                    $cleaned .= $char;
                } elseif ($char === '"') {
                    $inDoubleQuoteString = true;
                    $cleaned .= $char;
                } elseif ($char === '-' && $i + 1 < $length && $this->sql[$i + 1] === '-') {
                    // Skip single-line comment
                    while ($i < $length && $this->sql[$i] !== "\n") {
                        $i++;
                    }
                } elseif ($char === '/' && $i + 1 < $length && $this->sql[$i + 1] === '*') {
                    // Skip multi-line comment
                    $i += 2;
                    while ($i < $length && !($this->sql[$i] === '*' && $i + 1 < $length && $this->sql[$i + 1] === '/')) {
                        $i++;
                    }
                    $i++;
                } else {
                    $cleaned .= $char;
                }
            }
        }
    
        return $cleaned;
    }
}