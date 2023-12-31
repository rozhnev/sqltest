<?php
class Questionnire 
{
    private $lang;

    public function __construct(string $lang)
    {
        $this->lang = $lang;
    }

    public function get() {
        require_once("questions_{$this->lang}.php");
        return $questionnire;
    }
}