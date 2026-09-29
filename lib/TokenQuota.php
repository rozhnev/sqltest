<?php
/**
 * Per-user AI token budget (see LESSON_ASSISTANT_PLAN.md, Stage 2, and TOKEN_PURCHASE_PLAN.md).
 *
 * The balance is users.llm_tokens: set to LLM_FREE_TOKENS on registration,
 * increased by every paid token pack (TokenPurchase), and reduced by the actual
 * usage of every charged LLM call. Tokens never expire.
 */
class TokenQuota
{
    private PDO $dbh;
    private User $user;
    private array $env;

    /**
     * Balance read fresh from the DB, loaded lazily
     *
     * @var int|null
     */
    private ?int $balance = null;

    public function __construct(PDO $dbh, User $user, array $env)
    {
        $this->dbh  = $dbh;
        $this->user = $user;
        $this->env  = $env;
    }

    /**
     * Remaining tokens, never negative
     *
     * @return int
     */
    public function remaining(): int
    {
        return max(0, $this->load());
    }

    /**
     * Whether the balance is enough to start one more LLM call
     *
     * @return bool
     */
    public function canSpend(): bool
    {
        return $this->remaining() >= (int)($this->env['LLM_MIN_TOKENS_PER_REQUEST'] ?? 3000);
    }

    /**
     * Charge the actual usage of one LLM call and log it. Charges nothing when the
     * call reported no usage (failed before the provider billed anything).
     *
     * @param string $feature 'lesson_assistant' | 'free_answer'
     * @param int|null $refId Lesson id / question id
     * @param string $profile LLM profile name from config.php
     * @param array|null $usage LLM::getLastUsage() result
     * @return void
     */
    public function charge(string $feature, ?int $refId, string $profile, ?array $usage): void
    {
        $total = (int)($usage['total'] ?? 0);
        if ($total <= 0) {
            return;
        }

        $this->dbh->beginTransaction();
        try {
            // Atomic decrement: concurrent charges must not overwrite each other
            $stmt = $this->dbh->prepare("UPDATE users SET llm_tokens = llm_tokens - :total WHERE id = :user_id RETURNING llm_tokens");
            $stmt->execute([':total' => $total, ':user_id' => $this->user->getId()]);
            $balance = $stmt->fetchColumn();

            $stmt = $this->dbh->prepare("INSERT INTO llm_usage_log (user_id, feature, ref_id, llm_profile, prompt_tokens, completion_tokens)
                VALUES (:user_id, :feature, :ref_id, :llm_profile, :prompt_tokens, :completion_tokens)");
            $stmt->execute([
                ':user_id'           => $this->user->getId(),
                ':feature'           => $feature,
                ':ref_id'            => $refId,
                ':llm_profile'       => $profile,
                ':prompt_tokens'     => (int)($usage['prompt'] ?? 0),
                ':completion_tokens' => (int)($usage['completion'] ?? 0),
            ]);

            $this->dbh->commit();
        } catch (Throwable $error) {
            if ($this->dbh->inTransaction()) {
                $this->dbh->rollBack();
            }
            throw $error;
        }

        if ($this->balance !== null && $balance !== false) {
            $this->balance = (int)$balance;
        }
    }

    /**
     * Quota state for the UI
     *
     * @return array ['remaining' => int, 'remaining_text' => string, 'exhausted' => bool, 'low' => bool]
     */
    public function status(): array
    {
        return [
            'remaining'      => $this->remaining(),
            'remaining_text' => self::formatTokens($this->remaining()),
            'exhausted'      => !$this->canSpend(),
            // Time to offer a top-up (also true when exhausted)
            'low'            => $this->remaining() < (int)($this->env['LLM_LOW_BALANCE_TOKENS'] ?? 20000),
        ];
    }

    /**
     * Token count for display: digits grouped by thousands with a no-break space
     * (e.g. "1 000 000"), the same in every language
     */
    public static function formatTokens(int $tokens): string
    {
        return number_format($tokens, 0, '.', "\u{00A0}");
    }

    private function load(): int
    {
        if ($this->balance === null) {
            $stmt = $this->dbh->prepare("SELECT llm_tokens FROM users WHERE id = :user_id");
            $stmt->execute([':user_id' => $this->user->getId()]);
            $this->balance = (int)$stmt->fetchColumn();
        }
        return $this->balance;
    }
}
