<view-authorization>
  <div id="authorization">
    Введите пин-код
    <br>
    <input type="text" id="pin">
    <input type="button" value="далее" ontouchend="prepare()">
    <input id="getAccountId" class="hide" type="button" value="Получение списка счетов" ontouchend="getAccount()">
    <input id="getBalanceId" class="hide" type="button" value="Получение баланса" ontouchend="getBalance()">
  </div>

  <script>
    scope = this;
    prepare = function(e)
    {
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      var pin = scope.pin.value;
      var deviceId = localStorage.getItem('click_client_deviceID');
      var date = parseInt(Date.now() / 1000);
      console.log(date);
      var token = localStorage.getItem('click_client_token');
      var password = hex_sha512(token + date + hex_md5(pin));
      localStorage.setItem("pinForStand", pin);
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
          console.log("result[1][0] ", result[1][0]);
          if(!result[1][0].error) {
            var JsonInfo = JSON.stringify(result[1][0]);
            localStorage.setItem('click_client_loginInfo', JsonInfo);
            var info = JSON.parse(localStorage.getItem('click_client_loginInfo'));
            this.getAccountId.classList.add("show");
            this.getBalanceId.classList.add("show");
          }
        },
        onFail   : function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    }

    getAccount = function(e)
    {
      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = info.session_key;

      window.api.call({
        method: 'get.accounts',
        input : {
          session_key: sessionKey,
          phone_num  : phoneNumber
        },

        scope: this,

        onSuccess: function (result) {
          console.log(JSON.stringify(result))
          console.log("result[1][0] ", result[1][0]);
          var accountInfo = JSON.stringify(result[1][0]);
          localStorage.setItem("click_client_accountInfo", accountInfo);
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    }

    getBalance = function(e)
    {
      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = loginInfo.session_key;
      var accountInfo = JSON.parse(localStorage.getItem('click_client_accountInfo'));
      var accountId =  accountInfo.id;
      var cardNumHash = accountInfo.card_num_hash;
      var cardNumCrypted = accountInfo.card_num_crypted;

      window.api.call({
        method: 'get.balance',
        input : {
          session_key: sessionKey,
          phone_num: phoneNumber,
          account_id: accountId,
          card_num_hash: cardNumHash,
          card_num_crypted: cardNumCrypted
        },

      scope: this,
        onSuccess: function (result) {
          console.log("result[1][0] ", result[1][0]);
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })

    }
  </script>
</view-authorization>