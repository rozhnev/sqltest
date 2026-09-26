<?php
/**
 * Thin client for the Lava.top public API (https://gate.lava.top/docs).
 * No business logic here: see Subscription. Not final, so tests can substitute a fake.
 */
class LavaClient
{
    private string $apiKey;
    private string $baseUrl;
    private int $timeoutSeconds;

    public function __construct(string $apiKey, string $baseUrl = 'https://gate.lava.top', int $timeoutSeconds = 15)
    {
        $this->apiKey = $apiKey;
        $this->baseUrl = rtrim($baseUrl, '/');
        $this->timeoutSeconds = $timeoutSeconds;
    }

    /**
     * Create a purchase contract (POST /api/v3/invoice)
     *
     * @param array $invoice Request body: email, offerId, currency, periodicity, paymentProvider, ...
     * @return array{id: string, paymentUrl: string}
     * @throws LavaApiException
     */
    public function createInvoice(array $invoice): array
    {
        $response = $this->request('POST', '/api/v3/invoice', [], $invoice);
        if (empty($response['id']) || empty($response['paymentUrl'])) {
            throw new LavaApiException('Lava invoice response has no id or paymentUrl', 0);
        }
        return ['id' => (string)$response['id'], 'paymentUrl' => (string)$response['paymentUrl']];
    }

    /**
     * Cancel a subscription (DELETE /api/v1/subscriptions)
     *
     * @param string $contractId The first (parent) contract id of the subscription
     * @param string $email Email of the buyer who owns the subscription
     * @throws LavaApiException
     */
    public function cancelSubscription(string $contractId, string $email): void
    {
        $this->request('DELETE', '/api/v1/subscriptions', ['contractId' => $contractId, 'email' => $email]);
    }

    /**
     * @return array Decoded JSON body (empty for 204)
     * @throws LavaApiException On a network error or a non-2xx response
     */
    protected function request(string $method, string $path, array $query = [], ?array $body = null): array
    {
        if ($this->apiKey === '') {
            throw new LavaApiException('LAVA_API_KEY is not configured', 0);
        }

        $url = $this->baseUrl . $path . ($query ? '?' . http_build_query($query) : '');
        $curl = curl_init($url);
        curl_setopt_array($curl, [
            CURLOPT_CUSTOMREQUEST  => $method,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_CONNECTTIMEOUT => 5,
            CURLOPT_TIMEOUT        => $this->timeoutSeconds,
            CURLOPT_HTTPHEADER     => ['X-Api-Key: ' . $this->apiKey, 'Accept: application/json', 'Content-Type: application/json'],
        ]);
        if ($body !== null) {
            curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($body));
        }

        $result = curl_exec($curl);
        $status = (int)curl_getinfo($curl, CURLINFO_RESPONSE_CODE);
        $curlError = curl_error($curl);
        curl_close($curl);

        if ($result === false) {
            throw new LavaApiException("Lava API {$method} {$path} failed: {$curlError}", 0);
        }
        $decoded = json_decode((string)$result, true);
        if ($status < 200 || $status >= 300) {
            $message = is_array($decoded) && isset($decoded['error']) ? (string)$decoded['error'] : substr((string)$result, 0, 500);
            throw new LavaApiException("Lava API {$method} {$path} returned {$status}: {$message}", $status);
        }
        return is_array($decoded) ? $decoded : [];
    }
}

class LavaApiException extends RuntimeException
{
}
