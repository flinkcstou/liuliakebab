<component-pin-reset id="componentPinResetId" class="component-pinreset">
  <div style="width: 100%; height: 100%;" if="{firstStage}">
    <p class="component-pinreset-message">{window.languages.ComponentPinResetTextOne}</p>
    <hr class="component-pinreset-line">
    <p class="component-pinreset-message">{window.languages.ComponentPinResetTextTwo}</p>


    <div class="component-pinreset-buttons-container">
      <div id="pinResetYesButtonId" class="component-pinreset-button" ontouchstart="resetPinStart()" ontouchend="resetPinEnd()">
        <p class="component-pinreset-button-label">
          {window.languages.ComponentPinResetYesButtonLabel}</p>
      </div>
      <div id="pinResetCloseButtonId" class="component-pinreset-button component-pinreset-no-button" ontouchstart="closeWindowStart()"
           ontouchend="closeWindowEnd()">
        <p class="component-pinreset-button-label">{window.languages.ComponentPinResetNoButtonLabel}</p>
      </div>
    </div>

  </div>

  <div style="width: 100%; height: 100%;" if="{!firstStage}">
    <p class="component-pinreset-message component-pinreset-message-registration">
      {firstMessage}</p>
    <hr class="component-pinreset-line"/>
    <p class="component-pinreset-message">{secondMessage}</p>


    <div class="component-pinreset-buttons-container">
      <div id="goToRegButtonId" class="component-pinreset-registration-button" ontouchstart="goToRegistrationStart()" ontouchend="goToRegistrationEnd()">
        <p class="component-pinreset-registration-button-label">
          {window.languages.ComponentPinResetRegistrationButtonLabel}</p>
      </div>
    </div>

  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this;
    scope.firstStage = true;
    scope.showError = false;

    var resetPinStartX, resetPinStartY, resetPinEndX, resetPinEndY;

    resetPinStart = function () {
      resetPinStartX = event.changedTouches[0].pageX;
      resetPinStartY = event.changedTouches[0].pageY;

      document.getElementById("pinResetYesButtonId").style.webkitTransform = 'scale(0.8)'

    }

    resetPinEnd = function () {

      resetPinEndX = event.changedTouches[0].pageX;
      resetPinEndY = event.changedTouches[0].pageY;

      document.getElementById("pinResetYesButtonId").style.webkitTransform = 'scale(1)'

      if (Math.abs(resetPinStartX - resetPinEndX) <= 20 && Math.abs(resetPinStartY - resetPinEndY) <= 20) {

        var phoneNumber = localStorage.getItem('click_client_phoneNumber');
        var timeStamp = parseInt(Date.now() / 1000);
        var sign_string = hex_md5(phoneNumber.substring(0, 5) + timeStamp + phoneNumber.substring(phoneNumber.length - 4, phoneNumber.length));
        window.api.call({
          method: 'pin.reset',
          input : {
            timestamp  : timeStamp,
            phone_num  : phoneNumber,
            sign_string: sign_string
          },

          scope: this,

          onSuccess: function (result) {
            console.log('pin.reset', result);
            if (result[0][0].error == 0) {
              console.log("result of PIN RESET ", result);
              scope.firstMessage = result[1][0].text1;
              scope.secondMessage = result[1][0].text2;
              scope.firstStage = false;
              scope.update();
            }
            else {
              scope.clickPinError = false;
              scope.errorNote = result[0][0].error_note;
              scope.showError = true;
              scope.update();
            }
          },

          onFail: function (api_status, api_status_message, data) {
            console.log('pin.reset');
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });
      }
    };

    var closeResetStartX, closeResetStartY, closeResetEndX, closeResetEndY

    closeWindowStart = function () {
      closeResetStartX = event.changedTouches[0].pageX;
      closeResetStartY = event.changedTouches[0].pageY;

      document.getElementById("pinResetCloseButtonId").style.webkitTransform = 'scale(0.8)'
    };

    closeWindowEnd = function () {

      closeResetEndX = event.changedTouches[0].pageX;
      closeResetEndY = event.changedTouches[0].pageY;

      document.getElementById("pinResetCloseButtonId").style.webkitTransform = 'scale(1)'

      if (Math.abs(closeResetStartX - closeResetEndX) <= 20 && Math.abs(closeResetStartY - closeResetEndY) <= 20) {

        console.log("close");
        componentPinResetId.style.display = 'none';
      }
    };

    var goToRegStartX, goToRegStartY, goToRegEndX, goToRegEndY;

    goToRegistrationStart = function () {
      goToRegStartX = event.changedTouches[0].pageX;
      goToRegStartY = event.changedTouches[0].pageY;

      document.getElementById("goToRegButtonId").style.webkitTransform = 'scale(0.8)'
    };

    goToRegistrationEnd = function () {

      goToRegEndX = event.changedTouches[0].pageX;
      goToRegEndY = event.changedTouches[0].pageY;

      document.getElementById("goToRegButtonId").style.webkitTransform = 'scale(1)'

      if (Math.abs(goToRegStartX - goToRegEndX) <= 20 && Math.abs(goToRegStartY - goToRegEndY) <= 20) {
        localStorage.removeItem('click_client_token');
        componentPinResetId.style.display = 'none';
        this.riotTags.innerHTML = "<view-registration-device>";
        riot.mount('view-registration-device');
      }
//      scope.unmount()
    };

  </script>
</component-pin-reset>