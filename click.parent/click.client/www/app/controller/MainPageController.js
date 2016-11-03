Ext.define('Click.controller.MainPageController', {
  extend: 'Click.controller.Base',

  launch: function () {
    window.interaction = {};
    Ext.fly('appLoadingIndicator').destroy();
    this.showView('ViewMainPage');
  },

  config: {
    refs:{
      view:'mainView',

      myPaymentButton: 'mainView button[action = myPay]',
      myCardsButton: 'mainView button[action = myCards]'
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
  }
});