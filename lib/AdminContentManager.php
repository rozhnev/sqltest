<?php

abstract class AdminContentManager
{
    protected PDO $dbh;
    protected array $supportedLanguages = ['en', 'ru', 'pt', 'fr'];

    private const LANGUAGE_LABELS = [
        'en' => 'English',
        'ru' => 'Russian',
        'pt' => 'Portuguese',
        'fr' => 'French'
    ];

    public function __construct(PDO $dbh)
    {
        $this->dbh = $dbh;
    }

    public function getSupportedLanguages(): array
    {
        return $this->supportedLanguages;
    }

    public function getLanguageLabels(): array
    {
        $labels = [];
        foreach ($this->supportedLanguages as $language) {
            $labels[$language] = self::LANGUAGE_LABELS[$language] ?? ucfirst($language);
        }
        return $labels;
    }
}