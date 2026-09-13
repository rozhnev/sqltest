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
            "INSERT INTO referral_links_daily_stats (link_id, date, shows)
            VALUES (:link_id, CURRENT_DATE, 1) 
            ON CONFLICT (link_id, date) DO UPDATE SET shows = referral_links_daily_stats.shows + 1;"
        );
        $stmt->execute([':link_id' => $id]);
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

    public static function getDonations(PDO $dbh, int $limit = 5): array
    {
        $stmt = $dbh->prepare(
            "SELECT SUM(amount_usd) AS monthly_amount_usd 
            FROM donations 
            WHERE donated_at >= date_trunc('month', CURRENT_DATE);"
        );
        
        $monthly_amount_usd = $stmt->execute() ? (float) $stmt->fetchColumn() : 0.0;

        $stmt = $dbh->prepare(
            "SELECT
                d.donated_at,
                d.amount,
                d.currency,
                d.amount_usd,
                d.notes,
                COALESCE(NULLIF(TRIM(u.nickname), ''), 'Anonymous') AS donor_name
                FROM donations d
                LEFT JOIN users u ON u.id = d.user_id
                ORDER BY d.donated_at DESC NULLS LAST, d.id DESC
                LIMIT :limit"
        );
        $stmt->execute([':limit' => $limit]);
        $donations = $stmt->fetchAll(PDO::FETCH_ASSOC);
        return ['monthly_amount_usd' => $monthly_amount_usd, 'donations' => $donations];
    }

    /**
     * Fetches the singleton urgent banner row.
     * Returns a disabled/empty banner if the row does not exist yet.
     */
    public static function getUrgentBanner(PDO $dbh): array
    {
        $stmt = $dbh->query("SELECT enabled, version, background, text_color, messages FROM urgent_banner WHERE id = 1");
        $row = $stmt ? $stmt->fetch(PDO::FETCH_ASSOC) : false;

        if (!$row) {
            return [
                'enabled' => false,
                'version' => 0,
                'background' => '',
                'text_color' => '',
                'messages' => [],
            ];
        }

        return [
            'enabled' => (bool)$row['enabled'],
            'version' => (int)$row['version'],
            'background' => (string)$row['background'],
            'text_color' => (string)$row['text_color'],
            'messages' => json_decode($row['messages'], true) ?: [],
        ];
    }

    /**
     * Saves the singleton urgent banner row (creates it if missing).
     */
    public static function saveUrgentBanner(PDO $dbh, array $data): void
    {
        $stmt = $dbh->prepare(
            "INSERT INTO urgent_banner (id, enabled, version, background, text_color, messages, updated_at)
            VALUES (1, :enabled, :version, :background, :text_color, :messages, CURRENT_TIMESTAMP)
            ON CONFLICT (id) DO UPDATE SET
                enabled = EXCLUDED.enabled,
                version = EXCLUDED.version,
                background = EXCLUDED.background,
                text_color = EXCLUDED.text_color,
                messages = EXCLUDED.messages,
                updated_at = CURRENT_TIMESTAMP"
        );
        $stmt->execute([
            ':enabled' => $data['enabled'] ? 't' : 'f',
            ':version' => (int)$data['version'],
            ':background' => (string)$data['background'],
            ':text_color' => (string)$data['text_color'],
            ':messages' => json_encode($data['messages'], JSON_UNESCAPED_UNICODE),
        ]);
    }
}