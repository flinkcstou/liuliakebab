Ext.define('Click.controller.MainPageController', {
  extend: 'Click.controller.Base',

  launch: function () {
    window.interaction = {};
    Ext.fly('appLoadingIndicator').destroy();
    this.showView('ViewMainPage');
  },

  config: {
    refs:{
      view:'viewMain',

      myPaymentButton: 'viewMain button[action = myPay]',
      myCardsButton: 'viewMain button[action = myCards]',
      myFinanceButton: 'viewMain button[action = myFinance]',
      transferButton: 'viewMain button[action = transfer]',
      reportButton: 'viewMain button[action = report]',
    },
    control: {

      view: {
        show: 'onShow',
      },

      myPaymentButton: {
        tap: 'myPaymentButtonTap',
      },

      myCardsButton: {
        tap: 'myCardsButtonTap'
      },

      myFinanceButton: {
        tap: 'myFinanceButtonTap'
      },

      transferButton: {
        tap: 'transferButtonTap',
      },

      reportButton: {
        tap: 'reportButtonTap',
      }
    }

  },

  onShow: function(){

  },

  myPaymentButtonTap: function(){
    this.showView('ViewMyPayment');
  },

  myCardsButtonTap: function(){
    this.showView('ViewMyCards');
  },

  myFinanceButtonTap: function(){
    this.showView('ViewMyFinance');
  },

  transferButtonTap: function(){
    this.showView('ViewTransfer')
  },

  reportButtonTap: function(){
    this.showView('ViewReport')
  },

});