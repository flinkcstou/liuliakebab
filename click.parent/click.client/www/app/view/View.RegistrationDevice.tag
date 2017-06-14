<view-registration-device class="view-registration-device riot-tags-main-container">
  <div class="registration-device-flex-container">
    <div class="registration-device-unchangable-container">
      <div class="registration-device-phone-field">
        <p class="registration-device-text-field">{window.languages.ViewRegistrationTextField}</p>
        <p class="registration-device-phone-input">{maskPhoneNumber}</p>
        <div class="registration-device-remember" ontouchend="rememberTouchEnd()" ontouchstart="rememberTouchStart()">
          <p class="registration-device-remember-label">
            {window.languages.ViewRegistrationDeviceRememberLabel}</p>
          <div id="rememberIcon" class="registration-device-remember-icon"></div>
        </div>
        <div class="registration-button-enter button-enter" ontouchend="getPhoneNumberTouchEnd()"
             ontouchstart="getPhoneNumberTouchStart()">
          <div class="button-enter-label">{window.languages.ViewRegistrationDeviceButtonEnterLabel}</div>
        </div>
      </div>
    </div>
  </div>

  <div class="registration-keyboard-field keyboard-field">
    <div class="registration-button-help" ontouchend="helpTouchEnd()" ontouchstart="helpTouchStart()">
      {window.languages.ViewRegistrationDeviceButtonHelp}
    </div>
    <component-keyboard></component-keyboard>
  </div>


  <div class="registration-buttons-container">
    <div if="{device.platform != 'iOS'}" class="registration-container-offline"
         ontouchstart="registrationOfflineTouchStart()"
         ontouchend="registrationOfflineTouchEnd()">
      <div class="registration-button-offline">{window.languages.ViewRegistrationDeviceButtonOffline}</div>
    </div>
    <a id="demoContainer" class="registration-container-demo-version" ontouchend="goToDemoTouchEnd()"
       ontouchstart="goToDemoTouchStart()">
      <div class="registration-button-demo-version">{window.languages.ViewRegistrationDeviceButtonDemoVersion}
      </div>
    </a>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

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

    this.on('mount', function () {
      if (device.platform == 'iOS')
        demoContainer.style.left = 100 * widthK + 'px';
      if (device.platform != 'BrowserStand')
        StatusBar.backgroundColorByHexString("#00b0eb");

    })

    //    localStorage.setItem('device.platform', device.platform)

    //    localStorage.clear()


    var checkRemember = false;

    var rememberTouchStartX, rememberTouchStartY, rememberTouchEndX, rememberTouchEndY;
    rememberTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      rememberTouchStartX = event.changedTouches[0].pageX
      rememberTouchStartY = event.changedTouches[0].pageY

    };

    rememberTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      rememberTouchEndX = event.changedTouches[0].pageX
      rememberTouchEndY = event.changedTouches[0].pageY


      if (Math.abs(rememberTouchStartX - rememberTouchEndX) <= 20 && Math.abs(rememberTouchStartY - rememberTouchEndY) <= 20) {
        if (!checkRemember) {
//          this.rememberIcon.style.opacity = '1';
          this.rememberIcon.style.backgroundImage = "url(resources/icons/authorization/selected.png)";
          localStorage.setItem('device_remember', true);
          checkRemember = true;
          return;

        }
        else {
//          this.rememberIcon.style.opacity = '0.3';
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

    scope.showError = false;

    scope.phoneNumber = '+' + window.languages.CodeOfCountry;
    scope.maskPhoneNumber = '+' + window.languages.CodeOfCountry;

    var keyboardTouchStartX, keyboardTouchStartY, keyboardTouchEndX, keyboardTouchEndY;

    componentKeyboard.returnStartValue = function () {
      keyboardTouchStartX = event.changedTouches[0].pageX
      keyboardTouchStartY = event.changedTouches[0].pageY
    }


    componentKeyboard.returnValue = function (myValue) {

      keyboardTouchEndX = event.changedTouches[0].pageX
      keyboardTouchEndY = event.changedTouches[0].pageY


      if (Math.abs(keyboardTouchStartX - keyboardTouchEndX) <= 20 && Math.abs(keyboardTouchStartY - keyboardTouchEndY) <= 20) {

        if (scope.maskPhoneNumber.length < 14 && myValue != 'x') {
          if (scope.maskPhoneNumber.length == 4)
            scope.maskPhoneNumber += ' ';
          scope.maskPhoneNumber += myValue;
        }
        if (scope.phoneNumber.length < 13 && myValue != 'x') {
          scope.phoneNumber += myValue;
        }
        if (myValue == 'x' && scope.phoneNumber.length != 4) {
          scope.phoneNumber = scope.phoneNumber.substring(0, scope.phoneNumber.length - 1);
          scope.maskPhoneNumber = scope.maskPhoneNumber.substring(0, scope.maskPhoneNumber.length - 1);
        }
        console.log(scope.phoneNumber)
        console.log(scope.maskPhoneNumber)
        scope.update();
      }
      return
    }

    var offlineTouchStartX, offlineTouchStartY, offlineTouchEndX, offlineTouchEndY;

    registrationOfflineTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      offlineTouchStartX = event.changedTouches[0].pageX
      offlineTouchStartY = event.changedTouches[0].pageY


    }

    registrationOfflineTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      offlineTouchEndX = event.changedTouches[0].pageX
      offlineTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(offlineTouchStartX - offlineTouchEndX) <= 20 && Math.abs(offlineTouchStartY - offlineTouchEndY) <= 20) {

        modeOfApp.onlineMode = false;
        modeOfApp.offlineMode = true;

        this.riotTags.innerHTML = "<view-main-page>";
        riot.mount('view-main-page');
        scope.unmount()
      }
    }

    var demoContinueTouchStartX, demoContinueTouchStartY, demoContinueTouchEndX, demoContinueTouchEndY;

    demoContinueTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();


      demoContinueTouchStartX = event.changedTouches[0].pageX
      demoContinueTouchStartY = event.changedTouches[0].pageY
    }

    demoContinueTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      demoContinueTouchEndX = event.changedTouches[0].pageX
      demoContinueTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(demoContinueTouchStartX - demoContinueTouchEndX) <= 20 && Math.abs(demoContinueTouchStartY - demoContinueTouchEndY) <= 20) {
        if(!localStorage.getItem('device_platform'))
          localStorage.setItem('device_platform', device.platform)
        window.location = "index-stand-demo.html"
      }
    }

    var demoOpenTouchStartX, demoOpenTouchStartY, demoOpenTouchEndX, demoOpenTouchEndY;


    goToDemoTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      demoOpenTouchStartX = event.changedTouches[0].pageX
      demoOpenTouchStartY = event.changedTouches[0].pageY

    }

    goToDemoTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      demoOpenTouchEndX = event.changedTouches[0].pageX
      demoOpenTouchEndY = event.changedTouches[0].pageY

      console.log(demoOpenTouchStartX, demoOpenTouchStartY)
      console.log(demoOpenTouchEndX, demoOpenTouchEndY)

      if (Math.abs(demoOpenTouchStartX - demoOpenTouchEndX) <= 20 && Math.abs(demoOpenTouchStartY - demoOpenTouchEndY) <= 20) {


        demoContinueContainer.style.display = 'block'
      }

