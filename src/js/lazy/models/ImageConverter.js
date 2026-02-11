Ext.define('Tualo.VoteManager.lazy.models.ImageConverter', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.vote_manager_imageconverter',
    data: {

        wm_print_imagetype: 'jpg',
        wm_web_imagetype: 'webp',
        wm_convert_sourceid: '1',
        id: []
    },
    formulas: {
        formtext: function (get) {
            let count = get('id').length;
            return '<h2>Bild-Konvertierung</h2><p>Es sind ' + count + ' Kandidaten zum Konvertieren vorhanden.</p>';
        }
    },
    stores: {

    }
});