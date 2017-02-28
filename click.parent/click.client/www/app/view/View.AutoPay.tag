<view-auto-pay>
  <component-page-title title="{titleName}" backbutton="{backbuttoncheck}" rightbutton="{rightbuttoncheck}">
  </component-page-title>

  <script>
    this.titleName = window.languages.ComponentBankOperationsAutoPay;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-auto-pay') {
      history.arrayOfHistory.push(
        {
          "view": 'view-auto-pay',
          "params": ''
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    scope = this;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;

    var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    var fName = JSON.parse(localStorage.getItem('click_client_loginInfo')).firstname
    var lName = JSON.parse(localStorage.getItem('click_client_loginInfo')).lastname
    var gender = JSON.parse(localStorage.getItem('click_client_loginInfo')).gender

    window.api.call({
      method: 'get.terms',
      input: {
        session_key: sessionKey,
        phone_num: phoneNumber,

      },

      scope: this,

      onSuccess: function (result) {
        console.log('get.terms', result)
        if (result[0][0].error == 0) {
          console.log("get.terms", result);
        }
        else
          alert(result[0][0].error_note);
      },

      onFail: function (api_status, api_status_message, data) {
        console.log('get.terms')
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    });

    window.api.call({
      method: 'settings.change.visibility',
      input: {
        session_key: sessionKey,
        phone_num: phoneNumber,
        visibility: 0,

      },

      scope: this,

      onSuccess: function (result) {
        console.log('settings.change.visibility', result)
        if (result[0][0].error == 0) {
          console.log("settings.change.visibility", result);
        }
        else
          alert(result[0][0].error_note);
      },

      onFail: function (api_status, api_status_message, data) {
        console.log('settings.change.visibility')
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    });

    window.api.call({
      method: 'settings.change.profile.data',
      input: {
        session_key: sessionKey,
        phone_num: phoneNumber,
        firstname: 'BKB',
        lastname: lName,
        gender: gender,

      },

      scope: this,

      onSuccess: function (result) {
        console.log('settings.change.profile.data', result)
        if (result[0][0].error == 0) {
          console.log("settings.change.profile.data", result);
        }
        else
          alert(result[0][0].error_note);
      },

      onFail: function (api_status, api_status_message, data) {
        console.log('settings.change.profile.data')
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    });


    window.api.call({
      method: 'history.chart.data',
      input: {
        session_key: sessionKey,
        phone_num: phoneNumber,

      },

      scope: this,

      onSuccess: function (result) {
        console.log('history.chart.data', result)
        if (result[0][0].error == 0) {
          console.log("result of history.chart.data' ", result);
        }
        else
          alert(result[0][0].error_note);
      },

      onFail: function (api_status, api_status_message, data) {
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    });

    var timeStamp = parseInt(Date.now() / 1000);
    var sign_string = hex_md5(phoneNumber.substring(0, 5) + timeStamp + phoneNumber.substring(phoneNumber.length - 4, phoneNumber.length));
    window.api.call({
      method: 'pin.reset',
      input: {
        timestamp: timeStamp,
        phone_num: phoneNumber,
        sign_string: sign_string

      },

      scope: this,

      onSuccess: function (result) {
        console.log('pin.reset', result)
        if (result[0][0].error == 0) {
          console.log("result of PIN RESET ", result);
        }
        else
          alert(result[0][0].error_note);
      },

      onFail: function (api_status, api_status_message, data) {
        console.log('pin.reset')
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    });


  </script>
</view-auto-pay>
