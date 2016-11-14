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
      openFooterButton: 'viewMain button[action = openFooter]',

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

      openFooterButton: {
        tap: 'openFooterTap'
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
    if (Ext.device.Device.$className == 'Ext.device.device.Simulator') {
      window.api.call({
        method: 'device.register.request',
        input : {
          "phone_num"  : "998909464133",
          "device_info": " iPhone OS 9_3_5 Version/9.0 232323232323",
          "device_name": "iPhone 9",
          "device_type": 2,
          "datetime"   : Date.now(),
          "imei"       : "232323232323"
        },

        scope: this,

        onSuccess: function (result) {
          this.comeOk(result);
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }
    else {

      var deviceType = function () {
        if (device.platform == "Android") {
          return 1;
        }
        else return 2;
      };

      window.api.call({
        method: 'device.register.request',
        input : {
          phone_num  : "WILL ENTERED",
          device_info: device.model + ' ' + device.platform + ' ' + device.version,
          device_name: Ext.device.Device.Name, //TO CHECK
          device_type: deviceType(),
          datetime   : Date.now(),
          imei       : device.uuid, //UUID IS NOT IMEI

        }
      });
      alert("Model: " + device.model + ' Platform: ' + device.platform + ' Version: ' + device.version + ' Manufacturer: ' + device.manufacturer);
      alert("Serial number: " + device.serial);
      alert("UUID: " + device.uuid);
      alert("Name: " + Ext.device.Device.name);

    }
  },

  comeOk: function (result) {
    console.log("Come OK");
    console.log(result);
  },

  myFinanceButtonTap: function () {
    console.log();
    window.api.call({
      method: 'device.register.requestTest',
      input : {
        "phone_num"  : "998909464133",
        "device_info": " iPhone OS 9_3_5 Version/9.0 232323232323",
        "device_name": "iPhone 9",
        "device_type": 2,
        "datetime"   : 127542442,
        "imei"       : "232323232323"
      },

      scope: this,

      onSuccess: function (result) {
        this.comeOk(result);
      },

      onFail: function (api_status, api_status_message, data) {
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    });
    //this.showView('ViewMyFinance');
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