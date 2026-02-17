<?php

namespace Tualo\Office\VoteManager\Routes;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Route as BasicRoute;
use Tualo\Office\Basic\IRoute;

class RefreshPivot extends \Tualo\Office\Basic\RouteWrapper
{

    public static function scope(): string
    {
        return  'votemanager.refreshpivot'; // 'votemanager.state';
    }

    public static function register()
    {
        BasicRoute::add('/votemanager/refreshpivot', function () {
            App::contenttype('application/json');
            App::result('success', false);
            try {

                $session = App::get('session');
                $db = $session->getDB();

                $db->execute('call create_involvement_datatable()');
                $db->execute("call create_involvement_pivot(   'view_wahlbeteiligung_base',     'use_name,use_id',     'top_col_id',      'sum_helper',     '',      '' )");

                App::result('success', true);
            } catch (\Exception $e) {
                App::result('msg', $e->getMessage());
            }
        }, ['get'], true, [], self::scope());
    }
}
