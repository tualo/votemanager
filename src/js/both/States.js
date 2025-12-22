Ext.Loader.setPath('Tualo.VoteManager.lazy', './jsvotemanager');

Ext.define('Tualo.routes.States', {
    statics: {
        load: async function () {
            return [
                {
                    name: 'votemanager/states',
                    path: '#votemanager/states'
                }
            ]
        }
    },
    url: 'votemanager/states',
    handler: {
        action: function () {
            Ext.getApplication().addView('Tualo.VoteManager.lazy.States');


        },
        before: function (action) {

            action.resume();

        }
    }
});
