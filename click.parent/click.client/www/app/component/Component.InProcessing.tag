<component-in-processing id="componentInProcessingId" class="component-in-processing">
  <div class="in-processing-success-icon"></div>
  <p class="in-processing-operation-success-message-part-one">{opts.operationmessagepartone}</p>
  <p class="{in-processing-operation-success-message-part-two-for-transfer: forTransfer,
   in-processing-operation-success-message-part-two: !forTransfer}">{opts.operationmessageparttwo}</p>


  <button class="in-processing-next-button-inner-container" ontouchend="closeInProcessingMessageForm()">
    {window.languages.ComponentSuccessNext}
  </button>

  <script>
    var scope = this;
    scope.forTransfer = false;
    if (!opts.operationmessageparttwo.localeCompare(window.languages.ComponentInProcessingPartTwoForTransfer)) {
      scope.forTransfer = true;
      console.log(opts.operationmessageparttwo);
      console.log(window.languages.ComponentInProcessingPartTwoForTransfer);
      scope.update();
    }

    closeInProcessingMessageForm = function () {
      event.preventDefault();
      event.stopPropagation();
      window.common.alert.hide("componentInProcessingId");
      console.log("before inProcessing", history.arrayOfHistory)

      if (opts.step_amount) {
        history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - opts.step_amount)
        console.log(history.arrayOfHistory)
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

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
      } else if (!opts.step_amount && opts.viewpage) {
        console.log('opts.viewpage', opts.viewpage)
        riotTags.innerHTML = "<" + opts.viewpage + ">";
        riot.mount(opts.viewpage);
      }

    }
  </script>
</component-in-processing>