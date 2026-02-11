Ext.Loader.setPath('Tualo.VoteManager.lazy', './jsvotemanager');

Ext.define('Tualo.routes.Converter', {
    statics: {
        load: async function () {
            return [
                {
                    name: 'votemanager/imageconverter',
                    path: '#votemanager/imageconverter'
                }
            ]
        }
    },
    url: 'votemanager/imageconverter',
    handler: {
        action: function () {
            Ext.getApplication().addView('Tualo.VoteManager.lazy.ImageConverter');


        },
        before: function (action) {

            action.resume();

        }
    }
});
