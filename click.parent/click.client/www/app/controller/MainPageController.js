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
});