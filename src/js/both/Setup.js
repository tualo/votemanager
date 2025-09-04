Ext.Loader.setPath('Tualo.VoteManager.lazy', './jsvotemanager');

Ext.define('Tualo.routes.Setup', {
    statics: {
        load: async function () {
            return [
                {
                    name: 'votemanager/setup',
                    path: '#votemanager/setup'
                }
            ]
        }
    },
    url: 'votemanager/setup',
    handler: {
        action: function () {
            Ext.getApplication().addView('Tualo.VoteManager.lazy.Setup');


        },
        before: function (action) {

            action.resume();

        }
    }
});
