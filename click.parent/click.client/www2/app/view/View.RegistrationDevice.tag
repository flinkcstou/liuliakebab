<view-registration-device>
  <form id="phoneform">
    Введите телефон:
    <br>
    <input type="text" id="phoneNumber">
    <br>
    <input type="button" onclick="{getPhoneNumber}" value="Далее">
  </form>

  <form id="smsForm" >
    Введите sms:
    <br>
    <input type="text" id="sms">
    <br>
    <input type="button" onclick="{getSms}" value="Далее">
  </form>

  <script>
    getPhoneNumber()
    {
      console.log(device.info);
      var phoneNumber = this.phoneNumber.value;

      if (phoneNumber.length > 12) {
        alert("Number is too long");
      }
      console.log(phoneNumber);
      localStorage.setItem('phoneNumber', phoneNumber);
      var date = parseInt(Date.now() / 1000);

      registrationDevice(phoneNumber, date);
      this.smsForm.style.display = 'block';



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
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }
  </script>
</view-registration-device>