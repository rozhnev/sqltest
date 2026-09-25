<?php
/**
 * Per-user AI token budget (see LESSON_ASSISTANT_PLAN.md, Stage 2).
 *
 * The balance is users.llm_tokens: set to LLM_FREE_TOKENS on registration,
 * reset to LLM_SUBSCRIBER_CYCLE_TOKENS on every subscription payment, and
 * reduced by the actual usage of every charged LLM call. Only percentages
 * leave this class via status(); raw token numbers stay internal.
 */
class TokenQuota
{
    private PDO $dbh;
    private User $user;
    private array $env;

    /**
     * Fresh users row: llm_tokens, subscribed_till, subscribed. Loaded lazily.
     *
     * @var array|null
     */
    private ?array $row = null;

    public function __construct(PDO $dbh, User $user, array $env)
    {
        $this->dbh  = $dbh;
        $this->user = $user;
        $this->env  = $env;
    }

    /**
     * Plan size, used only for the percentage display
     *
     * @return int
     */
    public function planSize(): int
    {
        return $this->load()['subscribed']
            ? (int)($this->env['LLM_SUBSCRIBER_CYCLE_TOKENS'] ?? 1000000)
            : (int)($this->env['LLM_FREE_TOKENS'] ?? 50000);
    }

    /**
     * Remaining tokens, never negative
     *
     * @return int
     */
    public function remaining(): int
    {
        return max(0, (int)$this->load()['llm_tokens']);
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

        if ($this->row !== null && $balance !== false) {
            $this->row['llm_tokens'] = (int)$balance;
        }
    }

    /**
     * Quota state for the UI: percentages and the reset date only, no raw token numbers
     *
     * @return array ['percent_used' => int, 'subscribed' => bool, 'resets_at' => ?string, 'exhausted' => bool]
     */
    public function status(): array
    {
        $row = $this->load();
        $planSize = $this->planSize();
        $percentUsed = $planSize > 0 ? 100 - (int)round(100 * $this->remaining() / $planSize) : 100;

        return [
            'percent_used' => max(0, min(100, $percentUsed)),
            'subscribed'   => $row['subscribed'],
            // subscribed_till is the next payment, when the balance is refreshed
            'resets_at'    => $row['subscribed'] ? $row['subscribed_till'] : null,
            'exhausted'    => !$this->canSpend(),
        ];
    }

    /**
     * Read the balance fresh from the DB and apply lazy subscription expiry:
     * an expired subscriber's leftover balance drops to 0.
     *
     * @return array
     */
    private function load(): array
    {
        if ($this->row !== null) {
            return $this->row;
        }

        $stmt = $this->dbh->prepare("SELECT llm_tokens, subscribed_till,
                (subscribed_till is not null and subscribed_till > current_date) subscribed,
                (subscribed_till is not null and subscribed_till <= current_date) expired
            FROM users WHERE id = :user_id");
        $stmt->execute([':user_id' => $this->user->getId()]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC) ?: ['llm_tokens' => 0, 'subscribed_till' => null, 'subscribed' => false, 'expired' => false];

        if ($row['expired'] && (int)$row['llm_tokens'] > 0) {
            // Conditions repeated in SQL so a grant made in between is not wiped out
            $stmt = $this->dbh->prepare("UPDATE users SET llm_tokens = 0
                WHERE id = :user_id AND subscribed_till <= current_date AND llm_tokens > 0");
            $stmt->execute([':user_id' => $this->user->getId()]);
            $row['llm_tokens'] = 0;
        }

        $this->row = [
            'llm_tokens'      => (int)$row['llm_tokens'],
            'subscribed_till' => $row['subscribed_till'],
            'subscribed'      => (bool)$row['subscribed'],
        ];
        return $this->row;
    }
}
