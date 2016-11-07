Ext.define('Click.controller.AutoPayController', {
  extend: 'Click.controller.Base',


  config: {
    refs: {
      view: 'viewAutoPay',

      backButton: 'viewAutoPay button[action=back]'
    },

    control: {
      view: {
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