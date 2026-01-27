<?php

class Achievement
{
    private $dbh;
    private $id;
    
    public function __construct(PDO $dbh, string $id)
    {
        $this->dbh  = $dbh;
        $this->id = $id;
    }


    public function getData(string $lang): ?array
    {
        $stmt = $this->dbh->prepare(
            "SELECT 
                ua.user_id,
                COALESCE(u.full_name, u.nickname, '') AS share_user_name,
                ua.earned_at::date AS earned_at,
                to_char((ua.earned_at AT TIME ZONE 'UTC'), 'YYYY-MM-DD\"T\"HH24:MI:SS\"Z\"') AS earned_at_iso,
                a.title AS achievement_type,
                al.title AS achievement_title
            FROM user_achievements ua
            JOIN users u ON u.id = ua.user_id
            JOIN achievements a ON a.id = ua.achievement_id AND NOT a.deleted
            JOIN achievements_localization al ON al.achievement_id = a.id AND al.language = :lang
            WHERE user_achievement_id = :user_achievement_id
            LIMIT 1"
        );
        $stmt->execute([
            ':lang' => $lang,
            ':user_achievement_id' => $this->id,
        ]);
        $data = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($data && 
            (
                $data['achievement_type'] === 'five_tasks_completed' || 
                $data['achievement_type'] === '100_tasks_done' || 
                $data['achievement_type'] === '200_tasks_done' || 
                $data['achievement_type'] === '300_tasks_done' || 
                $data['achievement_type'] === 'all_tasks_solved'
            )
        ) {
            $stmt = $this->dbh->prepare(
                "with d as (
                    select 
                        q.rate,  qrl.rate rate_title, row_number() over (partition by user_id order by solved_at asc) p
                    from user_questions uq 
                    join questions q on q.id = uq.question_id
                    join question_rates_localization qrl on q.rate = qrl.id and qrl.language = :lang
                    where user_id = :user_id and solved_at is not null
                ) 
                select rate, rate_title, count(*) from d where p <= :count group by rate, rate_title order by rate;"
            );
            $user_questions_count = [
                'five_tasks_completed' => 5, 
                '100_tasks_done' => 100, 
                '200_tasks_done' => 200, 
                '300_tasks_done' => 300, 
                'all_tasks_solved' => 9999
            ];
            $stmt->execute([
                ':lang' => $lang,
                ':user_id' => $data['user_id'],
                ':count' => $user_questions_count[$data['achievement_type']] ?? 9999,
            ]);
            $data['solved_tasks_rates'] = $stmt->fetchAll(PDO::FETCH_ASSOC);
        }

