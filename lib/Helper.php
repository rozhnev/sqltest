<?php
class Helper
{
    /**
     * Normalizes text for <meta name="description">: plain text, 25–160 characters.
     * Longer text is cut at a word boundary with an ellipsis; shorter text is replaced by $fallback.
     */
    public static function metaDescription(?string $text, string $fallback = '', int $min = 25, int $max = 160): string
    {
        $text = html_entity_decode(strip_tags((string)$text), ENT_QUOTES | ENT_HTML5, 'UTF-8');
        $text = self::truncateText(trim(preg_replace('/\s+/u', ' ', $text)), $max);

        if (preg_match_all('/./us', $text) < $min && $fallback !== '') {
            return self::metaDescription($fallback, '', $min, $max);
        }

        return htmlspecialchars($text, ENT_QUOTES, 'UTF-8');
    }

    /**
     * Cuts text to at most $max characters at a word boundary, appending an ellipsis.
     */
    public static function truncateText(string $text, int $max): string
    {
        if (preg_match_all('/./us', $text) <= $max) {
            return $text;
        }
        if ($max < 2) {
            return '…';
        }
        preg_match('/^.{0,' . ($max - 1) . '}/us', $text, $m);
        $cut = $m[0];
        // Cut back to the last word boundary unless that drops more than half of the text
        if (preg_match('/^(.{' . intdiv($max, 2) . ',})\s\S*$/us', $cut, $w)) {
            $cut = $w[1];
        }
        return rtrim($cut, " \t,;:-–—.") . '…';
    }

    /**
     * Fills a description template with ##Name## placeholders so the text fits into $max characters.
     * The $shrinkable value (e.g. a question title) is the most specific part, so it is kept whole
     * when possible: first the template's last sentence (a generic call to action) is dropped,
     * and only then the $shrinkable value is shortened.
     */
    public static function fitDescription(string $template, array $vars, string $shrinkable, int $max = 160): string
    {
        $pairs = [];
        foreach ($vars as $name => $value) {
            $pairs["##{$name}##"] = trim(preg_replace('/\s+/u', ' ', (string)$value));
        }
        $length = fn(string $s): int => preg_match_all('/./us', $s);

        $text = strtr($template, $pairs);
        if ($length($text) <= $max) {
            return $text;
        }

        // Drop the last sentence when the template has more than one
        if (preg_match('/^(.+?[.!?。])\s*[^.!?。]+[.!?。]?$/us', $template, $m)) {
            $template = $m[1];
            $text = strtr($template, $pairs);
            if ($length($text) <= $max) {
                return $text;
            }
        }

        $key = "##{$shrinkable}##";
        $room = $max - $length(strtr($template, [$key => ''] + $pairs));
        $pairs[$key] = self::truncateText($pairs[$key] ?? '', max($room, 1));

        return strtr($template, $pairs);
    }

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
     * The site messages of a language (site_messages, falling back to 'en') with this month's
     * donations, in one query: the urgent banner and the donation goal widget of every page.
     *
     * @return array ['urgent_banner' => [enabled, version, background, text_color, html],
     *                'donation_goal' => [title, html, amount, received, progress]]
     */
    public static function getSiteMessages(PDO $dbh, string $lang): array
    {
        $stmt = $dbh->prepare(
            "SELECT m.*,
                (SELECT COALESCE(SUM(amount_usd), 0) FROM donations
                    WHERE donated_at >= date_trunc('month', CURRENT_DATE)) AS donations_received
            FROM site_messages m
            WHERE m.language IN (:lang, 'en')
            ORDER BY (m.language = :preferred) DESC
            LIMIT 1"
        );
        $stmt->execute([':lang' => $lang, ':preferred' => $lang]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC) ?: [];

        $amount = (float)($row['donation_goal_amount'] ?? 0);
        $received = (float)($row['donations_received'] ?? 0);
        return [
            'urgent_banner' => [
                'enabled'    => (bool)($row['urgent_banner_enabled'] ?? false),
                'version'    => (int)($row['urgent_banner_version'] ?? 0),
                'background' => (string)($row['urgent_banner_background'] ?? ''),
                'text_color' => (string)($row['urgent_banner_text_color'] ?? ''),
                'html'       => (string)($row['urgent_banner'] ?? ''),
            ],
            'donation_goal' => [
                'title'    => (string)($row['donation_goal_title'] ?? ''),
                'html'     => str_replace('##goal##', number_format($amount, 0, '.', ''), (string)($row['donation_goal'] ?? '')),
                'amount'   => $amount,
                'received' => $received,
                'progress' => $amount > 0 ? max(0, min(100, 100 * $received / $amount)) : 0,
            ],
        ];
    }

