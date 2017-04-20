<component-confirm>
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


    okConfirm = function () {
      event.preventDefault();
      event.stopPropagation();
      scope.parent.showConfirm = false;

      if (opts.step_amount || opts.step_amount == 0) {

        history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - opts.step_amount)
        console.log(history.arrayOfHistory)
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
        onBackKeyDown()
      }

      //OK
      riot.update()
    };

    cancelConfirm = function () {
      event.preventDefault();
      event.stopPropagation();
      scope.parent.showConfirm = false;

      if (opts.step_amount || opts.step_amount == 0) {

        history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - opts.step_amount)
        console.log(history.arrayOfHistory)
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
        onBackKeyDown()
      }

      //OK
      riot.update()
    }

    window.showAlert = function () {

    }
  </script>
</component-confirm>