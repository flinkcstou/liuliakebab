<view-auto-pay>
  <h1>AUTO PAY VIEW</h1>
  <button onclick="{call}"> CALL</button>

  <script>
    call()
    {

      api.call({
        method: 'device.register.request',
        input : {
          phone_num  : "998909464133",
          device_info: "iPhone OS 9_3_5 Version/9.0 232323232323",
          device_name: "iPhone 9",
          device_type: 2,
          datetime   : 127542442,
          imei       : "232323232323"
        },

        onSuccess: function (result) {
          alert("SUCCESS");
          console.log("RESULT FROM API ", result);
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });


    }

  </script>
</view-auto-pay>
