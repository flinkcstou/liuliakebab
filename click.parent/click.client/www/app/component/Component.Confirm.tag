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

      if (opts.confirmtype == 'local') {
        scope.parent.result(true);
      }
      else if (opts.confirmtype == 'internet') {
        modeOfApp.offlineMode = true;
        modeOfApp.onlineMode = false;

        riotTags.innerHTML = "<view-main-page>";
        riot.mount('view-main-page');
        riot.update()
//        scope.unmount()
      } else if (opts.confirmtype == 'session') {
        riotTags.innerHTML = "<view-authorization>";
        riot.mount('view-authorization');
//        scope.unmount()
      }
      else {
        navigator.app.exitApp();
      }
      scope.outerShowAlertBool = true;

      //OK
      riot.update()
    };

    cancelConfirm = function () {
      event.preventDefault();
      event.stopPropagation();

      scope.outerShowAlertBool = true;
      console.log(scope.outerShowAlertBool)

      riot.update()
    }

  </script>
</component-confirm>