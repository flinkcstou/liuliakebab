<component-alert>
  <div id="componentAlertId" class="component-alert">
    <div class="component-alert-icon"></div>
    <p class="component-alert-message" if="{!opts.clickpinerror}">{opts.errornote}</p>
    <p class="component-alert-message-settings" if="{opts.permissionerror}">{opts.pathtosettings}</p>

    <div class="component-alert-clickpin-error-container" if="{opts.clickpinerror}">
      <p class="component-alert-message component-alert-clickpin-message-one">
        {window.languages.ComponentAlertClickPinErrorTextOne}</p>
      <p class="component-alert-message component-alert-clickpin-message-two">
        {window.languages.ComponentAlertClickPinErrorTextTwo}</p>
      <p class="component-alert-message component-alert-clickpin-message-three">
        {window.languages.ComponentAlertClickPinErrorTextThree}</p>
    </div>


    <button id="alertOkButtonId" class="component-alert-button-inner-container"
            ontouchstart="closeAlertFormStart(this.id)"
            ontouchend="closeAlertFormEnd(this.id)">
      {opts.errorcode==2? window.languages.ComponentAlertRegister: window.languages.ComponentAlertOk}
    </button>
  </div>

  <script>
    var scope = this;
    var okButtonStartX, okButtonEndX, okButtonStartY, okButtonEndY;

    closeAlertFormStart = function (id) {
      event.preventDefault();
      event.stopPropagation();

      okButtonStartX = event.changedTouches[0].pageX;
      okButtonStartY = event.changedTouches[0].pageY;

      document.getElementById(id).style.webkitTransform = 'scale(0.8)';
    };

    closeAlertFormEnd = function (id) {
      event.preventDefault();
      event.stopPropagation();

      document.getElementById(id).style.webkitTransform = 'scale(1)';

      okButtonEndX = event.changedTouches[0].pageX;
      okButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(okButtonStartX - okButtonEndX) <= 20 && Math.abs(okButtonStartY - okButtonEndY) <= 20) {

        if (opts.parent) {
          console.log("Alert from parent:", opts.parent);
          window.common.alert.hide("componentAlertId");

          //special for broken session on iOS
          if (opts.session_broken){
            location.reload();
            return;
          }

          if (opts.carddelete) {
            riotTags.innerHTML = "<view-my-cards>";
            riot.mount('view-my-cards');
            return;
          }

          if (opts.errorcode === 1) {
            console.log("Alert to main page");
            riotTags.innerHTML = "<view-main-page>";
            riot.mount('view-main-page');
            return;
          }

          if (opts.errorcode === 2) {
            console.log("Alert to registration");
            riotTags.innerHTML = "<view-registration-device>";
            riot.mount('view-registration-device');
            return;
          }

          if (opts.viewpage) {
            if (opts.fingerprintmodeoff) {
              console.log("Alert to ", opts.viewpage);
              var fingerPrintMode = false;
              riotTags.innerHTML = "<" + opts.viewpage + ">";
              riot.mount(opts.viewpage, {fingerPrintMode: fingerPrintMode});
              return;
            } else {
              console.log("Alert to ", opts.viewpage);
              riotTags.innerHTML = "<" + opts.viewpage + ">";
              riot.mount(opts.viewpage);
              return;
            }

          }

          console.log("OPTS in ALERT", opts);
          console.log(JSON.stringify(history.arrayOfHistory));

          if (opts.step_amount)
            if (opts.step_amount || opts.step_amount == 0) {
              console.log("opts.step_amount", opts);
              history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - opts.step_amount)
              console.log(history.arrayOfHistory);
              sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
              if (!opts.viewmount)
                onBackKeyDown();
              else {
                riotTags.innerHTML = "<" + history.arrayOfHistory[history.arrayOfHistory.length - 1].view + ">";
                riot.mount(history.arrayOfHistory[history.arrayOfHistory.length - 1].view, history.arrayOfHistory[history.arrayOfHistory.length - 1].params);
              }
//          scope.unmount()
            }
        }
        else {
          console.log("Alert without parent");
          if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view == 'view-registration-device') {
            window.common.alert.hide("componentAlertId");
            console.log("Alert to device registration");
//            riot.update()
            riotTags.innerHTML = "<view-registration-device>";
            riot.mount('view-registration-device');
          } else if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view == 'view-sms') {
            window.common.alert.hide("componentAlertId");
            console.log("Alert to device registration");
            history.arrayOfHistory.pop();
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
            riotTags.innerHTML = "<view-registration-device>";
            riot.mount('view-registration-device');
          }
          else {
            console.log("Alert to authorization");
            window.common.alert.hide("componentAlertId");
            riotTags.innerHTML = "<view-authorization>";
            riot.mount('view-authorization');
            return;
          }
        }

        //OK
//        riot.update()
      }
    };


  </script>
</component-alert>