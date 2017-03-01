<component-pin-reset id="componentPinResetId" class="component-pinreset">
  <div style="width: 100%; height: 100%;" if="{firstStage}">
    <p class="component-pinreset-message">{window.languages.ComponentPinResetTextOne}</p>
    <hr class="component-pinreset-line">
    <p class="component-pinreset-message">{window.languages.ComponentPinResetTextTwo}</p>


    <div class="component-pinreset-buttons-container">
      <div class="component-pinreset-button" ontouchend="resetPin()">
        <p class="component-pinreset-button-label">{window.languages.ComponentPinResetYesButtonLabel}</p>
      </div>
      <div class="component-pinreset-button component-pinreset-no-button" ontouchend="closeWindow()">
        <p class="component-pinreset-button-label">{window.languages.ComponentPinResetNoButtonLabel}</p>
      </div>
    </div>

  </div>

  <div style="width: 100%; height: 100%;" if="{!firstStage}">
    <p class="component-pinreset-message component-pinreset-message-registration">
      {window.languages.ComponentPinResetTextThree}</p>
    <p class="component-pinreset-message">--------------------------</p>
    <p class="component-pinreset-message">{window.languages.ComponentPinResetTextFour}</p>


    <div class="component-pinreset-buttons-container">
      <div class="component-pinreset-registration-button" ontouchend="goToRegistration()">
        <p class="component-pinreset-registration-button-label">
          {window.languages.ComponentPinResetRegistrationButtonLabel}</p>
      </div>
    </div>

  </div>


  <script>
    var scope = this;
    scope.firstStage = true;

    resetPin = function () {
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
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
          console.log('pin.reset', result);
          if (result[0][0].error == 0) {
            console.log("result of PIN RESET ", result);
          }
          else
            alert(result[0][0].error_note);
        },

        onFail: function (api_status, api_status_message, data) {
          console.log('pin.reset');
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
      console.log("call method in api");
      scope.firstStage = false;
      riot.update(scope.firstStage);
    };

    closeWindow = function () {
      console.log("close");
      componentPinResetId.style.display = 'none';
    };

    goToRegistration = function () {
      localStorage.removeItem('click_client_token');
      console.log("registr, need to delete some lines in storage");
      componentPinResetId.style.display = 'none';
      this.riotTags.innerHTML = "<view-registration-device>";
      riot.mount('view-registration-device');
    };

  </script>
</component-pin-reset>