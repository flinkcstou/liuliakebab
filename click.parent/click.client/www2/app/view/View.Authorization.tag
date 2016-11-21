<view-authorization>
  <form id="authorization">
    Введите пин-код
    <br>
    <input type="text" id="pin">
    <input type="button" value="далее" onclick="{prepare}">
  </form>

  <script>
    prepare()
    {
      var phoneNumber = localStorage.getItem('phoneNumber');
      var pin = this.pin.value;
      var deviceId = localStorage.getItem('deviceID');
      var date = Date.now() / 1000;
      var token = localStorage.getItem('token');
      var password = hex_sha512(token + date + hex_md5(pin));
      authorization(phoneNumber, deviceId, password, date);
    }

    function authorization(phoneNumber, deviceId, password, date) {
      window.api.call({
        method: 'app.login',
        input:{
          phone_num: phoneNumber,
          device_id: deviceId,
          password: password,
          datetime: date
        },
        scope: this,

        onSuccess: function(result){
          console.log(result[0][0]);
        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    }
  </script>
</view-authorization>