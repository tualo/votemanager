Ext.define('TualoOffice.routes.DS',{
    statics: {
        load: async function() {
            return [
                {
                    name: 'votemanager',
                    path: '#votemanager'
                }
            ]
        }
    }, 
    url: 'votemanager',
    handler: {
        action: function(type,tablename,id){
            /*
            type='views';
            let tablenamecase = tablename.toLocaleUpperCase().substring(0,1) + tablename.toLowerCase().slice(1);
            console.log('Tualo.DataSets.'+type+'.'+tablenamecase,arguments);
            let opt = {};
            if (typeof id!='undefined'){ 
                opt.loadId=id;
            }
            */
            Ext.getApplication().addView('Tualo.votemanager.Viewport');
        },
        before: function (type,tablename,xid,action) {
            action.resume();
        }
    }
});