<?php
class Helper 
{
    /**
     * Returns referral link html code according language and view mode (mobile/desktop)
     *
     * @param PDO $dbh
     * @param string $lang
     * @param  string $mode
     * @return string|null
     */
    public static function getReferralLink(PDO $dbh, string $lang, string $mode): string
    {
        $stmt = $dbh->prepare(
            "SELECT referral_link AS referralLink 
            FROM referral_links 
            WHERE 
                lang = :lang 
                AND NOT deleted 
                AND (active_till IS NULL OR active_till > CURRENT_DATE)
                AND ((:mode = 'mobile' AND mobile) OR (:mode = 'desktop' AND desktop))
            ORDER BY random() LIMIT 1;"
        );
        $stmt->execute([':lang' => $lang, ':mode' => $mode]);
        return $stmt->fetchColumn(0) ?: null;
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