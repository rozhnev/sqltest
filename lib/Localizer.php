<?php
class Localizer {

    private static $translations = array();

    public static function init($locale) {
        $translation_file = realpath(".") . "/translations/$locale.php";
        if (!file_exists($translation_file)) {
            throw new Exception("Not supported locale: $locale");
        }
        require_once $translation_file;
        self::$translations = $translations;
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