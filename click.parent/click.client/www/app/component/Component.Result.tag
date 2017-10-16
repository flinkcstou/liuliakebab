<component-result hidden="{outerShowAlertBool}">
  <div id="componentResultId" class="component-result">
    <div id="alertNewIconId" class="component-result-icon"
         style="background-image: url('resources/gifs/loading.gif')"></div>
    <p id="wait" class="component-result-wait">{window.languages.ComponentResultPleaseWait}</p>
    <p id="resultMessage" class="component-result-message" if="{!opts.clickpinerror}">{opts.errornote}</p>

    <button id="alertOkButtonId" class="component-result-button-inner-container"
            ontouchstart="closeResultFormStart(this.id)"
            ontouchend="closeResultFormEnd(this.id)">
      {buttonText}
    </button>
  </div>

  <script>
    var scope = this;
    scope.outerShowAlertBool = false;
    scope.restart = false;
    scope.buttonText = window.languages.ComponentResultRepeat;


    updateIcon = function (result, checkStatus, from) {
      console.log("CHANGE GIF", result, checkStatus);
      alertOkButtonId.classList.remove("component-result-button-stop");
      alertOkButtonId.classList.remove("component-result-button-waiting");
      alertOkButtonId.classList.remove("component-result-button-success");
      alertOkButtonId.classList.remove("component-result-button-unsuccess");
      wait.classList.remove("component-result-wait-start");
      resultMessage.classList.remove("component-result-message-stop");
      if (result == 'success') {
        alertNewIconId.style.backgroundImage = "url(resources/gifs/success.gif)";
        scope.buttonText = window.languages.ComponentResultOk;
        alertOkButtonId.classList.add("component-result-button-success");
      } else if (result == 'unsuccess') {
        alertNewIconId.style.backgroundImage = "url(resources/gifs/unsuccess.gif)";
        alertOkButtonId.classList.add("component-result-button-unsuccess");
      } else if (result == 'waiting') {
        scope.restart = checkStatus ? checkStatus : false;
        scope.fromView = from;
        alertNewIconId.style.backgroundImage = "url(resources/gifs/waiting.gif)";
        alertOkButtonId.classList.add("component-result-button-waiting");
      }
      wait.classList.add("component-result-wait-stop");
      resultMessage.classList.add("component-result-message-start");
      alertOkButtonId.classList.add("component-result-button-start");
    }

    restartComponent = function () {
      scope.restart = false;
      alertNewIconId.style.backgroundImage = "url(resources/gifs/loading.gif)";
      alertOkButtonId.style.opacity = "0";
      alertOkButtonId.classList.remove("component-result-button-start");
      alertOkButtonId.classList.add("component-result-button-stop");
      wait.classList.remove("component-result-wait-stop");
      wait.classList.add("component-result-wait-start");
      resultMessage.classList.remove("component-result-message-start");
      resultMessage.classList.add("component-result-message-stop");
      console.log("PARENT", scope.parent);
      if (scope.fromView == 'view-add-card')
        scope.parent.cardAddCheck();
    }

    var okButtonStartX, okButtonEndX, okButtonStartY, okButtonEndY;

    closeResultFormStart = function (id) {
      event.preventDefault();
      event.stopPropagation();

      okButtonStartX = event.changedTouches[0].pageX;
      okButtonStartY = event.changedTouches[0].pageY;

      document.getElementById(id).style.webkitTransform = 'scale(0.8)'
    }

    closeResultFormEnd = function (id) {
      event.preventDefault();
      event.stopPropagation();

      document.getElementById(id).style.webkitTransform = 'scale(1)'

      okButtonEndX = event.changedTouches[0].pageX;
      okButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(okButtonStartX - okButtonEndX) <= 20 && Math.abs(okButtonStartY - okButtonEndY) <= 20) {

        if (scope.restart) {

          restartComponent();
        } else {

//        if (scope.parent) {
          console.log("Alert from parent:", scope.parent);
          scope.parent.showResult = false;


          if (opts.viewpage) {
            console.log("Alert to ", opts.viewpage);
            riotTags.innerHTML = "<" + opts.viewpage + ">";
            riot.mount(opts.viewpage);
            this.parent.unmount();
            this.unmount();

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

            }
//        }
//        else {
//          console.log("Alert without parent");
//          if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view == 'view-registration-device') {
//            scope.outerShowAlertBool = true;
//            console.log("Alert to device registration");
//            riot.update()
//            riotTags.innerHTML = "<view-registration-device>";
//            riot.mount('view-registration-device');
//          }
//          else {
//            console.log("Alert to authorization");
//            scope.outerShowAlertBool = true;
//            riot.update()
//            riotTags.innerHTML = "<view-authorization>";
//            riot.mount('view-authorization');
//          }
//        }

          //OK
          riot.update()

        }
      }
    };


  </script>
</component-result>