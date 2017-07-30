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


    <button id="alertOkButtonId" class="component-alert-button-inner-container" ontouchstart="closeAlertFormStart(this.id)"
            ontouchend="closeAlertFormEnd(this.id)">
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
      console.log('QQQ')
      console.log('scope.parent', scope.parent)

      document.getElementById(id).style.webkitTransform = 'scale(1)'

      okButtonEndX = event.changedTouches[0].pageX;
      okButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(okButtonStartX - okButtonEndX) <= 20 && Math.abs(okButtonStartY - okButtonEndY) <= 20) {

        if (scope.parent) {
          scope.parent.showError = false;

          if(opts.carddelete){
            riotTags.innerHTML = "<view-my-cards>";
            riot.mount('view-my-cards');
            return
          }

          if (opts.viewpage) {
            riotTags.innerHTML = "<" + opts.viewpage + ">";
            riot.mount(opts.viewpage);
          }

          if (opts.step_amount)
            if (opts.step_amount || opts.step_amount == 0) {
              console.log("opts.step_amount", opts)
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
        riot.update()
      }
    };


  </script>
</component-alert>