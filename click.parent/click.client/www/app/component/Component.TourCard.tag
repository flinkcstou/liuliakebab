<component-tour-card id="componentTourCardId" class="component-tour">
  <div type="button" class="tour-close-button" ontouchend="closeTour()"></div>
  <p class="tour-message">{opts.operationmessage}</p>
  <div class="tour-icon"></div>

  <button class="tour-next-button-inner-container" ontouchend="closeTourForm()">
    {window.languages.ComponentSuccessNext}
  </button>

  <script>
    var scope = this;

    closeTour = function () {
      event.preventDefault();
      event.stopPropagation();
      componentTourId.style.display = 'none';
//      console.log("before", history.arrayOfHistory)
//      history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - opts.step_amount)
//      console.log(history.arrayOfHistory)
//      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
//
//      if (opts.goback) {
//        console.log('opts', history.arrayOfHistory[history.arrayOfHistory.length - 1].params)
//        riotTags.innerHTML = "<" + opts.viewpage + ">";
//        riot.mount(opts.viewpage, history.arrayOfHistory[history.arrayOfHistory.length - 1].params);
//        return;
//      }
//
//      console.log('viewpage', opts.viewpage)
//
//      if (opts.viewpage) {
//
//        riotTags.innerHTML = "<" + opts.viewpage + ">";
//        riot.mount(opts.viewpage);
////        scope.unmount()
//      }
//
//
//      if (opts.close_action) {
//        opts.close_action();
//      }
    }

  </script>
</component-tour-card>

