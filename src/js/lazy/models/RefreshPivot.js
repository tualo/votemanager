Ext.define('Tualo.VoteManager.lazy.models.RefreshPivot', {
    extend: 'Ext.app.ViewModel',
    alias: 'viewmodel.vote_manager_refreshpivot',
    data: {

    },
    formulas: {
        formtext: function (get) {

            return '<h2>Pivot</h2><p>Auffrischen der Pivot-Daten</p>';
        }
    },
    stores: {

    }
});