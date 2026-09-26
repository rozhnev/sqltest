<?php
/**
 * Plain-text email through the site's SMTP settings (same configuration as the
 * password reset and prize emails in User).
 */
class Mailer
{
    public static function sendText(array $env, string $to, string $subject, string $text): bool
    {
        if ($to === '') {
            return false;
        }
        if (!class_exists('PHPMailer\\PHPMailer\\PHPMailer')) {
            error_log('Email failed: PHPMailer is not installed');
            return false;
        }

        try {
            $mail = new \PHPMailer\PHPMailer\PHPMailer(true);
            $mail->isSMTP();
            $mail->Host = $env['SMTP_HOST'] ?? 'localhost';
            $mail->Username = $env['SMTP_USER'] ?? '';
            $mail->Password = $env['SMTP_PASS'] ?? '';
            $mail->SMTPAuth = $mail->Username !== '' || $mail->Password !== '';
            $mail->Port = (int)($env['SMTP_PORT'] ?? 587);
            if ($mail->Port === 587) {
                $mail->SMTPSecure = \PHPMailer\PHPMailer\PHPMailer::ENCRYPTION_STARTTLS;
            } elseif ($mail->Port === 465) {
                $mail->SMTPSecure = \PHPMailer\PHPMailer\PHPMailer::ENCRYPTION_SMTPS;
            }
            $mail->setFrom($env['SMTP_FROM'] ?? 'support@sqltest.online', $env['SMTP_FROM_NAME'] ?? 'SQLTest.online');
            $mail->addAddress($to);
            $mail->CharSet = 'UTF-8';
            $mail->Subject = $subject;
            $mail->Body = $text;
            return $mail->send();
        } catch (Throwable $error) {
            error_log('Email failed: ' . $error->getMessage());
            return false;
        }
    }
}
