<view-help class="riot-tags-main-container">

  <div class="pay-page-title">
    <p class="settings-user-agreement-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>

  </div>

  <div class="settings-container">
    <p class="settings-user-agreement-text">{helpText}</p>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this;
    scope.showError = false;
    this.titleName = window.languages.ViewHelpTitle;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-help') {
      history.arrayOfHistory.push(
          {
            "view": 'view-help',
            "params": opts
          }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    scope.helpText = '';

    this.on('mount', function () {

    })

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
      scope.unmount()
    };

    //    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    //    var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    //    var sessionKey = loginInfo.session_key;


    window.api.call({
      method: 'get.help',
      input: {},
      scope: this,
      onSuccess: function (result) {
        if (result[0][0].error == 0) {
          if (result[1][0]) {
            scope.helpText = result[1][0].content;
            scope.update();
          }
        }
        else {
          scope.clickPinError = false;
          scope.errorNote = result[0][0].error_note;
          scope.showError = true;
          scope.update();
        }
      },

      onFail: function (api_status, api_status_message, data) {
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    });


  </script>
</view-help>
