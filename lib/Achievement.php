<?php

class Achievement
{
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

        imagefilledrectangle($im, 0, 0, $width, $height, $bg);

        // Card area.
        $pad = 64;
        imagefilledrectangle($im, $pad, $pad, $width - $pad, $height - $pad, $card);
        imagefilledrectangle($im, $pad, $pad, $width - $pad, $pad + 8, $accent);

        // Logo.
        $root = realpath(__DIR__ . '/..');
        $logoPath = $root ? ($root . '/favicons/android-chrome-512x512.png') : null;
        if ($logoPath && is_file($logoPath)) {
            $logo = @imagecreatefrompng($logoPath);
            if ($logo) {
                $logoTarget = 96;
                $logoX = $pad + 32;
                $logoY = $pad + 32;
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

        $title = (string)($data['achievement_title'] ?? '');
        $userName = (string)($data['share_user_name'] ?? '');
        $earnedAt = (string)($data['earned_at'] ?? '');

        $textX = $pad + 32;
        $contentTop = $pad + 160;
        $maxTextWidth = $width - ($pad * 2) - 64;

        if ($font) {
            // Title (wrap to max 2 lines).
            $titleFontSize = 48;
            $lines = self::wrapTextToWidth($title, $font, $titleFontSize, $maxTextWidth);
            $lines = array_slice($lines, 0, 2);
            $y = $contentTop;
            foreach ($lines as $line) {
                imagettftext($im, $titleFontSize, 0, $textX, $y, $text, $font, $line);
                $y += 58;
            }

            // Subtitle.
            $subFontSize = 28;
            $subY = $y + 20;
            $subtitle = $userName !== '' ? ($userName . ' • ' . $earnedAt) : $earnedAt;
            imagettftext($im, $subFontSize, 0, $textX, $subY, $muted, $font, $subtitle);

            // Footer branding.
            $brandFontSize = 22;
            imagettftext($im, $brandFontSize, 0, $textX, $height - $pad - 28, $muted, $font, 'SQLtest.online');
        } else {
            // Fallback: basic bitmap fonts.
            imagestring($im, 5, $textX, $contentTop - 30, $title, $text);
            imagestring($im, 4, $textX, $contentTop + 20, $userName . ' ' . $earnedAt, $muted);
            imagestring($im, 3, $textX, $height - $pad - 20, 'SQLtest.online', $muted);
        }

        imagepng($im);
        imagedestroy($im);
    }
}
