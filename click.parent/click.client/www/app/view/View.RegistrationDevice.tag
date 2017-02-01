<view-registration-device class="view-registration-device">
  <div class="registration-device-flex-container">
    <div class="registration-device-unchangable-container">
      <div class="registration-device-phone-field">
        <p class="registration-device-text-field">{window.languages.ViewRegistrationTextField}</p>
        <p class="registration-device-phone-input">{maskPhoneNumber}</p>
        <div class="registration-device-remember" ontouchend="touchEndRemember()">
          <p class="registration-device-remember-label">{window.languages.ViewRegistrationDeviceRememberLabel}</p>
          <div id="rememberIcon" class="registration-device-remember-icon"></div>
        </div>
        <div class="registration-button-enter button-enter" ontouchend="getPhoneNumber()">
          <div class="button-enter-label">{window.languages.ViewRegistrationDeviceButtonEnterLabel}</div>
        </div>
      </div>
    </div>
  </div>

  <div class="registration-keyboard-field keyboard-field">
    <div class="registration-button-help">{window.languages.ViewRegistrationDeviceButtonHelp}</div>
    <component-keyboard></component-keyboard>
  </div>


  <div class="registration-buttons-container">
    <div class="registration-container-offline">
      <div class="registration-button-offline">{window.languages.ViewRegistrationDeviceButtonOffline}</div>
    </div>
    <a href="stand/index-stand.html" id="demoContainer" class="registration-container-demo-version"
       ontouchstart="goToDemo()">
      <div class="registration-button-demo-version">{window.languages.ViewRegistrationDeviceButtonDemoVersion}</div>
    </a>
  </div>

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
    }

      history.arrayOfHistory.push(
              {
                "view": 'view-registration-device',
                "params": ''
              }

      );
    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))


    var scope = this;
    var token;


    scope.phoneNumber = '+' + window.languages.CodeOfCountry;
    scope.maskPhoneNumber = '+' + window.languages.CodeOfCountry;


    componentKeyboard.returnValue = function (myValue) {
      event.preventDefault();
      event.stopPropagation();
      if (scope.maskPhoneNumber.length < 17 && myValue != 'x') {
        if (scope.maskPhoneNumber.length == 4)
          scope.maskPhoneNumber += ' ';
        scope.maskPhoneNumber += myValue;
      }
      if (scope.phoneNumber.length < 13 && myValue != 'x') {
        scope.phoneNumber += myValue;
      }
      if (myValue == 'x' && scope.phoneNumber.length != 4) {
        scope.phoneNumber = scope.phoneNumber.substring(0, scope.phoneNumber.length - 1);

        if (scope.maskPhoneNumber.length == 8 || scope.maskPhoneNumber.length == 12 || scope.maskPhoneNumber.length == 15)
          scope.maskPhoneNumber = scope.maskPhoneNumber.substring(0, scope.maskPhoneNumber.length - 2);
        else
          scope.maskPhoneNumber = scope.maskPhoneNumber.substring(0, scope.maskPhoneNumber.length - 1);
      }
//      console.log(scope.phoneNumber)
      riot.update(scope.maskPhoneNumber);
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
        alert("incorrect number");

        correctPhoneNumber = false;
      }
//      console.log(phoneNumber);


      if (correctPhoneNumber) {
        localStorage.setItem('click_client_phoneNumber', phoneNumber);
        var date = parseInt(Date.now() / 1000);
        registrationDevice(phoneNumber, date);
      }

    };

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
      window.api.call({
        method: 'device.register.request',
        input : {
          phone_num  : phoneNumber,
          device_info: deviceInfo(),
          device_name: deviceName(),
          device_type: deviceType(),
          datetime   : date,
          imei       : deviceImei()
        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == -8) {
            alert("Пользователь не найден");
            return;
          }
//          console.log("result ", result);
          var deviceId = result[1][0].device_id;
          localStorage.setItem('click_client_deviceID', deviceId);
          token = hex_sha512(deviceId + date + phoneNumber);
          localStorage.setItem('click_client_token', token);
          if (result[1][0].confirm_needed) {
            localStorage.setItem('confirm_needed', true);
            this.riotTags.innerHTML = "<view-sms>";
            riot.mount('view-sms');
          }
          else {
            this.riotTags.innerHTML = "<view-authorization>";
            riot.mount('view-authorization');
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