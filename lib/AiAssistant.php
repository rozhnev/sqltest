<?php
/**
 * Shared base of the AI chat assistants (lesson: LessonAssistant, playground: PlaygroundAssistant,
 * see PLAYGROUND_ASSISTANT_PLAN.md): settings, the chat history in the PHP session and safe
 * rendering of the model's Markdown answer. Subclasses build their own prompt.
 */
abstract class AiAssistant
{
    protected const LANGUAGE_NAMES = [
        'en' => 'English',
        'ru' => 'Russian',
        'pt' => 'Portuguese',
        'fr' => 'French',
        'zh' => 'Simplified Chinese',
        'es' => 'Spanish',
    ];

    // Tags allowed in rendered answers; everything else is unwrapped or dropped
    private const ALLOWED_TAGS = [
        'p', 'br', 'hr', 'strong', 'b', 'em', 'i', 'del', 'code', 'pre', 'blockquote',
        'ul', 'ol', 'li', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6',
        'table', 'thead', 'tbody', 'tr', 'th', 'td', 'a',
    ];

    // Tags dropped together with their content
    private const DROPPED_TAGS = ['script', 'style', 'iframe', 'object', 'embed', 'template', 'noscript', 'textarea', 'select', 'svg', 'math'];

    protected array $env;

    public function __construct(array $env)
    {
        $this->env = $env;
    }

    /**
     * Prefix of this assistant's .env settings, e.g. 'LESSON_ASSISTANT'
     */
    abstract protected function envPrefix(): string;

    /**
     * $_SESSION key of this assistant's chat histories
     */
    abstract protected function sessionKey(): string;

    /**
     * How many chats (scopes) of this assistant the session keeps, to bound its size
     */
    protected function maxScopesInSession(): int
    {
        return 5;
    }

    /**
     * A setting from .env: <PREFIX>_<NAME>, falling back to the lesson assistant's LESSON_ASSISTANT_<NAME>
     */
    protected function setting(string $name, $default = null)
    {
        return $this->env[$this->envPrefix() . '_' . $name] ?? $this->env['LESSON_ASSISTANT_' . $name] ?? $default;
    }

    public function llmProfile(): string
    {
        return (string)($this->setting('LLM_PROFILE') ?? $this->env['USER_ANSWER_LLM_PROFILE'] ?? 'openai-gpt-4o-mini');
    }

    public function maxOutputTokens(): int
    {
        return (int)$this->setting('MAX_OUTPUT_TOKENS', 700);
    }

    /**
     * Trim and cap the student's question; empty string if nothing is left
     */
    public function normalizeQuestion(string $question): string
    {
        return self::truncate(trim($question), (int)$this->setting('MAX_QUESTION_CHARS', 1000));
    }

    // Chat history

    /**
     * Chat history of a scope (a lesson id, or one playground chat) from the session:
     * [['role' => 'user'|'assistant', 'content' => markdown], ...]
     */
    public function getHistory(int|string $scope): array
    {
        return $_SESSION[$this->sessionKey()][$scope] ?? [];
    }

    /**
     * Append a question/answer pair and keep the last <PREFIX>_HISTORY_MESSAGES messages
     */
    public function appendHistory(int|string $scope, string $question, string $answer): void
    {
        $history = $this->getHistory($scope);
        $history[] = ['role' => 'user', 'content' => $question];
        $history[] = ['role' => 'assistant', 'content' => $answer];
        $limit = max(2, (int)$this->setting('HISTORY_MESSAGES', 6));

        // Re-insert so the most recently used scope is last, then drop the oldest scopes
        $scopes = $_SESSION[$this->sessionKey()] ?? [];
        unset($scopes[$scope]);
        $scopes[$scope] = array_slice($history, -$limit);
        $_SESSION[$this->sessionKey()] = array_slice($scopes, -$this->maxScopesInSession(), null, true);
    }

    public function resetHistory(int|string $scope): void
    {
        unset($_SESSION[$this->sessionKey()][$scope]);
    }

    // Answer rendering

    /**
     * Render the model's markdown answer to HTML that is safe to insert into the page.
     * The model output is untrusted (prompt injection via the question or the context), and
     * cebe/markdown passes raw HTML through, so the rendered HTML goes through a tag and
     * attribute whitelist.
     */
    public function renderAnswer(string $markdown): string
    {
        $parser = new \cebe\markdown\GithubMarkdown();
        $parser->html5 = true;
        return self::sanitizeHtml($parser->parse($markdown));
    }

    public static function sanitizeHtml(string $html): string
    {
        if (trim($html) === '') {
            return '';
        }

        $document = new DOMDocument();
        $previous = libxml_use_internal_errors(true);
        $document->loadHTML('<?xml encoding="UTF-8"><div id="ai-assistant-root">' . $html . '</div>');
        libxml_clear_errors();
        libxml_use_internal_errors($previous);

        $root = $document->getElementById('ai-assistant-root');
        if ($root === null) {
            return htmlspecialchars(strip_tags($html), ENT_QUOTES | ENT_HTML5, 'UTF-8');
        }
        self::sanitizeChildren($root);

        $result = '';
        foreach ($root->childNodes as $child) {
            $result .= $document->saveHTML($child);
        }
        return $result;
    }

    private static function sanitizeChildren(DOMNode $node): void
    {
        // Copy the list first: the loop replaces and removes children
        foreach (iterator_to_array($node->childNodes) as $child) {
            if ($child instanceof DOMText) {
                continue;
            }
            if (!$child instanceof DOMElement) {
                // Comments, processing instructions, CDATA
                $node->removeChild($child);
                continue;
            }

            $tag = strtolower($child->tagName);
            if (in_array($tag, self::DROPPED_TAGS, true)) {
                $node->removeChild($child);
                continue;
            }

            self::sanitizeChildren($child);

            if (!in_array($tag, self::ALLOWED_TAGS, true)) {
                // Unknown tag: keep its (already sanitized) content, drop the tag itself
                while ($child->firstChild !== null) {
                    $node->insertBefore($child->firstChild, $child);
                }
                $node->removeChild($child);
                continue;
            }

            self::sanitizeAttributes($child, $tag);
        }
    }

    private static function sanitizeAttributes(DOMElement $element, string $tag): void
    {
        $href = $element->getAttribute('href');
        $class = $element->getAttribute('class');
        foreach (iterator_to_array($element->attributes) as $attribute) {
            $element->removeAttribute($attribute->nodeName);
        }

        if ($tag === 'a' && preg_match('#^https?://#i', trim($href))) {
            $element->setAttribute('href', trim($href));
            $element->setAttribute('target', '_blank');
            $element->setAttribute('rel', 'nofollow noopener noreferrer');
        }
        if ($tag === 'code' && preg_match('/^language-[\w-]+$/', $class)) {
            $element->setAttribute('class', $class);
        }
    }

    /**
     * Cap a string at $limit Unicode characters without requiring mbstring
     * (same approach as Question::checkFreeAnswer())
     */
    protected static function truncate(string $text, int $limit): string
    {
        if (preg_match('/^.{0,' . max(0, $limit) . '}/us', $text, $match)) {
            return $match[0];
        }
        // Malformed UTF-8: fall back to a byte cap
        return substr($text, 0, $limit * 4);
    }
}
