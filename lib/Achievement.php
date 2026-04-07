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
        return [
            'label' => Localizer::translateString('achievement_share_card_label'),
            'earned' => Localizer::translateString('achievement_share_card_earned'),
            'cta' => Localizer::translateString('achievement_share_card_cta'),
            'site' => Localizer::translateString('achievement_share_card_site'),
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
            '/usr/share/fonts/liberation-fonts/LiberationSans-Regular.ttf',
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

    private static function fillVerticalGradient($image, int $width, int $height, array $startColor, array $endColor): void
    {
        for ($y = 0; $y < $height; $y++) {
            $ratio = $height > 1 ? ($y / ($height - 1)) : 0;
            $red = (int)round($startColor[0] + (($endColor[0] - $startColor[0]) * $ratio));
            $green = (int)round($startColor[1] + (($endColor[1] - $startColor[1]) * $ratio));
            $blue = (int)round($startColor[2] + (($endColor[2] - $startColor[2]) * $ratio));
            $color = imagecolorallocate($image, $red, $green, $blue);
            imageline($image, 0, $y, $width, $y, $color);
        }
    }

    private static function fillRoundedRectangle($image, int $x1, int $y1, int $x2, int $y2, int $radius, int $color): void
    {
        imagefilledrectangle($image, $x1 + $radius, $y1, $x2 - $radius, $y2, $color);
        imagefilledrectangle($image, $x1, $y1 + $radius, $x2, $y2 - $radius, $color);
        imagefilledellipse($image, $x1 + $radius, $y1 + $radius, $radius * 2, $radius * 2, $color);
        imagefilledellipse($image, $x2 - $radius, $y1 + $radius, $radius * 2, $radius * 2, $color);
        imagefilledellipse($image, $x1 + $radius, $y2 - $radius, $radius * 2, $radius * 2, $color);
        imagefilledellipse($image, $x2 - $radius, $y2 - $radius, $radius * 2, $radius * 2, $color);
    }

    private static function drawCenteredText($image, int $fontSize, int $centerX, int $baselineY, int $color, string $fontPath, string $text): void
    {
        $box = imagettfbbox($fontSize, 0, $fontPath, $text);
        if (!$box) {
            imagettftext($image, $fontSize, 0, $centerX, $baselineY, $color, $fontPath, $text);
            return;
        }

        $width = abs($box[2] - $box[0]);
        $x = (int)round($centerX - ($width / 2));
        imagettftext($image, $fontSize, 0, $x, $baselineY, $color, $fontPath, $text);
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

        self::fillVerticalGradient($im, $width, $height, [18, 30, 68], [43, 69, 131]);

        $paper = imagecolorallocate($im, 250, 247, 240);
        $paperInset = imagecolorallocate($im, 255, 252, 247);
        $text = imagecolorallocate($im, 27, 33, 49);
        $muted = imagecolorallocate($im, 97, 102, 115);
        $accent = imagecolorallocate($im, 210, 165, 63);
        $accentDark = imagecolorallocate($im, 132, 94, 24);
        $panel = imagecolorallocate($im, 32, 47, 92);
        $panelSoft = imagecolorallocate($im, 56, 79, 140);
        $white = imagecolorallocate($im, 255, 255, 255);
        $line = imagecolorallocate($im, 225, 214, 187);
        $shadow = imagecolorallocatealpha($im, 14, 21, 41, 110);

        $pad = 42;
        self::fillRoundedRectangle($im, $pad + 10, $pad + 18, $width - $pad + 8, $height - $pad + 18, 34, $shadow);
        self::fillRoundedRectangle($im, $pad, $pad, $width - $pad, $height - $pad, 34, $paper);
        self::fillRoundedRectangle($im, $pad + 18, $pad + 18, $width - $pad - 18, $height - $pad - 18, 28, $paperInset);

        imagerectangle($im, $pad + 24, $pad + 24, $width - $pad - 24, $height - $pad - 24, $line);
        imagerectangle($im, $pad + 34, $pad + 34, $width - $pad - 34, $height - $pad - 34, $line);

        $rightPanelW = 292;
        self::fillRoundedRectangle(
            $im,
            $width - $pad - $rightPanelW,
            $pad + 26,
            $width - $pad - 26,
            $height - $pad - 26,
            26,
            $panel
        );
        imagefilledellipse($im, $width - $pad - 70, $pad + 78, 150, 150, $panelSoft);
        imagefilledellipse($im, $width - $pad - 182, $height - $pad - 96, 180, 180, $panelSoft);

        // Logo (site icon).
        $root = realpath(__DIR__ . '/..');
        $logoPath = $root ? ($root . '/favicons/android-chrome-512x512.png') : null;
        if ($logoPath && is_file($logoPath)) {
            $logo = @imagecreatefrompng($logoPath);
            if ($logo) {
                $logoTarget = 140;
                $logoX = $width - $pad - $rightPanelW + 74;
                $logoY = $pad + 56;
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
        $achievementType = self::clamp((string)($data['achievement_type'] ?? ''), 32);

        $textX = $pad + 76;
        $contentTop = $pad + 110;
        $maxTextWidth = $width - ($pad * 2) - $rightPanelW - 130;

        if ($font) {
            $labelFontSize = 24;
            imagettftext($im, $labelFontSize, 0, $textX, $contentTop, $accentDark, $font, strtoupper($ui['label']));

            imageline($im, $textX, $contentTop + 18, $textX + 180, $contentTop + 18, $accent);

            $titleFontSize = 52;
            $lines = self::wrapTextToWidth($title, $font, $titleFontSize, $maxTextWidth);
            $lines = array_slice($lines, 0, 2);
            $y = $contentTop + 96;
            foreach ($lines as $line) {
                imagettftext($im, $titleFontSize, 0, $textX, $y, $text, $font, $line);
                $y += 72;
            }

            $recipientLabel = $lang === 'ru' ? 'SQL Explorer' : 'SQL Explorer';
            $recipientBoxTop = $y + 6;
            self::fillRoundedRectangle($im, $textX - 18, $recipientBoxTop, $textX + $maxTextWidth - 10, $recipientBoxTop + 116, 22, $paper);
            imagerectangle($im, $textX - 18, $recipientBoxTop, $textX + $maxTextWidth - 10, $recipientBoxTop + 116, $line);

            $subFontSize = 20;
            $subY = $recipientBoxTop + 36;
            imagettftext($im, $subFontSize, 0, $textX + 8, $subY, $muted, $font, $recipientLabel);

            $nameFontSize = 30;
            $nameY = $subY + 52;
            imagettftext($im, $nameFontSize, 0, $textX + 8, $nameY, $text, $font, $userName);

            $metaY = $recipientBoxTop + 158;
            imagettftext($im, 18, 0, $textX, $metaY, $muted, $font, $ui['earned'] . ' ' . $earnedAt);

            if ((isset($data['solved_tasks_rates']) && !empty($data['solved_tasks_rates']))) {
                $barX = $textX;
                $barY = $metaY + 34;
                $barHeight = 22;
                $barWidth = $maxTextWidth;

                self::fillRoundedRectangle($im, $barX, $barY, $barX + $barWidth, $barY + $barHeight, 11, $line);

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

                $legendY = $barY + $barHeight + 34;
                $legendX = $barX;
                $legendFontSize = 12;
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

            $brandFontSize = 20;
            imagettftext($im, $brandFontSize, 0, $textX, $height - $pad - 54, $accentDark, $font, $ui['site']);
            imagettftext($im, 15, 0, $textX, $height - $pad - 22, $muted, $font, 'sqltest.online');

            $sealX = $width - $pad - $rightPanelW - 48;
            $sealY = $height - $pad - 106;
            imagefilledellipse($im, $sealX, $sealY, 122, 122, $accent);
            imagefilledellipse($im, $sealX, $sealY, 92, 92, $paperInset);
            imagefilledellipse($im, $sealX, $sealY, 76, 76, $accent);
            self::drawCenteredText($im, 15, $sealX, $sealY - 6, $paperInset, $font, 'CERTIFIED');
            self::drawCenteredText($im, 13, $sealX, $sealY + 22, $paperInset, $font, 'SQL SKILLS');

            self::drawCenteredText($im, 17, $width - $pad - (int)($rightPanelW / 2) - 14, $pad + 238, $white, $font, strtoupper($ui['site']));
            $panelLines = self::wrapTextToWidth($ui['cta'], $font, 24, $rightPanelW - 70);
            $panelY = $pad + 330;
            foreach (array_slice($panelLines, 0, 3) as $panelLine) {
                self::drawCenteredText($im, 24, $width - $pad - (int)($rightPanelW / 2) - 14, $panelY, $white, $font, $panelLine);
                $panelY += 42;
            }

            if ($achievementType !== '') {
                self::fillRoundedRectangle($im, $width - $pad - $rightPanelW + 36, $height - $pad - 172, $width - $pad - 56, $height - $pad - 132, 18, $paperInset);
                self::drawCenteredText($im, 15, $width - $pad - (int)($rightPanelW / 2) - 10, $height - $pad - 145, $accentDark, $font, strtoupper(str_replace('_', ' ', $achievementType)));
            }
        } else {
            imagestring($im, 5, $textX, $contentTop - 8, $ui['label'], $accentDark);
            imagestring($im, 5, $textX, $contentTop + 42, $title, $text);
            imagestring($im, 5, $textX, $contentTop + 88, $userName, $text);
            imagestring($im, 4, $textX, $contentTop + 122, $ui['earned'] . ' ' . $earnedAt, $muted);
            imagestring($im, 4, $textX, $height - $pad - 28, $ui['site'], $accentDark);
        }

        imagepng($im);
        imagedestroy($im);
    }
}
