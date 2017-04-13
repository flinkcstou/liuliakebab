<component-alert>
  <div id="componentAlertId" class="component-alert">
    <div class="component-alert-icon"></div>
    <p class="component-alert-message" if="{!opts.clickpinerror}">{opts.errornote}</p>

    <div class="component-alert-clickpin-error-container" if="{opts.clickpinerror}">
      <p class="component-alert-message component-alert-clickpin-message-one">
        {window.languages.ComponentAlertClickPinErrorTextOne}</p>
      <p class="component-alert-message component-alert-clickpin-message-two">
        {window.languages.ComponentAlertClickPinErrorTextTwo}</p>
      <p class="component-alert-message component-alert-clickpin-message-three">
        {window.languages.ComponentAlertClickPinErrorTextThree}</p>
    </div>


    <div class="component-alert-button-inner-container" ontouchend="closeAlertForm()">
      <p class="component-alert-button-label">{window.languages.ComponentAlertOk}</p>
    </div>
  </div>

  <script>
    var scope = this;


    closeAlertForm = function () {
      event.preventDefault();
      event.stopPropagation();
      scope.parent.showError = false;

      if (opts.step_amount || opts.step_amount == 0) {

        history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - opts.step_amount)
        console.log(history.arrayOfHistory)
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
        onBackKeyDown()
      }

      //OK
      riot.update()
    };

    window.showAlert = function () {

    }
  </script>
</component-alert>