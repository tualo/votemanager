Ext.define('Tualo.VoteManager.lazy.ImageConverter', {
    extend: 'Ext.Container',
    requires: [
        'Tualo.VoteManager.lazy.controller.ImageConverter',
        'Tualo.VoteManager.lazy.models.ImageConverter'
    ],
    layout: 'fit',
    controller: 'vote_manager_imageconverter',
    viewModel: {
        type: 'vote_manager_imageconverter'
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
                xtype: 'progressbar',
                itemId: 'progressbar',
                disabled: true,
                text: ' '
            }


        ],
        buttons: [
            {
                text: 'Konvertierung starten',
                handler: 'startConversion'
            }
        ]
    }
    ]
});