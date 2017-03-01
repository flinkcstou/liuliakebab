<view-sms class="view-sms">
  <div class="sms-flex-container">
    <div class="sms-unchangable-container">
      <div class="sms-phone-field">
        <p class="sms-text-field-one">{window.languages.ViewSmsFieldOne}</p>
        <p class="sms-phone-input">{confirmSms}</p>
        <div class="sms-timer" ontouchend="touchEndResend()">{time}
          <div class="sms-resend-icon"></div>
        </div>

        <div class="sms-text-field">
          <p style="margin-bottom: 4px">{messageTitle}<br>{messageTitleTwo}</p>
          <p id="deliveredPhoneNumber" style="margin: 0">{phoneNumber.substring(0, 3)}
            {phoneNumber.substring(3, phoneNumber.length)}</p>
        </div>
      </div>
    </div>
  </div>

  <div class="registration-keyboard-field keyboard-field" style="bottom: {150*widthK}px">
    <div class="registration-button-help" style="top: {560*widthK}px">{window.languages.ViewSmsButtonHelp}</div>
    <component-keyboard></component-keyboard>
  </div>


  <script>

    var scope = this;
    scope.messageTitle = window.languages.ViewSmsCodeActivationText;
    scope.messageTitleTwo = '';
    scope.phoneNumber = localStorage.getItem('click_client_phoneNumber');

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-sms') {
      history.arrayOfHistory.push(
        {
          "view": 'view-sms',
          "params": ''
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }
    scope.confirmSms = '';

    componentKeyboard.returnValue = function (myValue) {
      if (scope.confirmSms.length < 5 && myValue != 'x') {
        scope.confirmSms += myValue;
      }
      if (myValue == 'x') {
        scope.confirmSms = scope.confirmSms.substring(0, scope.confirmSms.length - 1);
      }
      riot.update();
      if (scope.confirmSms.length == 5) {
        var sms = scope.confirmSms;
        viewSms.getSms(sms);
        return;
      }
    }


    var minutes = 1;
    var seconds = 60;

    timer = function () {

      riot.update();
      seconds--;
      if (seconds < 10)
        scope.time = minutes + ':0' + seconds;
      else
        scope.time = minutes + ':' + seconds;
      if (minutes == 0 && seconds == 0) {
        scope.messageTitle = window.languages.ViewSmsMessageTitle;
        scope.messageTitleTwo = window.languages.ViewSmsMessageTitleTwo;
        riot.update();
        clearInterval(time);
      }
      if (seconds == 0) {
        seconds = 59;
        minutes--;
      }
    }
    var time = setInterval(timer, 1000);


    var token;
    viewSms.getSms = function (sms) {
      scope.confirmSms = sms;
      riot.update(scope.confirmSms)
      event.preventDefault();
      event.stopPropagation();

      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      var deviceId = localStorage.getItem('click_client_deviceID');
      registrationConfirm(sms, phoneNumber, deviceId);
    }
    function deviceRemember() {
      if (JSON.parse(localStorage.getItem('device_remember')) === true)
        return 1;
      return 0;
    }

    function registrationConfirm(sms, phoneNumber, deviceId) {

      window.api.call({
        method: 'device.register.confirm',
        input: {
          phone_num: phoneNumber,
          device_id: deviceId,
          sms_code: sms,
          device_remember: deviceRemember()
        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            localStorage.setItem('confirm_needed', false);
            console.log(result)
            if (result[0][0].client_exists == 1) {
              localStorage.setItem('click_client_registered', true)
              this.riotTags.innerHTML = "<view-authorization>";
              riot.mount('view-authorization');
            }
            else {
              localStorage.setItem('click_client_registered', false)
              this.riotTags.innerHTML = "<view-registration-client>";
              riot.mount('view-registration-client');
            }
          }
          else alert(result[0][0].error_note)
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

    }

    touchEndResend = function () {

      event.preventDefault();
      event.stopPropagation();
      alert(window.languages.ViewSmsResendText + localStorage.getItem('click_client_phoneNumber'));
      resendSms();
    }

    resendSms = function () {
      event.preventDefault();
      event.stopPropagation();
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      var deviceId = localStorage.getItem('click_client_deviceID');
      window.api.call({
        method: 'sms.resend',
        input: {
          phone_num: phoneNumber,
          device_id: deviceId
        },

        scope: this,

        onSuccess: function (result) {
//                    console.log("result[0][0] ", result[0][0]);
//                    console.log("result ", result);
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    }

    //      <div class="registration-buttons-container">
    //      <div class="registration-container-offline">
    //      <div class="registration-button-offline">Офлайн режим</div>
    //    </div>
    //    <a href="stand/index-stand.html" id="demoContainer" class="registration-container-demo-version"
    //    ontouchstart="goToDemo()">
    //      <div class="registration-button-demo-version">Демо версия</div>
    //    </a>
    //    </div>
  </script>
</view-sms>