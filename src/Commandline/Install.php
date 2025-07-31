<?php

namespace Tualo\Office\VoteManager\Commandline;

use Tualo\Office\Basic\ICommandline;
use Tualo\Office\Basic\CommandLineInstallSQL;

class Install extends CommandLineInstallSQL  implements ICommandline
{
    public static function getDir(): string
    {
        return dirname(__DIR__, 1);
    }
    public static $shortName  = 'votemanager';
    public static $files = [
        'install/ds_class' => 'setup ds_class',

        'install/ddl/wm_sync_tables' => 'setup wm_sync_tables',
        'install/ds/wm_sync_tables.ds' => 'setup ds wm_sync_tables',
        'install/data/wm_sync_tables.data' => 'setup data wm_sync_tables',


        'install/ddl/abgabetyp' => 'setup abgabetyp',
        'install/ds/abgabetyp.ds' => 'setup ds abgabetyp',
        'install/data/abgabetyp.data' => 'setup data abgabetyp',

        'install/ddl/wahltyp' => 'setup wahltyp',
        'install/ds/wahltyp.ds' => 'setup ds wahltyp',
        'install/data/wahltyp.data' => 'setup data wahltyp',

        'install/ddl/wahlgruppe' => 'setup wahlgruppe',
        'install/ds/wahlgruppe.ds' => 'setup ds wahlgruppe',

        'install/ddl/wahlbezirk' => 'setup wahlbezirk',
        'install/ds/wahlbezirk.ds' => 'setup ds wahlbezirk',


        'install/ddl/abgabetyp_offline_erlaubt' => 'setup abgabetyp_offline_erlaubt',
        'install/ds/abgabetyp_offline_erlaubt.ds' => 'setup ds abgabetyp_offline_erlaubt',
        'install/data/abgabetyp_offline_erlaubt.data' => 'setup data abgabetyp_offline_erlaubt',



        'install/ddl/stimmzettel' => 'setup stimmzettel',
        'install/ds/stimmzettel.ds' => 'setup ds stimmzettel',

        'install/ddl/stimmzettelgruppen' => 'setup stimmzettelgruppen',
        'install/ds/stimmzettelgruppen.ds' => 'setup ds stimmzettelgruppen',


    ];
}
