Ext.define('Click.controller.PhoneNumberController', {
  extend: 'Click.controller.Base',

  requires: ['Click.store.Api'],

  config: {
    refs: {
      view: 'viewPhoneNumber',

      nextButton      : 'viewPhoneNumber button[action = next]',
      phoneNumber     : 'viewPhoneNumber textfield[name = phoneNumberID]',
      deleteAll       : 'viewPhoneNumber button[action = delete]',
      smsField        : 'viewPhoneNumber textfield[name = smsField]',
      confirmSmsButton: 'viewPhoneNumber button[action = confirmSms]',
      resendSmsButton : 'viewPhoneNumber button[action = resendSms]'
    },

    control: {
      view            : {
        show: 'onShow'
      },
      phoneNumber     : {
        keyup: 'onPhoneNumberKeyUp'
      },
      nextButton      : {
        tap: 'nextButtonTap'
      },
      deleteAll       : {
        tap: 'deleteAllButtonTap'
      },
      confirmSmsButton: {
        tap: 'confirmSmsButtonTap'
      },
      resendSmsButton : {
        tap: 'resendSmsButtonTap'
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
    this.getResendSmsButton().hide();
    this.getSmsField().hide();
    this.getConfirmSmsButton().hide();
    this.getNextButton().setDisabled(true);

    var userStore = Ext.getStore('UserStore');
    userStore.load();
    console.log("LENGTH " + userStore.getData().length);


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

    this.getSmsField().show();
    this.getConfirmSmsButton().show();
    this.getResendSmsButton().show();


  },

  deviceInfo: function () {
    if (Ext.device.Device.$className == 'Ext.device.device.Simulator')
      return 'iPhone OS 9_3_5 Version/9.0 232323232323';

    return (device.model + ' ' + device.platform + ' ' + device.version);

  },

  deviceName: function () {
    if (Ext.device.Device.$className == 'Ext.device.device.Simulator')
      return 'Simulator';

    return Ext.device.Device.Name;
  },

  deviceImei: function () {
    if (Ext.device.Device.$className == 'Ext.device.device.Simulator')
      return '232323232323';

    return device.uuid;
  },

  deviceType:function(){
      if (Ext.device.Device.platform == "Android")
        return 1;

    return 2;
  },

  deviceRegisterRequest: function (phoneNumber) {

    var sha512 = hex_sha512("hello");

    console.log(sha512);

    var date = parseInt(Date.now() / 1000);


    window.api.call({
      method: 'device.register.request',
      input : {
        phone_num  : phoneNumber,
        device_info: this.deviceInfo(),
        device_name: this.deviceName(),
        device_type: this.deviceType(),
        datetime   : date,
        imei       : this.deviceImei()
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


  },

  confirmSmsButtonTap: function () {
    this.deviceRegisterConfirm();
  },

  deviceRegisterConfirm: function () {

    var userStore = Ext.getStore('UserStore');
    userStore.load();

    window.api.call({
      method: 'device.register.confirm',
      input : {
        phone_num      : userStore.getAt(0).get('phoneNumber'),
        device_id      : userStore.getAt(1).get('deviceId'),
        sms_code       : this.getSmsField().getValue(),
        device_remember: ''
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

  },

  resendSmsButtonTap: function () {
    this.resendSms();
  },

  resendSms: function () {

    var userStore = Ext.getStore('UserStore');
    userStore.load();


    window.api.call({
      method: 'sms.resend',
      input : {
        phone_num: userStore.getAt(0).get('phoneNumber'),
        device_id: userStore.getAt(1).get('deviceId'),
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
});