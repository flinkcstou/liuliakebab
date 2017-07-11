<view-sms class="view-sms riot-tags-main-container">
  <div class="sms-flex-container">
    <div class="sms-unchangable-container">
      <div class="sms-phone-field">
        <p class="sms-text-field-one">{window.languages.ViewSmsFieldOne}</p>
        <input class="sms-phone-input" value="{confirmSms}" ontouchend="onTouchendSmsNumber()"/>
        <div id="inputCaretSms" class="sms-caret"></div>
        <div class="sms-timer" ontouchend="touchEndResend()" ontouchstart="touchStartResend()">{time}
          <div class="sms-resend-icon"></div>
        </div>

        <div class="sms-text-field">
          <p style="margin-bottom: 4px">{messageTitle}<br>{messageTitleTwo}</p>
          <p id="deliveredPhoneNumber" style="margin: 0">{phoneNumber.substring(0, 3)}
            {phoneNumber.substring(3, phoneNumber.length)}</p>
          <a class="sms-button-enter" ontouchend="goToBackRegistrationEnd()"
             ontouchstart="goToBackRegistrationStart()">{window.languages.ViewSmsButtonEnterLabel}
          </a>
        </div>
      </div>
    </div>
  </div>


  <div class="registration-keyboard-field keyboard-field" style="bottom: {150*widthK}px">
    <div class="registration-button-help" ontouchend="helpTouchEndSms()" ontouchstart="helpTouchStartSms()"
         style="top: {560*widthK}px">{window.languages.ViewSmsButtonHelp}
    </div>
    <component-keyboard></component-keyboard>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <component-tour view="registration"></component-tour>

  <script>

    var scope = this;
    scope.messageTitle = window.languages.ViewSmsCodeActivationText;
    scope.messageTitleTwo = '';
    scope.phoneNumber = localStorage.getItem('click_client_phoneNumber');

    scope.showError = false;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-sms') {
      history.arrayOfHistory.push(
        {
          "view": 'view-sms',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }
    scope.confirmSms = '';

    this.on('mount', function () {

      if (device.platform != 'BrowserStand')
        StatusBar.backgroundColorByHexString("#00b0eb");
    })


    var keyboardTouchStartX, keyboardTouchStartY, keyboardTouchEndX, keyboardTouchEndY;

    componentKeyboard.returnStartValue = function () {
      keyboardTouchStartX = event.changedTouches[0].pageX
      keyboardTouchStartY = event.changedTouches[0].pageY
    }

    //
    //    componentKeyboard.returnValue = function (myValue) {
    //
    //      keyboardTouchEndX = event.changedTouches[0].pageX
    //      keyboardTouchEndY = event.changedTouches[0].pageY
    //
    //
    //      if (Math.abs(keyboardTouchStartX - keyboardTouchEndX) <= 20 && Math.abs(keyboardTouchStartY - keyboardTouchEndY) <= 20) {
    //
    //        if (scope.confirmSms.length < 5 && myValue != 'x') {
    //          scope.confirmSms += myValue;
    //        }
    //        if (myValue == 'x') {
    //          scope.confirmSms = scope.confirmSms.substring(0, scope.confirmSms.length - 1);
    //        }
    //        scope.update();
    //        if (scope.confirmSms.length == 5) {
    //          var sms = scope.confirmSms;
    //          viewSms.getSms(sms);
    //          return;
    //        }
    //      }
    //    }


    componentKeyboard.returnValue = function (myValue) {

      keyboardTouchEndX = event.changedTouches[0].pageX
      keyboardTouchEndY = event.changedTouches[0].pageY


      if (Math.abs(keyboardTouchStartX - keyboardTouchEndX) <= 20 && Math.abs(keyboardTouchStartY - keyboardTouchEndY) <= 20) {

        console.log("inputFocusIndexSms", inputFocusIndexSms);

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


        console.log("p=", scope.confirmSms);
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
      event.preventDefault()
      event.stopPropagation()

      helpTouchStartXSms = event.changedTouches[0].pageX
      helpTouchStartYSms = event.changedTouches[0].pageY

    }

    helpTouchEndSms = function () {
      event.preventDefault()
      event.stopPropagation()

      helpTouchEndXSms = event.changedTouches[0].pageX
      helpTouchEndYSms = event.changedTouches[0].pageY


      if (Math.abs(helpTouchStartXSms - helpTouchEndXSms) <= 20 && Math.abs(helpTouchStartYSms - helpTouchEndYSms) <= 20) {
//        riotTags.innerHTML = "<view-help>";
//        riot.mount('view-help');
//        scope.unmount()
        componentTourId.style.display = "block";
//        tourBackPageId.style.opacity = '1';
        if (device.platform != 'BrowserStand')
          StatusBar.backgroundColorByHexString("#024361");


      }
    }

    var goBackTouchStartXSms, goBackTouchStartYSms, goBackTouchEndXSms, goBackTouchEndYSms;
    goToBackRegistrationStart = function () {
      event.preventDefault()
      event.stopPropagation()

      goBackTouchStartXSms = event.changedTouches[0].pageX
      goBackTouchStartYSms = event.changedTouches[0].pageY
    }

    goToBackRegistrationEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      goBackTouchEndXSms = event.changedTouches[0].pageX
      goBackTouchEndYSms = event.changedTouches[0].pageY

      if (Math.abs(goBackTouchStartXSms - goBackTouchEndXSms) <= 20 && Math.abs(goBackTouchStartYSms - goBackTouchEndYSms) <= 20) {
        onBackKeyDown()
      }
    }


    var minutes = 1;
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
      scope.update(scope.confirmSms)
      event.preventDefault();
      event.stopPropagation();

      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      var deviceId = localStorage.getItem('click_client_deviceID');
      scope.tourData = {
        mainpage: false,
        transfer: false,
        invoice: false,
        autopaymethod: false,
        calculator: false,
        friendhelp: false
      };
      localStorage.setItem("tour_data", JSON.stringify(scope.tourData));
      registrationConfirm(sms, phoneNumber, deviceId);
    }
    function deviceRemember() {
      if (JSON.parse(localStorage.getItem('device_remember')) === true)
        return 1;
      return 0;
    }

    var countOfCall = 0;
    function registrationConfirm(sms, phoneNumber, deviceId) {
      countOfCall++;
      var checkServiceAnswer = false;
      if (device.platform != 'BrowserStand') {
        var options = {dimBackground: true};

        SpinnerPlugin.activityStart(languages.Downloading, options, function () {
          console.log("Started");
        }, function () {
          console.log("closed");
        });
      }


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

              localStorage.setItem('confirm_needed', false);
              console.log(result)
              if (result[0][0].client_exists == 1) {
                window.pushNotificationInitialize();
                localStorage.setItem('click_client_registered', true)
                this.riotTags.innerHTML = "<view-authorization>";
                riot.mount('view-authorization');

                scope.unmount()
              }
              else {
                localStorage.setItem('click_client_registered', false)
                this.riotTags.innerHTML = "<view-registration-client>";
                riot.mount('view-registration-client');

                scope.unmount()
              }
            }
            else {
              scope.clickPinError = false;
              scope.errorNote = result[0][0].error_code;
              scope.showError = true;
              scope.update();
            }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

      if (countOfCall <= 3 && !checkServiceAnswer && window.isConnected)
        setTimeout(function () {
          if (!checkServiceAnswer && modeOfApp.onlineMode) {
            var phoneNumber = localStorage.getItem('click_client_phoneNumber');
            var deviceId = localStorage.getItem('click_client_deviceID');
            registrationConfirm(scope.confirmSms, phoneNumber, deviceId);
          }
          if (countOfCall == 3 && !checkServiceAnswer) {
            scope.showError = true;
            scope.errorNote = "Сервис временно недоступен";
            countOfCall = 0;
            if (device.platform != 'BrowserStand') {
              SpinnerPlugin.activityStop();
            }
            window.isConnected = false;
            scope.update();

            return;
          }
        }, 10000);

    }

    var resendTouchStartX, resendTouchStartY, resendTouchEndX, resendTouchEndY;

    touchStartResend = function () {
      event.preventDefault();
      event.stopPropagation();

      resendTouchStartX = event.changedTouches[0].pageX
      resendTouchStartY = event.changedTouches[0].pageY
    }

    touchEndResend = function () {

      event.preventDefault();
      event.stopPropagation();

      resendTouchEndX = event.changedTouches[0].pageX
      resendTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(resendTouchStartX - resendTouchEndX) <= 20 && Math.abs(resendTouchStartY - resendTouchEndY) <= 20) {
        scope.clickPinError = false;
        scope.errorNote = window.languages.ViewSmsResendText + localStorage.getItem('click_client_phoneNumber');
        scope.showError = true;
        scope.update();
//      alert(window.languages.ViewSmsResendText + localStorage.getItem('click_client_phoneNumber'));
        resendSms();
      }
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