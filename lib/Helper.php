<?php
class Helper 
{
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
            "SELECT id, link, content
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

    /**
    * Updates the referral link statistics in the database.
    *
    * @param PDO $dbh The database connection.
    * @param int $id The ID of the referral link.
    * @return void
    */
    public static function updateReferralLinkStats(PDO $dbh, int $id): void
    {
        $stmt = $dbh->prepare(
            "INSERT INTO referral_link_stats (link_id, date, shows)
            VALUES (:link_id, CURRENT_DATE, 1) ON CONFLICT (link_id, date) DO UPDATE SET shows = shows + 1;"
        );
        $stmt->execute([':id' => $id]);
    }
    /**
     * Returns an array of books based on the specified language.
     *
     * @param PDO $dbh
     * @param string $lang
     * @return array
     */
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