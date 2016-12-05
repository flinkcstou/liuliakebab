<view-registration-device>

  <div class="registration-phone-field">

  </div>

  <input type="text" id="phoneNumber">

  <input type="button" ontouchend="getPhoneNumber()" value="Далее">

  <div id="smsForm" class="hide">
    Введите sms:
    <br>
    <input type="text" id="sms">
    <br>
    <input type="button" ontouchend="getSms()" value="Далее">
    <input type="checkbox" id="rememberDevice">Запомнить устройство
    <br>
    <input type="button" value="Переотправить sms" ontouchend="resendSms()">
  </div>

  <script>
    var scope = this;
    window.viewRegistration = {};
    getPhoneNumber = function () {
      var correctPhoneNumber = true;
      var phoneNumber = scope.phoneNumber.value;

      if (phoneNumber.length != 12) {
        alert("incorrect number");
        scope.phoneNumber.value = '';
        correctPhoneNumber = false;
      }
      console.log(phoneNumber);
      localStorage.setItem('click_client_phoneNumber', phoneNumber);
      var date = parseInt(Date.now() / 1000);


      if (correctPhoneNumber) {
        registrationDevice(phoneNumber, date);
      }

    };

    function deviceType() {
      return device.platform == 'IOS' ? 2 : 1;
    }

    function deviceName() {
      return device.name;
    }

    function deviceImei() {
      return device.uuid;
    }

    function deviceInfo() {
      return device.info;
    }


    function registrationDevice(phoneNumber, date) {
      window.api.call({
        method: 'device.register.request',
        input : {
          phone_num  : phoneNumber,
          device_info: deviceInfo(),
          device_name: deviceName(),
          device_type: deviceType(),
          datetime   : date,
          imei       : deviceImei()
        },

        scope: this,

        onSuccess: function (result) {
          console.log("result[1][0] ", result[1][0]);
          if (result[1][0].confirm_needed)
            smsForm.classList.add('show');
          var deviceId = result[1][0].device_id;
          localStorage.setItem('click_client_deviceID', deviceId);
          window.token = hex_sha512(deviceId + date + phoneNumber);

        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }

    getSms = function () {
      event.preventDefault();
      event.stopPropagation();

      var sms = scope.sms.value;
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      var deviceId = localStorage.getItem('click_client_deviceID');
      registrationConfirm(sms, phoneNumber, deviceId);
    }
    function deviceRemember() {
      if (this.rememberDevice.checked)
        return 1;
      return 0;
    }

    function registrationConfirm(sms, phoneNumber, deviceId) {

      window.api.call({
        method: 'device.register.confirm',
        input : {
          phone_num      : phoneNumber,
          device_id      : deviceId,
          sms_code       : sms,
          device_remember: deviceRemember()
        },

        scope: this,

        onSuccess: function (result) {
          console.log("result[0][0] ", result[0][0]);
          if (result[0][0].error == 0) {
            localStorage.setItem('click_client_token', token);
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

    }

    resendSms = function () {
      event.preventDefault();
      event.stopPropagation();
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      var deviceId = localStorage.getItem('click_client_deviceID');
      window.api.call({
        method: 'sms.resend',
        input : {
          phone_num: phoneNumber,
          device_id: deviceId
        },

        scope: this,

        onSuccess: function (result) {
          console.log("result[0][0] ", result[0][0]);
          console.log("result ", result);
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

    }
  </script>
</view-registration-device>