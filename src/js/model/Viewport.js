Ext.define('Tualo.votemanager.models.Viewport', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.votemanager',
    data:{
        currentWMState: 'unkown'
    },
    stores: {
        pgpkeys: {
            type: 'pgpkeys_store',
            autoLoad: true
        }
    }
});