<component-alert-new hidden="{outerShowAlertBool}">
  <div id="componentAlertId" class="component-alert">
    <div id="alertNewIconId" class="component-alert-icon" style="background-image: url('resources/raingif.jpg')"></div>
    <p class="component-alert-message" if="{!opts.clickpinerror}">{opts.errornote}</p>

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
    scope.outerShowAlertBool = false;

    //    console.log("OPTS OF ALERT", opts)
    //    if (opts[0] && opts[0].outerErrorNote) {
    //      console.log("OPTS OF ALERTGCHFG")
    //      scope.outerCall = true;
    //      scope.outerErrorNote = opts[0].outerErrorNote;
    //      riot.update();
    //    }

    setTimeout(function () {
        console.log("CHANGE GIF");
        alertNewIconId.style.backgroundImage = "url(resources/snowgif.jpg)";

      }, 3000
    )

    var okButtonStartX, okButtonEndX, okButtonStartY, okButtonEndY;

    closeAlertFormStart = function (id) {
      event.preventDefault();
      event.stopPropagation();

      okButtonStartX = event.changedTouches[0].pageX;
      okButtonStartY = event.changedTouches[0].pageY;

      document.getElementById(id).style.webkitTransform = 'scale(0.8)'
    }

    closeAlertFormEnd = function (id) {
      event.preventDefault();
      event.stopPropagation();

      document.getElementById(id).style.webkitTransform = 'scale(1)'

      okButtonEndX = event.changedTouches[0].pageX;
      okButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(okButtonStartX - okButtonEndX) <= 20 && Math.abs(okButtonStartY - okButtonEndY) <= 20) {

        if (scope.parent) {
          console.log("Alert from parent:", scope.parent);
          scope.parent.showAlertNew = false;

          if (opts.carddelete) {
            riotTags.innerHTML = "<view-my-cards>";
            riot.mount('view-my-cards');
            return
          }

          if (opts.errorcode == 1) {
            console.log("Alert to main page");
            riotTags.innerHTML = "<view-main-page>";
            riot.mount('view-main-page');
            return;
          }

          if (opts.errorcode == 2) {
            console.log("Alert to registration");
            riotTags.innerHTML = "<view-registration-device>";
            riot.mount('view-registration-device');
            return;
          }

          if (opts.viewpage) {
            console.log("Alert to ", opts.viewpage);
            riotTags.innerHTML = "<" + opts.viewpage + ">";
            riot.mount(opts.viewpage);

          }

          console.log("OPTS in ALERT", opts)
          console.log(JSON.stringify(history.arrayOfHistory))

          if (opts.step_amount)
            if (opts.step_amount || opts.step_amount == 0) {
              console.log("opts.step_amount", opts)
              history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - opts.step_amount)
              console.log(history.arrayOfHistory)
              sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
              if (!opts.viewmount)
                onBackKeyDown()
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
            scope.outerShowAlertBool = true;
            console.log("Alert to device registration");
            riot.update()
            riotTags.innerHTML = "<view-registration-device>";
            riot.mount('view-registration-device');
          }
          else {
            console.log("Alert to authorization");
            scope.outerShowAlertBool = true;
            riot.update()
            riotTags.innerHTML = "<view-authorization>";
            riot.mount('view-authorization');
          }
        }

        //OK
        riot.update()
      }
    };


  </script>
</component-alert-new>