//      localStorage.setItem('demo_version', true);
    }
    //    closeDemo = function () {
    //      event.preventDefault();
    //      event.stopPropagation();
    //      this.demoContainer.classList.add('hide')
    //    }

    var getPhoneNumberTouchStartX, getPhoneNumberTouchStartY, getPhoneNumberTouchEndX, getPhoneNumberTouchEndY

    getPhoneNumberTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      getPhoneNumberTouchStartX = event.changedTouches[0].pageX
      getPhoneNumberTouchStartY = event.changedTouches[0].pageY

    };

    getPhoneNumberTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      getPhoneNumberTouchEndX = event.changedTouches[0].pageX
      getPhoneNumberTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(getPhoneNumberTouchStartX - getPhoneNumberTouchEndX) <= 20 && Math.abs(getPhoneNumberTouchStartY - getPhoneNumberTouchEndY) <= 20) {
        var correctPhoneNumber = true;
        var phoneNumber = scope.phoneNumber.substring(1, scope.phoneNumber.length);

        if (phoneNumber.length != 12) {
          scope.clickPinError = false;
          scope.errorNote = "Неправильно введен номер телефона";
          scope.showError = true;
          scope.update();

          correctPhoneNumber = false;
        }
//      console.log(phoneNumber);


        if (correctPhoneNumber) {
          var versionOfApp = '5.0'
          if (localStorage.getItem('version') && localStorage.getItem('version') === versionOfApp) {

          }
          else {
            localStorage.clear()
            localStorage.setItem('version', versionOfApp)
          }
          localStorage.setItem('click_client_phoneNumber', phoneNumber);
          var date = parseInt(Date.now() / 1000);
          registrationDevice(phoneNumber, date);
        }
      }

    };

    var helpTouchStartX, helpTouchStartY, helpTouchEndX, helpTouchEndY;
    helpTouchStart = function () {
      event.preventDefault()
      event.stopPropagation()

      helpTouchStartX = event.changedTouches[0].pageX
      helpTouchStartY = event.changedTouches[0].pageY

    }

    helpTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      helpTouchEndX = event.changedTouches[0].pageX
      helpTouchEndY = event.changedTouches[0].pageY


      if (Math.abs(helpTouchStartX - helpTouchEndX) <= 20 && Math.abs(helpTouchStartY - helpTouchEndY) <= 20) {

        componentTourId.style.display = "block";
        if (device.platform != 'BrowserStand')
          StatusBar.backgroundColorByHexString("#024361");

      }
    }

    function deviceType() {
      return device.platform == 'iOS' ? 2 : 1;
    }

    function deviceName() {
      return device.model;
    }

    function deviceImei() {
      return (device.uuid.substring(0, device.uuid.length / 2));
    }

    function deviceInfo() {
      return device.manufacturer + ' ' + device.version + ' ' + device.model;
    }

    var countOfCall = 0;
    function registrationDevice(phoneNumber, date) {
      countOfCall++;
      var checkServiceAnswer = false;
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
        method: 'device.register.request',
        input: {
          phone_num: phoneNumber,
          device_info: deviceInfo(),
          device_name: deviceName(),
          device_type: deviceType(),
          datetime: date,
          imei: deviceImei(),
          app_version: '1.0.1'
        },

        scope: this,

        onSuccess: function (result) {
          checkServiceAnswer = true;
          if (result[0][0].error == 0) {
            if (result[1][0]) {

              localStorage.setItem('onResume', false)

              var deviceId = result[1][0].device_id;
              localStorage.setItem('click_client_deviceID', deviceId);
              token = hex_sha512(deviceId + date + phoneNumber);
              localStorage.setItem('click_client_token', token);
              if (result[1][0].confirm_needed) {
                localStorage.setItem('confirm_needed', true);
                this.riotTags.innerHTML = "<view-sms>";
                riot.mount('view-sms');
                scope.unmount()
              }
              else {
                window.pushNotificationInitialize();
                localStorage.setItem('confirm_needed', false);
                localStorage.setItem('click_client_registered', true)
                this.riotTags.innerHTML = "<view-authorization>";
                riot.mount('view-authorization');
                scope.unmount()
              }
            }
          }
          else {

            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            scope.update();
          }


        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

      if (countOfCall < 3 && !checkServiceAnswer && window.isConnected)
        setTimeout(function () {
          if (!checkServiceAnswer && modeOfApp.onlineMode) {
            var date = parseInt(Date.now() / 1000);
            registrationDevice(localStorage.getItem('click_client_phoneNumber'), date);
          }
          if (countOfCall == 2 && !checkServiceAnswer) {
            scope.showError = true;
            scope.errorNote = "Сервис временно недоступен";
            countOfCall = 0;
            scope.update();
            if (device.platform != 'BrowserStand') {
              SpinnerPlugin.activityStop();
            }
            window.isConnected = false;
            return;
          }
        }, 10000);
    }

  </script>
</view-registration-device>