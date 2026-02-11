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
            vm.set('wm_print_pixel_width', data.wm_print_pixel_width || 800);
            vm.set('wm_web_pixel_width', data.wm_web_pixel_width || 300);
            vm.set('id', data.id);
        }
        view.enable();
    },

    startConversion: async function () {
        let me = this,
            view = me.getView(),
            vm = view.getViewModel(),
            progressbar = view.down('form').getComponent('progressbar');

        progressbar.updateProgress(vm.get('currentIndex') / vm.get('id').length, Math.round((vm.get('currentIndex') / vm.get('id').length) * 100) + '%');
        let res = await (await fetch('./votemanager/convert/' + vm.get('wm_print_imagetype') + '/' + vm.get('wm_convert_sourceid') + '/80/' + vm.get('wm_print_pixel_width') + '/' + vm.get('id')[vm.get('currentIndex')])).json();
        if (res.success) {
            res = await (await fetch('./votemanager/convert/' + vm.get('wm_web_imagetype') + '/' + vm.get('wm_convert_sourceid') + '/90/' + vm.get('wm_web_pixel_width') + '/' + vm.get('id')[vm.get('currentIndex')])).json();
            if (res.success) {
                vm.set('currentIndex', vm.get('currentIndex') + 1);
                if (vm.get('currentIndex') < vm.get('id').length) {
                    this.startConversion();
                } else {
                    Ext.Msg.alert('Erfolg', 'Die Konvertierung wurde abgeschlossen.');
                }
            } else {
                Ext.Msg.alert('Fehler', 'Die Konvertierung konnte nicht gestartet werden: ' + res.msg);
            }
        } else {
            Ext.Msg.alert('Fehler', 'Die Konvertierung konnte nicht gestartet werden: ' + res.msg);
        }
    }

});