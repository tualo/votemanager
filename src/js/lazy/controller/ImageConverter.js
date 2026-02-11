Ext.define('Tualo.VoteManager.lazy.controller.ImageConverter', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.vote_manager_imageconverter',

    onReady: async function () {
        let me = this,
            view = me.getView(),
            vm = view.getViewModel(),
            data = await fetch('./votemanager/convertsetup', {
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
            }).then((response) => { return response.json() });
        if (data.success) {
            vm.set('wm_print_imagetype', data.wm_print_imagetype || 'jpg');
            vm.set('wm_web_imagetype', data.wm_web_imagetype || 'webp');
            vm.set('wm_convert_sourceid', data.wm_convert_sourceid || '1');
            vm.set('id', data.id);
        }
        view.enable();
    },

    startConversion: async function () {
        let me = this,
            progressbar = me.getComponent('form').getComponent('progressbar');

        progressbar.reset();
        progressbar.updateProgress(1);
        progressbar.updateText(' ');

        /*let me = this,
            view = me.getView(),
            vm = view.getViewModel(),
            data = await fetch('./votemanager/convertstart', {
                method: 'POST',
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    wm_print_imagetype: vm.get('wm_print_imagetype'),
                    wm_web_imagetype: vm.get('wm_web_imagetype'),
                    wm_convert_sourceid: vm.get('wm_convert_sourceid'),
                })
            }).then((response) => { return response.json() });
        if (data.success) {
            Ext.Msg.alert('Erfolg', 'Die Konvertierung wurde gestartet. Bitte warten Sie, bis alle Bilder konvertiert wurden.');
        } else {
            Ext.Msg.alert('Fehler', 'Die Konvertierung konnte nicht gestartet werden: ' + data.msg);
        }
        */
    }

});