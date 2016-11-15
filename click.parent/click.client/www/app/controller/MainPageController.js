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

    var sha512 = hex_sha512("hello");
    console.log(sha512);

    //Type of Device
    var deviceType = function () {
      if (Ext.device.Device.platform == "Android") {
        return 1;
      }
      else return 2;
    };

    //For Browser
    if (Ext.device.Device.$className == 'Ext.device.device.Simulator') {

      window.api.call({
        method: 'device.register.request',
        input : {
          phone_num  : '998909649098',
          device_info: 'iPhone OS 9_3_5 Version/9.0 232323232323',//device.model + ' ' + device.platform + ' ' + device.version,
          device_name: 'iPhone 9',//Ext.device.Device.Name, //TO CHECK
          device_type: 2,//deviceType(),
          datetime   : 1000000000,
          imei       : '232323232323'//device.uuid, //UUID IS NOT IMEI
        },

        scope: this,

        onSuccess: function (result) {
          console.log(result);
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }
      //For real phone
    else {
      window.api.call({
        method: 'device.register.request',
        input : {
          phone_num  : '998909649098',
          device_info: device.model + ' ' + device.platform + ' ' + device.version,
          device_name: Ext.device.Device.Name, //TO CHECK
          device_type: deviceType(),
          datetime   : Date.now(),
          imei       : device.uuid, //UUID IS NOT IMEI
        }
      });

    }
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