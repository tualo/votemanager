Ext.define('Tualo.VoteManager.lazy.Setup', {
    extend: 'Ext.Container',
    requires: [
        'Tualo.VoteManager.lazy.controller.Setup',
        'Tualo.VoteManager.lazy.models.Setup'
    ],
    layout: 'fit',
    controller: 'vote_manager_setup',
    viewModel: {
        type: 'vote_manager_setup'
    },
    listeners: {
        boxReady: 'onReady'
    },
    items: [
    ]
});