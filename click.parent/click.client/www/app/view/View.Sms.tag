<view-sms>
  <div id="smsForm" class="show">
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
    var token;
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
            var date = parseInt(Date.now() / 1000);
            token = hex_sha512(deviceId + date + phoneNumber);
            localStorage.setItem('click_client_token', token);
            this.riotTags.innerHTML = "<view-authorization>";
            riot.mount('view-authorization');
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
      })
    }
  </script>
</view-sms>