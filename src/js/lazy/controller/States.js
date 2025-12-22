Ext.define('Tualo.VoteManager.lazy.controller.States', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.vote_manager_states',

    onReady: async function () {
        let me = this,
            view = me.getView(),
            vm = view.getViewModel(),
            phases = vm.getStore('voting_states'),
            data = await fetch('./votemanager/state', {
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
            }).then((response) => { return response.json() });
        if (data.success) {

            vm.set('phase', data.phase || 'setup_phase');
            vm.set('new_phase', data.phase || 'setup_phase');



            let phase = phases.findRecord('id', data.phase, 0, false, true, true)
            if (phase) {
                vm.set('phase_name', phase.get('name'));
            } else {
                vm.set('phase_name', data.phase);
            }

        }
        view.enable();
    },

    onLoad: function (store, records, successful, eOpts) {
        let me = this,
            view = me.getView();
        me.onReady();
        view.enable();
    },
    save: async function (btn) {
        let me = this,
            view = me.getView(),
            vm = view.getViewModel(),
            data = await fetch('./votemanager/state', {
                method: 'PUT',
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    phase: vm.get('new_phase')
                })
            }).then((response) => { return response.json() });

        if (!data.success) {
            Ext.Msg.alert('Fehler', data.msg || 'Unbekannter Fehler');
        }
        view.disable();
        me.onReady();
    }

});