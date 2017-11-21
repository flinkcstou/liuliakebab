<component-transfer-to-card>
  <p class="transfer-new-card-text-field">{window.languages.ViewPayTransferNewCardTextField}</p>
  <div id="cardContainer" class="transfer-new-card-container">
    <div id="bankIconId" class="transfer-new-card-bankIcon" style="background-image: url({bankImage});"></div>
    <div id="processingIconId" class="transfer-new-card-processingIcon"
         style="background-image: url({processingImage});"></div>
    <input id="cardInputId"
           class="transfer-new-card-number-input"
           type="tel"
           onpaste="onPasteTrigger()"
           oninput="cardBlurAndChange()"
           onchange="cardBlurAndChange()"
           onkeydown="cardOnKeyDown(this)"
           onkeyup="searchCard()"/>
    <div id="cardSuggestions" class="transfer-new-card-suggestions-container">
      <div each="{i in cardSuggestionsArray}"
           class="transfer-new-card-found-container"
           ontouchstart="cardSuggestionTouchStart()"
           ontouchend="cardSuggestionTouchEnd({i.id})">
        <div class="transfer-card-found-photo" style="background-image: url({i.image})"></div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{i.name}</div>
        </div>
        <div class="transfer-new-card-found-text-two">{i.cardNumber.substring(0,4)} **** ****
          {i.cardNumber.substring(i.cardNumber.length-5,i.cardNumber.length)}
        </div>
      </div>
    </div>
    <div id="cardOwnerId" class="transfer-new-card-owner-container" hidden>
      <p class="transfer-new-card-owner-title">{window.languages.ViewPayTransferNewCardOwnerTitle}</p>
      <p class="transfer-new-card-owner-info">{cardOwner}</p>
    </div>
  </div>
  <script>

    var scope = this;
    var onPaste = false;
    var bankId = '';
    var processingId = '';
    var arrayOfCards = [];
    var transferCardTouchStartX,
      transferCardTouchStartY,
      transferCardTouchEndX,
      transferCardTouchEndY;
    var cardWithoutSpace = '';
    var sessionKey = '';
    var phoneNumber = '';
    var bankIconFound = false;
    var processingIconFound = false;
    scope.cardSuggestionsArray = [];
    scope.bankImage = '';
    scope.processingImage = '';
    scope.searchCardNumber = '';

    //Card number input handler
    cardBlurAndChange = function () {
      event.preventDefault();
      event.stopPropagation();

      if (onPaste) {
        cardWithoutSpace = inputVerification.spaceDeleter(event.target.value);
        cardInputId.value = inputVerification.cardVerification(cardWithoutSpace);
        onPaste = false;
      }

      checkForIcons();
      checkCardNumberLength();
      scope.update();
    };

    //SearchCard owner
    cardOnKeyDown = function (input) {
      cardStopChanging = input.value.length >= 19 && event.keyCode !== input_codes.BACKSPACE_CODE
        && event.keyCode !== input_codes.NEXT;
    };

    //Work with card number input: cursour, spacedeleter
    searchCard = function () {
      if (cardStopChanging) {
        cardInputId.value = event.target.value.substring(0, event.target.value.length - 1);
      }

      cardCursorPositionSelectionStart = cardInputId.selectionStart;
      cardCursorPositionSelectionEnd = cardInputId.selectionEnd;
      cardOldValueOfNumber = cardInputId.value;

      if (cardInputId.value.length <= 19
        && (event.keyCode !== input_codes.BACKSPACE_CODE && event.keyCode !== input_codes.NEXT)) {
        cardInputId.value = inputVerification.cardVerification(cardInputId.value);

        if (cardOldValueOfNumber.length !== cardInputId.value.length
          && inputVerification.spaceDeleter(cardOldValueOfNumber) === inputVerification.spaceDeleter(cardInputId.value)) {
          cardInputId.selectionStart = cardCursorPositionSelectionStart + 1;
          cardInputId.selectionEnd = cardCursorPositionSelectionEnd + 1;
        }
        else {
          cardInputId.selectionStart = cardCursorPositionSelectionStart;
          cardInputId.selectionEnd = cardCursorPositionSelectionEnd;
        }
      }

      if (JSON.parse(localStorage.getItem('p2pTransferCards'))) {
        arrayOfCards = JSON.parse(localStorage.getItem('p2pTransferCards'));
      }

      if (event.keyCode !== 16 && event.keyCode !== 18) {
        scope.searchCardNumber = event.target.value.replace(/\s/g, '');
      }

      scope.cardSuggestionsArray = [];

      arrayOfCards.forEach(function (cardInMemory) {
        var index = cardInMemory.cardNumber.replace(/\s/g, '').indexOf(scope.searchCardNumber);
        if (index !== -1 && scope.cardSuggestionsArray.length < 5) {
          var cardSuggestion = {};
          if (cardInMemory.cardNumber !== null) {
            cardSuggestion.cardNumber = cardInMemory.cardNumber;
            cardSuggestion.id = inputVerification.spaceDeleter(cardInMemory.cardNumber);
          } else {
            cardSuggestion.cardNumber = '';
            cardSuggestion.id = '';
          }
          if (cardInMemory.owner.firstName !== null) {
            cardSuggestion.name = cardInMemory.owner.firstName;
          } else {
            cardSuggestion.name = '';
          }
          if (cardInMemory.image !== null) {
            cardSuggestion.image = cardInMemory.image;
          } else {
            cardSuggestion.image = '';
          }
          scope.cardSuggestionsArray.push(cardSuggestion);
        }
      });

      event.preventDefault();
      event.stopPropagation();
      checkForIcons();
      checkCardNumberLength();
      scope.update();
    };

    cardOwnerFunction = function () {
      if (JSON.parse(localStorage.getItem('click_client_loginInfo')))
        sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      phoneNumber = localStorage.getItem('click_client_phoneNumber');
      window.api.call({
        method: 'p2p.card.info',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          card_number: cardInputId.value.replace(/\s/g, ''),
        },
        scope: this,
        onSuccess: function (result) {
          if (result[0][0].error === 0) {
            try {
              if (result[1] && result[1][0]) {
                scope.cardOwner = result[1][0].card_owner;
                if (scope.cardOwner)
                  cardOwnerId.style.display = 'block';
              }
              scope.update()
            }
            catch (error) {
              console.log(error)
            }
          }
          else {
            scope.errorNote = result[0][0].error_note;
            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: scope.clickPinError,
              errornote: scope.errorNote,
              pathtosettings: scope.pathToSettings,
              permissionerror: scope.permissionError,
            });
            scope.update();
          }
        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    };

    checkForIcons = function () {
      //Check for bank icon
      bankIdInInput = cardInputId.value.replace(/\s/g, '').substring(3, 6);
      if (bankId !== bankIdInInput) {
        bankId = bankIdInInput;
        bankIconFound = false;
        scope.parent.allBankList.forEach(function (element) {
          if (element.code === bankId) {
            scope.bankImage = element.image;
            bankIconId.style.display = 'block';
            bankIconFound = true;
          }
        });
        if (bankIconFound === false){
          bankId = '';
          scope.bankImage = '';
          bankIconId.style.display = 'none';
        }
      }
      if (cardInputId.value.replace(/\s/g, '').length < 6) {
        bankId = '';
        scope.bankImage = '';
        bankIconId.style.display = 'none';
      }

      //Check for processing icon
      processingIdInInput = cardInputId.value.replace(/\s/g, '').substring(0, 3);
      if (processingId !== processingIdInInput) {
        processingId = processingIdInInput;
        processingIconFound = false;
        /// TO DO PROCESSING ICON
        if (processingIconFound === false){
          processingId = '';
          scope.processingImage = '';
          processingIconId.style.display = 'none';
        }
      }

      if (cardInputId.value.replace(/\s/g, '').length < 3) {
        processingId = '';
        scope.processingImage = '';
        processingIconId.style.display = 'none';
      }
    };

    checkCardNumberLength = function () {
      if (cardInputId.value.replace(/\s/g, '').length === 16) {
        scope.parent.showBottomButton = true;
        cardSuggestions.style.display = 'none';
        cardOwnerFunction();
      }
      else {
        scope.parent.showBottomButton = false;
        cardSuggestions.style.display = 'block';
        cardOwnerId.style.display = 'none';
      }
      scope.parent.update();
    };

    onPasteTrigger = function () {
      onPaste = true;
    };

    cardSuggestionTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();
      transferCardTouchStartX = event.changedTouches[0].pageX;
      transferCardTouchStartY = event.changedTouches[0].pageY;
    };

    cardSuggestionTouchEnd = function (suggestionCard) {
      event.preventDefault();
      event.stopPropagation();

      transferCardTouchEndX = event.changedTouches[0].pageX;
      transferCardTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(transferCardTouchStartX - transferCardTouchEndX) <= 20
        && Math.abs(transferCardTouchStartY - transferCardTouchEndY) <= 20) {
        cardWithoutSpace = inputVerification.spaceDeleter(suggestionCard);
        cardInputId.value = inputVerification.cardVerification(cardWithoutSpace);
      }
      checkForIcons();
      checkCardNumberLength();
    };

  </script>
</component-transfer-to-card>