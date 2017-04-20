<component-confirm hidden="{outerShowAlertBool}">
  <div id="componentConfirmId" class="component-alert">
    <div class="component-alert-icon"></div>
    <p class="component-alert-message">{opts.confirmnote}</p>

    <div class="component-calc-buttons-container">
      <button class="component-confirm-button-cancel-container" ontouchend="cancelConfirm()">
        {window.languages.ComponentConfirmCancel}
      </button>
      <button class="component-confirm-button-ok-container" ontouchend="okConfirm()">
        {window.languages.ComponentAlertOk}
      </button>
    </div>

  </div>

  <script>
    var scope = this;
    scope.outerShowAlertBool = false;


    okConfirm = function () {
      event.preventDefault();
      event.stopPropagation();

//      if (opts.step_amount || opts.step_amount == 0) {
//
//        history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - opts.step_amount)
//        console.log(history.arrayOfHistory)
//        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
//        onBackKeyDown()
//      }
      modeOfApp.offlineMode = true;
      modeOfApp.onlineMode = false;

      riotTags.innerHTML = "<view-main-page>";
      riot.mount('view-main-page');
      riot.update()
      scope.outerShowAlertBool = true;
      console.log("close")
      console.log(scope.outerShowAlertBool)

      //OK
      riot.update()
    };

    cancelConfirm = function () {
      event.preventDefault();
      event.stopPropagation();

//      if (opts.step_amount || opts.step_amount == 0) {
//
//        history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - opts.step_amount)
//        console.log(history.arrayOfHistory)
//        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
//        onBackKeyDown()
//      }
      scope.outerShowAlertBool = true;
      console.log("close")
      console.log(scope.outerShowAlertBool)

      //OK
      riot.update()
    }

  </script>
</component-confirm>