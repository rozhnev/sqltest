<?php
class LLM {
    private $model = 'gpt-4o-mini';
    private $key;

    public function __construct(string $key)
    {
        $this->key = $key;
    }

    public function setModel(string $model) {
        $this->model = $model;
    }

    public function ask(array $dialog) {
        $data = [
            'model'         => $this->model,
            "messages"      => $dialog, 
            "temperature"   => 0.5,
            "max_tokens"    => 2000,
            "top_p"         => 1.0,
            "frequency_penalty" => 0.0,
            "presence_penalty" => 0.0,
            // "stop" => ["#", ";"]
        ];
        
        $crl = curl_init('https://api.openai.com/v1/chat/completions');
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

    public function parseMarkdown(string $markdown): string {
        $parser = new \cebe\markdown\GithubMarkdown();
        $parsed = $parser->parse($markdown);
        $parsed = str_replace("<span class='sql'>", htmlspecialchars("<span class='sql'>", ENT_QUOTES | ENT_HTML5), $parsed);
        $parsed = str_replace("</span>", htmlspecialchars("</span>", ENT_QUOTES | ENT_HTML5), $parsed);
        return $parsed;
    }

    public function cleanupResult(string $result): string
    {
        $result = preg_replace('#<br\s*/?>#i', "\n", $result);
        $result = strip_tags($result);
        return trim(html_entity_decode($result, ENT_QUOTES | ENT_HTML5));
    }
}
