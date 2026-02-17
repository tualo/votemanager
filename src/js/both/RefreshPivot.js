Ext.Loader.setPath('Tualo.VoteManager.lazy', './jsvotemanager');

Ext.define('Tualo.routes.RefreshPivot', {
    statics: {
        load: async function () {
            return [
                {
                    name: 'votemanager/refreshpivot',
                    path: '#votemanager/refreshpivot'
                }
            ]
        }
    },
    url: 'votemanager/refreshpivot',
    handler: {
        action: function () {
            Ext.getApplication().addView('Tualo.VoteManager.lazy.RefreshPivot');


        },
        before: function (action) {

            action.resume();

        }
    }
});
