<view-pin-code class="view-pincode riot-tags-main-container">
  <div class="pincode-flex-container">
    <div class="page-title">
    <div id="backButton" ontouchend="goToBackFromPinCodeTouchEnd()" ontouchstart="goToBackFromPinCodeTouchStart()"
         class="{back-button: backbuttoncheck}">
    </div>
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

  <button if="{device.platform != 'iOS'}" id="pinOfflineButtonId" class="authorization-footer-button-container"
       ontouchstart="offlineModeTouchStart()"
       ontouchend="offlineModeTouchEnd()">
    {window.languages.ViewAuthorizationOfflineModeLabel}
  </button>

  <script>

    var scope = this;

    scope.timeouts = [5000, 5000, 10000, 10000, 10000, 10000, 10000];
    scope.timeoutIndex = 0;

    this.on('mount', function () {
      if (device.platform != 'BrowserStand')
        StatusBar.backgroundColorByHexString("#ffffff");
    })

    window.saveHistory('view-pin-code', opts);


    console.log("OPTS", opts)


    var pin;
    var pinConfirm;
    var enteredPin = '';
    scope.checkPin = false;
    scope.nowCheckPin = true;
    scope.stepToBack = null;
    scope.checkPinConfirm = false;
    var fromRegistration = false;
    var fromAuthorization = false;
    var fromSettings = false;
    var fromPayOrTransfer = false;
    var timeOutTimer = 0;
    scope.showRegistrationProcess = false;
    scope.nowCheckPinTitle = window.languages.ViewPinCodeNowClickPinLabel;
    scope.backbuttoncheck = false;


    scope.labelOfTitle = window.languages.ViewPinCodeClickPinLabel;

    if (opts[0] == 'view-sms') {
      fromRegistration = true;
      scope.checkPin = true;
      scope.nowCheckPin = false
      console.log("ASD")
    } else if (opts[0] == 'view-security-settings') {
      fromSettings = true;
      fromAuthorization = false;
      fromRegistration = false;
      fromPayOrTransfer = false;
    }
    else if (opts[0] == 'view-pay-confirm' || opts[0] == 'view-transfer-submit') {
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

    //
    //    var registrationNextTouchStartX, registrationNextTouchStartY, registrationNextTouchEndX, registrationNextTouchEndY;
    //
    //    registrationProcessNextTouchStart = function () {
    //      event.preventDefault();
    //      event.stopPropagation();
    //
    //      registrationNextTouchStartX = event.changedTouches[0].pageX;
    //      registrationNextTouchStartY = event.changedTouches[0].pageY;
    //    }
    //
    //    registrationProcessNextTouchEnd = function () {
    //      event.preventDefault();
    //      event.stopPropagation();
    //
    //      registrationNextTouchEndX = event.changedTouches[0].pageX;
    //      registrationNextTouchEndY = event.changedTouches[0].pageY;
    //
    //      if (Math.abs(registrationNextTouchStartX - registrationNextTouchEndX) <= 20 && Math.abs(registrationNextTouchStartY - registrationNextTouchEndY) <= 20) {
    //
    //        riotTags.innerHTML = "<view-authorization>";
    //        riot.mount('view-authorization', {from: "registration-client"});
    //
    //        scope.unmount()
    //      }
    //    }
    //
    //    var registrationCheckStatusTouchStartX, registrationCheckStatusTouchStartY, registrationCheckStatusTouchEndX,
    //      registrationCheckStatusTouchEndY;
    //
    //    registrationProcessCheckStatusTouchStart = function () {
    //      event.preventDefault();
    //      event.stopPropagation();
    //
    //      registrationCheckStatusTouchStartX = event.changedTouches[0].pageX;
    //      registrationCheckStatusTouchStartY = event.changedTouches[0].pageY;
    //    }
    //
    //    registrationProcessCheckStatusTouchEnd = function () {
    //      event.preventDefault();
    //      event.stopPropagation();
    //
    //      registrationCheckStatusTouchEndX = event.changedTouches[0].pageX;
    //      registrationCheckStatusTouchEndY = event.changedTouches[0].pageY;
    //
    //      if (Math.abs(registrationCheckStatusTouchStartX - registrationCheckStatusTouchEndX) <= 20 && Math.abs(registrationCheckStatusTouchStartY - registrationCheckStatusTouchEndY) <= 20) {
    //
    //        riotTags.innerHTML = "<view-registration-client>";
    //        riot.mount('view-registration-client');
    //
    //      }
    //    }

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
        if (fromPayOrTransfer) {
          console.log('opts on backkeydown', opts[1]);
          onBackParams.opts = opts[1];
        }
        onBackKeyDown();
      }
    };

    updateEnteredPin = function () {


      if (enteredPin.length == 0) {
        circleOne.style.backgroundColor = '#b0aeb2';
        circleTwo.style.backgroundColor = '#b0aeb2';
        circleThree.style.backgroundColor = '#b0aeb2';
        circleFour.style.backgroundColor = '#b0aeb2';
        circleFive.style.backgroundColor = '#b0aeb2';
      }
      if (enteredPin.length == 1) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#b0aeb2';
        circleThree.style.backgroundColor = '#b0aeb2';
        circleFour.style.backgroundColor = '#b0aeb2';
        circleFive.style.backgroundColor = '#b0aeb2';
      }
      if (enteredPin.length == 2) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = '#b0aeb2';
        circleFour.style.backgroundColor = '#b0aeb2';
        circleFive.style.backgroundColor = '#b0aeb2';
      }

      if (enteredPin.length == 3) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = '#01cfff';
        circleFour.style.backgroundColor = '#b0aeb2';
        circleFive.style.backgroundColor = '#b0aeb2';
      }

      if (enteredPin.length == 4) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = '#01cfff';
        circleFour.style.backgroundColor = '#01cfff';
        circleFive.style.backgroundColor = '#b0aeb2';
      }

      if (enteredPin.length == 5) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = '#01cfff';
        circleFour.style.backgroundColor = '#01cfff';
        circleFive.style.backgroundColor = '#01cfff';

        console.log("enteredPin", enteredPin)

        setTimeout(function () {
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

              scope.checkPin = true;
              scope.checkPinConfirm = false;
              scope.update();

              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: scope.clickPinError,
                viewpage: scope.viewpage,
                errornote: scope.errorNote,
                errorcode: scope.errorCode,
                step_amount: scope.stepToBack
              });

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
                onBackParams.opts = opts[1];
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

              if (fromPayOrTransfer) {
                scope.errorNote = window.languages.ViewPinCodeConfirmPayTransferErrorAlertText;
                sessionStorage.setItem('payTransferConfirmed', false);
                errorPinTimesCounter++;
                if (errorPinTimesCounter == 3) {
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

              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: scope.clickPinError,
                viewpage: scope.viewpage,
                errornote: scope.errorNote,
                errorcode: scope.errorCode,
                step_amount: scope.stepToBack
              });
            }
          } else if (scope.checkPin) {
            pin = enteredPin;
            scope.checkPin = false;
            scope.checkPinConfirm = true;
            enteredPin = '';
            scope.update();
            updateEnteredPin()
          }
        }, 100)

      }
    }

    //    var registrationInterval;
    enter = function (pin) {
      //event.preventDefault();
      //event.stopPropagation();

      console.log("Enter of PINCODE");

      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      localStorage.setItem("click_client_pin", hex_md5(pin));


      window.api.call({
        method: 'user.register',
        input: {
          phone_num: phoneNumber,
          pin: hex_md5(pin),
          sign_string: hex_md5(phoneNumber.substring(0, 5) + 'CLICK' + phoneNumber.substring(5))
        },
        scope: this,

        onSuccess: function (result) {
          console.log(result)
          console.log(result[0][0])
          if (result[0][0].error == 0) {
            console.log("user register method result");

            localStorage.setItem('click_client_registered', true);
//            riotTags.innerHTML = "<view-authorization>";
//            riot.mount('view-authorization', {from: "registration-client"});
//            scope.unmount()

            var phoneNumber = localStorage.getItem('click_client_phoneNumber');
            var deviceId = localStorage.getItem('click_client_deviceID');
            var date = parseInt(Date.now() / 1000);
            var token = localStorage.getItem('click_client_token');
            console.log("pin before=", pin.toString());
            if (localStorage.getItem('click_client_pin')) {
              pin = localStorage.getItem('click_client_pin');
              var password = hex_sha512(token + date + pin);
            }
            localStorage.setItem("pinForStand", pin);
            authorizationPinCode(phoneNumber, deviceId, password, date);
          }
          else {
            console.log("pincode error part")
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.viewpage = "view-registration-device"
            scope.update();

            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: scope.clickPinError,
              viewpage: scope.viewpage,
              errornote: scope.errorNote,
              errorcode: scope.errorCode,
              step_amount: scope.stepToBack
            });
          }
        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    };

    //    scope.registrationSuccess = 0;

    function authorizationPinCode(phoneNumber, deviceId, password, date) {
      scope.firstEnter = false;
//      if (scope.firstEnter)
//        firstPinInputId.blur();

      var version = localStorage.getItem('version')

      window.startSpinner();

      window.api.call({
        method: 'app.login',
        stopSpinner: false,
        input: {
          phone_num: phoneNumber,
          device_id: deviceId,
          password: password,
          datetime: date,
          app_version: version
        },
        scope: this,


        onSuccess: function (result) {
          console.log('Clearing timer onSuccess', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          console.log("App.login method answer: success");

          if (result[0][0].error == 0) {
            if (!result[1][0].error) {
              console.log("User is authorized");

//              localStorage.setItem('click_client_pin', pin)
              localStorage.setItem('myNumberOperatorId', result[1][0].my_service_id);
              modeOfflineMode.check = false;
              var JsonInfo = JSON.stringify(result[1][0]);
              localStorage.setItem('click_client_loginInfo', JsonInfo);

              checkSessionKey = true;
              viewAuthorization.check = false;
              localStorage.setItem("click_client_authorized", true);

              if (localStorage.getItem('click_client_friends') && JSON.parse(localStorage.getItem('click_client_friends'))) {
                var friends = JSON.parse(localStorage.getItem('click_client_friends'));
                var outerFriendsCount = JSON.parse(localStorage.getItem('click_client_friendsOuter_count'));
                friends.splice(friends.length - outerFriendsCount, outerFriendsCount);
                localStorage.setItem('click_client_friends', JSON.stringify(friends));
                localStorage.removeItem('click_client_friendsOuter_count')
              }

              if (!localStorage.getItem('settings_finger_print')) {
                localStorage.setItem('settings_finger_print', false)
              }


              getAccount(checkSessionKey, scope.firstEnter);
              window.pushNotificationActions.retrievePushNotification();
            }
          }
          else {
            window.stopSpinner();

            if (result[0][0].error == -31) {
              console.log("click pin error");
              scope.clickPinError = true;
            } else if (result[0][0].error == -799) {
              scope.errorNote = result[0][0].error_note;
              scope.errorCode = 2;
              console.log("client not registered error");
            } else {
              console.log(opts)
              scope.errorNote = result[0][0].error_note;
              scope.clickPinError = false;
              console.log("errornote = ", scope.errorNote);
              scope.checkPin = true;
              scope.checkPinConfirm = false;
              scope.update();
              pinConfirm = '';
              pin = '';
              enteredPin = '';
            }
            scope.update();

            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: scope.clickPinError,
              viewpage: scope.viewpage,
              errornote: scope.errorNote,
              errorcode: scope.errorCode,
              step_amount: scope.stepToBack
            });
            enteredPin = '';
            if (!scope.firstEnter)
              updateEnteredPin();
          }
        },
        onFail: function (api_status, api_status_message, data) {
          console.log('Clearing timer onFail', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          updateAlertComponent(true, null, 'view-authorization', "Сервис временно не доступен");
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error("Error data: ", data);
        },
        onTimeOut: function () {
          timeOutTimer = setTimeout(function () {
            window.writeLog({
              reason: 'Timeout',
              method:'app.login',
            });
            updateAlertComponent(true, null, 'view-authorization', window.languages.WaitingTimeExpiredText);
            window.stopSpinner();
          }, 30000);
          console.log('creating timeOut', timeOutTimer);
        },
        onEmergencyStop: function () {
          console.log('Clearing timer emergencyStop', timeOutTimer);
          window.clearTimeout(timeOutTimer);
        }
      }, 30000);
    }


    changePin = function (pin) {

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
            localStorage.setItem("click_client_pin", JSON.stringify(hex_md5(pin)))

            if (!fromRegistration)
              scope.stepToBack = 1;
            if (fromAuthorization) {
              scope.stepToBack = null;
              scope.viewpage = 'view-main-page';
              console.log("FIRST ENTER CHANGE PIN fingerprint init ");
              fingerPrintInit();
            }
            localStorage.setItem('pinForStand', hex_md5(pin));
            scope.update();

            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: scope.clickPinError,
              viewpage: scope.viewpage,
              errornote: scope.errorNote,
              errorcode: scope.errorCode,
              step_amount: scope.stepToBack
            });

            //onBackKeyDown();
//            scope.unmount()
          }
          else {

            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            if (!fromAuthorization)
              scope.stepToBack = 1;
            else {
              sessionStorage.clear()
              scope.viewpage = 'view-authorization';
              scope.stepToBack = null
            }
            scope.update();

            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: scope.clickPinError,
              viewpage: scope.viewpage,
              errornote: scope.errorNote,
              errorcode: scope.errorCode,
              step_amount: scope.stepToBack
            });

            //onBackKeyDown();
            //scope.unmount()
          }

        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    };


    updateAlertComponent = function (showError, stepAmount, viewPage, text) {
      console.log("OPEN ALERT COMPONENT:", showError, text, stepAmount, viewPage);

      scope.stepAmount = stepAmount;

      scope.viewpage = viewPage;
      scope.errorNote = text;
      riot.update();

      if (showError) {

        window.common.alert.show("componentAlertId", {
          parent: scope,
          clickpinerror: scope.clickPinError,
          viewpage: scope.viewpage,
          errornote: scope.errorNote,
          errorcode: scope.errorCode,
          step_amount: scope.stepToBack
        });
      } else {

        window.common.alert.hide("componentAlertId");
      }
    }


  </script>
</view-pin-code>