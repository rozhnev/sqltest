<?php

class Achievement
{
    private static function getUiStrings(string $lang): array
    {
        $lang = strtolower($lang);
        if ($lang === 'ru') {
            return [
                'label' => 'Достижение получено',
                'earned' => 'Получено',
                'site' => 'SQLtest.online',
            ];
        }
        if ($lang === 'pt') {
            return [
                'label' => 'Conquista desbloqueada',
                'earned' => 'Conquistada em',
                'site' => 'SQLtest.online',
            ];
        }
        return [
            'label' => 'Achievement unlocked',
            'earned' => 'Earned on',
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

    public static function renderShareImage(array $data): void
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
        $pad = 64;
        imagefilledrectangle($im, $pad, $pad, $width - $pad, $height - $pad, $card);
        imagefilledrectangle($im, $pad, $pad, $width - $pad, $pad + 10, $accent);

        // Right-side accent panel to make the layout more "designed".
        $rightPanelW = 320;
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
                $logoTarget = 112;
                // Place into the right panel.
                $logoX = $width - $pad - $rightPanelW + 40;
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

        // Optional LinkedIn watermark (subtle) in the right panel.
        $linkedinPath = $root ? ($root . '/images/linkedin_logo.png') : null;
        if ($linkedinPath && is_file($linkedinPath)) {
            $li = @imagecreatefrompng($linkedinPath);
            if ($li) {
                $liTargetW = 160;
                $liTargetH = (int)round($liTargetW * (imagesy($li) / max(1, imagesx($li))));
                $liX = $width - $pad - $rightPanelW + 40;
                $liY = $height - $pad - 40 - $liTargetH;

                $tmp = imagecreatetruecolor($liTargetW, $liTargetH);
                imagealphablending($tmp, false);
                imagesavealpha($tmp, true);
                $transparent = imagecolorallocatealpha($tmp, 0, 0, 0, 127);
                imagefill($tmp, 0, 0, $transparent);

                imagecopyresampled($tmp, $li, 0, 0, 0, 0, $liTargetW, $liTargetH, imagesx($li), imagesy($li));

                // Merge with some transparency (GD treats 0 as fully transparent, 100 as opaque).
                imagecopymerge($im, $tmp, $liX, $liY, 0, 0, $liTargetW, $liTargetH, 35);

                imagedestroy($tmp);
                imagedestroy($li);
            }
        }

        $font = self::getShareCardFontPath();
        if (!$font || !function_exists('imagettftext') || !function_exists('imagettfbbox')) {
            $font = null;
        }

        $lang = (string)($data['lang'] ?? 'en');
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
            $titleFontSize = 52;
            $lines = self::wrapTextToWidth($title, $font, $titleFontSize, $maxTextWidth);
            $lines = array_slice($lines, 0, 2);
            $y = $contentTop + 70;
            foreach ($lines as $line) {
                imagettftext($im, $titleFontSize, 0, $textX, $y, $text, $font, $line);
                $y += 58;
            }

            // Subtitle.
            $subFontSize = 28;
            $subY = $y + 28;
            $subtitle = $userName !== '' ? ($userName . ' • ' . $ui['earned'] . ' ' . $earnedAt) : ($ui['earned'] . ' ' . $earnedAt);
            imagettftext($im, $subFontSize, 0, $textX, $subY, $muted, $font, $subtitle);

            // Footer branding.
            $brandFontSize = 22;
            imagettftext($im, $brandFontSize, 0, $textX, $height - $pad - 28, $muted, $font, $ui['site']);

            // Right panel text (white) for better contrast.
            $panelFontSize = 22;
            imagettftext(
                $im,
                $panelFontSize,
                0,
                $width - $pad - $rightPanelW + 40,
                $pad + 200,
                $white,
                $font,
                'Share on LinkedIn'
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
