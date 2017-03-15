<component-unsuccess id="componentUnsuccessId" class="component-unsuccess">
  <p class="unsuccess-operation-success-message">{opts.operationmessagepartone}<br>{opts.operationmessageparttwo}</p>
  <p class="unsuccess-operation-success-message-part-three">{opts.operationmessagepartthree}</p>
  <div class="unsuccess-unsuccess-icon"></div>

  <div class="unsuccess-next-button-inner-container" ontouchend="closeUnsuccessMessageForm()">
    <p class="unsuccess-next-button-label">{window.languages.ComponentUnsuccessNext}</p>
  </div>

  <script>
    var scope = this;

    closeUnsuccessMessageForm = function () {
      console.log('OPTS', opts)
      componentUnsuccessId.style.display = 'none';
    }

  </script>
</component-unsuccess>