<?php
use MaxMind\Db\Reader;

class Helper 
{
    private static $country = null;

    public static function getCountryFromIP(string $ip): ?string
    {
        $ip = filter_var($ip, FILTER_VALIDATE_IP);

        if ($ip === false) {
            return null;
        }
        if (self::$country) {
            return self::$country;
        }
        /* Load the MaxMind database reader */
        $maxmindReader = new Reader('GeoLite2-City.mmdb');
        $geoData = $maxmindReader->get($ip);
        if ($geoData && isset($geoData['country']['iso_code'])) {
            self::$country = $geoData['country']['iso_code'];
            return self::$country;
        }
        return null;
    }
    /**
     * Returns user OS language from HTTP_ACCEPT_LANGUAGE header
     *
     * @param array $SERVER
     * @return string
     */
    public static function getUserOSLanguage(array $SERVER): string
    {
        $lang = 'en';
        $langs = array();
        if (isset($SERVER['HTTP_ACCEPT_LANGUAGE'])) {
            // Break up string into pieces (languages and q factors)
            preg_match_all(
                '/([a-z]{1,8}(-[a-z]{1,8})?)\s*(;\s*q\s*=\s*(1|0\.[0-9]+))?/i',
                $SERVER['HTTP_ACCEPT_LANGUAGE'],
                $lang_parse
            );
            if (count($lang_parse[1])) {
                // Create a list like 'en' => 0.8
                $langs = array_combine($lang_parse[1], $lang_parse[4]);
                // Set default to 1 for any without q factor
                foreach ($langs as $lang => $val) {
                    if ($val === '') $langs[$lang] = 1;
                }
                // Sort list based on value
                arsort($langs, SORT_NUMERIC);
            }
        }
        // Extract most important (first)
        foreach ($langs as $lang => $val) { break; }
        // If complex language, simplify it
        if (stristr($lang, "-")) {
            $tmp = explode("-", $lang);
            $lang = $tmp[0];
        }
        return $lang;
    }
    
    /**
     * Returns referral link html code according language and view mode (mobile/desktop)
     *
     * @param PDO $dbh
     * @param string $lang
     * @param  string $mode
     * @return string|null
     */
    public static function getReferralLink(PDO $dbh, string $lang, string $mode): ?array
    {
        $stmt = $dbh->prepare(
            "SELECT link, content
            FROM referral_links 
            WHERE 
                lang = :lang 
                AND NOT deleted 
                AND (active_till IS NULL OR active_till > CURRENT_DATE)
                AND ((:mode = 'mobile' AND mobile) OR (:mode = 'desktop' AND desktop))
            ORDER BY random() LIMIT 1;"
        );
        $stmt->execute([':lang' => $lang, ':mode' => $mode]);
        return $stmt->fetch(PDO::FETCH_ASSOC) ?: null;
    }

    public static function getBooks(PDO $dbh, string $lang): array
    {
        $stmt = $dbh->prepare(
            "SELECT 
                referral_link,
	            picture_link,
	            title,
	            description
            FROM books 
            WHERE lang = :lang AND NOT deleted
            ORDER BY random();"
        );
        $stmt->execute([':lang' => $lang]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
    
    public static function getBook(PDO $dbh, string $lang, string $dbms): array
    {
        $stmt = $dbh->prepare(
            "SELECT 
                referral_link,
	            picture_link,
	            title,
	            description
            FROM books 
            WHERE 
                lang = :lang AND 
                (dbms = :dbms OR dbms IS NULL) AND
                NOT deleted
            ORDER BY random() LIMIT 1;"
        );
        $stmt->execute([':lang' => $lang, ':dbms' => $dbms]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}