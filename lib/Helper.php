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
}