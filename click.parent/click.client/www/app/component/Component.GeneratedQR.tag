<component-generated-qr id="componentGeneratedQrId" class="component-generated-qr">
  <p class="generatedqr-operation-upper-info-message">{opts.qr_header}</p>
  <div class="generatedqr-image" style="background-image: url({opts.qr_image})"></div>
  <p id="qrFooterTextId" class="generatedqr-operation-info-message"></p>


  <button id="qrCloseButtonId" class="generatedqr-close-button-inner-container"
          ontouchstart="closeGeneratedQrFormStart()"
          ontouchend="closeGeneratedQrFormEnd()">
    {window.languages.ComponentSuccessNext}
  </button>

  <script>
    var scope = this;

    var closeButtonStartX, closeButtonEndX, closeButtonStartY, closeButtonEndY;


    closeGeneratedQrFormStart = function () {
      event.preventDefault();
      event.stopPropagation();

      closeButtonStartX = event.changedTouches[0].pageX;
      closeButtonStartY = event.changedTouches[0].pageY;

      qrCloseButtonId.style.webkitTransform = 'scale(0.8)'
    }

    closeGeneratedQrFormEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      closeButtonEndX = event.changedTouches[0].pageX;
      closeButtonEndY = event.changedTouches[0].pageY;

      qrCloseButtonId.style.webkitTransform = 'scale(1)'

      if (Math.abs(closeButtonStartX - closeButtonEndX) <= 20 && Math.abs(closeButtonStartY - closeButtonEndY) <= 20) {

        componentGeneratedQrId.style.display = 'none';
        console.log("before success", history.arrayOfHistory)
        console.log("OPTS in qr comp", opts)
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
        }


//      if (opts.goback && opts.viewpage) {
//        console.log('opts', history.arrayOfHistory[history.arrayOfHistory.length - 1].params)
//        riotTags.innerHTML = "<" + opts.viewpage + ">";
//        riot.mount(opts.viewpage, history.arrayOfHistory[history.arrayOfHistory.length - 1].params);
//        return;
//      }

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
    }

  </script>
</component-generated-qr>