<?php

namespace Tualo\Office\VoteManager;

use Tualo\Office\Basic\TualoApplication as App;

class Votemanager
{


    private static string $lastError = '';

    /**
     * Get the current state of the voting process.
     *
     * @return VotemanagerPhase The current voting state.
     */
    public static function getState(): VotemanagerPhase
    {

        $session = App::getSession();
        $db = $session->getDB();
        $value = $db->singleValue(
            'select phase from voting_state where id=1',
            [],
            'phase'
        );
        return $value ?: VotemanagerPhase::Unknown;
    }

    public static function setState(VotemanagerPhase $newstate): bool
    {
        try {
            $session = App::getSession();
            $db = $session->getDB();
            $db->execute(
                'update voting_state set phase={phase} where id=1',
                ['phase' => $newstate]
            );
            return true;
        } catch (\Exception $e) {
            self::$lastError = $e->getMessage();
            App::addError(self::$lastError);
            return false;
        }
    }

    public static function getLastError(): string
    {
        return self::$lastError;
    }

    public static function isAllowed(array $allowedPhases): bool
    {
        $currentPhase = self::getState();
        foreach ($allowedPhases as $phase) {
            if ($currentPhase === $phase) {
                return true;
            }
        }
        return false;
    }
}
