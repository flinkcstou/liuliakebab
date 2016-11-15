Ext.define('Click.controller.MainPageController', {
  extend: 'Click.controller.Base',

  requires: [
    'Click.store.Api',
  ],

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

    window.api = Click.store.Api.create();

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
      phoneNumberButton: 'viewMain button[action = inputPhoneNumber]',

      carousel: 'viewMain carousel[name=main]',

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

      phoneNumberButton: {
        tap: 'phoneNumberTap'
      }
    }

  },

  onShow: function () {

  },

  myPaymentButtonTap: function () {
    var c = this.getCarousel();
    console.log(c);

    var i = Ext.create('Click.component.CarouselElement', {
      sum: 10,
    });

    c.add(i);
  },

  autoPayButtonTap: function () {

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

  phoneNumberTap: function () {
    this.showView('ViewPhoneNumber');
  }

});