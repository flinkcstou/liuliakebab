<view-authorization>
  <div id="authorization">
    Введите пин-код
    <br>
    <input type="text" id="pin">
    <input type="button" value="далее" onclick="{prepare}">
  </div>

  <script>
    prepare()
    {
      var phoneNumber = localStorage.getItem('phoneNumber');
      var pin = this.pin.value;
      var deviceId = localStorage.getItem('deviceID');
      var date = parseInt(Date.now() / 1000);
      console.log(date);
      var token = localStorage.getItem('token');
      var password = hex_sha512(token + date + hex_md5(pin));
      authorization(phoneNumber, deviceId, password, date);
    }

    function authorization(phoneNumber, deviceId, password, date) {
      window.api.call({
        method: 'app.login',
        input : {
          phone_num: phoneNumber,
          device_id: deviceId,
          password : password,
          datetime : date
        },
        scope : this,

        onSuccess: function (result) {
          console.log("result 0 1 ", result[1][0]);
          var JsonInfo = JSON.stringify(result[1][0]);
          localStorage.setItem('info', JsonInfo);
          var info = JSON.parse(localStorage.getItem('info'));
          console.log(info);
          console.log(info.session_key);
        },
        onFail   : function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    }
  </script>
</view-authorization>