Ext.define('Tualo.VoteManager.lazy.controller.RefreshPivot', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.vote_manager_refreshpivot',

    onReady: async function () {
        let me = this,
            view = me.getView(),
            vm = view.getViewModel(),
            data = await fetch('./onlinevote/state', {
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
            }).then((response) => { return response.json() });
        if (data.success) {

        }
        view.enable();
    },
    save: async function (btn) {
        let me = this,
            view = me.getView(),
            vm = view.getViewModel();
        view.disable();
        if (vm.get('stopdate') instanceof Date) vm.set('stopdate', Ext.util.Format.date(vm.get('stopdate'), 'Y-m-d'));
        if (vm.get('startdate') instanceof Date) vm.set('startdate', Ext.util.Format.date(vm.get('startdate'), 'Y-m-d'));
        if (vm.get('stoptime') instanceof Date) vm.set('stoptime', Ext.util.Format.date(vm.get('stoptime'), 'H:i:s'));
        if (vm.get('starttime') instanceof Date) vm.set('starttime', Ext.util.Format.date(vm.get('starttime'), 'H:i:s'));

        let o = await fetch('./votemanager/refreshpivot', {
            method: 'GET',
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            }
        }).then((response) => { return response.json() });
        if (o.success == false) {
            Ext.toast({
                html: o.msg,
                title: 'Fehler',
                align: 't',
                iconCls: 'fa fa-warning'
            });
        }

        view.enable();
    }

});