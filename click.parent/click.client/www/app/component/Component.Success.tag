<component-success id="componentSuccessId" class="component-success">
  <p class="success-operation-success-message">{opts.operationmessage}</p>
  <div class="success-success-icon"></div>

  <button class="success-next-button-inner-container" ontouchend="closeSuccessMessageForm()">
    {window.languages.ComponentSuccessNext}
  </button>

  <script>
    var scope = this;

    closeSuccessMessageForm = function () {
      event.preventDefault();
      event.stopPropagation();
      componentSuccessId.style.display = 'none';
      console.log("before success", history.arrayOfHistory)
      if (opts.step_amount) {
        history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - opts.step_amount)
        console.log(history.arrayOfHistory)
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
      }

      if (opts.goback) {
        console.log('opts', history.arrayOfHistory[history.arrayOfHistory.length - 1].params)
        riotTags.innerHTML = "<" + opts.viewpage + ">";
        riot.mount(opts.viewpage, history.arrayOfHistory[history.arrayOfHistory.length - 1].params);
        return;
      }

      console.log('viewpage', opts.viewpage)

      if (opts.viewpage) {

        riotTags.innerHTML = "<" + opts.viewpage + ">";
        riot.mount(opts.viewpage);
//        scope.unmount()
      }


      if (opts.close_action) {
        opts.close_action();
      }
    }

  </script>
</component-success>