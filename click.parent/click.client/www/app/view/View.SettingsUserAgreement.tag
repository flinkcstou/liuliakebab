<view-settings-user-agreement class="riot-tags-main-container">

  <div class="pay-page-title">
    <p class="settings-user-agreement-name-title">{titleName}</p>
    <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
         ontouchend="goToBackEnd()" class="pay-back-button"></div>
  </div>

  <div class="settings-container">
    <p class="settings-user-agreement-text">{contentOfAgreement}</p>
  </div>

  <script>

    var scope = this;

    this.titleName = window.languages.ViewSettingsUserAgreementTitle;

    window.saveHistory('view-settings-user-agreement', opts);

    scope.contentOfAgreement = '';
    //
    //    this.on('mount', function () {
    //      console.log('AGREEMENT', scope.contentOfAgreement)
    //    })

    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

    goToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(0.7)'

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    goToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(1)'

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown()
        scope.unmount()
      }
    };

    if (localStorage.getItem("click_client_agreement")) {
      scope.contentOfAgreement = localStorage.getItem("click_client_agreement");
      scope.update();
    }

    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    var sessionKey = loginInfo.session_key;

    if (!localStorage.getItem("click_client_agreement") || loginInfo.update_terms) {
      window.api.call({
        method: 'get.terms',
        stopSpinner: false,
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
        },
        scope: this,
        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            if (result[1][0]) {
              scope.contentOfAgreement = result[1][0].content;
              console.log("from FTRDFTYFIYV");
              localStorage.setItem("click_client_agreement", scope.contentOfAgreement);
              scope.update();
            }
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;

            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: scope.clickPinError,
              errornote: scope.errorNote,
            });

            scope.update();
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }


  </script>
</view-settings-user-agreement>
