<view-settings-user-agreement>

  <div class="pay-page-title">
    <p class="pay-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
    <div id="rightButton" type="button" class="settings-security-check-button"
         ontouchend="saveEditedNameToucEnd()"></div>
  </div>

  <div class="settings-container">

  </div>


  <script>
    var scope = this;
    this.titleName = window.languages.ViewSettingsUserAgreementTitle;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-settings-user-agreement') {
      history.arrayOfHistory.push(
        {
          "view": 'view-settings-user-agreement',
          "params": ''
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    };

    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    var sessionKey = loginInfo.session_key;

    window.api.call({
      method: 'get.terms',
      input: {
        session_key: sessionKey,
        phone_num: phoneNumber,
      },
      scope: this,
      onSuccess: function (result) {
        if (result[0][0].error == 0) {
          if (result[1][0]) {
            console.log('RESULT OF TERMS', result[1][0].content)
          }
        }
        else
          alert(result[0][0].error_note);
      },

      onFail: function (api_status, api_status_message, data) {
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    });


  </script>
</view-settings-user-agreement>
