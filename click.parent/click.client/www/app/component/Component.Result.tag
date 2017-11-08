<component-result>
  <div id="componentResultId" class="component-result">
    <div id="alertNewIconId" class="component-result-icon"
         style="background-image: url('resources/gifs/loading.gif')"></div>
    <p id="wait" class="component-result-wait">{window.languages.ComponentResultPleaseWait}</p>
    <p id="resultMessage" class="component-result-message">{opts.resulttext}</p>

    <button id="resultButtonId" class="component-result-button-inner-container"
            ontouchstart="closeResultFormStart(this.id)"
            ontouchend="closeResultFormEnd(this.id)">
      {buttonText}
    </button>
  </div>

  <script>
    var scope = this;
    scope.restart = false;
    scope.buttonText = window.languages.ComponentResultClose;

    this.on('updated', function () {
      console.log('Updated!')
    });


    updateIcon = function (result, checkStatus, from, text, stepAmount, viewPage) {
      console.log(result, checkStatus, from, text, stepAmount);
      opts.resulttext = text;
      opts.step_amount = stepAmount;
      opts.viewpage = viewPage;
      scope.update();
      console.log("CHANGE GIF", result, checkStatus);
      resultButtonId.classList.remove("component-result-button-stop");
      resultButtonId.classList.remove("component-result-button-waiting");
      resultButtonId.classList.remove("component-result-button-success");
      resultButtonId.classList.remove("component-result-button-unsuccess");
      wait.classList.remove("component-result-wait-start");
      resultMessage.classList.remove("component-result-message-stop");
      if (result == 'success') {
        alertNewIconId.style.backgroundImage = "url(resources/gifs/success.gif)";
        scope.buttonText = window.languages.ComponentResultOk;
        resultButtonId.classList.add("component-result-button-success");
      } else if (result == 'unsuccess') {
        alertNewIconId.style.backgroundImage = "url(resources/gifs/unsuccess.gif)";
        resultButtonId.classList.add("component-result-button-unsuccess");
      } else if (result == 'waiting') {
        scope.restart = checkStatus ? checkStatus : false;
        scope.fromView = from;
        alertNewIconId.style.backgroundImage = "url(resources/gifs/waiting.gif)";
        resultButtonId.classList.add("component-result-button-waiting");
      }
      wait.classList.add("component-result-wait-stop");
      resultMessage.classList.add("component-result-message-start");
      resultButtonId.classList.add("component-result-button-start");
    };

    restartComponent = function () {
      scope.restart = false;
      alertNewIconId.style.backgroundImage = "url(resources/gifs/loading.gif)";
      resultButtonId.style.opacity = "0";
      resultButtonId.classList.remove("component-result-button-start");
      resultButtonId.classList.add("component-result-button-stop");
      wait.classList.remove("component-result-wait-stop");
      wait.classList.add("component-result-wait-start");
      resultMessage.classList.remove("component-result-message-start");
      resultMessage.classList.add("component-result-message-stop");
      console.log("PARENT", opts.parent);
      if (scope.fromView == 'view-add-card')
        opts.parent.cardAddCheck();
    };

    var okButtonStartX, okButtonEndX, okButtonStartY, okButtonEndY;

    closeResultFormStart = function (id) {
      event.preventDefault();
      event.stopPropagation();

      okButtonStartX = event.changedTouches[0].pageX;
      okButtonStartY = event.changedTouches[0].pageY;

      document.getElementById(id).style.webkitTransform = 'scale(0.8)'
    };

    closeResultFormEnd = function (id) {
      event.preventDefault();
      event.stopPropagation();

      document.getElementById(id).style.webkitTransform = 'scale(1)'

      okButtonEndX = event.changedTouches[0].pageX;
      okButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(okButtonStartX - okButtonEndX) <= 20 && Math.abs(okButtonStartY - okButtonEndY) <= 20
        && resultButtonId.classList.contains("component-result-button-start")) {

        if (scope.restart) {

          restartComponent();
        } else {

          console.log("OPTS in RESULT COMPONENT", opts);
          window.common.alert.hide("componentResultId");


//          if (opts.viewpage) {
//            console.log("Alert to ", opts.viewpage);
//            riotTags.innerHTML = "<" + opts.viewpage + ">";
//            riot.mount(opts.viewpage);
//            this.parent.unmount();
//            this.unmount();
//
//          }


          window.common.alert.hide("componentResultId");


          if (opts.step_amount) {
            history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - opts.step_amount)
            console.log(history.arrayOfHistory)
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

            console.log("after success", history.arrayOfHistory)

            if (history.arrayOfHistory.length != 0) {
              console.log('opts', history.arrayOfHistory[history.arrayOfHistory.length - 1].params)
              riotTags.innerHTML = "<" + history.arrayOfHistory[history.arrayOfHistory.length - 1].view + ">";
              riot.mount(history.arrayOfHistory[history.arrayOfHistory.length - 1].view, history.arrayOfHistory[history.arrayOfHistory.length - 1].params);
              return;
            } else {
              console.log("unsuccess mounting main-page");
              riotTags.innerHTML = "<view-main-page>";
              riot.mount("view-main-page");
            }
          } else if (!opts.step_amount && opts.viewpage) {
            riotTags.innerHTML = "<" + opts.viewpage + ">";
            riot.mount(opts.viewpage);
            opts.parent.unmount();
            scope.unmount();
          }
        }
      }
    };


  </script>
</component-result>