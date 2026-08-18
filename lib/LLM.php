<?php
class LLM {
    private $model;
    private $key;
    private $baseUrl;
    private $tokenParam;
    private $reasoningEffort; // null = send normal sampling params instead
    private $maxTokens;       // budget used by ask()
    private $maxTokensJson;   // budget used by askJson()

    /**
     * @param string $llm Name of an entry in config.php's llm_profiles (e.g.
     *                     'openai-gpt-4o-mini', 'groq-gpt-oss-20b'). There is no fallback
     *                     for an unrecognized name — every model/provider wiring (base
     *                     URL, token param name, reasoning params, API key) must come
     *                     from a real profile.
     * @throws Exception If $llm doesn't match any entry in config.php's llm_profiles,
     *                    or if that profile's API key is missing/empty in .env.
     */
    public function __construct(string $llm)
    {
        $profile = $this->loadLlmProfiles()[$llm] ?? null;
        if ($profile === null) {
            throw new Exception("LLM: unknown profile '{$llm}'.");
        }

        $apiKeyEnv = $profile['api_key_env'] ?? 'OPENAI_API_KEY';
        $this->key = $this->loadEnv()[$apiKeyEnv] ?? '';
        if ($this->key === '') {
            throw new Exception("LLM: no API key configured for '{$llm}'.");
        }

        $this->model           = $profile['model'];
        $this->baseUrl         = $profile['base_url'];
        $this->tokenParam      = $profile['token_param'];
        $this->reasoningEffort = $profile['reasoning_effort'] ?? null;
        $this->maxTokens       = $profile['max_tokens'] ?? 2000;
        $this->maxTokensJson   = $profile['max_tokens_json'] ?? 500;
    }

    private function loadEnv(): array
    {
        static $env = null;
        if ($env === null) {
            $path = dirname(__DIR__) . '/.env';
            $env = is_readable($path) ? (parse_ini_string(file_get_contents($path), 1) ?: []) : [];
        }
        return $env;
    }

    private function loadLlmProfiles(): array
    {
        static $profiles = null;
        if ($profiles === null) {
            // config.php just assigns $config = [...] without returning it, so require()-ing
            // it here (inside a method) populates $config in this local scope instead.
            $config = ['llm_profiles' => []];
            $path = dirname(__DIR__) . '/config.php';
            if (is_readable($path)) {
                require $path;
            }
            $profiles = $config['llm_profiles'] ?? [];
        }
        return $profiles;
    }

    public function ask(array $dialog) {
        $data = [
            'model'            => $this->model,
            "messages"         => $dialog,
            $this->tokenParam  => $this->maxTokens,
        ];
        if ($this->reasoningEffort !== null) {
            $data['reasoning_effort'] = $this->reasoningEffort;
        } else {
            $data['temperature']       = 0.5;
            $data['top_p']             = 1.0;
            $data['frequency_penalty'] = 0.0;
            $data['presence_penalty']  = 0.0;
        }

        $crl = curl_init($this->baseUrl);
        curl_setopt($crl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($crl, CURLINFO_HEADER_OUT, true);
        curl_setopt($crl, CURLOPT_POST, true);
        curl_setopt($crl, CURLOPT_POSTFIELDS, json_encode($data));
        curl_setopt($crl, CURLOPT_HTTPHEADER, ["Content-Type: application/json", "Authorization: Bearer " . $this->key]);

        $result = curl_exec($crl);
        $response = json_decode($result);
        curl_close($crl);

        if (property_exists($response, 'error')) {
            return $response->error->message;
        }
        $answer = $response->choices[0]->message->content;
        return nl2br($answer);
    }

    /**
     * Ask the model for a strict JSON object and return it decoded, or null on any failure
     * (network error, timeout, API error, or unparsable response).
     *
     * @param array $dialog Chat messages, same shape as ask().
     * @param int $timeoutSeconds Hard curl timeout so a hanging request can't hang the page.
     * @return array|null
     */
    public function askJson(array $dialog, int $timeoutSeconds = 20): ?array {
        $data = [
            'model'            => $this->model,
            'messages'         => $dialog,
            $this->tokenParam  => $this->maxTokensJson,
            'response_format'  => ['type' => 'json_object'],
        ];
        if ($this->reasoningEffort !== null) {
            $data['reasoning_effort'] = $this->reasoningEffort;
        } else {
            $data['temperature'] = 0.3;
        }

        $crl = curl_init($this->baseUrl);
        curl_setopt($crl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($crl, CURLOPT_POST, true);
        curl_setopt($crl, CURLOPT_POSTFIELDS, json_encode($data));
        curl_setopt($crl, CURLOPT_HTTPHEADER, ["Content-Type: application/json", "Authorization: Bearer " . $this->key]);
        curl_setopt($crl, CURLOPT_TIMEOUT, $timeoutSeconds);
        curl_setopt($crl, CURLOPT_CONNECTTIMEOUT, 5);

        $result = curl_exec($crl);
        $errno = curl_errno($crl);
        curl_close($crl);
        if ($result === false || $errno !== 0) {
            return null;
        }

        $response = json_decode($result, true);
        if (!is_array($response) || !empty($response['error']['message'])) {
            return null;
        }

        $content = trim((string)($response['choices'][0]['message']['content'] ?? ''));
        if ($content === '') {
            return null;
        }

        $json = $this->extractJsonObject($content);
        if ($json === null) {
            return null;
        }

        $decoded = json_decode($json, true);
        return is_array($decoded) ? $decoded : null;
    }

    private function extractJsonObject(string $raw): ?string {
        $raw = trim($raw);
        if ($raw === '') {
            return null;
        }
        if ($raw[0] === '{' && str_ends_with($raw, '}')) {
            return $raw;
        }
        if (preg_match('/\{.*\}/s', $raw, $match)) {
            return $match[0];
        }
        return null;
    }

    public function parseMarkdown(string $markdown): string {
        $markdown = str_replace('—', '-', $markdown);
        $parser = new \cebe\markdown\GithubMarkdown();
        $parsed = $parser->parse($markdown);
        $parsed = preg_replace('#</?(ul|ol)>#i', '', $parsed);
        $parsed = preg_replace('#<li>#i', '- ', $parsed);
        $parsed = preg_replace('#</li>#i', "\n", $parsed);
        $parsed = preg_replace('#<p>#i', '', $parsed);
        $parsed = preg_replace('#</p>#i', '', $parsed);

        foreach (["<span class='sql'>", '</span>', '<b>', '</b>'] as $tag) {
            $parsed = str_replace($tag, htmlspecialchars($tag, ENT_QUOTES | ENT_HTML5), $parsed);
        }
        return $parsed;
    }

    public function cleanupResult(string $result): string
    {
        $result = preg_replace('#<br\s*/?>#i', "\n", $result);
        $result = strip_tags($result);
        return trim(html_entity_decode($result, ENT_QUOTES | ENT_HTML5));
    }
}
