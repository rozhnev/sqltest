<?php
class Localizer {

    private static $translations = array();

    public static function init($locale) {
        $basePath = realpath(".") . "/translations";
        $baseTranslationFile = $basePath . "/en.php";
        $translation_file = $basePath . "/$locale.php";

        if (!file_exists($baseTranslationFile)) {
            throw new Exception("Base locale file missing: en");
        }

        $translations = [];
        require $baseTranslationFile;
        $baseTranslations = is_array($translations) ? $translations : [];

        if (!file_exists($translation_file)) {
            throw new Exception("Not supported locale: $locale");
        }

        $translations = [];
        require $translation_file;
        $localeTranslations = is_array($translations) ? $translations : [];

        self::$translations = array_merge($baseTranslations, $localeTranslations);
    }

    public static function translate($params, $name, $smarty) {

        $translation = '';
        if( ! is_null($name) && array_key_exists($name, self::$translations)) {

            // get variables in translation text
            $translation = self::$translations[$name];
            preg_match_all('/##([^#]+)##/i', $translation, $vars, PREG_SET_ORDER);

            // replace with assigned smarty values
            foreach($vars as $var) {
                $translation = str_replace($var[0], $smarty->getTemplateVars($var[1]), $translation);
            }

        }

        return $translation;

    }
    public static function translateString($name) {
        return $translation = self::$translations[$name] ?? $name;
    }
}