<view-authorization>

  <div class="authorization-pin-container">
    <div class="authorization-pin-field">
      <div id="circleOne" class="authorization-pin-circles authorization-pin-one"></div>
      <div id="circleTwo" class="authorization-pin-circles authorization-pin-two"></div>
      <div id="circleThree" class="authorization-pin-circles authorization-pin-three"></div>
      <div id="circleFour" class="authorization-pin-circles authorization-pin-four"></div>
      <div id="circleFive" class="authorization-pin-circles authorization-pin-five"></div>
    </div>
  </div>

  <div class="authorization-keyboard-field">
    <component-keyboard></component-keyboard>
  </div>

  <div class="authorization-button-enter" ontouchend="prepare()">
    <div class="authorization-enter-label">ВОЙТИ</div>
  </div>

  <div class="authorization-buttons-container">
    <div class="authorization-button-forget-pin">Забыли Click-Pin?</div>
    <div class="authorization-button-registration">Регистрация</div>
    <div class="authorization-button-offline">Офлайн режим</div>
  </div>


  <input id="getBalanceId" class="hide" type="button" value="Получение баланса" ontouchend="getBalance()">


  <script>
    scope = this;
    window.viewAuthorization = {};
    viewAuthorization.check = true;
    var pin;

    window.viewAuthorization.updateEnteredPin = function () {
      console.log("Updated PIN ", viewAuthorization.enteredPin);

      if (viewAuthorization.enteredPin.length == 0) {
        scope.circleOne.style.backgroundColor = 'transparent';
        scope.circleTwo.style.backgroundColor = 'transparent';
        scope.circleThree.style.backgroundColor = 'transparent';
        scope.circleFour.style.backgroundColor = 'transparent';
        scope.circleFive.style.backgroundColor = 'transparent';
      }
      if (viewAuthorization.enteredPin.length == 1) {
        scope.circleOne.style.backgroundColor = '#01cfff';
        scope.circleTwo.style.backgroundColor = 'transparent';
        scope.circleThree.style.backgroundColor = 'transparent';
        scope.circleFour.style.backgroundColor = 'transparent';
        scope.circleFive.style.backgroundColor = 'transparent';
      }
      if (viewAuthorization.enteredPin.length == 2) {
        scope.circleOne.style.backgroundColor = '#01cfff';
        scope.circleTwo.style.backgroundColor = '#01cfff';
        scope.circleThree.style.backgroundColor = 'transparent';
        scope.circleFour.style.backgroundColor = 'transparent';
        scope.circleFive.style.backgroundColor = 'transparent';
      }

      if (viewAuthorization.enteredPin.length == 3) {
        scope.circleOne.style.backgroundColor = '#01cfff';
        scope.circleTwo.style.backgroundColor = '#01cfff';
        scope.circleThree.style.backgroundColor = '#01cfff';
        scope.circleFour.style.backgroundColor = 'transparent';
        scope.circleFive.style.backgroundColor = 'transparent';
      }

      if (viewAuthorization.enteredPin.length == 4) {
        scope.circleOne.style.backgroundColor = '#01cfff';
        scope.circleTwo.style.backgroundColor = '#01cfff';
        scope.circleThree.style.backgroundColor = '#01cfff';
        scope.circleFour.style.backgroundColor = '#01cfff';
        scope.circleFive.style.backgroundColor = 'transparent';
      }

      if (viewAuthorization.enteredPin.length == 5) {
        scope.circleOne.style.backgroundColor = '#01cfff';
        scope.circleTwo.style.backgroundColor = '#01cfff';
        scope.circleThree.style.backgroundColor = '#01cfff';
        scope.circleFour.style.backgroundColor = '#01cfff';
        scope.circleFive.style.backgroundColor = '#01cfff';
      }

      if (viewAuthorization.enteredPin.length == 5) {
        pin = viewAuthorization.enteredPin;
        viewAuthorization.enteredPin = '';

      }
    }

    prepare = function () {
      event.preventDefault();
      event.stopPropagation();

      console.log("PIN CODE ", pin)

      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
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
          if (!result[1][0].error) {
            var JsonInfo = JSON.stringify(result[1][0]);
            localStorage.setItem('click_client_loginInfo', JsonInfo);
            var info = JSON.parse(localStorage.getItem('click_client_loginInfo'));
            viewAuthorization.check = false;
          }
        },
        onFail   : function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    }
    var arrayAccountInfo = [];
    getAccount = function (e) {
      if (JSON.parse(localStorage.getItem("click_client_loginInfo"))) {
        var phoneNumber = localStorage.getItem("click_client_phoneNumber");
        var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
        var sessionKey = info.session_key;

        console.log(phoneNumber, ' ', sessionKey);

        window.api.call({
          method: 'get.accounts',
          input : {
            session_key: sessionKey,
            phone_num  : phoneNumber
          },

          scope: this,

          onSuccess: function (result) {
            console.log('RESULT ', result);
            for (var i = 0; i < result[1].length; i++) {
              arrayAccountInfo.push(result[1][i])
            }
            var accountInfo = JSON.stringify(arrayAccountInfo);
            localStorage.setItem("click_client_accountInfo", accountInfo);
          },

          onFail: function (api_status, api_status_message, data) {
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        })
      }
      console.log(arrayAccountInfo);
    }

    getBalance = function (e) {
      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = loginInfo.session_key;
      var accountInfo = JSON.parse(localStorage.getItem('click_client_accountInfo'));
      var accountId = accountInfo.id;
      var cardNumHash = accountInfo.card_num_hash;
      var cardNumCrypted = accountInfo.card_num_crypted;

      window.api.call({
        method: 'get.balance',
        input : {
          session_key     : sessionKey,
          phone_num       : phoneNumber,
          account_id      : accountId,
          card_num_hash   : cardNumHash,
          card_num_crypted: cardNumCrypted
        },

        scope    : this,
        onSuccess: function (result) {
          console.log("result[1][0] ", result[1][0]);
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })

    }

    getAccount();
  </script>
</view-authorization>