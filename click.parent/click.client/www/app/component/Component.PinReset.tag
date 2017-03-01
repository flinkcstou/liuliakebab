<component-pin-reset id="componentPinResetId" class="component-pinreset">
  <div style="width: 100%; height: 100%;" if="{firstStage}">
    <p class="component-pinreset-message">{window.languages.ComponentPinResetTextOne}</p>
    <p class="component-pinreset-message">--------------------------</p>
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
      console.log("call method in api");
      scope.firstStage = false;
      riot.update(scope.firstStage);
    }

    closeWindow = function () {
      console.log("close");
      componentPinResetId.style.display = 'none';
    }

    goToRegistration = function () {
      console.log("registr, need to delete some lines in storage");
      componentPinResetId.style.display = 'none';
    }

  </script>
</component-pin-reset>