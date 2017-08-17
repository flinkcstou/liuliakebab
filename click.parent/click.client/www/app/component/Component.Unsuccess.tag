<component-unsuccess id="componentUnsuccessId" class="component-unsuccess">
  <p class="unsuccess-operation-success-message">{opts.operationmessagepartone}<br>{opts.operationmessageparttwo}</p>
  <p class="unsuccess-operation-success-message-part-three">{(opts.operationmessagepartthree)
    ? opts.operationmessagepartthree :window.languages.tempText}</p>
  <div class="unsuccess-unsuccess-icon"></div>

  <button id="unsuccessButtonId" class="unsuccess-next-button-inner-container"
          ontouchstart="closeUnsuccessMessageFormStart()" ontouchend="closeUnsuccessMessageFormEnd()">
    {window.languages.ComponentUnsuccessNext}
  </button>

  <script>
    var scope = this;

    scope.errorMessage = '';

    var closeButtonStartX, closeButtonEndX, closeButtonStartY, closeButtonEndY;

    closeUnsuccessMessageFormStart = function () {
      closeButtonStartX = event.changedTouches[0].pageX;
      closeButtonStartY = event.changedTouches[0].pageY;

      unsuccessButtonId.style.webkitTransform = 'scale(0.8)'
    }

    closeUnsuccessMessageFormEnd = function () {

      closeButtonEndX = event.changedTouches[0].pageX;
      closeButtonEndY = event.changedTouches[0].pageY;

      unsuccessButtonId.style.webkitTransform = 'scale(1)'

      if (Math.abs(closeButtonStartX - closeButtonEndX) <= 20 && Math.abs(closeButtonStartY - closeButtonEndY) <= 20) {
        console.log('OPTS', opts)
        console.log('errorMessage', scope.errorMessage)
        componentUnsuccessId.style.display = 'none';
        console.log("before unsuccess", history.arrayOfHistory)
        if (opts.step_amount) {
          history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - opts.step_amount)
          console.log(history.arrayOfHistory)
          sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

          console.log("after unsuccess", history.arrayOfHistory)

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
        }

      }
    }

  </script>
</component-unsuccess>