<?php

namespace Tualo\Office\VoteManager;

use Tualo\Office\Basic\Middleware\Session;
use Tualo\Office\Basic\PostCheck;
use Tualo\Office\Basic\TualoApplication as App;


class TestDataDefinition  extends PostCheck {
    public static function test(array $config){
        // print_r($config);
        $tables = [
            /*
            'adressen'=>[
                'columns'=>[
                    'name'=>'varchar(255)'
                ]
            ],
            'ds'=>[],
            */
            'voters'=>[
                'columns'=>[
                    'stimmzettel'=>'varchar(10)'
                ]
            ]
        ];
        self::tableCheck('votemanager',$tables);
        /*
        $_SERVER['REQUEST_URI']='';
        $_SERVER['REQUEST_METHOD']='none';
        App::run();
        $session = App::get('session');
        $sessiondb = $session->db;
        $dbs = $sessiondb->direct('select username dbuser, password dbpass, id dbname, host dbhost, port dbport from macc_clients ');
        foreach($dbs as $db){
            $clientdb = $session->newDBByRow($db);
            try{ $clientdb->direct('explain voters'); }catch(\Exception $e){ 
                self::formatPrintLn(['red'],'TestDataDefinition test '.$db['dbname'].' failed ( table voters not found ) ');
                continue; 
            }
        }
        echo "TestDataDefinition test ".PHP_EOL;
        */
    }
}