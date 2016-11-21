<view-registration-device>
  <form id="phoneform">
    Введите телефон:
    <br>
    <input type="text" id="phoneNumber">
    <br>
    <input type="button" onclick="{getPhoneNumber}" value="Далее">
  </form>

  <form id="smsForm" class="hide">
    Введите sms:
    <br>
    <input type="text" id="sms">
    <br>
    <input type="button" onclick="{getSms}" value="Далее">
    <input type="checkbox" id="rememberDevice">Запомнить устройство
    <br>
    <input type="button" value="Переотправит sms" onclick="{resendSms}">
  </form>

  <script>
    getPhoneNumber()
    {
      var correctPhoneNumber = true;
      var phoneNumber = this.phoneNumber.value;

      if (phoneNumber.length != 12) {
        alert("incorrect number");
        this.phoneNumber.value = '';
        correctPhoneNumber = false;
      }
      console.log(phoneNumber);
      localStorage.setItem('phoneNumber', phoneNumber);
      var date = parseInt(Date.now() / 1000);


      if (correctPhoneNumber) {
        registrationDevice(phoneNumber, date);
      }


    }

    function deviceType() {
      if (device.platform == 'IOS')
        return 2;

      return 1;

    }

    function deviceName() {
      if (!device.name)
        return 'iPhone 9'
      return device.name;
    }

    function deviceImei() {
      if (!device.uuid)
        return '232323232323';
      return device.uuid;
    }

    function deviceInfo() {
      if (!device.info)
        return 'iPhone OS 9_3_5 Version/9.0 232323232323';
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
          console.log(result);
          console.log("ANSWER OF API ", result[1][0]);
          if (result[1][0].confirm_needed)
            smsForm.classList.add('show');
          var deviceId = result[1][0].device_id;
          localStorage.setItem('deviceID', deviceId);
          var token = hex_sha512(deviceId + date + phoneNumber);
          localStorage.setItem('token', token);
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }

    getSms()
    {
      var sms = this.sms.value;
      var phoneNumber = localStorage.getItem('phoneNumber');
      var deviceId = localStorage.getItem('deviceID');
      registrationConfirm(sms, phoneNumber, deviceId);
    }
    function deviceRemember() {
      if (this.rememberDevice.checked)
        return 1;
      return 0;
    }

    function registrationConfirm(sms, phoneNumber, deviceId) {
      console.log(sms);
      window.api.call({
        method: 'device.register.confirm',
        input : {
          phone_num      : phoneNumber,
          device_id      : deviceId,
          sms_code       : sms,
          device_remember: deviceRemember()
        },

        scope: this,

        onSuccess: function (result) {
          console.log("DEVICE REGISTER CONFIRM ", result[0][0]);
          if(result[0][0].error != 0){
            localStorage.removeItem('token');
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

    }

    resendSms()
    {
      var phoneNumber = localStorage.getItem('phoneNumber');
      var deviceId = localStorage.getItem('deviceID');
      window.api.call({
        method: 'sms.resend',
        input : {
          phone_num: phoneNumber,
          device_id: deviceId
        },

        scope: this,

        onSuccess: function (result) {
          console.log(result[0][0]);
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

    }
  </script>
</view-registration-device>