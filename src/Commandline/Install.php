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

        'install/ddl/voting_state' => 'setup voting_state',
        'install/data/voting_state.data' => 'setup data voting_state',

        'install/ddl/system_settings' => 'setup system_settings',
        'install/ds/system_settings.ds' => 'setup ds system_settings',


        'install/ddl/system_settings_suggestion' => 'setup system_settings_suggestion',
        'install/ds/system_settings_suggestion.ds' => 'setup ds system_settings_suggestion',


        'install/ddl/system_settings_user_access' => 'setup system_settings_user_access',
        'install/ds/system_settings_user_access.ds' => 'setup ds system_settings_user_access',
        'install/data/system_settings_user_access.data' => 'setup data system_settings_user_access',


        'install/ddl/wzbruecklauffelder' => 'setup wzbruecklauffelder',
        'install/ds/wzbruecklauffelder.ds' => 'setup ds wzbruecklauffelder',

        /*
        'install/ddl/wm_sync_tables' => 'setup wm_sync_tables',
        'install/ds/wm_sync_tables.ds' => 'setup ds wm_sync_tables',
        'install/data/wm_sync_tables.data' => 'setup data wm_sync_tables',
        */
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

        'install/ddl/wahlberechtigte' => 'setup wahlberechtigte',
        'install/ds/wahlberechtigte.ds' => 'setup ds wahlberechtigte',

        'install/ddl/stimmzettel' => 'setup stimmzettel',
        'install/ds/stimmzettel.ds' => 'setup ds stimmzettel',

        'install/ddl/stimmzettelgruppen' => 'setup stimmzettelgruppen',
        'install/ds/stimmzettelgruppen.ds' => 'setup ds stimmzettelgruppen',


        'install/ddl/briefwahlstimmzettel' => 'setup briefwahlstimmzettel',
        'install/ddl/onlinestimmzettel' => 'setup onlinestimmzettel',


        'install/ddl/wm_tanboegen' => 'setup wm_tanboegen',
        'install/ds/wm_tanboegen.ds' => 'setup ds wm_tanboegen',

        'install/ddl/wm_tannummer' => 'setup wm_tannummer',
        'install/ds/wm_tannummer.ds' => 'setup ds wm_tannummer',


        'install/ddl/ruecklauffelder' => 'setup ruecklauffelder',
        'install/ds/ruecklauffelder.ds' => 'setup ds ruecklauffelder',
        'install/data/ruecklauffelder.data' => 'setup data ruecklauffelder',


        'install/ddl/wahlscheinstatus' => 'setup wahlscheinstatus',
        'install/ds/wahlscheinstatus.ds' => 'setup ds wahlscheinstatus',
        'install/data/wahlscheinstatus.data' => 'setup data wahlscheinstatus',


        'install/ddl/wahlscheinstatus_grund' => 'setup wahlscheinstatus_grund',
        'install/ds/wahlscheinstatus_grund.ds' => 'setup ds wahlscheinstatus_grund',
        'install/data/wahlscheinstatus_grund.data' => 'setup data wahlscheinstatus_grund',


        'install/ddl/stimmzettel_fusstexte' => 'setup stimmzettel_fusstexte',
        'install/ds/stimmzettel_fusstexte.ds' => 'setup ds stimmzettel_fusstexte',

        'install/ddl/stimmzettel_stimmzettel_fusstexte' => 'setup stimmzettel_stimmzettel_fusstexte',
        'install/ds/stimmzettel_stimmzettel_fusstexte.ds' => 'setup ds stimmzettel_stimmzettel_fusstexte',

        'install/proc/randomString' => 'setup randomString',



        'install/ddl/kandidaten_bilder_typen' => 'setup kandidaten_bilder_typen',
        'install/ds/kandidaten_bilder_typen.ds' => 'setup ds kandidaten_bilder_typen',
        'install/data/kandidaten_bilder_typen.data' => 'setup data kandidaten_bilder_typen',

        'install/ddl/kandidaten' => 'setup kandidaten',
        'install/ddl/kandidaten_bilder' => 'setup kandidaten_bilder',
        'install/ds/kandidaten_bilder.ds' => 'setup kandidaten_bilder.ds',

        'install/views/view_kandidaten_sitze_vergeben' => 'setup view_kandidaten_sitze_vergeben',
        'install/views/view_readtable_kandidaten' => 'setup view_readtable_kandidaten',
        'install/ds/kandidaten.ds' => 'setup ds kandidaten',

        'install/ddl/onlinekandidaten' => 'setup onlinekandidaten',
        'install/ddl/briefwahlkandidaten' => 'setup briefwahlkandidaten',
        'install/proc/proc_briefwahlkandidaten' => 'setup proc_briefwahlkandidaten',


        'install/ddl/counting.ddl' => 'setup counting.ddl',
        'install/ddl/counting.ddl.trigger' => 'setup counting.ddl.trigger',



        'install/ddl/wahlschein' => 'setup wahlschein',
        'install/ds/wahlschein.ds' => 'setup ds wahlschein',


        'install/ddl/wahlscheinstatus_offline_erlaubt' => 'setup wahlscheinstatus_offline_erlaubt',
        'install/ds/wahlscheinstatus_offline_erlaubt.ds' => 'setup ds wahlscheinstatus_offline_erlaubt',
        'install/data/wahlscheinstatus_offline_erlaubt.data' => 'setup data wahlscheinstatus_offline_erlaubt',

        'install/ddl/wahlscheinstatus_online_erlaubt' => 'setup wahlscheinstatus_online_erlaubt',
        'install/ds/wahlscheinstatus_online_erlaubt.ds' => 'setup ds wahlscheinstatus_online_erlaubt',
        'install/data/wahlscheinstatus_online_erlaubt.data' => 'setup data wahlscheinstatus_online_erlaubt',

        'install/ddl/wm_sync_tables' => 'setup wm_sync_tables',
        'install/ds/wm_sync_tables.ds' => 'setup ds wm_sync_tables',
        'install/data/wm_sync_tables.data' => 'setup data wm_sync_tables',


        'install/proc/canChangeValue' => 'setup canChangeValue',

        'install/ddl/ds_files' => 'setup ds_files',
        'install/ds/ds_files.ds' => 'setup ds ds_files',


        'install/ddl/ds_files_data' => 'setup ds_files_data',
        'install/ds/ds_files_data.ds' => 'setup ds ds_files_data',
    ];
}
