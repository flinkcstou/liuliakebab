<component-unsuccess id="componentUnsuccessId" class="component-unsuccess">
  <p class="unsuccess-operation-success-message">{opts.operationmessagepartone}<br>{opts.operationmessageparttwo}</p>
  <p class="unsuccess-operation-success-message-part-three">{opts.operationmessagepartthree}</p>
  <div class="unsuccess-unsuccess-icon"></div>

  <button class="unsuccess-next-button-inner-container" ontouchstart="closeUnsuccessMessageFormStart()" ontouchend="closeUnsuccessMessageFormEnd()">
    {window.languages.ComponentUnsuccessNext}
  </button>

  <script>
    var scope = this;

    closeUnsuccessMessageFormStart = function () {

    }

    closeUnsuccessMessageFormEnd = function () {
      console.log('OPTS', opts)
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

  </script>
</component-unsuccess>