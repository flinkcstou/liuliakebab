Ext.define('Click.controller.MyPaymentController', {
  extend: 'Click.controller.Base',

  config: {
    refs: {
      view        : 'viewMyPayment',
      backButton  : 'viewMyPayment button[action = back]',
    },

    control: {
      view:{
        show: 'onShow',
      },
      backButton: {
        tap: 'backButtonTap',
      }
    }
  },

  onShow: function() {

  },

  backButtonTap: function() {
    this.showView('ViewMainPage');
  }
});
