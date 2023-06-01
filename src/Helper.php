<?php
namespace Tualo\Office\VoteManager;

use Tualo\Office\Basic\TualoApplication as App;

class Helper {
       
    public static function mainlist($data=null){
        $fname=App::get('tempPath').'/mainlist.json';
        if (!is_null($data)){
            file_put_contents($fname,json_encode($data));
        }
        if (!file_exists($fname)) return [];
        return json_decode(file_get_contents($fname),true);
    }
    

}
