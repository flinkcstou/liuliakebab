<component-pin-reset id="componentPinResetId" class="component-pinreset">
  <p class="component-pinreset-message">{window.languages.ComponentPinResetTextOne}</p>
  <p class="component-pinreset-message">--------------------------</p>
  <p class="component-pinreset-message">{window.languages.ComponentPinResetTextTwo}</p>


  <div class="component-pinreset-buttons-container" ontouchend="closeSuccessMessageForm()">
    <div class="component-pinreset-yes-button">
      <p class="component-pinreset-yes-button-label">{window.languages.ComponentPinResetYesButtonLabel}</p>
    </div>
    <div class="component-pinreset-no-button">
      <p class="component-pinreset-no-button-label">{window.languages.ComponentPinResetNoButtonLabel}</p>
    </div>

  </div>

  <script>
    var scope = this;

    closeSuccessMessageForm = function () {
      event.preventDefault();
      event.stopPropagation();
      componentPinResetId.style.display = 'none';
      history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - 3)
      console.log(history.arrayOfHistory)
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

      console.log('viewpage', opts.viewpage)


      riotTags.innerHTML = "<" + opts.viewpage + ">";
      riot.mount(opts.viewpage);
    }
  </script>
</component-pin-reset>