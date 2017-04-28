<view-registration-device class="view-registration-device">
  <div class="registration-device-flex-container">
    <div class="registration-device-unchangable-container">
      <div class="registration-device-phone-field">
        <p class="registration-device-text-field">{window.languages.ViewRegistrationTextField}</p>
        <p class="registration-device-phone-input">{maskPhoneNumber}</p>
        <div class="registration-device-remember" ontouchend="touchEndRemember()">
          <p class="registration-device-remember-label">
            {window.languages.ViewRegistrationDeviceRememberLabel}</p>
          <div id="rememberIcon" class="registration-device-remember-icon"></div>
        </div>
        <div class="registration-button-enter button-enter" ontouchend="getPhoneNumber()">
          <div class="button-enter-label">{window.languages.ViewRegistrationDeviceButtonEnterLabel}</div>
        </div>
      </div>
    </div>
  </div>

  <div class="registration-keyboard-field keyboard-field">
    <div class="registration-button-help" ontouchend="helpTouchEnd()">
      {window.languages.ViewRegistrationDeviceButtonHelp}
    </div>
    <component-keyboard></component-keyboard>
  </div>


  <div class="registration-buttons-container">
    <div if="{device.platform != 'iOS'}" class="registration-container-offline" ontouchend="registrationOfflineTouchEnd()">
      <div class="registration-button-offline">{window.languages.ViewRegistrationDeviceButtonOffline}</div>
    </div>
    <a href="index-stand-demo.html" id="demoContainer" class="registration-container-demo-version">
      <div class="registration-button-demo-version">{window.languages.ViewRegistrationDeviceButtonDemoVersion}
      </div>
    </a>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>


    var checkRemember = false;
    touchEndRemember = function () {
      event.preventDefault();
      event.stopPropagation();

      if (!checkRemember) {
        this.rememberIcon.style.opacity = '1';
        localStorage.setItem('device_remember', true);
        checkRemember = true;
        return;

      }
      else {
        this.rememberIcon.style.opacity = '0.3';
        localStorage.setItem('device_remember', false);
        checkRemember = false;
        return;
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


    componentKeyboard.returnValue = function (myValue) {
      event.preventDefault();
      event.stopPropagation();
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
      riot.update(scope.maskPhoneNumber);
    }

    registrationOfflineTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      modeOfApp.onlineMode = false;
      modeOfApp.offlineMode = true;
      this.riotTags.innerHTML = "<view-main-page>";
      riot.mount('view-main-page');
      scope.unmount()
    }

    goToDemo = function () {
      event.preventDefault();
      event.stopPropagation();
      localStorage.setItem('demo_version', true);
    }
    closeDemo = function () {
      event.preventDefault();
      event.stopPropagation();
      this.demoContainer.classList.add('hide')
    }

    getPhoneNumber = function () {
      event.preventDefault();
      event.stopPropagation();

      var correctPhoneNumber = true;
      var phoneNumber = scope.phoneNumber.substring(1, scope.phoneNumber.length);

      if (phoneNumber.length != 12) {
        scope.clickPinError = false;
        scope.errorNote = "Неправильно введен номер телефона";
        scope.showError = true;
        riot.update();

        correctPhoneNumber = false;
      }
//      console.log(phoneNumber);


      if (correctPhoneNumber) {
        localStorage.setItem('click_client_phoneNumber', phoneNumber);
        var date = parseInt(Date.now() / 1000);
        registrationDevice(phoneNumber, date);
      }

    };

    helpTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      riotTags.innerHTML = "<view-help>";
      riot.mount('view-help');
      scope.unmount()
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


    function registrationDevice(phoneNumber, date) {

      if (device.platform != 'BrowserStand') {
        var options = {dimBackground: true};

        SpinnerPlugin.activityStart(languages.Downloading, options, function () {
          console.log("Started");
        }, function () {
          console.log("closed");
        });
      }

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
            riot.update();
          }


        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }

  </script>
</view-registration-device>