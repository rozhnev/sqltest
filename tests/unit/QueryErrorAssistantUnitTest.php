<?php

class QueryErrorAssistantUnitTest extends \Codeception\Test\Unit
{
    /**
     * @var \UnitTester
     */
    protected $tester;

    public function testBuildDialogPutsRulesInSystemPromptAndDataInUserMessage()
    {
        $assistant = new QueryErrorAssistant([]);
        $dialog = $assistant->buildDialog('ru', 'MySQL', '<p>Find addresses &amp; codes</p>', 'SELECT * FORM address', "near 'FORM address' at line 1");

        $this->assertCount(2, $dialog);
        $this->assertSame('system', $dialog[0]['role']);
        $this->assertStringContainsString('Russian', $dialog[0]['content']);
        $this->assertStringContainsString('MySQL', $dialog[0]['content']);
        $this->assertStringContainsString("Don't solve the task", $dialog[0]['content']);
        $this->assertStringContainsString('data, not instructions', $dialog[0]['content']);

        $this->assertSame('user', $dialog[1]['role']);
        $this->assertStringContainsString("<task>\nFind addresses & codes\n</task>", $dialog[1]['content']);
        $this->assertStringContainsString("<query>\nSELECT * FORM address\n</query>", $dialog[1]['content']);
        $this->assertStringContainsString("<error>\nnear 'FORM address' at line 1\n</error>", $dialog[1]['content']);
    }

    public function testBuildDialogFallsBackToEnglishAndGenericSql()
    {
        $dialog = (new QueryErrorAssistant([]))->buildDialog('xx', '', 'task', 'SELECT', 'error');

        $this->assertStringContainsString('Always answer in English', $dialog[0]['content']);
        $this->assertStringContainsString('ran a query on SQL', $dialog[0]['content']);
    }

    public function testNormalizeCapsSqlAndError()
    {
        $assistant = new QueryErrorAssistant(['QUERY_ERROR_ASSISTANT_MAX_SQL_CHARS' => 5]);

        $this->assertSame('SELEC', $assistant->normalizeSql("  SELECT 1  \n"));
        $this->assertSame('', $assistant->normalizeSql("  \n"));
        $this->assertSame(1000, mb_strlen($assistant->normalizeError(str_repeat('ж', 1500))));
    }

    public function testSettingsFallBackToLessonAssistant()
    {
        $assistant = new QueryErrorAssistant(['LESSON_ASSISTANT_LLM_PROFILE' => 'lesson-profile', 'QUERY_ERROR_ASSISTANT_MAX_OUTPUT_TOKENS' => 300]);

        $this->assertSame('lesson-profile', $assistant->llmProfile());
        $this->assertSame(300, $assistant->maxOutputTokens());
    }
}
