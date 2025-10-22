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


        'install/ddl/voting_states' => 'setup voting_states',
        'install/ds/voting_states.ds' => 'setup ds voting_states.ds',

        'install/ddl/voting_state' => 'setup voting_state',
        'install/data/voting_state.data' => 'setup data voting_state',

        'install/ddl/system_settings' => 'setup system_settings',
        'install/ds/system_settings.ds' => 'setup ds system_settings',

        'install/ddl/votemanager_setup' => 'setup votemanager_setup',
        'install/ds/votemanager_setup.ds' => 'setup ds votemanager_setup',


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
        'install/ds/briefwahlstimmzettel.ds' => 'ds briefwahlstimmzettel',
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

        'install/view/view_kandidaten_sitze_vergeben' => 'setup view_kandidaten_sitze_vergeben',
        'install/view/view_readtable_kandidaten' => 'setup view_readtable_kandidaten',

        'install/view/view_readtable_kandidaten_bilder' => 'setup view_readtable_kandidaten_bilder',
        'install/ds/kandidaten_bilder.ds' => 'setup kandidaten_bilder.ds',

        'install/ds/kandidaten.ds' => 'setup ds kandidaten',

        'install/ddl/onlinekandidaten' => 'setup onlinekandidaten',
        'install/ddl/briefwahlkandidaten' => 'setup briefwahlkandidaten',
        'install/proc/proc_briefwahlkandidaten' => 'setup proc_briefwahlkandidaten',


        'install/ddl/counting.ddl' => 'setup counting.ddl',
        'install/ddl/counting.ddl.trigger' => 'setup counting.ddl.trigger',



        'install/ddl/wahlschein_blocknumbers' => 'setup wahlschein_blocknumbers',
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

        // 'install/ds/wahlschein_blocknumbers.ds' => 'setup ds wahlschein_blocknumbers',

        'install/ddl/wahlberechtigte_anlage' => 'setup wahlberechtigte_anlage',
        'install/ddl/before_insert_wahlberechtigte_anlage' => 'setup before_insert_wahlberechtigte_anlage',
        'install/ds/wahlberechtigte_anlage.ds' => 'setup wahlberechtigte_anlage.ds',


        'install/view/view_kandidaten_stimmenanzahl' => 'setup view_kandidaten_stimmenanzahl',
        'install/ds/view_kandidaten_stimmenanzahl.ds' => 'setup ds view_kandidaten_stimmenanzahl',

        'install/view/view_protokoll_erwartet' => 'setup view_protokoll_erwartet',
        'install/ds/view_protokoll_erwartet.ds' => 'setup ds view_protokoll_erwartet',




        'install/ddl/wm_berichte' => 'setup wm_berichte',
        'install/ds/wm_berichte.ds' => 'setup ds wm_berichte',
        'install/data/wm_berichte.data' => 'setup data wm_berichte',
        'install/data/wm_berichte.pug' => 'setup data wm_berichte PUG ',
        'install/data/wm_berichte_header.pug' => 'setup data wm_berichte_header PUG ',
        'install/data/wm_berichte_abschlussbericht_gesamt.pug' => 'setup data wm_berichte_abschlussbericht_gesamt PUG ',


        'install/ds/view_wm_berichte_formats.ds' => 'setup ds',
        'install/ds/view_wm_berichte_page_orientations.ds' => 'setup ds view_wm_berichte_page_orientations',


        'install/ddl/ds_files_data' => 'setup ds_files_data',
        'install/ds/ds_files_data.ds' => 'setup ds ds_files_data',

        'install/ddl/ds_files' => 'setup ds_files',
        'install/ds/ds_files.ds' => 'setup ds ds_files',


        'install/ddl/wm_nachzaehlung_wahlschein_wahlscheinnummer' => 'setup wm_nachzaehlung_wahlschein_wahlscheinnummer',
        'install/ds/wm_nachzaehlung_wahlschein_wahlscheinnummer.ds' => 'setup ds wm_nachzaehlung_wahlschein_wahlscheinnummer',

        'install/ddl/wm_nachzaehlung_wahlschein_wahlberechtigte' => 'setup wm_nachzaehlung_wahlschein_wahlberechtigte',
        'install/ds/wm_nachzaehlung_wahlschein_wahlberechtigte.ds' => 'setup ds wm_nachzaehlung_wahlschein_wahlberechtigte',



        'install/view/view_wahlbeteiligung_base' => 'setup view_wahlbeteiligung_base',

        'install/proc/create_involvement_pivot' => 'setup create_involvement_pivot',


        'install/ddl/wahlbeteiligung_bericht' => 'setup wahlbeteiligung_bericht',
        'install/ds/wahlbeteiligung_bericht.ds' => 'setup ds wahlbeteiligung_bericht',
        'install/data/wahlbeteiligung_bericht.data' => 'setup data wahlbeteiligung_bericht',

        'install/ddl/wahlbeteiligung_bericht_abgabetyp' => 'setup wahlbeteiligung_bericht_abgabetyp',
        'install/ds/wahlbeteiligung_bericht_abgabetyp.ds' => 'setup ds wahlbeteiligung_bericht_abgabetyp',
        'install/data/wahlbeteiligung_bericht_abgabetyp.data' => 'setup data wahlbeteiligung_bericht_abgabetyp',

        'install/ddl/wahlbeteiligung_bericht_status' => 'setup wahlbeteiligung_bericht_status',
        'install/ds/wahlbeteiligung_bericht_status.ds' => 'setup ds wahlbeteiligung_bericht_status',
        'install/data/wahlbeteiligung_bericht_status.data' => 'setup data wahlbeteiligung_bericht_status',

        'install/ddl/wahlbeteiligung_bericht_formel' => 'setup wahlbeteiligung_bericht_formel',
        'install/ds/wahlbeteiligung_bericht_formel.ds' => 'setup ds wahlbeteiligung_bericht_formel',
        'install/data/wahlbeteiligung_bericht_formel.data' => 'setup data wahlbeteiligung_bericht_formel',



        'install/ddl/wahlbeteiligung_bericht_formel_nenner' => 'setup wahlbeteiligung_bericht_formel_nenner',
        'install/ds/wahlbeteiligung_bericht_formel_nenner.ds' => 'setup ds wahlbeteiligung_bericht_formel_nenner',
        'install/data/wahlbeteiligung_bericht_formel_nenner.data' => 'setup data wahlbeteiligung_bericht_formel_nenner',


        'install/ddl/wahlbeteiligung_bericht_formel_teiler' => 'setup wahlbeteiligung_bericht_formel_teiler',
        'install/ds/wahlbeteiligung_bericht_formel_teiler.ds' => 'setup ds wahlbeteiligung_bericht_formel_teiler',
        'install/data/wahlbeteiligung_bericht_formel_teiler.data' => 'setup data wahlbeteiligung_bericht_formel_teiler',


        'install/ddl/votemanager_setup_involvement_types' => 'setup votemanager_setup_involvement_types',
        'install/ds/votemanager_setup_involvement_types.ds' => 'setup ds votemanager_setup_involvement_types',

        'install/ddl/wahlzeichnungsberechtigter' => 'setup wahlzeichnungsberechtigter',
        'install/ds/wahlzeichnungsberechtigter.ds' => 'setup ds wahlzeichnungsberechtigter',

        'install/ddl/wm_wahlschein_register' => 'setup wm_wahlschein_register',


        'install/view/view_ruecklauffelder_columns' => 'setup view_ruecklauffelder_columns',
        'install/ds/view_ruecklauffelder_columns.ds' => 'setup ds view_ruecklauffelder_columns',




    ];
}
