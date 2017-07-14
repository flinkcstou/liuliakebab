<component-confirm hidden="{outerShowAlertBool}">
  <div id="componentConfirmId" class="component-alert">
    <div class="component-alert-icon"></div>
    <p class="component-alert-message">{opts.confirmnote}</p>

    <div class="component-calc-buttons-container">
      <button id="confirmCancelButtonId" class="component-confirm-button-cancel-container" ontouchstart="cancelConfirmStart()" ontouchend="cancelConfirmEnd()">
        {window.languages.ComponentConfirmCancel}
      </button>
      <button id="confirmOkButtonId" class="component-confirm-button-ok-container" ontouchstart="okConfirmStart()" ontouchend="okConfirmEnd()">
        {window.languages.ComponentAlertOk}
      </button>
    </div>

  </div>

  <script>
    var scope = this;
    scope.outerShowAlertBool = false;

    var okButtonStartX, okButtonEndX, okButtonStartY, okButtonEndY;

    okConfirmStart = function () {
      event.preventDefault();
      event.stopPropagation();

      okButtonStartX = event.changedTouches[0].pageX;
      okButtonStartY = event.changedTouches[0].pageY;

      confirmOkButtonId.style.webkitTransform = 'scale(0.8)'
    }

    okConfirmEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      confirmOkButtonId.style.webkitTransform = 'scale(1)'

      okButtonEndX = event.changedTouches[0].pageX;
      okButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(okButtonStartX - okButtonEndX) <= 20 && Math.abs(okButtonStartY - okButtonEndY) <= 20) {

        if (opts.confirmtype == 'local') {
          scope.parent.result(true);
          scope.parent.confirmShowBool = false;

        }
        else if (opts.confirmtype == 'internet') {
          modeOfApp.offlineMode = true;
          modeOfApp.onlineMode = false;

          riotTags.innerHTML = "<view-main-page>";
          riot.mount('view-main-page');
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
      }
    };

    var cancelButtonStartX, cancelButtonEndX, cancelButtonStartY, cancelButtonEndY;

    cancelConfirmStart = function () {
      event.preventDefault();
      event.stopPropagation();

      cancelButtonStartX = event.changedTouches[0].pageX;
      cancelButtonStartY = event.changedTouches[0].pageY;

      confirmCancelButtonId.style.webkitTransform = 'scale(0.8)'


    }

    cancelConfirmEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      confirmCancelButtonId.style.webkitTransform = 'scale(1)'

      cancelButtonEndX = event.changedTouches[0].pageX;
      cancelButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(cancelButtonStartX - cancelButtonEndX) <= 20 && Math.abs(cancelButtonStartY - cancelButtonEndY) <= 20) {

        scope.outerShowAlertBool = true;
        if (scope.parent)
          scope.parent.confirmShowBool = false;
        console.log(scope.outerShowAlertBool)

        riot.update()
      }
    }

  </script>
</component-confirm>