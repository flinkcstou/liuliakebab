Ext.define('Click.controller.AuthorizationController', {
  extend: 'Click.controller.Base',

  requires: ['Click.store.Api'],

  config: {
    refs: {
      view: 'viewAuthorization',

      authorizationField: 'viewAuthorization textfield[name = authorizationField]',
      authorizationButton: 'viewAuthorization button[action = authorization]',
      deleteAll       : 'viewAuthorization button[action = delete]'
    },

    control: {
      view              : {
        show: 'onShow'
      },
      authorizationField: {
        keyup: 'authorizationKeyUp'
      },
      authorizationButton: {
        tap: 'authorizationButtonTap'
      },
      deleteAll       : {
        tap: 'deleteAllButtonTap'
      }
    }
  },

  deleteAllButtonTap: function () {

    var userStore = Ext.getStore('UserStore');
    userStore.load();
    userStore.removeAll();
    console.log(userStore.getData().length);
    userStore.sync();
    console.log("Все НОМЕРА и АЙДИ удалены");
  },

  onShow: function () {

  },

  authorizationKeyUp: function () {
      console.log(this.getAuthorizationField().getValue());
  },

  authorizationButtonTap: function(){
    var userStore = Ext.getStore('UserStore');
    userStore.load();

    var phoneNumber = userStore.getAt(0).get('phoneNumber');
    console.log("Phone Number ",phoneNumber);
    var deviceId = userStore.getAt(1).get('deviceId');
    console.log("Device ID ",deviceId);
    var token = userStore.getAt(2).get('idTimeNumberToken');
    console.log("Token ",token);
    var pin = this.getAuthorizationField().getValue();
    console.log("Pin ",pin);
    var userStore = Ext.getStore('UserStore');
    userStore.load();
    var date = userStore.getAt(3).get('dateTime');
    console.log(date);
    var password = hex_sha512(token + date + hex_md5(pin));
    console.log("Password ",password);

    this.authorization(phoneNumber, deviceId, password, date);
  },

  authorization: function(phoneNumber, deviceId, password, date) {
    window.api.call({
      method: 'app.login',
      input: {
        phone_num: phoneNumber,
        device_id: deviceId,
        password: password,
        datetime: date
      },

      scope:this,
      onSuccess: function(result){
        console.log(result);
      },

      onFail: function(api_status, api_status_message, data){
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }

    });
  }

});