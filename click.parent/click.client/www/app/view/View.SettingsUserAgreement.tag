<view-settings-user-agreement>

  <div class="pay-page-title">
    <p class="settings-user-agreement-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>

  </div>

  <div class="settings-container">
    <p class="settings-user-agreement-text">{contentOfAgreement}</p>
  </div>

  <component-alert clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

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

    scope.contentOfAgreement = '';

    this.on('mount', function () {
      console.log('AGREEMENT', scope.contentOfAgreement)
    })

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
            scope.contentOfAgreement = result[1][0].content;
            riot.update();
          }
        }
        else {
          scope.clickPinError = false;
          scope.errorNote = result[0][0].error_note;
          riot.update();
          componentAlertId.style.display = 'block';
        }
      },

      onFail: function (api_status, api_status_message, data) {
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    });


  </script>
</view-settings-user-agreement>
