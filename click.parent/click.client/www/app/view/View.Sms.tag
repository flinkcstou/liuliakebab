<view-sms class="view-sms riot-tags-main-container">
  <div class="sms-flex-container">
    <div class="page-title">
      <div id="smsButtonHelpId" class="registration-button-help" ontouchend="helpTouchEndSms()"
           ontouchstart="helpTouchStartSms()">
        {window.languages.ViewSmsButtonHelp}
      </div>
      <div class="title-bottom-border">
      </div>
    </div>
    <div class="sms-unchangable-container">
      <div class="sms-phone-field">
        <p class="sms-text-field-one">{window.languages.ViewSmsFieldOne}</p>
        <input class="sms-phone-input" value="{confirmSms}" ontouchend="onTouchendSmsNumber()" disabled/>
        <div id="inputCaretSms" class="sms-caret"></div>
        <div class="sms-timer" ontouchend="touchEndResend()" ontouchstart="touchStartResend()">{time}
          <div class="sms-resend-icon" role="button" aria-label="{window.languages.ViewSmsAriaLabelResendSms}"></div>
        </div>
      </div>
      <div class="sms-text-field">
        <p style="margin-bottom: {4 * widthK}px;
         margin-top: {15 * widthK}px;">{messageTitle}<br>{messageTitleTwo}</p>
        <p id="deliveredPhoneNumber" style="margin: 0; margin-bottom: {15 * widthK}px;">{phoneNumber.substring(0, 3)}
          {phoneNumber.substring(3, phoneNumber.length)}</p>
        <div class="hor-line-border">
        </div>
        <div id="changeNumberButtonId" class="sms-button-enter" ontouchend="goToBackRegistrationEnd()"
             ontouchstart="goToBackRegistrationStart()">{window.languages.ViewSmsButtonEnterLabel}
        </div>
      </div>
    </div>
  </div>


  <div class="sms-keyboard-field keyboard-field" style="bottom: {150*widthK}px">
    <component-keyboard></component-keyboard>
  </div>

  <component-tour view="registration"></component-tour>

  <script>

    var scope = this;
    scope.messageTitle = window.languages.ViewSmsCodeActivationText;
    scope.messageTitleTwo = '';
    scope.phoneNumber = localStorage.getItem('click_client_phoneNumber');

    window.saveHistory('view-sms', opts);
    scope.confirmSms = '';

    this.on('mount', function () {

      if (device.platform !== 'BrowserStand')
        StatusBar.backgroundColorByHexString("#ffffff");
    });


    var keyboardTouchStartX, keyboardTouchStartY, keyboardTouchEndX, keyboardTouchEndY;

    componentKeyboard.returnStartValue = function (id) {

      document.getElementById(id).style.webkitTransform = 'scale(0.8)'

      keyboardTouchStartX = event.changedTouches[0].pageX
      keyboardTouchStartY = event.changedTouches[0].pageY
    };

    componentKeyboard.returnValue = function (myValue, id) {

      document.getElementById(id).style.webkitTransform = 'scale(1)';

      keyboardTouchEndX = event.changedTouches[0].pageX
      keyboardTouchEndY = event.changedTouches[0].pageY


      if (Math.abs(keyboardTouchStartX - keyboardTouchEndX) <= 20 && Math.abs(keyboardTouchStartY - keyboardTouchEndY) <= 20) {

        if (scope.confirmSms.length < 5 && myValue != 'x') {

          scope.confirmSms = scope.confirmSms.slice(0, inputFocusIndexSms) + myValue + scope.confirmSms.slice(inputFocusIndexSms);
          ++inputFocusIndexSms;
          inputCaretSms.style.left = ctx.measureText(scope.confirmSms.substring(0, inputFocusIndexSms)).width + inputLocalStartXSms - 3 * widthK + 'px';
        }

        if (myValue == 'x') {

          if (inputFocusIndexSms != 0) {
            scope.confirmSms = scope.confirmSms.slice(0, inputFocusIndexSms - 1) + scope.confirmSms.slice(inputFocusIndexSms);
            --inputFocusIndexSms;
            inputCaretSms.style.left = ctx.measureText(scope.confirmSms.substring(0, inputFocusIndexSms)).width + inputLocalStartXSms - 3 * widthK + 'px';
          }
        }


        scope.update();
        if (scope.confirmSms.length == 5) {
          var sms = scope.confirmSms;
          viewSms.getSms(sms);
          return;
        }
      }
    };

    var regNumberTouchEndX, regNumberTouchEndY;

    var inputStartXSms = 80 * widthK;
    var inputLocalStartXSms = inputStartXSms - 80 * widthK;
    var inputFocusIndexSms = 0;
    var canvas = document.createElement('canvas');
    var ctx = canvas.getContext("2d");
    ctx.font = 64 * widthK + "px SFUIDisplay-Light";


    onTouchendSmsNumber = function () {
      event.preventDefault();
      event.stopPropagation();

      regNumberTouchEndX = event.changedTouches[0].pageX;


      var valueLength = ctx.measureText(scope.confirmSms).width;

      if ((regNumberTouchEndX < inputStartXSms) || (regNumberTouchEndX < ctx.measureText(scope.confirmSms[0]).width / 2 + inputStartXSms)) {
        inputCaretSms.style.left = inputLocalStartXSms + 'px';
        inputFocusIndexSms = 0;
      }
      else if (regNumberTouchEndX > (valueLength + inputStartXSms)) {

        inputCaretSms.style.left = (valueLength + inputLocalStartXSms) + 'px';
        inputFocusIndexSms = scope.confirmSms.length;
      } else {
        for (var i = 0; i < scope.confirmSms.length; i++) {

          if (regNumberTouchEndX < (ctx.measureText(scope.confirmSms.substring(0, i + 1)).width + inputStartXSms)) {

            if (regNumberTouchEndX < (ctx.measureText(scope.confirmSms.substring(0, i)).width + ctx.measureText(scope.confirmSms[i]).width / 2 + inputStartXSms)) {
              inputCaretSms.style.left = ctx.measureText(scope.confirmSms.substring(0, i)).width + inputLocalStartXSms - 3 * widthK + 'px';
              inputFocusIndexSms = i;
            } else if (regNumberTouchEndX > (ctx.measureText(scope.confirmSms.substring(0, i)).width + ctx.measureText(scope.confirmSms[i]).width / 2 + inputStartXSms)) {
              inputCaretSms.style.left = ctx.measureText(scope.confirmSms.substring(0, i + 1)).width + inputLocalStartXSms - 3 * widthK + 'px';
              inputFocusIndexSms = i + 1;
            }

            break;
          }

        }

      }
    };

    function updateTransition() {
      var el = document.getElementById("inputCaretSms");

      if (el) {
        if (el.className == "sms-caret") {
          el.className = "sms-caret-two";
        } else {
//        el = document.querySelector("div.box1");
          el.className = "sms-caret";
        }
      }

      return el;
    }

    var intervalIDSms = window.setInterval(updateTransition, 800);


    var helpTouchStartXSms, helpTouchStartYSms, helpTouchEndXSms, helpTouchEndYSms;
    helpTouchStartSms = function () {
      event.preventDefault();
      event.stopPropagation();

      smsButtonHelpId.style.webkitTransform = 'scale(0.8)';

      helpTouchStartXSms = event.changedTouches[0].pageX;
      helpTouchStartYSms = event.changedTouches[0].pageY;

    };

    helpTouchEndSms = function () {
      event.preventDefault();
      event.stopPropagation();

      smsButtonHelpId.style.webkitTransform = 'scale(1)';

      helpTouchEndXSms = event.changedTouches[0].pageX;
      helpTouchEndYSms = event.changedTouches[0].pageY;


      if (Math.abs(helpTouchStartXSms - helpTouchEndXSms) <= 20 && Math.abs(helpTouchStartYSms - helpTouchEndYSms) <= 20) {

        componentTourId.style.display = "block";
        if (device.platform !== 'BrowserStand')
          StatusBar.backgroundColorByHexString("#ffffff");


      }
    };

    var goBackTouchStartXSms, goBackTouchStartYSms, goBackTouchEndXSms, goBackTouchEndYSms;
    goToBackRegistrationStart = function () {
      event.preventDefault();
      event.stopPropagation();

      changeNumberButtonId.style.webkitTransform = 'scale(0.8)';

      goBackTouchStartXSms = event.changedTouches[0].pageX;
      goBackTouchStartYSms = event.changedTouches[0].pageY;
    };

    goToBackRegistrationEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      changeNumberButtonId.style.webkitTransform = 'scale(1)';

      goBackTouchEndXSms = event.changedTouches[0].pageX;
      goBackTouchEndYSms = event.changedTouches[0].pageY;

      if (Math.abs(goBackTouchStartXSms - goBackTouchEndXSms) <= 20 && Math.abs(goBackTouchStartYSms - goBackTouchEndYSms) <= 20) {
        onBackKeyDown();
        console.log('CLEARING INTERVAL FOR CALL.IVR', time);
        clearInterval(time);
      }
    };


    var minutes = 0;
    var seconds = 60;

    timer = function () {

      seconds--;
      if (seconds < 10)
        scope.time = minutes + ':0' + seconds;
      else
        scope.time = minutes + ':' + seconds;
      if (minutes == 0 && seconds == 0) {
        scope.messageTitle = window.languages.ViewSmsMessageTitle;
        scope.messageTitleTwo = window.languages.ViewSmsMessageTitleTwo;
        scope.update();

        var phoneNumber = localStorage.getItem('click_client_phoneNumber');
        var deviceId = localStorage.getItem('click_client_deviceID');
        var timestamp = parseInt(Date.now() / 1000);
        var signString = hex_md5(phoneNumber.substring(0, 5) + timestamp + phoneNumber.substring(phoneNumber.length - 4, phoneNumber.length));

        window.api.call({
          method: 'call.ivr',
          input: {
            phone_num: phoneNumber,
            device_id: deviceId,
            timestamp: timestamp,
            sign_string: signString
          },

          scope: this,

          onSuccess: function (result) {

          },
          onFail: function (api_status, api_status_message, data) {
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });
        clearInterval(time);
      }
      if (seconds == 0) {
        seconds = 59;
        minutes--;
      }
      scope.update();
    }
    var time = setInterval(timer, 1000);


    var token;
    viewSms.getSms = function (sms) {
      scope.confirmSms = sms;
      scope.update(scope.confirmSms);
      event.preventDefault();
      event.stopPropagation();

      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      var deviceId = localStorage.getItem('click_client_deviceID');
      scope.tourData = {
        mainpage: true,
        transfer: true,
        invoice: true,
        autopaymethod: true,
        calculator: true,
        friendhelp: true
      };
      localStorage.setItem("tour_data", JSON.stringify(scope.tourData));
      registrationConfirm(sms, phoneNumber, deviceId);
    };

    function deviceRemember() {
      if (JSON.parse(localStorage.getItem('device_remember')) === true)
        return 1;
      return 0;
    }

    var countOfCall = 0;
    var checkServiceAnswer;

    function registrationConfirm(sms, phoneNumber, deviceId) {
      countOfCall++;
      checkServiceAnswer = false;
      window.startSpinner();

      if (countOfCall <= 3 && !checkServiceAnswer)
        setTimeout(function () {
          if (!checkServiceAnswer && modeOfApp.onlineMode) {
            var phoneNumber = localStorage.getItem('click_client_phoneNumber');
            var deviceId = localStorage.getItem('click_client_deviceID');
            registrationConfirm(scope.confirmSms, phoneNumber, deviceId);
          }
          if (countOfCall == 3 && !checkServiceAnswer) {
            scope.errorNote = "Сервис временно недоступен";
            countOfCall = 0;
            window.stopSpinner();

            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: scope.clickPinError,
              errornote: scope.errorNote,
            });
            scope.update();
          }
        }, 10000);
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
          checkServiceAnswer = true;
          if (result[0][0])
            if (result[0][0].error == 0) {
              clearInterval(time);
              localStorage.setItem('confirm_needed', false);
              if (result[0][0].client_exists == 1) {
                localStorage.setItem('click_client_registered', true);
                this.riotTags.innerHTML = "<view-authorization>";
                riot.mount('view-authorization');
                scope.unmount()
              }
              else {
                localStorage.setItem('click_client_registered', false);
                riotTags.innerHTML = "<view-pin-code>";
                riot.mount('view-pin-code', ['view-sms']);
                scope.unmount()
              }
            }
            else {
              scope.clickPinError = false;
              scope.errorNote = result[0][0].error_code;

              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: scope.clickPinError,
                errornote: scope.errorNote
              });

              scope.update();
            }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      }, 10000);

    }

    var resendTouchStartX, resendTouchStartY, resendTouchEndX, resendTouchEndY;

    touchStartResend = function () {
      event.preventDefault();
      event.stopPropagation();

      resendTouchStartX = event.changedTouches[0].pageX
      resendTouchStartY = event.changedTouches[0].pageY
    };

    touchEndResend = function () {

      event.preventDefault();
      event.stopPropagation();

      resendTouchEndX = event.changedTouches[0].pageX;
      resendTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(resendTouchStartX - resendTouchEndX) <= 20 && Math.abs(resendTouchStartY - resendTouchEndY) <= 20) {
        scope.clickPinError = false;
        scope.errorNote = window.languages.ViewSmsResendText + localStorage.getItem('click_client_phoneNumber');

        window.common.alert.show("componentAlertId", {
          parent: scope,
          clickpinerror: scope.clickPinError,
          errornote: scope.errorNote
        });

        scope.update();
        resendSms();
      }
    };

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
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    }


  </script>
</view-sms>