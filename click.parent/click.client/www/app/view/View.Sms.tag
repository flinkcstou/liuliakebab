<view-sms>
  <input id="rememberDevice" type="checkbox">
  <div class="registration-phone-field">
    <p class="registration-text-field">Введите проверочный код</p>
    <p class="registration-phone-input">{viewSms.confirmSms}</p>
    <p class="sms-timer">{viewSms.time}</p>
  </div>

  <div class="sms-text-field">
    <p style="margin-bottom: 4px">Код активации выслан на номер:</p>
    <p style="margin: 0">{viewRegistration.phoneNumber.substring(0, 4)} {viewRegistration.phoneNumber.substring(4, 6)}
      {viewRegistration.phoneNumber.substring(6, viewRegistration.phoneNumber.length)}</p>
  </div>

  <div class="registration-keyboard-field keyboard-field" style="top: 150px">
    <div class="registration-button-help">Помощь</div>
    <component-keyboard></component-keyboard>
  </div>

  <div class="registration-buttons-container">
    <div class="registration-container-offline">
      <div class="registration-button-offline">Офлайн режим</div>
    </div>
    <a href="stand/index-stand.html" id="demoContainer" class="registration-container-demo-version"
       ontouchstart="goToDemo()">
      <div class="registration-button-demo-version">Демо версия</div>
    </a>
  </div>

  <script>
    var scope = this;
    history.arrayOfHistory.push('view-sms');
    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    viewSms.confirmSms = '';

    componentKeyboard.returnValue = function (myValue) {
      if (viewSms.confirmSms.length < 5 && myValue != 'x') {
        viewSms.confirmSms += myValue;
      }
      if (myValue == 'x') {
        viewSms.confirmSms = viewSms.confirmSms.substring(0, viewSms.confirmSms.length - 1);
      }
      console.log(myValue)
      riot.update();
      if (viewSms.confirmSms.length == 5) {
        console.log("LENGTH EQUAL 5")
        var sms = viewSms.confirmSms;
        getSms(sms);
        return;
      }
    }



    var minutes = 1;
    var seconds = 60;

    timer = function () {

      riot.update();
      seconds--;
      if (seconds < 10)
        viewSms.time = minutes + ':0' + seconds;
      else
        viewSms.time = minutes + ':' + seconds;
      if (minutes == 0 && seconds == 0) {
        alert("Вы не успкли ввести. Смс-код будет переотправлен");
        clearInterval(time);
      }
      if (seconds == 0) {
        seconds = 59;
        minutes--;
      }
    }
    var time = setInterval(timer, 1000);



    var token;
    getSms = function (sms) {
      event.preventDefault();
      event.stopPropagation();

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
          if(result[0][0].error == -4) {
            alert("Неверный смс код");
            viewSms.confirmSms = '';
            return;
          }
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