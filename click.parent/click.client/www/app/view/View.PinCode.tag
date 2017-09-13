<view-pin-code class="view-pincode riot-tags-main-container">

  <div class="pincode-flex-container">

    <div id="backButton" ontouchend="goToBackFromPinCodeTouchEnd()" ontouchstart="goToBackFromPinCodeTouchStart()"
         class="{pincode-back-button: backbuttoncheck}">
    </div>

    <div class="pincode-unchangable-container">
      <div if="{nowCheckPin}" id="labelOfNowPinId" class="pincode-enter-pin-label">
        {nowCheckPinTitle}
      </div>
      <div if="{checkPin}" id="labelOfPinId" class="pincode-enter-pin-label">{labelOfTitle}</div>
      <div if="{checkPinConfirm}" class="pincode-enter-pin-confirm-label">
        {window.languages.ViewPinCodeConfirmClickPinLabel}
      </div>
      <div class="pincode-pin-container">
        <div class="pincode-pin-field">
          <div id="circleOne" class="pincode-pin-circles pincode-pin-one"></div>
          <div id="circleTwo" class="pincode-pin-circles pincode-pin-two"></div>
          <div id="circleThree" class="pincode-pin-circles pincode-pin-three"></div>
          <div id="circleFour" class="pincode-pin-circles pincode-pin-four"></div>
          <div id="circleFive" class="pincode-pin-circles pincode-pin-five"></div>
        </div>
      </div>
    </div>
  </div>

  <div class="pincode-keyboard-field keyboard-field">
    <component-keyboard></component-keyboard>
  </div>

  <div if="{device.platform != 'iOS'}" id="pinOfflineButtonId" class="pincode-button-offline"
       ontouchstart="offlineModeTouchStart()"
       ontouchend="offlineModeTouchEnd()">
    {window.languages.ViewAuthorizationOfflineModeLabel}
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}" step_amount="{stepToBack}" viewpage="{viewpage}"></component-alert>

  <div if="{showRegistrationProcess}" class="registration-process">

    <div if="{registrationSuccess == 0}" class="registration-process-container">
      <div id="registrationProcessingId" class="registration-process-processing">
      </div>
      <div class="registration-process-text">
        <p>Пожалуйста, подождите.<br><br>Мы регистрируем вашу карту в системе CLICK!</p>
      </div>
    </div>

    <div if="{registrationSuccess == -2}" class="registration-process-container">
      <div class="registration-process-x">
      </div>
      <div class="registration-process-text">
        <p class="registration-process-check-status-label-not-registered-yet">
          Ваша карта ещё не добавлена.<br><br>Проверьте статус регистрации через несколько минут</p>
      </div>
      <button class="registration-process-button-check-status" ontouchstart="checkRegistrationTouchStart()"
              ontouchend="checkRegistrationTouchEnd()">ПРОВЕРИТЬ СТАТУС РЕГИСТРАЦИИ
      </button>
    </div>

    <div if="{registrationSuccess == 1}" class="registration-process-container">
      <div class="registration-process-ok">
      </div>
      <div class="registration-process-text">
        <p>Ваша карта<br>успешно зарегестрирована!</p>
      </div>

      <button class="registration-process-button-next" ontouchstart="registrationProcessNextTouchStart()"
              ontouchend="registrationProcessNextTouchEnd()">ДАЛЕЕ
      </button>
    </div>

    <div if="{registrationSuccess == -1}" class="registration-process-container">
      <div class="registration-process-x">
      </div>
      <div class="registration-process-text">
        <p class="registration-process-check-status-label" id="registrationProcessErorrId">
          Произошла ошибка при регистрации.<br>Попробуйте ещё раз</p>
      </div>

      <button class="registration-process-button-check-status" ontouchstart="registrationProcessCheckStatusTouchStart()"
              ontouchend="registrationProcessCheckStatusTouchEnd()">ЗАРЕГИСТРИРОВАТЬСЯ ЗАНОВО
      </button>
    </div>


  </div>


  <script>

    var scope = this;

    scope.timeouts = [5000, 5000, 10000, 10000, 10000, 10000, 10000];
    scope.timeoutIndex = 0;

    this.on('mount', function () {
      if (device.platform != 'BrowserStand')
        StatusBar.backgroundColorByHexString("#00a8f1");
    })

    if (history.arrayOfHistory.length != 0) {
      if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-pin-code') {
        history.arrayOfHistory.push(
          {
            "view": 'view-pin-code',
            "params": opts
          }
        );
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
      }
    }


    console.log("OPTS", opts)


    var pin;
    var pinConfirm;
    var enteredPin = '';
    scope.checkPin = false;
    scope.nowCheckPin = true;
    scope.stepToBack = null;
    scope.checkPinConfirm = false;
    scope.showError = false;
    var fromRegistration = false;
    var fromAuthorization = false;
    var fromSettings = false;
    var fromPayOrTransfer = false;
    scope.showRegistrationProcess = false;
    scope.nowCheckPinTitle = window.languages.ViewPinCodeNowClickPinLabel;
    scope.backbuttoncheck = false;


    scope.labelOfTitle = window.languages.ViewPinCodeClickPinLabel;

    if (opts[0] == 'view-registration-client') {
      fromRegistration = true;
      scope.checkPin = true;
      scope.nowCheckPin = false
      var cardNumber = opts[1];
      var cardInformation = opts[2];
    } else if (opts[0] == 'view-security-settings') {
      fromSettings = true;
      fromAuthorization = false;
      fromRegistration = false;
      fromPayOrTransfer = false;
    }
    else if (opts[0] == 'view-pay-confirm' || opts[0] == 'view-transfer-stepfour') {
      scope.nowCheckPinTitle = window.languages.ViewPinCodeConfirmPayTransferLabel;
      scope.backbuttoncheck = true;
      fromSettings = false;
      fromAuthorization = false;
      fromRegistration = false;
      fromPayOrTransfer = true;
      var errorPinTimesCounter = 0;
    }
    else if (opts[0] == 'view-authorization') {
      fromAuthorization = true;
      scope.checkPin = true;
      scope.nowCheckPin = false
      scope.labelOfTitle = "Для удобства пользования, просим установить новый CLICK-PIN из 5 цифр!"
    }

    scope.update();

    var keyboardTouchStartX, keyboardTouchStartY, keyboardTouchEndX, keyboardTouchEndY;

    componentKeyboard.returnStartValue = function (id) {

      document.getElementById(id).style.webkitTransform = 'scale(0.8)'

      keyboardTouchStartX = event.changedTouches[0].pageX
      keyboardTouchStartY = event.changedTouches[0].pageY
    }

    componentKeyboard.returnValue = function (myValue, id) {
      event.preventDefault();
      event.stopPropagation();

      document.getElementById(id).style.webkitTransform = 'scale(1)'

      keyboardTouchEndX = event.changedTouches[0].pageX
      keyboardTouchEndY = event.changedTouches[0].pageY


      if (Math.abs(keyboardTouchStartX - keyboardTouchEndX) <= 20 && Math.abs(keyboardTouchStartY - keyboardTouchEndY) <= 20) {

        if (enteredPin.length < 5 && myValue != 'x') {
          enteredPin += myValue;
        }
        if (myValue == 'x') {
          enteredPin = enteredPin.substring(0, enteredPin.length - 1);
        }

        scope.update();
        updateEnteredPin();
      }
    }

    var offlineModeTouchStartX, offlineModeTouchEndX, offlineModeTouchStartY, offlineModeTouchEndY;

    offlineModeTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      pinOfflineButtonId.style.webkitTransform = 'scale(0.8)'

      offlineModeTouchStartX = event.changedTouches[0].pageX;
      offlineModeTouchStartY = event.changedTouches[0].pageY;

    }


    offlineModeTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      pinOfflineButtonId.style.webkitTransform = 'scale(1)'

      offlineModeTouchEndX = event.changedTouches[0].pageX;
      offlineModeTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(offlineModeTouchStartX - offlineModeTouchEndX) <= 20 && Math.abs(offlineModeTouchStartY - offlineModeTouchEndY) <= 20) {

        modeOfApp.onlineMode = false;
        modeOfApp.offlineMode = true;

        this.riotTags.innerHTML = "<view-main-page>";
        riot.mount('view-main-page');

        scope.unmount()
      }
    }


    var registrationNextTouchStartX, registrationNextTouchStartY, registrationNextTouchEndX, registrationNextTouchEndY;

    registrationProcessNextTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      registrationNextTouchStartX = event.changedTouches[0].pageX;
      registrationNextTouchStartY = event.changedTouches[0].pageY;
    }

    registrationProcessNextTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      registrationNextTouchEndX = event.changedTouches[0].pageX;
      registrationNextTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(registrationNextTouchStartX - registrationNextTouchEndX) <= 20 && Math.abs(registrationNextTouchStartY - registrationNextTouchEndY) <= 20) {

        riotTags.innerHTML = "<view-authorization>";
        riot.mount('view-authorization', {from: "registration-client"});

        scope.unmount()
      }
    }

    var registrationCheckStatusTouchStartX, registrationCheckStatusTouchStartY, registrationCheckStatusTouchEndX,
      registrationCheckStatusTouchEndY;

    registrationProcessCheckStatusTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      registrationCheckStatusTouchStartX = event.changedTouches[0].pageX;
      registrationCheckStatusTouchStartY = event.changedTouches[0].pageY;
    }

    registrationProcessCheckStatusTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      registrationCheckStatusTouchEndX = event.changedTouches[0].pageX;
      registrationCheckStatusTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(registrationCheckStatusTouchStartX - registrationCheckStatusTouchEndX) <= 20 && Math.abs(registrationCheckStatusTouchStartY - registrationCheckStatusTouchEndY) <= 20) {

        riotTags.innerHTML = "<view-registration-client>";
        riot.mount('view-registration-client');

      }
    }

    var backFromPinCodeTouchStartX, backFromPinCodeTouchStartY, backFromPinCodeTouchEndX,
      backFromPinCodeTouchEndY;

    goToBackFromPinCodeTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();


      backFromPinCodeTouchStartX = event.changedTouches[0].pageX;
      backFromPinCodeTouchStartY = event.changedTouches[0].pageY;
    };

    goToBackFromPinCodeTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      backFromPinCodeTouchEndX = event.changedTouches[0].pageX;
      backFromPinCodeTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(backFromPinCodeTouchStartX - backFromPinCodeTouchEndX) <= 20 && Math.abs(backFromPinCodeTouchStartY - backFromPinCodeTouchEndY) <= 20) {
        onBackKeyDown();
      }
    };

    updateEnteredPin = function () {


      if (enteredPin.length == 0) {
        circleOne.style.backgroundColor = 'transparent';
        circleTwo.style.backgroundColor = 'transparent';
        circleThree.style.backgroundColor = 'transparent';
        circleFour.style.backgroundColor = 'transparent';
        circleFive.style.backgroundColor = 'transparent';
      }
      if (enteredPin.length == 1) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = 'transparent';
        circleThree.style.backgroundColor = 'transparent';
        circleFour.style.backgroundColor = 'transparent';
        circleFive.style.backgroundColor = 'transparent';
      }
      if (enteredPin.length == 2) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = 'transparent';
        circleFour.style.backgroundColor = 'transparent';
        circleFive.style.backgroundColor = 'transparent';
      }

      if (enteredPin.length == 3) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = '#01cfff';
        circleFour.style.backgroundColor = 'transparent';
        circleFive.style.backgroundColor = 'transparent';
      }

      if (enteredPin.length == 4) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = '#01cfff';
        circleFour.style.backgroundColor = '#01cfff';
        circleFive.style.backgroundColor = 'transparent';
      }

      if (enteredPin.length == 5) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = '#01cfff';
        circleFour.style.backgroundColor = '#01cfff';
        circleFive.style.backgroundColor = '#01cfff';

        if (scope.checkPinConfirm) {
          pinConfirm = enteredPin;
          scope.checkPinConfirm = false;
          if (pin == pinConfirm) {
            if (fromRegistration)
              enter(pin);
            else changePin(pin);
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = "Введенный CLICK-PIN не совпадает указанному ранее. Попробуйте еще раз!";

            console.log('scope.checkPin', scope.checkPin, 'scope.checkPinConfirm', scope.checkPinConfirm)
            scope.showError = true;
            scope.checkPin = true;
            scope.checkPinConfirm = false;
            scope.update();
            console.log('scope.checkPin', scope.checkPin, 'scope.checkPinConfirm', scope.checkPinConfirm)
            pinConfirm = '';
            pin = '';
            enteredPin = '';
            updateEnteredPin()
          }

        }
        else if (scope.nowCheckPin) {
          if (hex_md5(enteredPin) == localStorage.getItem('pinForStand')) {

            if (fromPayOrTransfer) {
              sessionStorage.setItem('payTransferConfirmed', true);
              onBackKeyDown();
            } else {
              scope.checkPin = true;
              scope.nowCheckPin = false;
              scope.checkPinConfirm = false;
              pinConfirm = '';
              pin = '';
              enteredPin = '';
              updateEnteredPin()
              scope.update();
            }
          }
          else {
            scope.clickPinError = false;
            scope.showError = true;

            if (fromPayOrTransfer) {
              scope.errorNote = window.languages.ViewPinCodeConfirmPayTransferErrorAlertText;
              sessionStorage.setItem('payTransferConfirmed', false);
              errorPinTimesCounter++;
              if (errorPinTimesCounter == 3) {
                console.log("OOPS");
                scope.errorNote = window.languages.ViewPinCodeConfirmPayTransferThirdErrorAlertText;
                scope.viewpage = "view-authorization";
              }

            } else {
              scope.errorNote = "Неверный текущий CLICK-PIN!";
            }

            scope.nowCheckPin = true;
            scope.checkPin = false;
            scope.checkPinConfirm = false;
            pinConfirm = '';
            pin = '';
            enteredPin = '';
            updateEnteredPin()
            scope.update();
          }
        } else if (scope.checkPin) {
          console.log('qwewewww')
          pin = enteredPin;
          scope.checkPin = false;
          scope.checkPinConfirm = true;
          enteredPin = '';
          scope.update();
          updateEnteredPin()
        }
      }
    }

    var registrationInterval;
    enter = function (pin) {
      event.preventDefault();
      event.stopPropagation();

      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      localStorage.setItem("click_client_pin", JSON.stringify(hex_md5(pin)))

//      if (device.platform != 'BrowserStand') {
//        var options = {dimBackground: true};
//
//        SpinnerPlugin.activityStart(languages.Downloading, options, function () {
//          console.log("Started");
//        }, function () {
//          console.log("closed");
//        });
//      }


      window.api.call({
        method: 'registration',
        input: {
          phone_num: phoneNumber,
          card_number: cardNumber,
          card_data: cardInformation,
          pin: hex_md5(pin)
        },
        scope: this,

        onSuccess: function (result) {
          console.log(result)
          console.log(result[0][0])
          if (result[0][0].error == 0) {

            var processOpacity = 10;
            scope.showRegistrationProcess = true;
            scope.update();
            scope.registrationProcessInterval = setInterval(function () {
              if (scope.registrationSuccess != 0 && scope.registrationSuccess != -2) {
                clearInterval(scope.registrationProcessInterval)
                return
              }

              if (window["registrationProcessingId"] && typeof window["registrationProcessingId"] !== "undefined") {

                registrationProcessingId.style.opacity = '0.' + processOpacity;
//        console.log('Changing Opacity')
                processOpacity++;
                if (processOpacity == 99) {
                  processOpacity = 10;
                }
              }
            }, 20)
            console.log('REGISTRATION CLIENT', result)
//            scope.clickPinError = false;
//            scope.errorNote = result[0][0].error_note;
//            scope.showError = true;

            localStorage.setItem("registration_check_id", JSON.stringify(result[1][0].check_id))
            localStorage.setItem("registration_check_hash", JSON.stringify(result[1][0].check_hash))
//            riotTags.innerHTML = "<view-authorization>";
//            riot.mount('view-authorization', {from: "registration-client"});
            scope.timeoutIndex = 0;
            setTimeout(function () {checkRegistrationFunction()}, 5000)
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            scope.viewpage = "view-registration-client"
            scope.update();
          }

        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })

    };

    scope.registrationSuccess = 0;

    var checkRegistrationTouchStartX, checkRegistrationTouchStartY, checkRegistrationTouchEndX,
      checkRegistrationTouchEndY;

    checkRegistrationTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      checkRegistrationTouchStartX = event.changedTouches[0].pageX;
      checkRegistrationTouchStartY = event.changedTouches[0].pageY;
    };

    checkRegistrationTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      checkRegistrationTouchEndX = event.changedTouches[0].pageX;
      checkRegistrationTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(checkRegistrationTouchStartX - checkRegistrationTouchEndX) <= 20 && Math.abs(checkRegistrationTouchStartY - checkRegistrationTouchEndY) <= 20) {
        scope.registrationSuccess = 0; //Выполнить повторную проверку
        scope.timeoutIndex = 0;
        scope.update();
        checkRegistrationFunction()
      }
    };

    checkRegistrationFunction = function () {
      console.log("CHECK REGISTRATION")
//      event.preventDefault();
//      event.stopPropagation();

      var phoneNumber = localStorage.getItem('click_client_phoneNumber');


//      if (device.platform != 'BrowserStand') {
//        var options = {dimBackground: true};
//
//        SpinnerPlugin.activityStart(languages.Downloading, options, function () {
//          console.log("Started");
//        }, function () {
//          console.log("closed");
//        });
//      }

      window.api.call({
        method: 'registration.check',
        input: {
          phone_num: phoneNumber,
          check_id: JSON.parse(localStorage.getItem("registration_check_id")),
          check_hash: JSON.parse(localStorage.getItem("registration_check_hash")),
        },
        scope: this,

        onSuccess: function (result) {
          console.log("SUCCESS registration.check");
          console.log(result)
          console.log(result[0][0])
          if (result[0][0].error == 0) {
            console.log('REGISTRATION CHECK', result)
            if (result[1][0].registered == 0) {

              if (scope.timeouts.length > scope.timeoutIndex) {

                setTimeout(function () {checkRegistrationFunction()}, scope.timeouts[scope.timeoutIndex]);
                scope.registrationSuccess = 0;
                scope.timeoutIndex++;
              } else {

                scope.registrationSuccess = -2;
                scope.timeoutIndex %= scope.timeouts.length;
              }

              scope.update();

              console.log("ANSWER OF CHECK REGISTRATION", 0)
              return;
            }
            else {
              if (result[1][0].registered == -1) {
                scope.registrationSuccess = -1;
                scope.errorRegistrationProcess = result[0][0].error_note;
//                clearInterval(registrationInterval)

                console.log("ANSWER OF CHECK REGISTRATION", -1)

//
//                setTimeout(function () {
//                  riotTags.innerHTML = "<view-registration-client>";
//                  riot.mount('view-registration-client')
//                }, 10000)
              }
              if (result[1][0].registered == 1) {
                window.standCheckRegistration = true;
                localStorage.setItem('click_client_registered', true)
                scope.registrationSuccess = 1;
//                clearInterval(registrationInterval)

                console.log("ANSWER OF CHECK REGISTRATION", 1)

              }

            }
            scope.update();
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            scope.viewpage = "view-registration-client"
            scope.update();

          }

        },
        onFail: function (api_status, api_status_message, data) {
          console.log("FAIL registration.check");
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })

    }

    changePin = function (pin) {
      console.log("aaa");
      event.preventDefault();
      event.stopPropagation();

      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      var currentPin = localStorage.getItem('pinForStand');

      window.api.call({
        method: 'settings.change.pin',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          current_pin: currentPin,
          new_pin: hex_md5(pin)
        },
        scope: this,

        onSuccess: function (result) {
          console.log(result)
          console.log(result[0][0])
          if (result[0][0].error == 0) {
            scope.clickPinError = false;
            scope.errorNote = "CLICK PIN успешно изменен";
            scope.showError = true;
            localStorage.setItem("click_client_pin", JSON.stringify(hex_md5(pin)))

            if (!fromRegistration)
              scope.stepToBack = 1;
            if (fromAuthorization) {
              scope.stepToBack = null
              scope.viewpage = 'view-main-page'
            }
            localStorage.setItem('pinForStand', hex_md5(pin));
            scope.update();

            //onBackKeyDown();
//            scope.unmount()
          }
          else {
            scope.showError = true;
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            if (!fromAuthorization)
              scope.stepToBack = 1;
            else {
              sessionStorage.clear()
              scope.viewpage = 'view-authorization'
              scope.stepToBack = null
            }
            scope.update();

            //onBackKeyDown();
            //scope.unmount()
          }

        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    }


  </script>
</view-pin-code>