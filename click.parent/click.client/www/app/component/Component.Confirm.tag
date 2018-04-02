<component-confirm>
  <div id="componentConfirmId" class="component-alert">
    <div class="component-alert-icon"></div>
    <p class="component-alert-message">{opts.confirmnote}</p>

    <div class="component-calc-buttons-container">
      <button id="confirmCancelButtonId" class="component-confirm-button-cancel-container"
              ontouchstart="cancelConfirmStart(this.id)" ontouchend="cancelConfirmEnd(this.id)">
        {window.languages.ComponentConfirmCancel}
      </button>
      <button id="confirmOkButtonId" class="component-confirm-button-ok-container"
              ontouchstart="okConfirmStart(this.id)" ontouchend="okConfirmEnd(this.id)">
        {window.languages.ComponentAlertOk}
      </button>
    </div>

  </div>

  <script>
    var scope = this;

    console.log("COMPONENT CONFIRM", opts);

    var okButtonStartX, okButtonEndX, okButtonStartY, okButtonEndY;

    okConfirmStart = function (id) {
      event.preventDefault();
      event.stopPropagation();

      okButtonStartX = event.changedTouches[0].pageX;
      okButtonStartY = event.changedTouches[0].pageY;

      document.getElementById(id).style.webkitTransform = 'scale(0.8)';
    };

    okConfirmEnd = function (id) {
      event.preventDefault();
      event.stopPropagation();

      document.getElementById(id).style.webkitTransform = 'scale(1)';

      okButtonEndX = event.changedTouches[0].pageX;
      okButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(okButtonStartX - okButtonEndX) <= 20 && Math.abs(okButtonStartY - okButtonEndY) <= 20) {

        if (opts.confirmtype === 'local') {
          console.log("Confirm on local");
          opts.parent.result(true);
          window.common.alert.hide("componentConfirmId");
        }
        else if (opts.confirmtype === 'internet') {

          modeOfApp.offlineMode = true;
          modeOfApp.onlineMode = false;
          console.log("Confirm on internet");
          riotTags.innerHTML = "<view-main-page>";
          riot.mount('view-main-page');
          //        scope.unmount()
        }
        else if (opts.confirmtype === 'session') {
          riotTags.innerHTML = "<view-authorization>";
          riot.mount('view-authorization');
        }
        else {
          navigator.app.exitApp();
        }
        window.common.alert.hide("componentConfirmId");

        //OK
        riot.update()
      }
    };

    var cancelButtonStartX, cancelButtonEndX, cancelButtonStartY, cancelButtonEndY;

    cancelConfirmStart = function (id) {
      event.preventDefault();
      event.stopPropagation();

      cancelButtonStartX = event.changedTouches[0].pageX;
      cancelButtonStartY = event.changedTouches[0].pageY;

      document.getElementById(id).style.webkitTransform = 'scale(0.8)';
    };

    cancelConfirmEnd = function (id) {
      event.preventDefault();
      event.stopPropagation();

      document.getElementById(id).style.webkitTransform = 'scale(1)';

      cancelButtonEndX = event.changedTouches[0].pageX;
      cancelButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(cancelButtonStartX - cancelButtonEndX) <= 20 && Math.abs(cancelButtonStartY - cancelButtonEndY) <= 20) {

        window.common.alert.hide("componentConfirmId");
        if (opts.parent) {
          console.log("Confirm from parent");
          window.common.alert.hide("componentConfirmId");
          return;
        }
        console.log("confirm component, history=", history.arrayOfHistory);

        if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view === 'view-registration-device') {
          console.log("Confirm to device registration");
          riot.update();
          riotTags.innerHTML = "<view-registration-device>";
          riot.mount('view-registration-device');
        }
        else if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view === 'view-sms') {
          console.log("Confirm to device registration");
          history.arrayOfHistory.pop();
          sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
          riotTags.innerHTML = "<view-registration-device>";
          riot.mount('view-registration-device');
        }
        else {
          console.log("Confirm to authorization");
          riot.update();
          riotTags.innerHTML = "<view-authorization>";
          riot.mount('view-authorization');
        }

      }
    }

  </script>
</component-confirm>