    /**
     * All rows of site_messages by language, for the admin page
     *
     * @return array<string, array> language => row
     */
    public static function getAllSiteMessages(PDO $dbh): array
    {
        $rows = [];
        foreach ($dbh->query("SELECT * FROM site_messages ORDER BY language")->fetchAll(PDO::FETCH_ASSOC) as $row) {
            $row['urgent_banner_enabled'] = (bool)$row['urgent_banner_enabled'];
            $rows[$row['language']] = $row;
        }
        return $rows;
    }

    /**
     * Save the admin page: the texts and banner settings of each language, and the donation goal
     * amount, which is the same for every language. One transaction.
     *
     * @param array<string, array> $messages language => [donation_goal_title, donation_goal, urgent_banner,
     *                                       urgent_banner_enabled, urgent_banner_version,
     *                                       urgent_banner_background, urgent_banner_text_color]
     */
    public static function saveSiteMessages(PDO $dbh, array $messages, float $donationGoalAmount): void
    {
        $stmt = $dbh->prepare(
            "INSERT INTO site_messages (language, donation_goal_title, donation_goal, donation_goal_amount,
                urgent_banner, urgent_banner_enabled, urgent_banner_version, urgent_banner_background,
                urgent_banner_text_color, updated_at)
            VALUES (:language, :donation_goal_title, :donation_goal, :donation_goal_amount,
                :urgent_banner, :urgent_banner_enabled, :urgent_banner_version, :urgent_banner_background,
                :urgent_banner_text_color, CURRENT_TIMESTAMP)
            ON CONFLICT (language) DO UPDATE SET
                donation_goal_title = EXCLUDED.donation_goal_title,
                donation_goal = EXCLUDED.donation_goal,
                donation_goal_amount = EXCLUDED.donation_goal_amount,
                urgent_banner = EXCLUDED.urgent_banner,
                urgent_banner_enabled = EXCLUDED.urgent_banner_enabled,
                urgent_banner_version = EXCLUDED.urgent_banner_version,
                urgent_banner_background = EXCLUDED.urgent_banner_background,
                urgent_banner_text_color = EXCLUDED.urgent_banner_text_color,
                updated_at = CURRENT_TIMESTAMP"
        );
        $dbh->beginTransaction();
        try {
            foreach ($messages as $language => $message) {
                $stmt->execute([
                    ':language'                 => (string)$language,
                    ':donation_goal_title'      => (string)($message['donation_goal_title'] ?? ''),
                    ':donation_goal'            => (string)($message['donation_goal'] ?? ''),
                    ':donation_goal_amount'     => $donationGoalAmount,
                    ':urgent_banner'            => (string)($message['urgent_banner'] ?? ''),
                    ':urgent_banner_enabled'    => !empty($message['urgent_banner_enabled']) ? 't' : 'f',
                    ':urgent_banner_version'    => max(1, (int)($message['urgent_banner_version'] ?? 1)),
                    ':urgent_banner_background' => (string)($message['urgent_banner_background'] ?? ''),
                    ':urgent_banner_text_color' => (string)($message['urgent_banner_text_color'] ?? ''),
                ]);
            }
            $dbh->commit();
        } catch (Throwable $error) {
            if ($dbh->inTransaction()) {
                $dbh->rollBack();
            }
            throw $error;
        }
    }
}