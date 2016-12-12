<view-registration-device>
  <div class="registration-phone-field">
    <p class="registration-text-field">Введите номер телефона</p>
    <p class="registration-phone-input">{viewRegistration.phoneNumber}</p>
  </div>

  <div class="registration-keyboard-field keyboard-field">
    <div class="registration-button-help">Помощь</div>
    <component-keyboard></component-keyboard>
  </div>

  <div class="registration-button-enter button-enter" ontouchend="getPhoneNumber()">
    <div class="button-enter-label">Далее</div>
  </div>

  <div class="registration-buttons-container">
    <div class="registration-container-offline">
      <div class="registration-button-offline">Офлайн режим</div>
    </div>
    <a href="stand/index-stand.html" id="demoContainer" class="registration-container-demo-version" ontouchstart="goToDemo()">
      <div   class="registration-button-demo-version">Демо версия</div>
    </a>
  </div>

  <script>
    history.arrayOfHistory.push('view-registration-device');
    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

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
          if(result[0][0].error == -8){
            alert("Пользователь не найден");
            return;
          }
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