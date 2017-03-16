<component-in-processing id="componentInProcessingId" class="component-in-processing">
  <p class="in-processing-operation-success-message-part-one">{opts.operationmessagepartone}</p>
  <p class="in-processing-operation-success-message-part-two">{opts.operationmessageparttwo}</p>
  <div class="in-processing-success-icon"></div>

  <div class="in-processing-next-button-inner-container" ontouchend="closeSuccessMessageForm()">
    <p class="in-processing-next-button-label">{window.languages.ComponentSuccessNext}</p>
  </div>

  <script>
    var scope = this;

    closeSuccessMessageForm = function () {
      event.preventDefault();
      event.stopPropagation();
      componentInProcessingId.style.display = 'none';
      history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - 3)
      console.log(history.arrayOfHistory)
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

      console.log('viewpage', opts.viewpage)


      riotTags.innerHTML = "<" + opts.viewpage + ">";
      riot.mount(opts.viewpage);
    }
  </script>
</component-in-processing>