<component-in-processing id="componentInProcessingId" class="component-in-processing">
  <p class="in-processing-operation-success-message-part-one">{opts.operationmessagepartone}</p>
  <p class="in-processing-operation-success-message-part-two">{opts.operationmessageparttwo}</p>
  <div class="in-processing-success-icon"></div>

  <button class="in-processing-next-button-inner-container" ontouchend="closeInProcessingMessageForm()">
    {window.languages.ComponentSuccessNext}
  </button>

  <script>
    var scope = this;

    closeInProcessingMessageForm = function () {
      event.preventDefault();
      event.stopPropagation();
      componentInProcessingId.style.display = 'none';
      console.log("before inProcessing", history.arrayOfHistory)

      if (opts.step_amount) {
        history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - opts.step_amount)
        console.log(history.arrayOfHistory)
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
      } else {
        history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - 3)
        console.log(history.arrayOfHistory)
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
      }

      console.log("after inProcessing", history.arrayOfHistory)

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

//
//
//      console.log('viewpage', opts.viewpage)
//
//
//      if (opts.viewpage) {
//        riotTags.innerHTML = "<" + opts.viewpage + ">";
//        riot.mount(opts.viewpage);
////      scope.unmount()
//      }
    }
  </script>
</component-in-processing>