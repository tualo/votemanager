Ext.define('Tualo.VoteManager.lazy.States', {
    extend: 'Ext.Container',
    requires: [
        'Tualo.VoteManager.lazy.controller.States',
        'Tualo.VoteManager.lazy.models.States'
    ],
    layout: 'fit',
    controller: 'vote_manager_states',
    viewModel: {
        type: 'vote_manager_states'
    },
    listeners: {
        boxReady: 'onReady'
    },
    items: [{
        xtype: 'form',
        shadow: 'true',
        bodyPadding: 15,
        defaults: {
            anchor: '100%',
            labelWidth: 120
        },
        items: [
            {
                xtype: 'panel',
                bind: {
                    html: '{formtext}'
                }
            },
            {
                xtype: 'combobox',
                fieldLabel: 'Wahlphase',
                displayField: 'name',
                valueField: 'id',
                queryMode: 'local',
                bind: {
                    store: '{voting_states}',
                    value: '{new_phase}'
                }
            },


        ],
        buttons: [
            {
                text: 'Speichern',
                handler: 'save'
            }
        ]
    }
    ]
});