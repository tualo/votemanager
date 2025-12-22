Ext.define('Tualo.VoteManager.lazy.models.States', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.vote_manager_states',
    data: {
        phase_name: 'Unbekannt',
        phase: 'setup_phase'
    },
    formulas: {
        formtext: function (get) {

            return ['<h2>Wahlstatus</h2>',
                '<p>Stellen Sie den aktuellen Status der Wahl ein.</p>',
                '<p>Derzeitiger Status: <b>', get('phase_name'), '</b></p>',


            ].join('');
        }
    },
    stores: {
        voting_states: {
            type: 'voting_states_store',
            autoLoad: true,
            listeners: {
                load: 'onLoad'
            }
        }
    }
});