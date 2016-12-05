<view-transfer>
  <h1>TRANSFER VIEW</h1>

  <script>
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    phoneNumber = phoneNumber.substring(3, phoneNumber.length);
    console.log('PHONE NUMBER ',phoneNumber);
    var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;

    window.api.call({
      method: 'get.service.list',
      input : {
        session_key: sessionKey,
        phone_num: phoneNumber
      },
      scope : this,

      onSuccess: function (result) {
        console.log(result)
      },
      onFail   : function (api_status, api_status_message, data) {
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    })


    window.api.call({
      method: 'get.service.parameters.list',
      input : {
        session_key: sessionKey,
        phone_num: phoneNumber
      },
      scope : this,

      onSuccess: function (result) {
        console.log(result)
      },
      onFail   : function (api_status, api_status_message, data) {
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    })

  </script>
</view-transfer>
