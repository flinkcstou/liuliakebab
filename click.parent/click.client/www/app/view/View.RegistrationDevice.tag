<view-registration-device>

  <div class="registration-phone-field"><p class="registration-phone-input">{viewRegistration.phoneNumber}</p></div>

  <div class="registration-keyboard-field keyboard-field">
    <component-keyboard></component-keyboard>
  </div>

  <div class="registration-button-enter button-enter" ontouchend="getPhoneNumber()">
    <div class="button-enter-label">ВОЙТИ</div>
  </div>

  <div class="registration-buttons-container">
    <div class="registration-button-help">Помощь</div>
    <div class="registration-button-registration">Регистрация</div>
    <div class="registration-text-field">Для прохождения регистрации<br>Вам необходимо активировать <br> услугу
      "СМС-информаирование UzCard
    </div>
    <div class="registration-container-offline">
      <div class="registration-button-offline">Офлайн режим</div>
    </div>
    <a href="stand/index-stand.html" id="demoContainer" class="registration-container-demo-version" ontouchstart="goToDemo()">
      <div   class="registration-button-demo-version">Демо версия</div>
    </a>
  </div>

  <script>

    var scope = this;
    var token;

    viewRegistration.check = true;

    goToDemo = function () {
      localStorage.setItem('demo_version', true);
    }
    closeDemo = function (){
      this.demoContainer.classList.add('hide')
    }

    getPhoneNumber = function () {
      var correctPhoneNumber = true;
      var phoneNumber = viewRegistration.phoneNumber.substring(1, viewRegistration.phoneNumber.length);

      if (phoneNumber.length != 12) {
        alert("incorrect number");
        correctPhoneNumber = false;
      }
      console.log(phoneNumber);


      if (correctPhoneNumber) {
        localStorage.setItem('click_client_phoneNumber', phoneNumber);
        var date = parseInt(Date.now() / 1000);
        registrationDevice(phoneNumber, date);
      }

    };

    function deviceType() {
      return device.platform == 'IOS' ? 2 : 1;
    }

    function deviceName() {
      return device.name;
    }

    function deviceImei() {
      return device.uuid;
    }

    function deviceInfo() {
      return device.info;
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
          console.log("result ", result);
          var deviceId = result[1][0].device_id;
          localStorage.setItem('click_client_deviceID', deviceId);
          viewRegistration.check = false;
          if (result[1][0].confirm_needed) {
            this.riotTags.innerHTML = "<view-sms>";
            riot.mount('view-sms');
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