        return $data ?: null;
    }

    private static function getUiStrings(string $lang): array
    {
        $lang = strtolower($lang);
        if ($lang === 'ru') {
            return [
                'label' => 'Достижение получено',
                'earned' => 'Получено',
                'cta' => 'Прокачивай SQL каждый день',
                'site' => 'SQLtest.online',
            ];
        }
        if ($lang === 'pt') {
            return [
                'label' => 'Conquista desbloqueada',
                'earned' => 'Conquistada em',
                'cta' => 'Evolua seu SQL todos os dias',
                'site' => 'SQLtest.online',
            ];
        }
        return [
            'label' => 'Achievement unlocked',
            'earned' => 'Earned on',
            'cta' => 'Level up your SQL every day',
            'site' => 'SQLtest.online',
        ];
    }

    private static function formatEarnedAt(string $earnedAt, string $lang): string
    {
        $earnedAt = trim($earnedAt);
        if ($earnedAt === '') {
            return '';
        }

        try {
            $dt = new DateTime($earnedAt);
        } catch (Exception $e) {
            return $earnedAt;
        }

        $lang = strtolower($lang);
        if ($lang === 'ru') {
            return $dt->format('d.m.Y');
        }
        if ($lang === 'pt') {
            return $dt->format('d/m/Y');
        }
        return $dt->format('M j, Y');
    }

    private static function clamp(string $text, int $maxChars): string
    {
        $text = trim($text);
        if ($text === '') {
            return '';
        }
        if (function_exists('mb_strlen') && function_exists('mb_substr')) {
            if (mb_strlen($text, 'UTF-8') > $maxChars) {
                return rtrim(mb_substr($text, 0, $maxChars - 1, 'UTF-8')) . '…';
            }
            return $text;
        }
        if (strlen($text) > $maxChars) {
            return rtrim(substr($text, 0, $maxChars - 3)) . '...';
        }
        return $text;
    }

    private static function getShareCardFontPath(): ?string
    {
        $candidates = [
            '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf',
            '/usr/share/fonts/dejavu/DejaVuSans.ttf',
            '/usr/share/fonts/truetype/liberation/LiberationSans-Regular.ttf',
            '/System/Library/Fonts/Supplemental/Arial.ttf',
            '/Library/Fonts/Arial.ttf',
        ];

        foreach ($candidates as $path) {
            if (is_file($path) && is_readable($path)) {
                return $path;
            }
        }
        return null;
    }

    private static function wrapTextToWidth(string $text, string $fontPath, int $fontSize, int $maxWidth): array
    {
        if (!function_exists('imagettfbbox')) {
            $single = trim($text);
            return $single === '' ? [] : [$single];
        }

        $words = preg_split('/\s+/u', trim($text)) ?: [];
        $lines = [];
        $current = '';

        foreach ($words as $word) {
            $test = $current === '' ? $word : ($current . ' ' . $word);
            $box = imagettfbbox($fontSize, 0, $fontPath, $test);
            $width = $box ? (abs($box[2] - $box[0])) : 0;
            if ($width > $maxWidth && $current !== '') {
                $lines[] = $current;
                $current = $word;
            } else {
                $current = $test;
            }
        }

        if ($current !== '') {
            $lines[] = $current;
        }

        return $lines;
    }

    public function renderShareImage(array $data, string $lang): void
    {
        // Avoid fatals on hosts without GD: fall back to a static image.
        if (!function_exists('imagecreatetruecolor') || !function_exists('imagepng')) {
            header('Location: https://sqltest.online/favicons/android-chrome-512x512.png', true, 302);
            return;
        }

        header('Content-Type: image/png');
        header('Cache-Control: public, max-age=86400');

        $width = 1200;
        $height = 627;

        $im = imagecreatetruecolor($width, $height);
        imagealphablending($im, true);
        imagesavealpha($im, true);

        // Colors based on existing site palette.
        $bg = imagecolorallocate($im, 39, 62, 116);      // #273E74
        $card = imagecolorallocate($im, 238, 242, 252);  // #EEF2FC
        $text = imagecolorallocate($im, 23, 27, 35);     // #171B23
        $muted = imagecolorallocate($im, 72, 79, 88);    // #484F58
        $accent = imagecolorallocate($im, 255, 215, 0);  // #FFD700
        $white = imagecolorallocate($im, 255, 255, 255);

        imagefilledrectangle($im, 0, 0, $width, $height, $bg);

        // Card area.
        $pad = 36;
        imagefilledrectangle($im, $pad, $pad, $width - $pad, $height - $pad, $card);
        imagefilledrectangle($im, $pad, $pad, $width - $pad, $pad + 10, $accent);

        // Right-side accent panel to make the layout more "designed".
        $rightPanelW = 360;
        imagefilledrectangle(
            $im,
            $width - $pad - $rightPanelW,
            $pad + 10,
            $width - $pad,
            $height - $pad,
            $bg
        );

        // Logo (site icon).
        $root = realpath(__DIR__ . '/..');
        $logoPath = $root ? ($root . '/favicons/android-chrome-512x512.png') : null;
        if ($logoPath && is_file($logoPath)) {
            $logo = @imagecreatefrompng($logoPath);
            if ($logo) {
                $logoTarget = 196;
                // Place into the right panel.
                $logoX = $width - $pad - $rightPanelW + 24;
                $logoY = $pad + 40;
                imagecopyresampled(
                    $im,
                    $logo,
                    $logoX,
                    $logoY,
                    0,
                    0,
                    $logoTarget,
                    $logoTarget,
                    imagesx($logo),
                    imagesy($logo)
                );
                imagedestroy($logo);
            }
        }

        $font = self::getShareCardFontPath();
        if (!$font || !function_exists('imagettftext') || !function_exists('imagettfbbox')) {
            $font = null;
        }

        $ui = self::getUiStrings($lang);

        $title = self::clamp((string)($data['achievement_title'] ?? ''), 80);
        $userName = self::clamp((string)($data['share_user_name'] ?? ''), 40);
        $earnedAt = self::formatEarnedAt((string)($data['earned_at'] ?? ''), $lang);

        $textX = $pad + 56;
        $contentTop = $pad + 120;
        $maxTextWidth = $width - ($pad * 2) - $rightPanelW - 80;

        if ($font) {
            // Eyebrow label
            $labelFontSize = 24;
            imagettftext($im, $labelFontSize, 0, $textX, $contentTop, $muted, $font, $ui['label']);

            // Title (wrap to max 2 lines).
            $titleFontSize = 48;
            $lines = self::wrapTextToWidth($title, $font, $titleFontSize, $maxTextWidth);
            $lines = array_slice($lines, 0, 2);
            $y = $contentTop + 70;
            foreach ($lines as $line) {
                imagettftext($im, $titleFontSize, 0, $textX, $y, $text, $font, $line);
                $y += 72;
            }

            // Subtitle.
            $subFontSize = 24;
            $subY = $y + 28;
            imagettftext($im, $subFontSize, 0, $textX, $subY, $muted, $font, $userName);

            $subY = $subY + 32;
            imagettftext($im, 18, 0, $textX, $subY, $muted, $font, $ui['earned'] . ' ' . $earnedAt);

            if ((isset($data['solved_tasks_rates']) && !empty($data['solved_tasks_rates']))) {
                $barX = $textX;
                $barY = $subY + 40;
                $barHeight = 24;
                $barWidth = $maxTextWidth;

                $colors = [
                    1 => imagecolorallocate($im, 40, 167, 69),
                    2 => imagecolorallocate($im, 255, 193, 7),
                    3 => imagecolorallocate($im, 253, 126, 20),
                    4 => imagecolorallocate($im, 220, 53, 69),
                    5 => imagecolorallocate($im, 33, 37, 41),
                ];

                $currentX = $barX;
                $solvedTasksCount = array_sum(array_column($data['solved_tasks_rates'], 'count')); 
                foreach ($data['solved_tasks_rates'] as $r) {
                    $segmentWidth = ($r['count'] / $solvedTasksCount) * $barWidth;
                    $c = $colors[$r['rate']] ?? $muted;
                    imagefilledrectangle($im, (int)$currentX, $barY, (int)($currentX + $segmentWidth), $barY + $barHeight, $c);
                    $currentX += $segmentWidth;
                }

                $legendY = $barY + $barHeight + 35;
                $legendX = $barX;
                $legendFontSize = 11;
                $bulletSize = 12;
                foreach ($data['solved_tasks_rates'] as $r) {
                    $c = $colors[$r['rate']] ?? $muted;

                    // Draw colored bullet (circle)
                    imagefilledellipse($im, (int)$legendX + 6, (int)$legendY - 5, $bulletSize, $bulletSize, $c);

                    $lText = $r['rate_title'] . ': ' . $r['count'];
                    $box = imagettfbbox($legendFontSize, 0, $font, $lText);
                    $lWidth = $box ? abs($box[2] - $box[0]) : 50;

                    imagettftext($im, $legendFontSize, 0, (int)($legendX + 18), $legendY, $muted, $font, $lText);
                    $legendX += $lWidth + 45;
                }
            }

            // Footer branding.
            $brandFontSize = 22;
            imagettftext($im, $brandFontSize, 0, $textX, $height - $pad - 28, $muted, $font, $ui['site']);

            // Right panel text (white) for better contrast.
            $panelFontSize = 16;
            imagettftext(
                $im,
                $panelFontSize,
                0,
                $width - $pad - $rightPanelW + 20,
                $pad + 300,
                $white,
                $font,
                $ui['cta']
            );
        } else {
            // Fallback: basic bitmap fonts.
            imagestring($im, 4, $textX, $contentTop - 20, $ui['label'], $muted);
            imagestring($im, 5, $textX, $contentTop + 20, $title, $text);
            $subtitle = $userName !== '' ? ($userName . ' - ' . $ui['earned'] . ' ' . $earnedAt) : ($ui['earned'] . ' ' . $earnedAt);
            imagestring($im, 4, $textX, $contentTop + 60, $subtitle, $muted);
            imagestring($im, 3, $textX, $height - $pad - 20, $ui['site'], $muted);
        }

        imagepng($im);
        imagedestroy($im);
    }
}
