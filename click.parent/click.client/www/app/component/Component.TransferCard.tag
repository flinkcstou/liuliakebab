<component-transfer-card>
  <p class="transfer-new-card-text-field">{window.languages.ViewPayTransferNewCardTextField}</p>
  <div id="cardContainer" class="transfer-new-card-container">
    <div id="bankIcon" class="transfer-new-card-bankIcon"></div>
    <div id="processingIcon" class="transfer-new-card-processingIcon"></div>
    <input id="cardInput"
           class="transfer-new-card-number-input"
           type="tel"
           onpaste="onPasteTrigger()"
           oninput="cardBlurAndChange()"
           onchange="cardBlurAndChange()"
           onfocus="cardBlurAndChange()"
           onkeydown="searchCard(this)"
           onkeyup="cardOnKeyUp()"/>
    <div id="cardOwner" class="transfer-new-card-owner-container" hidden>
      <p class="transfer-new-card-owner-title">{window.languages.ViewPayTransferNewCardOwnerTitle}</p>
      <p class="transfer-new-card-owner-info">{cardOwner}</p>
    </div>
  </div>
  <script>

    var scope = this;
    var onPaste = false;

    //Card number input handler
    cardBlurAndChange = function () {
      event.preventDefault();
      event.stopPropagation();

      if (onPaste) {
        var cardWithouSpace = inputVerification.spaceDeleter(event.target.value);
        cardInput.value = inputVerification.cardVerification(cardWithouSpace);
        onPaste = false;
      }

      if (cardInput.value.replace(/\s/g, '').length === 16) {
        cardOwnerFunction();
        bottomButtonId.style.display = 'block';
      }
      else
        bottomButtonId.style.display = 'none';
      scope.update();
    };

    onPasteTrigger = function () {
      onPaste = true;
    };

  </script>
</component-transfer-card>