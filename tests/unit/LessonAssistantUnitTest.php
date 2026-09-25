<?php

class LessonAssistantUnitTest extends \Codeception\Test\Unit
{
    /**
     * @var \UnitTester
     */
    protected $tester;

    protected function _before()
    {
        $_SESSION = [];
    }

    public function testRenderAnswerDropsScriptsAndEventHandlers()
    {
        $assistant = new LessonAssistant([]);
        $html = $assistant->renderAnswer("<script>alert(1)</script>\n\nHi <img src=x onerror=alert(1)> <svg onload=alert(1)></svg>");

        $this->assertStringNotContainsString('<script', $html);
        $this->assertStringNotContainsString('<img', $html);
        $this->assertStringNotContainsString('<svg', $html);
        $this->assertStringNotContainsString('onerror', $html);
        $this->assertStringNotContainsString('alert', $html);
    }

    public function testRenderAnswerKeepsOnlySafeLinks()
    {
        $assistant = new LessonAssistant([]);
        $html = $assistant->renderAnswer('[bad](javascript:alert(1)) [good](https://sqltest.online)');

        $this->assertStringNotContainsString('javascript:', $html);
        $this->assertStringContainsString('href="https://sqltest.online"', $html);
        $this->assertStringContainsString('rel="nofollow noopener noreferrer"', $html);
    }

    public function testRenderAnswerKeepsSqlCodeReadable()
    {
        $assistant = new LessonAssistant([]);
        $html = $assistant->renderAnswer("```sql\nSELECT * FROM t WHERE a < b;\n```");

        $this->assertStringContainsString('<code class="language-sql">', $html);
        // Escaped exactly once: shown as "a < b", not "a &lt; b"
        $this->assertStringContainsString('a &lt; b', $html);
        $this->assertStringNotContainsString('&amp;lt;', $html);
    }

    public function testBuildDialogPutsLessonInSystemPromptAndHistoryBeforeQuestion()
    {
        $assistant = new LessonAssistant(['LESSON_ASSISTANT_MAX_CONTEXT_CHARS' => 10]);
        $history = [
            ['role' => 'user', 'content' => 'q1'],
            ['role' => 'assistant', 'content' => 'a1'],
        ];
        $dialog = $assistant->buildDialog('ru', 'Joins', '0123456789ABCDEF', $history, 'q2');

        $this->assertSame('system', $dialog[0]['role']);
        $this->assertStringContainsString('Russian', $dialog[0]['content']);
        $this->assertStringContainsString('0123456789', $dialog[0]['content']);
        $this->assertStringNotContainsString('ABCDEF', $dialog[0]['content']);
        $this->assertSame(['q1', 'a1', 'q2'], array_column(array_slice($dialog, 1), 'content'));
    }

    public function testHistoryKeepsLastMessagesAndLimitsLessons()
    {
        $assistant = new LessonAssistant(['LESSON_ASSISTANT_HISTORY_MESSAGES' => 4]);
        for ($i = 1; $i <= 3; $i++) {
            $assistant->appendHistory(1, "q{$i}", "a{$i}");
        }
        $this->assertSame(['q2', 'a2', 'q3', 'a3'], array_column($assistant->getHistory(1), 'content'));

        for ($lesson = 2; $lesson <= 6; $lesson++) {
            $assistant->appendHistory($lesson, 'q', 'a');
        }
        $this->assertSame([], $assistant->getHistory(1));
        $this->assertCount(5, $_SESSION['lesson_assistant']);

        $assistant->resetHistory(6);
        $this->assertSame([], $assistant->getHistory(6));
    }

    public function testNormalizeQuestionTrimsAndCaps()
    {
        $assistant = new LessonAssistant(['LESSON_ASSISTANT_MAX_QUESTION_CHARS' => 5]);

        $this->assertSame('', $assistant->normalizeQuestion("   \n "));
        $this->assertSame('Приве', $assistant->normalizeQuestion('  Привет мир '));
    }
}
