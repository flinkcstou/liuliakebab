<component-unsuccess id="componentUnsuccessId" class="component-unsuccess">
  <p class="unsuccess-operation-success-message">{opts.operationmessagepartone}<br>{opts.operationmessageparttwo}</p>
  <p class="unsuccess-operation-success-message-part-three">{opts.operationmessagepartthree}</p>
  <div class="unsuccess-unsuccess-icon"></div>

  <button class="unsuccess-next-button-inner-container" ontouchend="closeUnsuccessMessageForm()">
    {window.languages.ComponentUnsuccessNext}
  </button>

  <script>
    var scope = this;

    closeUnsuccessMessageForm = function () {
      console.log('OPTS', opts)
      componentUnsuccessId.style.display = 'none';
      console.log("before", history.arrayOfHistory)
      history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - opts.step_amount)
      console.log(history.arrayOfHistory)
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

      if (opts.viewpage) {

        riotTags.innerHTML = "<" + opts.viewpage + ">";
        riot.mount(opts.viewpage);
//        scope.unmount()
      }
    }

  </script>
</component-unsuccess>