<view-authorization class="view-authorization riot-tags-main-container">

  <div if="{!firstEnter}" class="authorization-flex-container">
    <div class="authorization-unchangable-container">
      <div class="authorization-enter-pin-label">{window.languages.ViewAuthorizationClickPinLabel}</div>
      <div class="authorization-pin-container">
        <div class="authorization-pin-field">
          <div id="circleOne" class="authorization-pin-circles authorization-pin-one"></div>
          <div id="circleTwo" class="authorization-pin-circles authorization-pin-two"></div>
          <div id="circleThree" class="authorization-pin-circles authorization-pin-three"></div>
          <div id="circleFour" class="authorization-pin-circles authorization-pin-four"></div>
          <div id="circleFive" class="authorization-pin-circles authorization-pin-five"></div>
        </div>
      </div>
    </div>
  </div>

  <div if="{!firstEnter}" class="authorization-keyboard-field keyboard-field">
    <component-keyboard fingerprint="{JSON.parse(localStorage.getItem('settings_finger_print'))}"></component-keyboard>
  </div>


  <div id="authorizationButtonsContainerId" class="authorization-buttons-container">
    <div if="{firstEnter}" class="authorization-first-enter-pin-label">
      {window.languages.ViewAuthorizationClickPinLabel}
    </div>
    <div if="{firstEnter}" class="authorization-pin-input-first-enter-container">
      <input autofocus="true" type="password" class="authorization-pin-input-first-enter" onblur="inputPinBlur()"
             id="firstPinInputId"/>
      <div class="authorization-input-eye-button" role="button"
           aria-label="{window.languages.ViewAuthorizationFirstEnterAriaLabelShowPass}"
           onclick="eyeClicked()"></div>
    </div>
    <div if="{firstEnter}" id="firstEnterButtonId" class="authorization-button-first-enter"
         ontouchend="firstPinEnterTouchEnd()"
         ontouchstart="firstPinEnterTouchStart()">
      <div class="button-enter-label">{window.languages.ViewAuthorizationFirstEnterLabel}</div>
    </div>

    <div id="forgetPinButtonId" class="authorization-button-forget-pin" ontouchstart="pinResetTouchStart()"
         ontouchend="pinResetTouchEnd()">
      {window.languages.ViewAuthorizationForgetPinLabel}
    </div>
    <div id="resetLocalButtonId" class="authorization-button-registration" ontouchstart="resetLocalStorageTouchStart()"
         ontouchend="resetLocalStorageTouchEnd()">
      {window.languages.ViewAuthorizationResetLocalStorageLabel}
    </div>
  </div>
  <div id="authOfflineButtonId" hidden="{device.platform == 'iOS'}"
       class="{authorization-button-offline : !firstEnter, authorization-button-offline-first-enter : firstEnter}"
       ontouchstart="offlineModeTouchStart()"
       ontouchend="offlineModeTouchEnd()">
    {window.languages.ViewAuthorizationOfflineModeLabel}
  </div>

  <component-pin-reset></component-pin-reset>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}" errorcode="{errorCode}"></component-alert>

  <component-confirm if="{confirmShowBool}" confirmnote="{confirmNote}"
                     confirmtype="{confirmType}"></component-confirm>

  <script>


    //    TEST = function () {
    //      CardIO.scan({
    //        "expiry": true,
    //        "cvv": true,
    //        "zip": false,
    //        "suppressManual": false,
    //        "suppressConfirm": false,
    //        "hideLogo": true
    //      }, onCardIOComplete, onCardIOCancel);
    //    };
    //
    //    if (device.platform != 'BrowserStand')
    //      CardIO.canScan(onCardIOCheck);
    //
    //    function onCardIOComplete(response) {
    //      var cardIOResponseFields = [
    //        "card_type",
    //        "redacted_card_number",
    //        "card_number",
    //        "expiry_month",
    //        "expiry_year",
    //        "cvv",
    //        "zip"
    //      ];
    //
    //      var len = cardIOResponseFields.length;
    //      console.log("card.io scan complete");
    //      for (var i = 0; i < len; i++) {
    //        var field = cardIOResponseFields[i];
    //        alert(field + ": " + response[field]);
    //      }
    //    }
    //
    //    function onCardIOCancel(error) {
    //      console.log("card.io scan cancelled");
    //      console.log(error)
    //    }
    //
    //    function onCardIOCheck(canScan) {
    //      console.log("card.io canScan? " + canScan);
    //      if (!canScan) {
    //        console.log('can Scan false')
    //      }
    //    }

    this.on('mount', function () {

      localStorage.setItem('session_broken', false);

      if (scope.firstEnter) {

        authorizationButtonsContainerId.style.top = 400 * widthK + 'px';

        if (device.platform == 'iOS') {
          firstPinInputId.autofocus;
          firstPinInputId.focus();
        }
        else {
          setTimeout(function () {
            firstPinInputId.focus();
          }, 0)
        }
      }
      scope.update();
    });

    window.lastSocketMethodToSend = undefined;

    localStorage.setItem("click_client_authorized", false);

    var scope = this;
    scope.checkAndroid = false;
    scope.errorCode = 0;

    if (localStorage.getItem("click_client_accountInfo")) {
      scope.firstEnter = false;
    }
    else {
      if (JSON.parse(localStorage.getItem('click_client_registered')) == true && !localStorage.getItem("click_client_accountInfo") && opts && opts.from && opts.from == "registration-client")
        scope.firstEnter = false;
      else
        scope.firstEnter = true;
    }

    scope.showError = false;
    scope.confirmShowBool = false;

    if (history.arrayOfHistory.length != 0) {
      if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-authorization' && !JSON.parse(localStorage.getItem('onResume')) && !JSON.parse(localStorage.getItem('session_broken'))) {
        history.arrayOfHistory.push(
          {
            "view": 'view-authorization',
            "params": opts
          }
        );
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
      }
    }
    else {
      history.arrayOfHistory.push(
        {
          "view": 'view-authorization',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }


    if (device.platform != 'BrowserStand')
      StatusBar.backgroundColorByHexString("#00b0eb");

    if (device.platform == 'Android') {
      scope.checkAndroid = true;
    }

    if (!localStorage.getItem('settings_finger_print')) {
      localStorage.setItem('settings_finger_print', false)
    }


    fingerPrintTurnOn = function () {
      window.fingerPrint.fingerPrintInitialize = true;
      if (localStorage.getItem('settings_finger_print') !== null) {
        if (device.platform == 'Android') {

          function isAvailableSuccess(result) {
            console.log("FingerprintAuth available: " + JSON.stringify(result));
            if (result.isAvailable) {
              window.fingerPrint.check = true;
              localStorage.setItem('settings_finger_print_enrolled', true)

              if (window.fingerPrint.check) {
                var encryptConfig = {
                  clientId: "myAppName",
                  clientSecret: "currentUser",
                  password: "currentUser",
                  token: "currentUser",
                  locale: "ru",
                  disableBackup: true,
//              userAuthRequired: false,
                  dialogHint: "Повторите попытку",
                  dialogTitle: "Сканирование для CLICK"

                }; // See config object for required parameters

                if (localStorage.getItem("settings_finger_print") !== null) {
                  if (JSON.parse(localStorage.getItem("settings_finger_print")) === true && localStorage.getItem('click_client_pin')) {

                    FingerprintAuth.encrypt(encryptConfig, encryptSuccessCallback, encryptErrorCallback);
                  }
                  else {

                    if (!localStorage.getItem('click_client_cards')) {
                      onConfirm = function (index) {
                        if (index == 1) {
                          localStorage.setItem('settings_finger_print', true)

                        }
                        else {
                          localStorage.setItem('settings_finger_print', false)
                        }
                      }

                      navigator.notification.confirm(
                        'Хотите использовать ее для CLICK?',  // message
                        onConfirm,              // callback to invoke with index of button pressed
                        'Устройтсво поддерживает технологию TouchID',            // title
                        ['Да', 'Нет']          // buttonLabels
                      );
                    }
                  }
                }
              }
            }
            else {
              window.fingerPrint.check = false
              riot.update();
            }
          }

          function isAvailableError(message) {
            console.log("isAvailableError(): " + message);
            window.fingerPrint.check = false;
            riot.update();
          }

          FingerprintAuth.isAvailable(isAvailableSuccess, isAvailableError);


          function encryptSuccessCallback(result) {
            window.fingerPrint.fingerPrintInitialize = false;
            console.log("successCallback(): " + JSON.stringify(result));
            if (result.withFingerprint) {
              console.log("Successfully encrypted credentials.");
              console.log("Encrypted credentials: " + result.token);
              pin = localStorage.getItem('click_client_pin');
              console.log('pin', pin)
              enter();
            } else if (result.withBackup) {
              console.log("Authenticated with backup password");
              pin = localStorage.getItem('click_client_pin');
              console.log('pin', pin)
              enter();
            }
          }

          function encryptErrorCallback(error) {
            window.fingerPrint.fingerPrintInitialize = false;
            if (error === "Cancelled") {
              console.log("FingerprintAuth Dialog Cancelled!");
            } else {
              console.log("FingerprintAuth Error: " + error);
            }
          }

        }
        else if (device.platform == 'iOS') {

          function successCallback(success) {
            window.fingerPrint.check = true;
            localStorage.setItem('settings_finger_print_enrolled', true)
            console.log('success', success)

            if (localStorage.getItem("settings_finger_print") !== null) {
              if (JSON.parse(localStorage.getItem("settings_finger_print")) === true && localStorage.getItem('click_client_pin')) {
                var text = 'Приложите палец для сканирования';
                window.plugins.touchid.verifyFingerprint(text, successCallbackOfAuth, failureCallbackOfAuth);
              }
              else {
                if (!localStorage.getItem('click_client_cards')) {
                  onConfirm = function (index) {
                    if (index == 1) {
                      localStorage.setItem('settings_finger_print', true)
                    }
                    else {
                      localStorage.setItem('settings_finger_print', false)
                    }
                  }

                  navigator.notification.confirm(
                    'Хотите использовать ее для CLICK?',  // message
                    onConfirm,              // callback to invoke with index of button pressed
                    'Устройтсво поддерживает технологию TouchID',            // title
                    ['Да', 'Нет']          // buttonLabels
                  );
                }
              }
            }
          }

          function notSupportedCallback(error) {
            console.log('error', error)
            window.fingerPrint.check = false;
            localStorage.setItem('settings_finger_print_enrolled', false)
          }


          window.plugins.touchid.isAvailable(successCallback, notSupportedCallback);


          function successCallbackOfAuth(success) {
            window.fingerPrint.fingerPrintInitialize = false;
            console.log(success)
            console.log('SUCCIESS FINGER PRINT')
            pin = localStorage.getItem('click_client_pin');
            enter();
          }

          function failureCallbackOfAuth(error) {
            window.fingerPrint.fingerPrintInitialize = false;
            console.log(error)
            console.log('FAIL FINGER PRINT')
          }
        }
      }
    }

    if (typeof window.fingerPrint.fingerPrintInitialize != undefined && window.fingerPrint.fingerPrintInitialize == false) {

      try {
        fingerPrintTurnOn();
      }
      catch (e) {
        console.log(e)
      }
    }

    var eyeInputShow = false;

    eyeClicked = function () {
      event.preventDefault();
      event.stopPropagation();

      if (!eyeInputShow) {
        firstPinInputId.type = "text"
        eyeInputShow = true;
      }
      else {
        firstPinInputId.type = "password"
        eyeInputShow = false;
      }

    }

    inputPinBlur = function () {
//      event.preventDefault();
//      event.stopPropagation();


      firstPinInputId.blur();
    }

    var pinResetTouchStartX, pinResetTouchStartY, pinResetTouchEndX, pinResetTouchEndY;

    pinResetTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      forgetPinButtonId.style.webkitTransform = 'scale(0.8)'

      pinResetTouchStartX = event.changedTouches[0].pageX
      pinResetTouchStartY = event.changedTouches[0].pageY


    };


    pinResetTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      forgetPinButtonId.style.webkitTransform = 'scale(1)'

      pinResetTouchEndX = event.changedTouches[0].pageX
      pinResetTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(pinResetTouchStartX - pinResetTouchEndX) <= 20 && Math.abs(pinResetTouchStartY - pinResetTouchEndY) <= 20) {
        if (scope.firstEnter)
          firstPinInputId.blur();
        componentPinResetId.style.display = 'block';
      }
    };

    var resetLocalStorageTouchStartX, resetLocalStorageTouchStartY, resetLocalStorageTouchEndX,
      resetLocalStorageTouchEndY;

    resetLocalStorageTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      resetLocalButtonId.style.webkitTransform = 'scale(0.8)'
      resetLocalStorageTouchStartX = event.changedTouches[0].pageX
      resetLocalStorageTouchStartY = event.changedTouches[0].pageY

    }

    resetLocalStorageTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      resetLocalButtonId.style.webkitTransform = 'scale(1)'

      resetLocalStorageTouchEndX = event.changedTouches[0].pageX
      resetLocalStorageTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(resetLocalStorageTouchStartX - resetLocalStorageTouchEndX) <= 20 && Math.abs(resetLocalStorageTouchStartY - resetLocalStorageTouchEndY) <= 20) {
        if (scope.firstEnter)
          firstPinInputId.blur();

        var question = 'Подтвердите удаление данных'
        scope.confirmShowBool = true;
        scope.confirmNote = question;
        scope.confirmType = 'local';
        scope.update();
        scope.result = function (bool) {
          if (bool) {
            localStorage.clear();
            if (device.platform != 'BrowserStand') {
              window.FirebasePlugin.unsubscribe("news");
            }
            riotTags.innerHTML = "<view-registration-device>";
            riot.mount('view-registration-device');
            scope.unmount()
            return
          }
        };
      }
    };

    var pin;
    var enteredPin = '';
    var checkSessionKey = false;

    var keyboardTouchStartX, keyboardTouchStartY, keyboardTouchEndX, keyboardTouchEndY;

    componentKeyboard.returnStartValue = function (id) {

      document.getElementById(id).style.webkitTransform = 'scale(0.8)'

      keyboardTouchStartX = event.changedTouches[0].pageX
      keyboardTouchStartY = event.changedTouches[0].pageY
    }

    componentKeyboard.returnValue = function (myValue, id) {

      document.getElementById(id).style.webkitTransform = 'scale(1)'

      keyboardTouchEndX = event.changedTouches[0].pageX
      keyboardTouchEndY = event.changedTouches[0].pageY


      if (Math.abs(keyboardTouchStartX - keyboardTouchEndX) <= 20 && Math.abs(keyboardTouchStartY - keyboardTouchEndY) <= 20) {

        if (enteredPin.length < 5 && myValue != 'x' && myValue != 'space') {
          enteredPin += myValue;
        }
        if (myValue == 'x') {
          enteredPin = enteredPin.substring(0, enteredPin.length - 1);
        }

        if (myValue == "space" && JSON.parse(localStorage.getItem('settings_finger_print')) == true) {
          try {
            fingerPrintTurnOn();
          }
          catch (e) {
            console.log(e)
          }
        }

        scope.update();
        updateEnteredPin();
      }
    }

    var offlineModeTouchStartX, offlineModeTouchStartY, offlineModeTouchEndX, offlineModeTouchEndY;

    offlineModeTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      authOfflineButtonId.style.webkitTransform = 'scale(0.8)'

      offlineModeTouchStartX = event.changedTouches[0].pageX
      offlineModeTouchStartY = event.changedTouches[0].pageY

    }
    offlineModeTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      authOfflineButtonId.style.webkitTransform = 'scale(1)'

      offlineModeTouchEndX = event.changedTouches[0].pageX
      offlineModeTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(offlineModeTouchStartX - offlineModeTouchEndX) <= 20 && Math.abs(offlineModeTouchStartY - offlineModeTouchEndY) <= 20) {
        modeOfApp.onlineMode = false
        modeOfApp.offlineMode = true;

        this.riotTags.innerHTML = "<view-main-page>";
        riot.mount('view-main-page');
        scope.unmount()
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
        pin = hex_md5(enteredPin);
        enter();
      }
    };

    var firstPinEnterTouchStartX, firstPinEnterTouchStartY, firstPinEnterTouchEndX, firstPinEnterTouchEndY;

    firstPinEnterTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      firstEnterButtonId.style.webkitTransform = 'scale(0.8)'

      firstPinEnterTouchStartX = event.changedTouches[0].pageX
      firstPinEnterTouchStartY = event.changedTouches[0].pageY
    }

    firstPinEnterTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      firstEnterButtonId.style.webkitTransform = 'scale(1)'

      firstPinEnterTouchEndX = event.changedTouches[0].pageX
      firstPinEnterTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(firstPinEnterTouchStartX - firstPinEnterTouchEndX) <= 20 && Math.abs(firstPinEnterTouchStartY - firstPinEnterTouchEndY) <= 20) {
        pin = hex_md5(firstPinInputId.value);
        enter()
      }
    }

    enter = function () {

      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      var deviceId = localStorage.getItem('click_client_deviceID');
      var date = parseInt(Date.now() / 1000);
      var token = localStorage.getItem('click_client_token');
      if (!pin && localStorage.getItem('click_client_pin')) {
        pin = localStorage.getItem('click_client_pin');
      }
      var password = hex_sha512(token + date + pin);
      localStorage.setItem("pinForStand", pin);

      authorization(phoneNumber, deviceId, password, date);
    };

    var answerFromServer;

    function authorization(phoneNumber, deviceId, password, date) {

      if (scope.firstEnter)
        firstPinInputId.blur();

      var version = localStorage.getItem('version')
      answerFromServer = false;

      if (device.platform != 'BrowserStand') {
        var options = {dimBackground: true};
        SpinnerPlugin.activityStart(languages.Downloading, options, function () {
          console.log("Spinner start in authorization");
        }, function () {
          console.log("Spinner stop in authorization");
        });
      }

      window.api.call({
        method: 'app.login',
        stopSpinner: true,
        input: {
          phone_num: phoneNumber,
          device_id: deviceId,
          password: password,
          datetime: date,
          app_version: version
        },
        scope: this,

        onSuccess: function (result) {
          answerFromServer = true;
          console.log("App.login method answer: success");

          if (result[0][0].error == 0) {
            if (!result[1][0].error) {
              console.log("User is authorized");

              localStorage.setItem('click_client_pin', pin)
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

              getAccount();
              window.pushNotificationActions.retrievePushNotification();
            }
          }
          else {
            if (device.platform != 'BrowserStand') {
              console.log("Spinner Stop View Authorization");
              SpinnerPlugin.activityStop();
            }

            if (result[0][0].error == -31) {
              console.log("click pin error");
              scope.clickPinError = true;
            } else if (result[0][0].error == -799) {
              scope.errorNote = result[0][0].error_note;
              scope.errorCode = 2;
              console.log("client not registered error");
            } else {
              console.log(opts)
              if (opts.from == "registration-client") {
                scope.errorNote = "Карта ещё не добавлена. Попробуйте войти через несколько минут";
              }
              else
                scope.errorNote = result[0][0].error_note;
              scope.clickPinError = false;
              console.log("errornote = ", scope.errorNote);
            }
            scope.showError = true;
            scope.update();
            enteredPin = '';
            if (!scope.firstEnter)
              updateEnteredPin();
            return
          }
        },
        onFail: function (api_status, api_status_message, data) {
          answerFromServer = true;
          console.log("App.login method answer: fail");
          showAlertComponent("Сервис временно не доступен");
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error("Error data: ", data);
          return;
        }
      });

      setTimeout(function () {
        if (!answerFromServer && window.isConnected) {
          showAlertComponent("Время ожидания истекло");
          answerFromServer = true;
          if (device.platform != 'BrowserStand') {
            console.log("Spinner stop in authorization by timeout");
            SpinnerPlugin.activityStop();
          }
          window.isConnected = false;
          return
        }
      }, 30000)
    }

    if (checkSessionKey) {
      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = loginInfo.session_key;
    }

    getAccount = function () {

      if (history.arrayOfHistory.length < 2) {
        localStorage.setItem('onResume', false)
      }

      if (JSON.parse(localStorage.getItem("click_client_loginInfo"))) {
        var phoneNumber = localStorage.getItem("click_client_phoneNumber");
        var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
        var sessionKey = info.session_key;

        if (scope.firstEnter) {
          var lengthOfPin = firstPinInputId.value.length;
          var compareLength = window.inputVerification.spaceDeleter(firstPinInputId.value);
          console.log("First enter in account");
        }

        if (scope.firstEnter && (lengthOfPin != compareLength.length || lengthOfPin != 5)) {
          riotTags.innerHTML = "<view-pin-code>";
          riot.mount('view-pin-code', ['view-authorization']);
        }
        else if (!localStorage.getItem("click_client_accountInfo")) {
          this.riotTags.innerHTML = "<view-main-page>";
          riot.mount('view-main-page');
          scope.unmount()
        }
        else {
          if (!JSON.parse(localStorage.getItem('onResume')) && !JSON.parse(localStorage.getItem('session_broken')) && !JSON.parse(sessionStorage.getItem("push_news"))) {
            this.riotTags.innerHTML = "<view-main-page>";
            riot.mount('view-main-page');
          }
          else {
            if (localStorage.getItem('settings_block') || localStorage.getItem('session_broken') || sessionStorage.getItem("push_news")) {
              if (JSON.parse(localStorage.getItem('settings_block')) === true || JSON.parse(localStorage.getItem('session_broken')) === true || JSON.parse(sessionStorage.getItem("push_news")) === true) {
                if (history.arrayOfHistory) {
                  if (history.arrayOfHistory[history.arrayOfHistory.length - 1]) {
                    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view == 'view-news') {
                      this.riotTags.innerHTML = "<view-main-page>";
                      riot.mount("view-main-page");
                    }
                    else {
                      this.riotTags.innerHTML = "<" + history.arrayOfHistory[history.arrayOfHistory.length - 1].view + ">";
                      riot.mount(history.arrayOfHistory[history.arrayOfHistory.length - 1].view, history.arrayOfHistory[history.arrayOfHistory.length - 1].params);
                    }

                    if (device.platform != 'BrowserStand')
                      StatusBar.backgroundColorByHexString("#00a8f1");

                    if (JSON.parse(localStorage.getItem('settings_block')) === true) {
                      localStorage.setItem('onResume', false);
                    }
                    else {
                      if (JSON.parse(localStorage.getItem('session_broken')) === true) {
                        localStorage.setItem('session_broken', false);
                      }
                      else {
                        if (JSON.parse(sessionStorage.getItem("push_news")) === true) {
                          sessionStorage.setItem("push_news", false)
                        }
                      }
                    }
                    return
                  }
                }
              }
              else {
                this.riotTags.innerHTML = "<view-main-page>";
                riot.mount('view-main-page');
              }
            }
            else {
              this.riotTags.innerHTML = "<view-main-page>";
              riot.mount('view-main-page');
            }
          }
        }

        if ((!localStorage.getItem("click_client_payCategoryList") || info.update_categories) && modeOfApp.onlineMode) {

          scope.categoryList = [];
          scope.categoryNamesMap = {};
          window.api.call({
            method: 'get.service.category.list',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber
            },
            scope: this,

            onSuccess: function (result) {
              if (result[0][0].error == 0)
                if (result[1][0]) {
                  if (device.platform != 'BrowserStand') {
                    window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
                      var j = -1;

                      for (var i in result[1]) {
                        scope.categoryNamesMap[result[1][i].id] = {
                          "name": result[1][i].name,
                          "icon": result[1][i].icon
                        };
                        j++;
                        scope.categoryList.push(result[1][i]);

                        var icon = result[1][i].icon;
                        var filename = icon.substr(icon.lastIndexOf('/') + 1);

                        var newIconBool = checkImageURL;
                        newIconBool('www/resources/icons/ViewPay/', 'ViewPay', filename, icon, j, function (bool, index, fileName) {

                          if (bool) {
                            scope.categoryList[index]['icon'] = cordova.file.dataDirectory + fileName;
                          } else {
                            scope.categoryList[index]['icon'] = 'resources/icons/ViewPay/' + fileName;
                          }

                          if (result[1].length == scope.categoryList.length) {
                            scope.update(scope.categoryList);
                            localStorage.setItem('click_client_payCategoryList', JSON.stringify(scope.categoryList));
                            localStorage.setItem('click_client_categoryNamesMap', JSON.stringify(scope.categoryNamesMap));
                          }
                        });
                      }
                    }, onErrorLoadFs);
                  }
                  else {
                    for (var i in result[1]) {

                      scope.categoryList.push(result[1][i]);
                      scope.categoryNamesMap[result[1][i].id] = {
                        "name": result[1][i].name,
                        "icon": result[1][i].icon
                      };
                    }
                    localStorage.setItem('click_client_payCategoryList', JSON.stringify(scope.categoryList));
                    localStorage.setItem('click_client_categoryNamesMap', JSON.stringify(scope.categoryNamesMap));
                  }
                }

              scope.id = 0;

            },
            onFail: function (api_status, api_status_message, data) {
              console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
              console.error(data);
            }
          });
        }
        /*
         * Убрана проверка, так как по требованию в онлайн режиме всегда производится вызов сервисов.
         * */
        if ((!(localStorage.getItem("click_client_payServiceList") && localStorage.getItem("click_client_servicesMapByCategory")
          && localStorage.getItem("click_client_servicesMap")) || info.update_services) && modeOfApp.onlineMode) {
          scope.serviceList = [];
          scope.servicesMapByCategory = {};
          scope.servicesMap = {};
          scope.serviceNamesMap = {};
          scope.operatorKey = phoneNumber.substr(3, 2);
          window.api.call({
            method: 'get.service.list',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber
            },
            scope: this,

            onSuccess: function (result) {
              if (result[0][0].error == 0)
                if (result[1][0]) {
                  var firstService;

                  for (var i in result[1]) {
                    if (result[1][i].is_visible == 1) {

                      scope.serviceNamesMap[result[1][i].id] = result[1][i].name;
                      scope.serviceList.push(result[1][i]);

                      if (!scope.servicesMapByCategory[result[1][i].category_id]) {
                        scope.servicesMapByCategory[result[1][i].category_id] = [];
                        if (result[1][i].category_id === 1 && (result[1][i].id === window.mOperators[scope.operatorKey])) {
                          localStorage.setItem('myNumberOperatorId', result[1][i].id);

                          var myNumberObject = {};
                          myNumberObject.name = 'Мой номер';
                          myNumberObject.image = 'resources/icons/ViewPay/myphone.png';
                          myNumberObject.id = 'mynumber' + result[1][i].id;
                          scope.servicesMapByCategory[result[1][i].category_id].push(myNumberObject);

                        } else if (result[1][i].category_id === 1) {
                          firstService = result[1][i];
                        }
                        scope.servicesMapByCategory[result[1][i].category_id].push(result[1][i]);
                      }
                      else {
                        if (result[1][i].category_id === 1 && (result[1][i].id === window.mOperators[scope.operatorKey])) {
                          localStorage.setItem('myNumberOperatorId', result[1][i].id);

                          var myNumberObject = {};
                          myNumberObject.name = 'Мой номер';
                          myNumberObject.image = 'resources/icons/ViewPay/myphone.png';
                          myNumberObject.id = 'mynumber' + result[1][i].id;
                          scope.servicesMapByCategory[result[1][i].category_id][0] = myNumberObject;
                          scope.servicesMapByCategory[result[1][i].category_id].push(firstService);
                        }
                        scope.servicesMapByCategory[result[1][i].category_id].push(result[1][i]);
                      }

                      if (!scope.servicesMap[result[1][i].id + '']) {
                        scope.servicesMap[result[1][i].id + ''] = [];
                        scope.servicesMap[result[1][i].id + ''].push(result[1][i]);
                      }
                      else {
                        scope.servicesMap[result[1][i].id + ''].push(result[1][i]);
                      }
                    }
                  }
                  localStorage.setItem('click_client_payServiceList', JSON.stringify(scope.serviceList));
                  localStorage.setItem('click_client_payServiceNamesMap', JSON.stringify(scope.serviceNamesMap));
                  localStorage.setItem('click_client_servicesMapByCategory', JSON.stringify(scope.servicesMapByCategory));
                  localStorage.setItem('click_client_servicesMap', JSON.stringify(scope.servicesMap));
                  serviceImagesCaching();
                }
              servicesParamsInit();
            },
            onFail: function (api_status, api_status_message, data) {
              console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
              console.error(data);
            }
          })
        }

        serviceImagesCaching = function () {
          if (device.platform != 'BrowserStand') {
            window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
              var j = -1, counter = 0;

              for (var i in scope.serviceList) {
                j++;

                var icon = scope.serviceList[i].image;
                var filename = icon.substr(icon.lastIndexOf('/') + 1);

                var newIconBool = checkImageURL;
                newIconBool('www/resources/icons/ViewPay/', 'ViewPay', filename, icon, j, function (bool, index, fileName) {

                  if (bool) {
                    counter++;
                    scope.serviceList[index].image = cordova.file.dataDirectory + fileName;
                    scope.servicesMap[scope.serviceList[index].id + ''][0].image = cordova.file.dataDirectory + fileName;

                    for (var k = 0; k < scope.servicesMapByCategory[scope.serviceList[index].category_id].length; k++) {
                      if (scope.servicesMapByCategory[scope.serviceList[index].category_id][k].id != ('mynumber' + localStorage.getItem('myNumberOperatorId')) &&
                        scope.servicesMapByCategory[scope.serviceList[index].category_id][k].id == scope.serviceList[index].id) {
                        scope.servicesMapByCategory[scope.serviceList[index].category_id][k].image = cordova.file.dataDirectory + fileName;
                      }
                    }

                    if (counter == scope.serviceList.length) {
                      localStorage.setItem('click_client_servicesMapByCategory', JSON.stringify(scope.servicesMapByCategory));
                      localStorage.setItem('click_client_servicesMap', JSON.stringify(scope.servicesMap));
                    }
                  }
                });
              }

            }, onErrorLoadFs);
          }
        }


        servicesParamsInit = function () {
          scope.servicesParams = [];
          scope.servicesParamsMapOne = {};
          scope.servicesParamsMapTwo = {};
          scope.servicesParamsMapThree = {};
          scope.servicesParamsMapFour = {};
          scope.servicesParamsMapFive = {};
          scope.servicesParamsMapSix = {};
          window.api.call({
            method: 'get.service.parameters.list',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber
            },

            scope: this,

            onSuccess: function (result) {
              if (result[0][0].error == 0) {
                if (result[1])
                  for (var i in result[1]) {
                    if (!scope.servicesParamsMapOne[result[1][i].service_id]) {
                      scope.servicesParamsMapOne[result[1][i].service_id] = [];
                      scope.servicesParamsMapOne[result[1][i].service_id].push(result[1][i]);
                    }
                    else
                      scope.servicesParamsMapOne[result[1][i].service_id].push(result[1][i]);


                  }
                if (result[2])
                  for (var i in result[2]) {
                    if (!scope.servicesParamsMapTwo[result[2][i].service_id]) {
                      scope.servicesParamsMapTwo[result[2][i].service_id] = [];
                      scope.servicesParamsMapTwo[result[2][i].service_id].push(result[2][i]);
                    }
                    else
                      scope.servicesParamsMapTwo[result[2][i].service_id].push(result[2][i]);

                  }
                if (result[3])
                  for (var i in result[3]) {
                    if (!scope.servicesParamsMapThree[result[3][i].service_id]) {
                      scope.servicesParamsMapThree[result[3][i].service_id] = [];
                      scope.servicesParamsMapThree[result[3][i].service_id].push(result[3][i]);
                    }
                    else
                      scope.servicesParamsMapThree[result[3][i].service_id].push(result[3][i]);

                  }
                if (result[4])
                  for (var i in result[4]) {
                    if (!scope.servicesParamsMapFour[result[4][i].service_id]) {
                      scope.servicesParamsMapFour[result[4][i].service_id] = [];
                      scope.servicesParamsMapFour[result[4][i].service_id].push(result[4][i]);
                    }
                    else
                      scope.servicesParamsMapFour[result[4][i].service_id].push(result[4][i]);
                  }
                if (result[5])
                  for (var i in result[5]) {
                    if (!scope.servicesParamsMapFive[result[5][i].service_id]) {
                      scope.servicesParamsMapFive[result[5][i].service_id] = [];
                      scope.servicesParamsMapFive[result[5][i].service_id].push(result[5][i]);
                    }
                    else
                      scope.servicesParamsMapFive[result[5][i].service_id].push(result[5][i]);
                  }
                if (result[6])
                  for (var i in result[6]) {
                    if (!scope.servicesParamsMapSix[result[6][i].service_id]) {
                      scope.servicesParamsMapSix[result[6][i].service_id] = [];
                      scope.servicesParamsMapSix[result[6][i].service_id].push(result[6][i]);
                    }
                    else
                      scope.servicesParamsMapSix[result[6][i].service_id].push(result[6][i]);
                  }
                localStorage.setItem('click_client_servicesParams', JSON.stringify(result));
                localStorage.setItem('click_client_servicesParamsMapOne', JSON.stringify(scope.servicesParamsMapOne));
                localStorage.setItem('click_client_servicesParamsMapTwo', JSON.stringify(scope.servicesParamsMapTwo));
                localStorage.setItem('click_client_servicesParamsMapThree', JSON.stringify(scope.servicesParamsMapThree));
                localStorage.setItem('click_client_servicesParamsMapFour', JSON.stringify(scope.servicesParamsMapFour));
                localStorage.setItem('click_client_servicesParamsMapFive', JSON.stringify(scope.servicesParamsMapFive));
                localStorage.setItem('click_client_servicesParamsMapSix', JSON.stringify(scope.servicesParamsMapSix));
              }
            },

            onFail: function (api_status, api_status_message, data) {
              console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
              console.error(data);
            }
          });
        };


      }

      if (device.platform != 'BrowserStand') {
        console.log("Spinner Stop View Authorization");
        SpinnerPlugin.activityStop();
      }
    }

  </script>
</view-authorization>