<view-registration-device class="view-registration-device riot-tags-main-container">
  <div class="registration-device-flex-container">
    <div class="page-title">

      <div class="registration-button-offline"
           if="{device.platform != 'iOS'}"
           id="registrationOfflineButtonId"
           ontouchstart="registrationOfflineTouchStart()"
           ontouchend="registrationOfflineTouchEnd()">{window.languages.ViewRegistrationDeviceButtonOffline}
      </div>

      <div id="registrationHelpButtonId" class="registration-button-help" ontouchend="helpTouchEnd()"
           ontouchstart="helpTouchStart()">
        {window.languages.ViewRegistrationDeviceButtonHelp}
      </div>
      <div class="title-bottom-border">
      </div>
    </div>
    <div class="registration-device-unchangable-container">
      <div class="registration-device-phone-field">
        <component-canvas></component-canvas>
        <p class="registration-device-text-field">{window.languages.ViewRegistrationTextField}</p>

        <p class="registration-device-phone-code-part">+{window.languages.CodeOfCountry}</p>
        <input class="registration-device-phone-input-part"
               id="regNumberInput"
               value="{maskPhoneNumber}" ontouchend="onTouchendRegNumber()" disabled/>
        <div id="inputCaret" class="registration-caret"></div>

        <div class="registration-device-remember" ontouchend="rememberTouchEnd()" ontouchstart="rememberTouchStart()"
             role="button" aria-label="{window.languages.ViewRegistrationDeviceRememberLabel}">
          <p class="registration-device-remember-label">
            {window.languages.ViewRegistrationDeviceRememberLabel}</p>
          <div id="rememberIcon" class="registration-device-remember-icon"></div>
        </div>
      </div>
    </div>
  </div>

  <div class="registration-keyboard-field keyboard-field">
    <component-keyboard></component-keyboard>
  </div>

  <div id="registrationNextButtonId" class="bottom-button-container"
       ontouchend="getPhoneNumberTouchEnd()"
       ontouchstart="getPhoneNumberTouchStart()">
    <div class="button-enter-label">{window.languages.ViewRegistrationDeviceButtonEnterLabel}</div>
    <div class="button-enter-icon"></div>
  </div>

  <component-tour view="registration"></component-tour>

  <div hidden id="demoContinueContainer" class="demo-version-continue riot-tags-main-container">
    <p class="demo-version-demonstration-text">Демонстрационный режим</p>
    <div class="demo-version-continue-container">
      <div class="demo-version-continue-continue">
      </div>
      <div class="demo-version-continue-text">
        <p>В данном режиме отображаются демонстрационные данные.<br>Полноценный функционал приложения недоступен. Для
          использования всех функций приложения авторизуйтесь.</p>
      </div>

      <button class="demo-version-continue-button-continue" ontouchstart="demoContinueTouchStart()"
              ontouchend="demoContinueTouchEnd()">ПРОДОЛЖИТЬ
      </button>
    </div>
  </div>

  <script>
    var scope = this;

    this.on('mount', function () {
      if (device.platform != 'BrowserStand')
        StatusBar.backgroundColorByHexString("#ffffff");
      canvas = document.getElementById('canvas');
      ctx = canvas.getContext("2d");
    });

    var checkRemember = false;
    var timeOutTimer = 0;

    scope.deviceimei;

    function deviceImei() {

      if (device.platform == "BrowserStand" || device.platform == 'iOS') {
        scope.deviceimei = (device.uuid.substring(0, device.uuid.length / 2));
      } else {
        window.plugins.imei.get(
          function (imei) {
            console.log("got imei: " + imei);
            scope.deviceimei = imei;
          },
          function (e) {
            console.log("error loading imei=" + e);
          }
        );
      }
    }

    deviceImei();

    var rememberTouchStartX, rememberTouchStartY, rememberTouchEndX, rememberTouchEndY;
    rememberTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      rememberTouchStartX = event.changedTouches[0].pageX;
      rememberTouchStartY = event.changedTouches[0].pageY;

    };

    rememberTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      rememberTouchEndX = event.changedTouches[0].pageX;
      rememberTouchEndY = event.changedTouches[0].pageY;


      if (Math.abs(rememberTouchStartX - rememberTouchEndX) <= 20 && Math.abs(rememberTouchStartY - rememberTouchEndY) <= 20) {
        if (!checkRemember) {
          this.rememberIcon.style.backgroundImage = "url(resources/icons/authorization/selected.png)";
          localStorage.setItem('device_remember', true);
          checkRemember = true;
          return;

        }
        else {
          this.rememberIcon.style.backgroundImage = "url(resources/icons/authorization/deselected.png)";
          localStorage.setItem('device_remember', false);
          checkRemember = false;
          return;
        }
      }
    };

    history.arrayOfHistory.push(
      {
        "view": 'view-registration-device',
        "params": opts
      }
    );
    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

    var scope = this;
    var token;

    scope.phoneNumber = '';
    scope.maskPhoneNumber = '';
    scope.maskPhoneNumberDisplay = '';

    var keyboardTouchStartX, keyboardTouchStartY, keyboardTouchEndX, keyboardTouchEndY;

    componentKeyboard.returnStartValue = function (myValue, id) {

      document.getElementById(id).style.webkitTransform = 'scale(0.8)';

      keyboardTouchStartX = event.changedTouches[0].pageX;
      keyboardTouchStartY = event.changedTouches[0].pageY;

      if (window.inputVerification.spaceDeleter(scope.maskPhoneNumber).length < 9 && myValue != 'x') {

        if (inputFocusIndex <= 2) {
          scope.maskPhoneNumber = window.inputVerification.phoneEnterTransform(inputFocusIndex, myValue, scope.maskPhoneNumber);
          scope.phoneNumber = '+' + window.languages.CodeOfCountry + window.inputVerification.spaceDeleter(scope.maskPhoneNumber);
          inputFocusIndex = inputFocusIndex == 2 ? 4 : (inputFocusIndex == 1 ? 2 : 1);
        } else {
          scope.maskPhoneNumber = scope.maskPhoneNumber.slice(0, inputFocusIndex) + myValue + scope.maskPhoneNumber.slice(inputFocusIndex);
          scope.phoneNumber = '+' + window.languages.CodeOfCountry + window.inputVerification.spaceDeleter(scope.maskPhoneNumber);
          ++inputFocusIndex
        }
        inputCaret.style.left = ctx.measureText(scope.maskPhoneNumber.substring(0, inputFocusIndex)).width + inputLocalStartX - 3 * widthK + 'px';
      }

      if (myValue == 'x' && inputFocusIndex != 0) {

        if (inputFocusIndex <= 4) {

          scope.maskPhoneNumber = window.inputVerification.phoneDelTransform(inputFocusIndex, scope.maskPhoneNumber);
          inputFocusIndex = inputFocusIndex == 4 ? 2 : ((inputFocusIndex == 3 || inputFocusIndex == 2) ? 1 : 0);
        }
        else {
          scope.maskPhoneNumber = scope.maskPhoneNumber.slice(0, inputFocusIndex - 1) + scope.maskPhoneNumber.slice(inputFocusIndex);
          --inputFocusIndex;
        }
        scope.phoneNumber = '+' + window.languages.CodeOfCountry + window.inputVerification.spaceDeleter(scope.maskPhoneNumber);
        inputCaret.style.left = ctx.measureText(scope.maskPhoneNumber.substring(0, inputFocusIndex)).width + inputLocalStartX - 3 * widthK + 'px';
      }

      scope.update();
    };


    componentKeyboard.returnValue = function (myValue, id) {

      document.getElementById(id).style.webkitTransform = 'scale(1)';

      keyboardTouchEndX = event.changedTouches[0].pageX;
      keyboardTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(keyboardTouchStartX - keyboardTouchEndX) <= 20 && Math.abs(keyboardTouchStartY - keyboardTouchEndY) <= 20) {

      }
      return
    };

    var regNumberTouchEndX;
    var inputStartX = 250 * widthK;
    var inputLocalStartX = inputStartX - 80 * widthK;
    var inputFocusIndex = 0;
    var canvas;
    var ctx;


    onTouchendRegNumber = function () {
      event.preventDefault();
      event.stopPropagation();

      regNumberTouchEndX = event.changedTouches[0].pageX;


      var valueLength = ctx.measureText(scope.maskPhoneNumber).width;

      if ((regNumberTouchEndX < inputStartX) || (regNumberTouchEndX < ctx.measureText(scope.maskPhoneNumber[0]).width / 2 + inputStartX)) {
        inputCaret.style.left = inputLocalStartX - 3 * widthK + 'px';
        inputFocusIndex = 0;
      }
      else if (regNumberTouchEndX > (valueLength + inputStartX)) {

        inputCaret.style.left = (valueLength + inputLocalStartX - 3 * widthK) + 'px';
        inputFocusIndex = scope.maskPhoneNumber.length;
      } else {
        for (var i = 0; i < scope.maskPhoneNumber.length; i++) {

          if (regNumberTouchEndX < (ctx.measureText(scope.maskPhoneNumber.substring(0, i + 1)).width + inputStartX)) {
            if (regNumberTouchEndX < (ctx.measureText(scope.maskPhoneNumber.substring(0, i)).width + ctx.measureText(scope.maskPhoneNumber[i]).width / 2 + inputStartX)) {
              inputCaret.style.left = ctx.measureText(scope.maskPhoneNumber.substring(0, i)).width + inputLocalStartX - 3 * widthK + 'px';
              inputFocusIndex = i;
            }
            else if (regNumberTouchEndX > (ctx.measureText(scope.maskPhoneNumber.substring(0, i)).width + ctx.measureText(scope.maskPhoneNumber[i]).width / 2 + inputStartX)) {
              inputCaret.style.left = ctx.measureText(scope.maskPhoneNumber.substring(0, i + 1)).width + inputLocalStartX - 3 * widthK + 'px';
              inputFocusIndex = i + 1;
            }
            break;
          }
        }
      }
    };

    function updateTransition() {
      var el = document.getElementById("inputCaret");

      if (el) {
        if (el.className == "registration-caret") {
          el.className = "registration-caret-two";
        } else {
          el.className = "registration-caret";
        }
      }
      return el;
    }

    var intervalID = window.setInterval(updateTransition, 800);

    var offlineTouchStartX, offlineTouchStartY, offlineTouchEndX, offlineTouchEndY;

    registrationOfflineTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      registrationOfflineButtonId.style.webkitTransform = 'scale(0.8)';

      offlineTouchStartX = event.changedTouches[0].pageX;
      offlineTouchStartY = event.changedTouches[0].pageY;

    };

    registrationOfflineTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      registrationOfflineButtonId.style.webkitTransform = 'scale(1)';

      offlineTouchEndX = event.changedTouches[0].pageX;
      offlineTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(offlineTouchStartX - offlineTouchEndX) <= 20 && Math.abs(offlineTouchStartY - offlineTouchEndY) <= 20) {

        modeOfApp.onlineMode = false;
        modeOfApp.offlineMode = true;

        window.clearInterval(intervalID);
        this.riotTags.innerHTML = "<view-main-page>";
        riot.mount('view-main-page');
        scope.unmount()
      }
    };

    var demoContinueTouchStartX, demoContinueTouchStartY, demoContinueTouchEndX, demoContinueTouchEndY;

    demoContinueTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      demoContinueTouchStartX = event.changedTouches[0].pageX;
      demoContinueTouchStartY = event.changedTouches[0].pageY;
    };

    demoContinueTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      demoContinueTouchEndX = event.changedTouches[0].pageX;
      demoContinueTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(demoContinueTouchStartX - demoContinueTouchEndX) <= 20 && Math.abs(demoContinueTouchStartY - demoContinueTouchEndY) <= 20) {
        if (!localStorage.getItem('device_platform'))
          localStorage.setItem('device_platform', device.platform);
        window.location = "index-stand-demo.html";
      }
    };

    var demoOpenTouchStartX, demoOpenTouchStartY, demoOpenTouchEndX, demoOpenTouchEndY;

    goToDemoTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      demoContainer.style.webkitTransform = 'scale(0.8)';

      demoOpenTouchStartX = event.changedTouches[0].pageX;
      demoOpenTouchStartY = event.changedTouches[0].pageY;

    };

    goToDemoTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      demoContainer.style.webkitTransform = 'scale(1)';

      demoOpenTouchEndX = event.changedTouches[0].pageX;
      demoOpenTouchEndY = event.changedTouches[0].pageY;

      console.log(demoOpenTouchStartX, demoOpenTouchStartY);
      console.log(demoOpenTouchEndX, demoOpenTouchEndY);

      if (Math.abs(demoOpenTouchStartX - demoOpenTouchEndX) <= 20 && Math.abs(demoOpenTouchStartY - demoOpenTouchEndY) <= 20) {


        demoContinueContainer.style.display = 'block'
      }

    };

    var getPhoneNumberTouchStartX, getPhoneNumberTouchStartY, getPhoneNumberTouchEndX, getPhoneNumberTouchEndY;

    getPhoneNumberTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      registrationNextButtonId.style.webkitTransform = 'scale(0.8)';

      getPhoneNumberTouchStartX = event.changedTouches[0].pageX;
      getPhoneNumberTouchStartY = event.changedTouches[0].pageY;
    };

    getPhoneNumberTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      registrationNextButtonId.style.webkitTransform = 'scale(1)';

      getPhoneNumberTouchEndX = event.changedTouches[0].pageX;
      getPhoneNumberTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(getPhoneNumberTouchStartX - getPhoneNumberTouchEndX) <= 20 && Math.abs(getPhoneNumberTouchStartY - getPhoneNumberTouchEndY) <= 20) {
        var correctPhoneNumber = true;
        var phoneNumber = scope.phoneNumber.substring(1, scope.phoneNumber.length);

        if (!scope.deviceimei)
          deviceImei();

        if (phoneNumber.length != 12) {
          scope.clickPinError = false;
          scope.errorNote = "Неправильно введен номер телефона";
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote,
            viewpage: scope.viewPage,
          });
          scope.update();
          correctPhoneNumber = false;
        }

        if (correctPhoneNumber) {
          if (localStorage.getItem('version') && localStorage.getItem('version') === AppVersion.version) {

          }
          else {
            localStorage.removeItem('click_client_payCategoryList');
            localStorage.removeItem('click_client_categoryNamesMap');
            localStorage.removeItem('click_client_payServiceList');
            localStorage.removeItem('click_client_servicesMapByCategory');
            localStorage.removeItem('click_client_servicesMap');
            localStorage.setItem('version', AppVersion.version)
          }
          localStorage.setItem('click_client_phoneNumber', phoneNumber);
          var date = parseInt(Date.now() / 1000);

          callRegistrationDevice = function () {
            registrationDevice(phoneNumber, date);
          };

          noInternetConfirm = function () {
            console.log('no internet connection on device registration');

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
                modeOfApp.onlineMode = false;
                modeOfApp.offlineMode = true;

                window.clearInterval(intervalID);
                riotTags.innerHTML = "<view-main-page>";
                riot.mount('view-main-page');
                scope.unmount();
              }
            };

            window.common.alert.show("componentConfirmId", {
              "confirmnote": confirmNote,
              "confirmtype": confirmType,
              parent: scope
            });
          };

          checkConnection(callRegistrationDevice, noInternetConfirm);
