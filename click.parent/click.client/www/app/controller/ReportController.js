Ext.define('Click.controller.ReportController', {
  extend: 'Click.controller.Base',


  config: {
    refs: {
      view: 'viewReport',

      backButton: 'viewReport button[action=back]'
    },

    control: {
      view      : {
        show: 'onShow'
      },
      backButton: {
        tap: 'backButtonTap'
      }
    }
  },

  onShow: function () {

  },

  backButtonTap: function () {
    this.showView('ViewMainPage');
  }

});