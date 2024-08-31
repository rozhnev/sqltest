<?php
class Helper 
{
    public static function getReferralLink(PDO $dbh, string $lang): string
    {
        $stmt = $dbh->prepare(
            "SELECT referral_link AS referralLink 
            FROM referral_links 
            WHERE lang = :lang AND NOT deleted AND (active_till IS NULL OR active_till > CURRENT_DATE)
            ORDER BY random() LIMIT 1;"
        );
        $stmt->execute([':lang' => $lang]);
        return $stmt->fetchColumn(0);
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