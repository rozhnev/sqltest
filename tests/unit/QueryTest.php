<?php
namespace Tests\Unit;

use PHPUnit\Framework\TestCase;
use phpmock\phpunit\PHPMock;
use SQLTest\Query;
use ReflectionClass;

require_once __DIR__ . '/../../lib/Query.php';

class QueryTest extends TestCase
{
    use PHPMock;
    public function testCleanCommentsRemovesSingleLineComments()
    {
        $sql = "SELECT * FROM users -- this is a comment\nWHERE id = 1;";
        $query = new Query($sql);
        $cleaned = $query->cleanComments();
        $this->assertStringNotContainsString('-- this is a comment', $cleaned);
        $this->assertStringContainsString('SELECT * FROM users', $cleaned);
        $this->assertStringContainsString('WHERE id = 1;', $cleaned);
    }

    public function testCleanCommentsRemovesMultiLineComments()
    {
        $sql = "SELECT /* comment */ id FROM users;";
        $query = new Query($sql);
        $cleaned = $query->cleanComments();
        $this->assertStringNotContainsString('/* comment */', $cleaned);
        $this->assertStringContainsString('SELECT ', $cleaned);
        $this->assertStringContainsString('id FROM users;', $cleaned);
    }

    public function testCleanCommentsKeepsQuotedStrings()
    {
        $sql = "SELECT '/* not a comment */' as test FROM users;";
        $query = new Query($sql);
        $cleaned = $query->cleanComments();
        $this->assertStringContainsString("'/* not a comment */'", $cleaned);
    }

    public function testCleanCommentsRemovesHashSingleLineComments()
    {
        $sql = "SELECT * FROM users # this is a hash comment\nWHERE id = 2;";
        $query = new Query($sql);
        $cleaned = $query->cleanComments();
        $this->assertStringNotContainsString('# this is a hash comment', $cleaned);
        $this->assertStringContainsString('SELECT * FROM users', $cleaned);
        $this->assertStringContainsString('WHERE id = 2;', $cleaned);
    }

    public function testCleanCommentsKeepsHashInsideQuotedStrings()
    {
        $sql = "SELECT '# not a comment' as test FROM users;";
        $query = new Query($sql);
        $cleaned = $query->cleanComments();
        $this->assertStringContainsString("'# not a comment'", $cleaned);
    }

    public function testConstructorStoresSql()
    {
        $sql = "SELECT 1;";
        $query = new Query($sql);
        $reflection = new ReflectionClass($query);
        $property = $reflection->getProperty('sql');
        $property->setAccessible(true);
        $this->assertEquals($sql, $property->getValue($query));
    }

    // Note: getResult and setHash use external HTTP requests, so they should be tested with mocks or integration tests.
    // Here, we just check that getResult throws an Exception if the cURL handle cannot be created.
    private $mockBuilder;
    private $mocks = [];

    protected function setUp(): void
    {
        \phpmock\MockRegistry::getInstance()->unregisterAll();
        $this->mockBuilder = new \phpmock\MockBuilder();
        $this->mockBuilder->setNamespace('SQLTest');
    }

    protected function tearDown(): void
    {
        \phpmock\MockRegistry::getInstance()->unregisterAll();
        foreach ($this->mocks as $mock) {
            if (method_exists($mock, 'disable')) {
                $mock->disable();
            }
        }
        $this->mocks = [];
    }

    public function testGetResultThrowsExceptionOnCurlFailure()
    {
        $query = new Query('SELECT 1;');
        
        $this->expectException(\Exception::class);
        $this->expectExceptionMessage("Can't qet query hash");

        // Mock curl_init to return false
        $this->mocks['curl_init'] = $this->mockBuilder
            ->setName('curl_init')
            ->setFunction(
                function() { 
                    return false;
                }
            )
            ->build();

        $this->mocks['curl_init']->enable();
        
        $query->getResult('mysql80_sakila', 'json');
    }

    public function testGetResultThrowsExceptionOnCurlExecFailure()
    {
        $query = new Query('SELECT 1;');
        $handler = 'dummy_handle';

        // Mock all required curl functions
        $this->mocks['curl_init'] = $this->mockBuilder
            ->setName('curl_init')
            ->setFunction(
                function() use ($handler) { 
                    return $handler;
                }
            )
            ->build();

        $this->mocks['curl_setopt'] = $this->mockBuilder
            ->setName('curl_setopt')
            ->setFunction(
                function() {
                    return true;
                }
            )
            ->build();

        $this->mocks['curl_exec'] = $this->mockBuilder
            ->setName('curl_exec')
            ->setFunction(
                function() {
                    return false;
                }
            )
            ->build();

        $this->mocks['curl_close'] = $this->mockBuilder
            ->setName('curl_close')
            ->setFunction(
                function() {
                    return;
                }
            )
            ->build();

        // Enable all mocks before expectations
        foreach ($this->mocks as $mock) {
            $mock->enable();
        }

        $this->expectException(\Exception::class);
        $this->expectExceptionMessage("Can't qet query hash");

        $query->getResult('mysql80_sakila', 'json');
    }

    public function testGetResultSuccess()
    {
        $query = new Query('SELECT 1;');
        $expectedHash = 'test_hash';
        $expectedJson = '[{"headers":[{"header":"1","pdo_type":1}],"data":[[1]]}]';
        $handler = curl_init(); // Get a real curl handle for testing

        $curlResponses = [
            $expectedHash,               // First curl_exec call returns hash
            $expectedHash . $expectedJson // Second call returns hash + result
        ];
        $currentResponse = 0;

        // Mock all required curl functions
        $curlInit = $this->mockBuilder
            ->setName('curl_init')
            ->setFunction(function() use ($handler) { return $handler; })
            ->build();

        $curlSetOpt = $this->mockBuilder
            ->setName('curl_setopt')
            ->setFunction(function() { return true; })
            ->build();

        $curlExec = $this->mockBuilder
            ->setName('curl_exec')
            ->setFunction(function() use (&$curlResponses, &$currentResponse) {
                return $curlResponses[$currentResponse++];
            })
            ->build();

        $curlClose = $this->mockBuilder
            ->setName('curl_close')
            ->setFunction(function() { return; })
            ->build();

        // Enable all mocks
        $curlInit->enable();
        $curlSetOpt->enable();
        $curlExec->enable();
        $curlClose->enable();

        try {
            $result = $query->getResult('mysql80_sakila', 'json');
            $this->assertJsonStringEqualsJsonString($expectedJson, $result);
        } finally {
            // Disable all mocks
            $curlInit->disable();
            $curlSetOpt->disable();
            $curlExec->disable();
            $curlClose->disable();
        }        
    }
}
