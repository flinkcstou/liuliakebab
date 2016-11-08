Ext.define('Click.controller.MainPageController', {
  extend: 'Click.controller.Base',

  launch: function () {
    window.interaction = {};

    var me = this;

    if (window.cordova) {
      document.addEventListener("deviceready", function () {
        me.runApplication();
      }, false);
    } else {
      me.runApplication();
    }

  },

  runApplication: function () {
    Ext.fly('appLoadingIndicator').destroy();

    this.showView('ViewMainPage');
  },

  config: {
    refs   : {
      view: 'viewMain',

      myPaymentButton : 'viewMain button[action = myPay]',
      autoPayButton   : 'viewMain button[action = autoPay]',
      myFinanceButton : 'viewMain button[action = myFinance]',
      transferButton  : 'viewMain button[action = transfer]',
      reportButton    : 'viewMain button[action = report]',
      openFooterButton: 'viewMain button[action = openFooter]'
    },
    control: {

      view: {
        show: 'onShow'
      },

      myPaymentButton: {
        tap: 'myPaymentButtonTap'
      },

      autoPayButton: {
        tap: 'autoPayButtonTap'
      },

      myFinanceButton: {
        tap: 'myFinanceButtonTap'
      },

      transferButton: {
        tap: 'transferButtonTap'
      },

      reportButton: {
        tap: 'reportButtonTap'
      },

      openFooterButton: {
        tap: 'openFooterTap'
      }
    }

  },

  onShow: function () {

  },

  myPaymentButtonTap: function () {
    this.showView('ViewMyPayment');
  },

  autoPayButtonTap: function () {
    this.showView('ViewAutoPay');
  },

  myFinanceButtonTap: function () {
    this.showView('ViewMyFinance');
  },

  transferButtonTap: function () {
    this.showView('ViewTransfer')
  },

  reportButtonTap: function () {
    this.showView('ViewReport')
  },

  openFooterTap: function () {
    this.showView('TestFooter');
  }

});