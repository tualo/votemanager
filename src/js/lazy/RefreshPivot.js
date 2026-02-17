Ext.define('Tualo.VoteManager.lazy.RefreshPivot', {
    extend: 'Ext.Container',
    requires: [
        'Tualo.VoteManager.lazy.controller.RefreshPivot',
        'Tualo.VoteManager.lazy.models.RefreshPivot'
    ],
    layout: 'fit',
    controller: 'vote_manager_refreshpivot',
    viewModel: {
        type: 'vote_manager_refreshpivot'
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
            }
        ],
        buttons: [
            {
                text: 'Auffrischen',
                handler: 'save'
            }
        ]
    }
    ]
}); 