<view-authorization class="view-authorization riot-tags-main-container">

  <div class="view-authorization-inner-container" if="{!fingerprintMode}">

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

    <div if="{firstEnter}" class="authorization-flex-container">
      <div class="authorization-unchangable-container">
        <div class="authorization-enter-pin-label">
          {window.languages.ViewAuthorizationClickPinLabel}
        </div>
        <div class="authorization-pin-input-first-enter-container" id="firstPinContainerId">
          <input autofocus="true"
                 type="password"
                 class="authorization-pin-input-first-enter"
                 onfocus="focusColor()"
                 onblur="inputPinBlur()"
                 id="firstPinInputId"/>
          <div id="eyeButtonId" class="authorization-input-eye-button" role="button"
               aria-label="{window.languages.ViewAuthorizationFirstEnterAriaLabelShowPass}"
               onclick="eyeClicked()"></div>
        </div>
      </div>
    </div>

    <div id="authorizationButtonsContainerId" class="authorization-buttons-container">


      <div id="forgetPinButtonId" class="authorization-button-forget-pin" ontouchstart="pinResetTouchStart()"
           ontouchend="pinResetTouchEnd()">
        {window.languages.ViewAuthorizationForgetPinLabel}
      </div>
      <div class="hor-line-border">
      </div>
      <div id="resetLocalButtonId" class="authorization-button-registration"
           ontouchstart="resetLocalStorageTouchStart()"
           ontouchend="resetLocalStorageTouchEnd()">
        {window.languages.ViewAuthorizationResetLocalStorageLabel}
      </div>
    </div>

    <div if="{!firstEnter}" class="authorization-keyboard-field keyboard-field">
      <component-keyboard
        fingerprint="{JSON.parse(localStorage.getItem('settings_finger_print'))}"></component-keyboard>
    </div>

    <div if="{firstEnter}" id="firstEnterButtonId" class="bottom-button-container"
         ontouchend="firstPinEnterTouchEnd()"
         ontouchstart="firstPinEnterTouchStart()">
      <div class="button-enter-label">{window.languages.ViewAuthorizationFirstEnterLabel}</div>
      <div class="button-enter-icon"></div>
    </div>

    <button id="authOfflineButtonId" hidden="{device.platform == 'iOS'}"
            if="{firstEnter}"
            class="authorization-footer-button-container-first"
            ontouchstart="offlineModeTouchStart()"
            ontouchend="offlineModeTouchEnd()">
      {window.languages.ViewAuthorizationOfflineModeLabel}
    </button>

    <div if="{!firstEnter && device.platform != 'iOS'}"
         class="authorization-footer-button-container">
      <div id="authOfflineButtonId"
           class="authorization-footer-not-first-button"
           ontouchstart="offlineModeTouchStart()"
           ontouchend="offlineModeTouchEnd()">
        <div class="authorization-footer-not-first-offline-icon"></div>
        <div class="authorization-footer-not-first-offline-label">
          {window.languages.ViewAuthorizationOfflineModeLabel}
        </div>
      </div>
      <div class="authorization-footer-not-first-border-right"></div>
      <div id="authClickPassButtonId"
           class="authorization-footer-not-first-button"
           ontouchstart="clickPassTouchStart()"
           ontouchend="clickPassTouchEnd()">
        <div class="authorization-footer-not-first-click-pass-icon"></div>
        <div class="authorization-footer-not-first-click-pass-label">
          {window.languages.ViewAuthorizationClickScanLabel}
        </div>
      </div>
    </div>
    <div if="{!firstEnter && device.platform == 'iOS'}"
         class="authorization-footer-button-container-ios-for-border">
      <div class="authorization-footer-button-container-ios"
           id="authClickPassButtonId"
           ontouchstart="clickPassTouchStart()"
           ontouchend="clickPassTouchEnd()">
        <div class="authorization-footer-not-first-button-ios">
          <div class="authorization-footer-not-first-click-pass-icon-ios"></div>
          <div class="authorization-footer-not-first-click-pass-label-ios">
            {window.languages.ViewAuthorizationClickScanLabel}
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="view-authorization-inner-container" if="{fingerprintMode && device.platform == 'Android'}">

    <div class="auth-fingerprint-logo"></div>

    <div class="auth-fingerprint-body-label">{languages.ViewAuthFingerprintBodyText}</div>

    <div id="fingerPrintIconId" class="auth-fingerprint-icon"
         style="background-image: url('resources/gifs/auth/wait.gif')"></div>

    <p id="fingerPrintErrorText" class="auth-fingerprint-errortext">{errorMessage}</p>

    <div id="switchModeButton" class="button-auth-fingerprint"
         ontouchend="goToClickPinAuthorizationEnd()"
         ontouchstart="goToClickPinAuthorizationStart()">
      <div class="auth-fingerprint-mode-label">{window.languages.ViewAuthFingerprintModeButtonLabel}</div>
      <div class="button-auth-fingerprint-clickpin-icon"></div>
    </div>

  </div>

  <component-pin-reset></component-pin-reset>

  <script>

    var scope = this;
    var timeOutTimer = 0;
    scope.checkAndroid = false;
    scope.errorCode = 0;
    scope.fingerprintMode = false;
    window.fingerPrint.fingerprintMode = false;
    scope.settingsFingerPrint = localStorage.getItem("settings_finger_print") ? JSON.parse(localStorage.getItem("settings_finger_print")) : false;
    modeOfApp.onlineMode = true;
    modeOfApp.offlineMode = false;
    onBackParams.opts = 'fromAuthorization';

    console.log("OPTS in Auth", opts);


    this.on('mount', function () {


      localStorage.setItem('session_broken', false);
      localStorage.setItem("click_client_authorized", false);
      sessionStorage.setItem('click_client_inPlacePayCategoryList', JSON.stringify(null));

      if (scope.firstEnter) {

//        authorizationButtonsContainerId.style.top = 400 * widthK + 'px';

        inputPinFocus();
      }
      scope.update();
      if (device.platform !== 'BrowserStand')
        navigator.splashscreen.hide();

    });


    if (localStorage.getItem("click_client_accountInfo")) {
      scope.firstEnter = false;
    }
    else {
      if (JSON.parse(localStorage.getItem('click_client_registered')) === true
        && !localStorage.getItem("click_client_accountInfo")
        && opts && opts.from && opts.from === "registration-client") {
        console.log("It's not first enter");
        scope.firstEnter = false;
      }
      else {
        console.log("It's first enter");
        scope.firstEnter = true;
      }
    }

    if (history.arrayOfHistory.length !== 0) {
      if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view !== 'view-authorization'
        && !JSON.parse(localStorage.getItem('onResume')) && !JSON.parse(localStorage.getItem('session_broken'))) {
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


    if (device.platform !== 'BrowserStand')
      StatusBar.backgroundColorByHexString("#ffffff");

    if (device.platform === 'Android') {
      scope.checkAndroid = true;
    }

    if (!localStorage.getItem('settings_finger_print')) {
      localStorage.setItem('settings_finger_print', false)
    }

    if (localStorage.getItem('settings_finger_print_enrolled')) {
      window.fingerPrint.check = JSON.parse(localStorage.getItem('settings_finger_print_enrolled'));
    }


    if (JSON.parse(localStorage.getItem('settings_finger_print')) && !scope.firstEnter) {
      scope.fingerprintMode = device.platform == 'iOS' || !scope.settingsFingerPrint ? false : (opts.fingerPrintMode == false ? false : true);
      window.fingerPrint.fingerprintMode = scope.fingerprintMode;
      console.log("opts.fingerprintMode ", opts.fingerPrintMode, scope.fingerprintMode);
      scope.update();
    }


    setTimeout(function () {
      if (JSON.parse(localStorage.getItem('settings_finger_print')) && !scope.firstEnter) {
        try {
          if (device.platform == 'iOS') {
            if (window.scannerCanBeAsked) {
              fingerPrintAsk('fingerPrintIconId');
            }
          } else {
            fingerPrintAsk('fingerPrintIconId');
          }
        }
        catch (e) {
          console.log(e)
        }
      }
    }, 1000);


    var eyeInputShow = false;

    eyeClicked = function () {
      event.preventDefault();
      event.stopPropagation();

      if (!eyeInputShow) {
        firstPinInputId.type = "text";
        eyeButtonId.style.backgroundImage = 'url(resources/icons/authorization/pin_show.png)';
        eyeInputShow = true;
      }
      else {
        firstPinInputId.type = "password";
        eyeButtonId.style.backgroundImage = 'url(resources/icons/authorization/pin_hide.png)';
        eyeInputShow = false;
      }

    };

    inputPinBlur = function () {
      document.getElementById("firstPinContainerId").style.borderColor = "#e8e8e8";
      firstPinInputId.blur();
    };

    focusColor = function () {
      document.getElementById("firstPinContainerId").style.borderColor = "#00a8f1";
    };

    inputPinFocus = function () {
      console.log("ALert is shown? ", window.common.alert.isShown("componentAlertId"));
      if (!window.common.alert.isShown("componentAlertId")) {
        if (device.platform === 'iOS') {
          firstPinInputId.autofocus;
          firstPinInputId.focus();
        }
        else {
          setTimeout(function () {
            firstPinInputId.focus();
          }, 0)
        }
      }
    };

    var pinResetTouchStartX, pinResetTouchStartY, pinResetTouchEndX, pinResetTouchEndY;

    pinResetTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      forgetPinButtonId.style.webkitTransform = 'scale(0.8)';

      pinResetTouchStartX = event.changedTouches[0].pageX;
      pinResetTouchStartY = event.changedTouches[0].pageY;


    };


    pinResetTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      forgetPinButtonId.style.webkitTransform = 'scale(1)';

      pinResetTouchEndX = event.changedTouches[0].pageX;
      pinResetTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(pinResetTouchStartX - pinResetTouchEndX) <= 20 && Math.abs(pinResetTouchStartY - pinResetTouchEndY) <= 20) {
        if (scope.firstEnter)
          firstPinInputId.blur();
        componentPinResetId.style.display = 'block';
      }
    };

    var resetLocalStorageTouchStartX, resetLocalStorageTouchStartY, resetLocalStorageTouchEndX,
      resetLocalStorageTouchEndY;

    resetLocalStorageTouchStart = function () {
      if (event) {
        event.preventDefault();
        event.stopPropagation();
      }

      resetLocalButtonId.style.webkitTransform = 'scale(0.8)';
      resetLocalStorageTouchStartX = event.changedTouches[0].pageX;
      resetLocalStorageTouchStartY = event.changedTouches[0].pageY;

    };

    resetLocalStorageTouchEnd = function () {
      if (event) {
        event.preventDefault();
        event.stopPropagation();
      }

      resetLocalButtonId.style.webkitTransform = 'scale(1)';

      resetLocalStorageTouchEndX = event.changedTouches[0].pageX;
      resetLocalStorageTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(resetLocalStorageTouchStartX - resetLocalStorageTouchEndX) <= 20 && Math.abs(resetLocalStorageTouchStartY - resetLocalStorageTouchEndY) <= 20) {

        if (scope.firstEnter)
          firstPinInputId.blur();

        var question = 'Подтвердите удаление данных';
        window.common.alert.show("componentConfirmId", {
          parent: scope,
          "confirmnote": question,
          "confirmtype": 'local'
        });
        scope.update();
        scope.result = function (bool) {
          if (bool) {
            localStorage.clear();
            if (device.platform !== 'BrowserStand') {
              window.FirebasePlugin.unsubscribe("news");
            }
            riotTags.innerHTML = "<view-registration-device>";
            riot.mount('view-registration-device');
            scope.unmount();
          }
        };
      }
    };

    var pin;
    var enteredPin = '';
    var checkSessionKey = false;

    var keyboardTouchStartX, keyboardTouchStartY, keyboardTouchEndX, keyboardTouchEndY;

    componentKeyboard.returnStartValue = function (myValue, id) {

      document.getElementById(id).style.webkitTransform = 'scale(0.8)';

      keyboardTouchStartX = event.changedTouches[0].pageX;
      keyboardTouchStartY = event.changedTouches[0].pageY;

      if (enteredPin.length < 5 && myValue !== 'x' && myValue !== 'space') {
        enteredPin += myValue;
      }
      if (myValue === 'x') {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      }

      if (myValue === "space" && JSON.parse(localStorage.getItem('settings_finger_print')) === true) {
        try {
          console.log("AUTHORIZATION CALL new OF FINGERPRINT 338");
          scope.fingerprintMode = device.platform == 'iOS' || !scope.settingsFingerPrint ? false : true;
          window.fingerPrint.fingerprintMode = scope.fingerprintMode;
          updateEnteredPin();
          scope.update();
          fingerPrintAsk('fingerPrintIconId');
          return;

        }
        catch (e) {
          console.log(e)
        }
      }

      scope.update();
      updateEnteredPin();
    };

    componentKeyboard.returnValue = function (myValue, id) {

      document.getElementById(id).style.webkitTransform = 'scale(1)';

      keyboardTouchEndX = event.changedTouches[0].pageX;
      keyboardTouchEndY = event.changedTouches[0].pageY;


      if (Math.abs(keyboardTouchStartX - keyboardTouchEndX) <= 20 && Math.abs(keyboardTouchStartY - keyboardTouchEndY) <= 20) {

      }
    };

    var offlineModeTouchStartX, offlineModeTouchStartY, offlineModeTouchEndX, offlineModeTouchEndY;

    offlineModeTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      authOfflineButtonId.style.webkitTransform = 'scale(0.8)';

      offlineModeTouchStartX = event.changedTouches[0].pageX;
      offlineModeTouchStartY = event.changedTouches[0].pageY;

    };
    offlineModeTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      authOfflineButtonId.style.webkitTransform = 'scale(1)';

      offlineModeTouchEndX = event.changedTouches[0].pageX;
      offlineModeTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(offlineModeTouchStartX - offlineModeTouchEndX) <= 20 && Math.abs(offlineModeTouchStartY - offlineModeTouchEndY) <= 20) {
        modeOfApp.onlineMode = false
        modeOfApp.offlineMode = true;

        this.riotTags.innerHTML = "<view-main-page>";
        riot.mount('view-main-page');
        scope.unmount()
      }
    };

    var clickPassTouchStartX, clickPassTouchStartY, clickPassTouchEndX, clickPassTouchEndY;

    clickPassTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      authClickPassButtonId.style.webkitTransform = 'scale(0.8)';

      clickPassTouchStartX = event.changedTouches[0].pageX;
      clickPassTouchStartY = event.changedTouches[0].pageY;

    };
    clickPassTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      onBackParams.opts = null;

      authClickPassButtonId.style.webkitTransform = 'scale(1)';

      clickPassTouchEndX = event.changedTouches[0].pageX;
      clickPassTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(clickPassTouchStartX - clickPassTouchEndX) <= 20
        && Math.abs(clickPassTouchStartY - clickPassTouchEndY) <= 20) {

        if (!localStorage.getItem('click_client_otp_time')) {
          var question = 'Для работы раздела CLICK PASS необходимо один раз зайти в онлайн режим';
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });
          scope.update();
          return;
        }

        window.saveHistory('view-authorization');
        riotTags.innerHTML = "<view-pin-code>";
        riot.mount('view-pin-code', ['view-click-pass']);
      }
    };

    updateEnteredPin = function () {

      if (enteredPin.length === 0) {
        circleOne.style.backgroundColor = '#b0aeb2';
        circleTwo.style.backgroundColor = '#b0aeb2';
        circleThree.style.backgroundColor = '#b0aeb2';
        circleFour.style.backgroundColor = '#b0aeb2';
        circleFive.style.backgroundColor = '#b0aeb2';
      }
      if (enteredPin.length === 1) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#b0aeb2';
        circleThree.style.backgroundColor = '#b0aeb2';
        circleFour.style.backgroundColor = '#b0aeb2';
        circleFive.style.backgroundColor = '#b0aeb2';
      }
      if (enteredPin.length === 2) {
        circleOne.style.backgroundColor = '#01cfff';
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = '#b0aeb2';
        circleFour.style.backgroundColor = '#b0aeb2';
        circleFive.style.backgroundColor = '#b0aeb2';
      }

      if (enteredPin.length === 3) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = '#01cfff';
        circleFour.style.backgroundColor = '#b0aeb2';
        circleFive.style.backgroundColor = '#b0aeb2';
      }

      if (enteredPin.length === 4) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = '#01cfff';
        circleFour.style.backgroundColor = '#01cfff';
        circleFive.style.backgroundColor = '#b0aeb2';
      }

      if (enteredPin.length === 5) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = '#01cfff';
        circleFour.style.backgroundColor = '#01cfff';
        circleFive.style.backgroundColor = '#01cfff';
        pin = hex_md5(enteredPin);
        checkConnection(enter, noInternetConfirm);
      }
    };

    var firstPinEnterTouchStartX, firstPinEnterTouchStartY, firstPinEnterTouchEndX, firstPinEnterTouchEndY;

    firstPinEnterTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      firstEnterButtonId.style.webkitTransform = 'scale(0.8)';

      firstPinEnterTouchStartX = event.changedTouches[0].pageX;
      firstPinEnterTouchStartY = event.changedTouches[0].pageY;
    };

    firstPinEnterTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      firstEnterButtonId.style.webkitTransform = 'scale(1)';

      firstPinEnterTouchEndX = event.changedTouches[0].pageX;
      firstPinEnterTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(firstPinEnterTouchStartX - firstPinEnterTouchEndX) <= 20 && Math.abs(firstPinEnterTouchStartY - firstPinEnterTouchEndY) <= 20) {
        pin = hex_md5(firstPinInputId.value);
        checkConnection(enter, noInternetConfirmFirstEnter);
      }
    };

    var goToClickPinAuthStartX, goToClickPinAuthStartY, goToClickPinAuthEndX, goToClickPinAuthEndY;

    goToClickPinAuthorizationStart = function () {
      event.preventDefault();
      event.stopPropagation();

      switchModeButton.style.webkitTransform = 'scale(0.8)';

      goToClickPinAuthStartX = event.changedTouches[0].pageX;
      goToClickPinAuthStartY = event.changedTouches[0].pageY;
    };

    goToClickPinAuthorizationEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      switchModeButton.style.webkitTransform = 'scale(1)';

      goToClickPinAuthEndX = event.changedTouches[0].pageX;
      goToClickPinAuthEndY = event.changedTouches[0].pageY;

      if (Math.abs(goToClickPinAuthStartX - goToClickPinAuthEndX) <= 20 && Math.abs(goToClickPinAuthStartY - goToClickPinAuthEndY) <= 20) {
        fingerPrintStop();
        scope.fingerprintMode = false;
        window.fingerPrint.fingerprintMode = false;
        window.fingerPrint.fingerPrintInitialize = false;
        scope.update();
        console.log("OPEN USUAL :CLICK PIN AUTH, show stop listener");
      }
    };

    noInternetConfirm = function () {

      enteredPin = '';
      updateEnteredPin();

      if (device.platform == 'iOS') {
        scope.errorNote = 'Интернет-соединение отсутствует. Проверьте подключение.';
        window.common.alert.show("componentAlertId", {
          parent: scope,
          clickpinerror: scope.clickPinError,
          errornote: scope.errorNote,
        });
        scope.update();
        return;
      }

      var confirmNote = window.languages.ComponentConfirmNoInternetConnection;
      var confirmType = 'local';

      scope.result = function (bool) {
        if (bool) {
          modeOfApp.onlineMode = false
          modeOfApp.offlineMode = true;

          riotTags.innerHTML = "<view-main-page>";
          riot.mount('view-main-page');
          scope.unmount();
        }
      };

      window.common.alert.show("componentConfirmId", {
        "confirmnote": confirmNote,
        "confirmtype": confirmType,
        parent: scope,
      });
    };

    noInternetConfirmFirstEnter = function () {

      if (document.getElementById("firstPinInputId")) {
        document.getElementById("firstPinInputId").value = '';
      }

      var confirmNote = window.languages.ComponentConfirmNoInternetConnection;
      var confirmType = 'local';

      if (device.platform == 'iOS') {
        scope.errorNote = 'Интернет-соединение отсутствует. Проверьте подключение.';
        window.common.alert.show("componentAlertId", {
          parent: scope,
          errorcode: scope.errorCode,
          clickpinerror: scope.clickPinError,
          errornote: scope.errorNote,
        });
        scope.update();
        return;
      }

      scope.result = function (bool) {
        if (bool) {
          modeOfApp.onlineMode = false
          modeOfApp.offlineMode = true;

          riotTags.innerHTML = "<view-main-page>";
          riot.mount('view-main-page');
          scope.unmount();
        }
      };

      window.common.alert.show("componentConfirmId", {
        "confirmnote": confirmNote,
        "confirmtype": confirmType,
        parent: scope,
      });
    };

    enter = function (bool) {

      console.log("Enter of AUTH, bool input=", bool);

      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      var deviceId = localStorage.getItem('click_client_deviceID');
      var date = parseInt(Date.now()).toString();
      var token = localStorage.getItem('click_client_token');
      if (!pin && localStorage.getItem('click_client_pin')) {
        pin = localStorage.getItem('click_client_pin');
      }
      var password = hex_sha512(token + date + pin);
      localStorage.setItem("pinForStand", pin);
      if (bool == false) {
        password = hex_sha512(token + date + hex_md5("sjfhyasdugjhkhiuk"));
        scope.fingerprintError = true;

      } else {
        window.startSpinner();
      }
      authorization(phoneNumber, deviceId, password, date);
    };

    var firstPinInputValue = "";

    function authorization(phoneNumber, deviceId, password, date) {

      if (scope.firstEnter) {
        firstPinInputId.blur();
        firstPinInputValue = firstPinInputId.value;
      }

      window.fingerPrint.fingerPrintInitialize = false;

      var version = localStorage.getItem('version');

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

          if (result[0][0].error === 0) {
            if (!result[1][0].error) {
              console.log("User is authorized");

              viewAuthorization.fingerPrintErrorCount == 0;
              localStorage.setItem('click_client_pin', pin);
              localStorage.setItem('myNumberOperatorId', result[1][0].my_service_id);
              modeOfflineMode.check = false;
              var JsonInfo = JSON.stringify(result[1][0]);

              if (result[1][0].sync) {
                var otpTime = result[1][0].sync;

                otpTime.returned_time = parseInt(new Date().getTime());
                console.log("receive_time: ", otpTime.receive_time, parseInt(otpTime.receive_time));
                console.log("client_time: ", otpTime.client_time, parseInt(otpTime.client_time));
                console.log("transmit_time: ", otpTime.transmit_time, parseInt(otpTime.transmit_time));
                console.log("getTime : ", new Date().getTime(), Date.now());
                console.log("returned: ", otpTime.returned_time);
                otpTime.sending = parseInt(otpTime.receive_time) - parseInt(otpTime.client_time);
                console.log("sending: ", otpTime.sending);
                otpTime.receive_diff = otpTime.returned_time - parseInt(otpTime.transmit_time);
                otpTime.round_trip = otpTime.sending + otpTime.receive_diff;
                otpTime.oneway = Math.floor(otpTime.round_trip / 2);
                otpTime.difference = otpTime.sending - otpTime.oneway;
                console.log("receive_diff: ", otpTime.receive_diff);
                console.log("round_trip: ", otpTime.round_trip);
                console.log("oneway: ", otpTime.oneway);
                console.log("difference", otpTime.difference);
                localStorage.setItem('click_client_otp_time', JSON.stringify(otpTime));
              }

              localStorage.setItem('click_client_loginInfo', JsonInfo);

              checkSessionKey = true;
              viewAuthorization.check = false;
              localStorage.setItem("click_client_authorized", true);

              if (localStorage.getItem('click_client_friends') && JSON.parse(localStorage.getItem('click_client_friends')) && localStorage.getItem('click_client_friendsOuter_count')) {
                var friends = JSON.parse(localStorage.getItem('click_client_friends'));
                var outerFriendsCount = JSON.parse(localStorage.getItem('click_client_friendsOuter_count'));
                friends.splice(friends.length - outerFriendsCount, outerFriendsCount);
                localStorage.setItem('click_client_friends', JSON.stringify(friends));
                localStorage.removeItem('click_client_friendsOuter_count')
              }


              getAccount(checkSessionKey, scope.firstEnter, firstPinInputValue);
              window.pushNotificationActions.retrievePushNotification();
            }
          }
          else {
            window.stopSpinner();
            if (!scope.fingerprintMode) {

              var clickPinError, errorNote, errorCode, viewPage;

              if (result[0][0].error === -31) {

                clickPinError = true;

              } else if (result[0][0].error === -799) {

                errorNote = result[0][0].error_note;
                errorCode = 2;

              } else {

                //This conidition cannot be true, need to be deleted in future
                if (opts.from === "registration-client") {
                  errorNote = "Карта ещё не добавлена. Попробуйте войти через несколько минут";
                }
                else {
                  errorNote = result[0][0].error_note;
                  viewPage = "view-authorization";
                }
                clickPinError = false;

              }

              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: clickPinError,
                errornote: errorNote,
                errorcode: errorCode,
                viewpage: viewPage,
                fingerprintmodeoff: true
              });
              scope.update();
              enteredPin = '';
              if (!scope.firstEnter)
                updateEnteredPin();
              else {
                firstPinInputId.value = "";
                inputPinFocus();
              }
              return
            } else {

              console.log("fingerprintMode error", result[0][0].error_note);
              scope.errorMessage = result[0][0].error_note;
              scope.update();

              console.log("viewAuthorization.fingerPrintErrorCount in Auth=", viewAuthorization.fingerPrintErrorCount);

              setTimeout(function () {
                if (document.getElementById('fingerPrintErrorText')) {
                  document.getElementById('fingerPrintErrorText').classList.add("auth-fingerprint-errortext-start");
                }
                setTimeout(function () {
                  if (viewAuthorization.fingerPrintErrorCount == 3 || !scope.fingerprintError) {
                    console.log("stopping fingerPrintMode");
                    fingerPrintStop();
                    scope.fingerprintMode = false;
                    window.fingerPrint.fingerprintMode = false;
                    scope.update();
                  } else {
                    if (document.getElementById('fingerPrintErrorText'))
                      document.getElementById('fingerPrintErrorText').classList.remove("auth-fingerprint-errortext-start");

                    fingerPrintAsk('fingerPrintIconId');

                    if (document.getElementById('fingerPrintIconId'))
                      document.getElementById('fingerPrintIconId').style.backgroundImage = "url(resources/gifs/auth/wait.gif?p" + new Date().getTime() + ")";
                  }
                }, 3500);
              }, 500);


            }
          }
        },
        onFail: function (api_status, api_status_message, data) {
          console.log('Clearing timer onFail', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          updateAlertComponent(true, null, 'view-authorization', window.languages.ServiceUnavailableText, true);
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error("Error data: ", data);
        },
        onTimeOut: function () {
          timeOutTimer = setTimeout(function () {
            window.writeLog({
              reason: 'Timeout',
              method: 'app.login',
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


    updateAlertComponent = function (showError, stepAmount, viewPage, text) {
      console.log("OPEN ALERT COMPONENT:", showError, text, stepAmount, viewPage);

      if (showError) {

        window.common.alert.show("componentAlertId", {
          parent: scope,
          viewpage: viewPage,
          errornote: text
        });
      } else {

        window.common.alert.hide("componentAlertId");
      }

      scope.stepAmount = stepAmount;

      riot.update();
    }


  </script>
</view-authorization>