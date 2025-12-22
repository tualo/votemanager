<?php

namespace Tualo\Office\VoteManager\Routes;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;

class State extends \Tualo\Office\Basic\RouteWrapper
{
    public static function scope(): string
    {
        return  'basic'; // 'votemanager.state';
    }

    public static function register()
    {
        BasicRoute::add('/votemanager/state', function () {
            App::contenttype('application/json');
            App::result('success', false);
            try {

                $session = App::get('session');
                $db = $session->getDB();
                App::result('phase', $db->singleValue('select phase from voting_state', [], 'phase'));


                App::result('success', true);
            } catch (\Exception $e) {
                App::result('msg', $e->getMessage());
            }
        }, ['get'], true, [], self::scope());

        BasicRoute::add('/votemanager/state', function () {
            App::contenttype('application/json');
            App::result('success', false);
            try {

                $session = App::get('session');
                $db = $session->getDB();
                $data = json_decode(file_get_contents('php://input'), true);
                $db->direct('update voting_state set phase={phase}', ['phase' => $data['phase']]);

                App::result('success', true);
            } catch (\Exception $e) {
                App::result('msg', $e->getMessage());
            }
        }, ['put'], true, [], self::scope());
    }
}
