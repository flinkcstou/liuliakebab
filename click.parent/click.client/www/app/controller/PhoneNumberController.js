Ext.define('Click.controller.PhoneNumberController', {
  extend: 'Click.controller.Base',

  requires: ['Click.store.Api'],

  config: {
    refs: {
      view: 'viewPhoneNumber',

      nextButton : 'viewPhoneNumber button[action = next]',
      phoneNumber: 'viewPhoneNumber textfield[name = phoneNumberID]',
      deleteAll  : 'viewPhoneNumber button[action = delete]'
    },

    control: {
      view       : {
        show: 'onShow'
      },
      phoneNumber: {
        keyup: 'onPhoneNumberKeyUp'
      },
      nextButton : {
        tap: 'nextButtonTap'
      },
      deleteAll  : {
        tap: 'deleteAllButtonTap'
      }
    },
  },

  deleteAllButtonTap: function () {
    var userStore = Ext.getStore('UserStore');
    userStore.load();
    userStore.removeAll();
    console.log(userStore.getData().length);
    userStore.sync();
    console.log("Все НОМЕРА и АЙДИ удалены");
  },

  onPhoneNumberKeyUp: function () {
    console.log(this.getPhoneNumber().getValue());

    if (this.getPhoneNumber().getValue().length > 12) {
      alert("Phone number is incorrect");
      this.getNextButton().setDisabled(true);
    }
    if (this.getPhoneNumber().getValue().length == 12) {
      this.getNextButton().setDisabled(false);
    }
  },

  onShow: function () {

    this.getNextButton().setDisabled(true);

    var userStore = Ext.getStore('UserStore');
    userStore.load();


    if (userStore.getAt(0) != null) {
      var modelRecord = userStore.getAt(0).get('phoneNumber');
      console.log("Number is created " + modelRecord);
    }

  },

  nextButtonTap: function () {

    var userStore = Ext.getStore('UserStore');
    userStore.load();
    if (userStore.getAt(0) == null) {
      userStore.add({phoneNumber: this.getPhoneNumber().getValue()});
    }
    else {
      alert("Your device is registered");
    }
    userStore.sync();

    this.deviceRegisterRequest(this.getPhoneNumber().getValue());
  },

  deviceRegisterRequest: function (phoneNumber) {

    var sha512 = hex_sha512("hello");

    console.log(sha512);

    var date = parseInt(Date.now() / 1000);

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
          phone_num  : phoneNumber,
          device_info: 'iPhone OS 9_3_5 Version/9.0 232323232323',
          device_name: 'iPhone 9',
          device_type: deviceType(),
          datetime   : date,
          imei       : '232323232323'
        },

        scope: this,

        onSuccess: function (result) {

          if (result[0][0].success == 1) {
            var deviceId = result[1][0].device_id;

            var idTimeNumberSha512Token = hex_sha512(deviceId + date + phoneNumber);


            var userStore = Ext.getStore('UserStore');
            userStore.load();
            userStore.add({deviceId: deviceId});
            userStore.add({idTimeNumberToken: idTimeNumberSha512Token});
            userStore.sync();


            console.log("DEVICE ID \n" + userStore.getAt(1).get('deviceId'));
            console.log("TOKEN SHA512 \n" + userStore.getAt(2).get('idTimeNumberToken'));
          }
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
          phone_num  : phoneNumber,
          device_info: device.model + ' ' + device.platform + ' ' + device.version,
          device_name: Ext.device.Device.Name, //TO CHECK
          device_type: deviceType(),
          datetime   : date,
          imei       : device.uuid, //UUID IS NOT IMEI
        },

        scope: this,

        onSuccess: function (result) {

          if (result[0][0].success == 1) {
            var deviceId = result[1][0].device_id;

            var idTimeNumberSha512Token = hex_sha512(deviceId + date + phoneNumber);

            var userStore = Ext.getStore('UserStore');
            userStore.load();
            userStore.add({deviceId: deviceId});
            userStore.add({idTimeNumberToken: idTimeNumberSha512Token});
            userStore.sync();

          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

    }
  }
});