//          registrationDevice(phoneNumber, date);
        }
      }

    };

    var helpTouchStartX, helpTouchStartY, helpTouchEndX, helpTouchEndY;
    helpTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      registrationHelpButtonId.style.webkitTransform = 'scale(0.8)'

      helpTouchStartX = event.changedTouches[0].pageX
      helpTouchStartY = event.changedTouches[0].pageY

    };

    helpTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      registrationHelpButtonId.style.webkitTransform = 'scale(1)'

      helpTouchEndX = event.changedTouches[0].pageX;
      helpTouchEndY = event.changedTouches[0].pageY;


      if (Math.abs(helpTouchStartX - helpTouchEndX) <= 20 && Math.abs(helpTouchStartY - helpTouchEndY) <= 20) {

        componentTourId.style.display = "block";
        if (device.platform != 'BrowserStand')
          StatusBar.backgroundColorByHexString("#ffffff");

      }
    }

    function deviceType() {
      return device.platform == 'iOS' ? 2 : 1;
    }

    function deviceName() {
      return device.model;
    }

    function deviceInfo() {
      return device.manufacturer + ' ' + device.version + ' ' + device.model;
    }

    function registrationDevice(phoneNumber, date) {
      window.startSpinner();
      var timeOut = 0;
      if (!scope.deviceimei)
        timeOut = 1000;

      setTimeout(function () {
        console.log("scope.deviceimei =", scope.deviceimei);

        window.api.call({
          method: 'device.register.request',
          stopSpinner: false,
          input: {
            phone_num: phoneNumber,
            device_info: deviceInfo(),
            device_name: deviceName(),
            device_type: deviceType(),
            datetime: date,
            imei: scope.deviceimei,
            app_version: AppVersion.version
          },

          scope: this,

          onSuccess: function (result) {
            console.log('Clearing timer onSuccess', timeOutTimer);
            window.clearTimeout(timeOutTimer);
            window.stopSpinner();
            console.log("Device.register.request method answer: fail");

            if (result[0][0].error == 0) {
              if (result[1][0]) {

                localStorage.setItem('onResume', false);

                var deviceId = result[1][0].device_id;
                localStorage.setItem('click_client_deviceID', deviceId);
                token = hex_sha512(deviceId + date + phoneNumber);
                localStorage.setItem('click_client_token', token);
                if (result[1][0].confirm_needed) {
                  localStorage.setItem('confirm_needed', true);
                  window.clearInterval(intervalID);
                  this.riotTags.innerHTML = "<view-sms>";
                  riot.mount('view-sms');
                  scope.unmount()
                }
                else {
                  window.pushNotificationInitialize();
                  localStorage.setItem('confirm_needed', false);
                  localStorage.setItem('click_client_registered', true);
                  window.clearInterval(intervalID);
                  this.riotTags.innerHTML = "<view-authorization>";
                  riot.mount('view-authorization');
                  scope.unmount()
                }
              }
            }
            else {
              scope.clickPinError = false;
              updateAlertComponent(true, null, 'view-registration-device', result[0][0].error_note);
            }
          },

          onFail: function (api_status, api_status_message, data) {
            console.log('Clearing timer onFail', timeOutTimer);
            window.clearTimeout(timeOutTimer);
            console.log("Device.register.request method answer: fail");
            window.stopSpinner();
            updateAlertComponent(true, null, 'view-registration-device', "Сервис временно не доступен");
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          },
          onTimeOut: function () {
            timeOutTimer = setTimeout(function () {
              window.writeLog({
                reason: 'Timeout',
                method: 'device.register.request',
              });
              updateAlertComponent(true, null, 'view-registration-device', window.languages.WaitingTimeExpiredText);
              window.stopSpinner();
              window.api.forceClose();
            }, 30000);
            console.log('creating timeOut', timeOutTimer);
          },
          onEmergencyStop: function () {
            console.log('Clearing timer emergencyStop', timeOutTimer);
            window.clearTimeout(timeOutTimer);
          }
        });
      }, timeOut);
    }

    updateAlertComponent = function (showError, stepAmount, viewPage, text) {
      console.log("OPEN ALERT COMPONENT:", showError, text, stepAmount, viewPage);

      scope.stepAmount = stepAmount;

      scope.viewPage = viewPage;
      scope.errorNote = text;
      riot.update();

      if (showError) {

        window.common.alert.show("componentAlertId", {
          parent: scope,
          clickpinerror: scope.clickPinError,
          errornote: scope.errorNote,
          viewpage: scope.viewPage,
        });
      } else {

        window.common.alert.hide("componentAlertId");
      }
    }

  </script>
</view-registration-device>