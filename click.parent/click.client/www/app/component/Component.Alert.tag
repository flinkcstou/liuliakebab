<component-alert hidden="{outerShowAlertBool}">
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


    <button class="component-alert-button-inner-container" ontouchend="closeAlertForm()">
      {window.languages.ComponentAlertOk}
    </button>
  </div>

  <script>
    var scope = this;
    scope.outerShowAlertBool = false;

    //    console.log("OPTS OF ALERT", opts)
    //    if (opts[0] && opts[0].outerErrorNote) {
    //      console.log("OPTS OF ALERTGCHFG")
    //      scope.outerCall = true;
    //      scope.outerErrorNote = opts[0].outerErrorNote;
    //      riot.update();
    //    }

    closeAlertForm = function () {
      event.preventDefault();
      event.stopPropagation();

      if (scope.parent) {
        scope.parent.showError = false;

        if (opts.step_amount || opts.step_amount == 0) {

          history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - opts.step_amount)
          console.log(history.arrayOfHistory)
          sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
          onBackKeyDown()
//          scope.unmount()
        }
      } else {
        scope.outerShowAlertBool = true;
        console.log("close")
        console.log(scope.outerShowAlertBool)
      }

      //OK
      scope.update()
    };


  </script>
</component-alert>