<component-transfer-to-card>
  <p class="transfer-new-card-text-field">{window.languages.ViewPayTransferNewCardTextField}</p>
  <div id="cardContainer" class="transfer-new-card-container">
    <img id="cardDesignId" class="transfer-new-card-design">
    <div id="cardInputFieldsId" class="transfer-new-card-input-fields">
      <div id="bankIconId" class="transfer-new-card-bankIcon" style="background-image: url({bankImage});"></div>
      <div id="processingIconId" class="transfer-new-card-processingIcon"
           style="background-image: url({processingImage});"></div>
      <div id="cardInputContainer"
           class="transfer-new-card-number-input-container"
           ontouchstart="cardNumberFormTouchStart()"
           ontouchend="cardNumberFormTouchEnd()">
        <input id="cardInputId"
               class="transfer-new-card-number-input"
               type="tel"
               value="8600 "
               onpaste="onPasteTriggerCard()"
               oninput="cardBlurAndChange()"
               onchange="cardBlurAndChange()"
               onkeydown="cardOnKeyDown(this)"
               onkeyup="searchCard()"
               onfocus="cardFocus(event)"
               onblur="cardBlur()"/>
      </div>
      <div class="transfer-new-card-number-input-container-bottom-shadow"></div>

      <div id="cardSuggestions" class="transfer-new-card-suggestions-container">
        <div each="{i in cardSuggestionsArray}"
             class="transfer-new-card-found-container"
             ontouchstart="cardSuggestionTouchStart()"
             ontouchend="cardSuggestionTouchEnd({i.id})">
          <div class="transfer-card-found-photo" style="background-image: url({i.image})"></div>
          <div class="transfer-contact-found-text-container-for-card">
            {i.name}
          </div>
          <div class="transfer-new-card-found-text-two">{i.cardNumber.substring(0,4)} **** ****
            {i.cardNumber.substring(i.cardNumber.length-4,i.cardNumber.length)}
          </div>
        </div>
      </div>
      <div id="cardOwnerId" class="transfer-new-card-owner-container" hidden>
        <p class="transfer-new-card-owner-title">{window.languages.ViewPayTransferNewCardOwnerTitle}</p>
        <p class="transfer-new-card-owner-info">{cardOwner}</p>
      </div>
    </div>
  </div>
  <button if="{showBottomButton}"
          id="bottomButtonCardId"
          style="bottom: {window.bottomButtonBottom}"
          class="bottom-button-container"
          ontouchstart="onTouchStartOfNextCard(this)"
          ontouchend="onTouchEndOfNextCard(this)">
    {window.languages.ViewPayTransferNewContinue}
  </button>
  <script>

    var scope = this;
    var onPasteCard = false;
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
    var cardStopChanging = false;
    scope.cardSuggestionsArray = [];
    scope.bankImage = '';
    scope.processingImage = '';
    scope.searchCardNumber = '';
    scope.showBottomButton = false;
    scope.cardOwner = '';
    scope.cardsarray = {};
    scope.cardNumberFromMain = 1;
    scope.idCardFromMyCards = -1;
    scope.cardCounter = 1;
    scope.processingPrefix = '';
    scope.minLimit = 5000;
    scope.maxLimit = 15000000;
    scope.taxPercent = 1;
    scope.bankIdentified = false;
    scope.issuerList = [];
    scope.p2pStatusOfBank = false;
    scope.nameOfBank = '';
    scope.local_card_background_dir = 'resources/icons/cards/';

    scope.on('mount', function () {
      if (opts && JSON.stringify(opts) !== '{}') {
        if (opts.cardsarray) {
          scope.cardsarray = opts.cardsarray;
        }
      }
      if (opts.idcardfrommycards !== -1) {
        scope.idCardFromMyCards = opts.idcardfrommycards;
        scope.countCard = scope.cardsarray[scope.idCardFromMyCards].countCard;
      }
      if (opts.cardcounter) {
        scope.cardCounter = opts.cardcounter;
      }
      scope.update();
    });

    cardNumberFormTouchStart = function () {
      scope.parent.transitionRunning = true;
    };

    cardNumberFormTouchEnd = function () {
      event.stopPropagation();
      scope.parent.transitionRunning = false;
    };


    //Card number input handler
    cardBlurAndChange = function () {
      event.preventDefault();
      event.stopPropagation();

      if (onPasteCard) {
        cardWithoutSpace = inputVerification.spaceDeleter(event.target.value);
        cardInputId.value = inputVerification.cardVerification(cardWithoutSpace);
        onPasteCard = false;
      }

      checkForIcons();
      checkCardNumberLength();
      scope.update();
    };

    //SearchCard owner
    cardOnKeyDown = function (input) {
      cardStopChanging = input.value.length >= 19 && event.keyCode !== input_codes.BACKSPACE_CODE
        && event.keyCode !== input_codes.NEXT
        && event.keyCode !== input_codes.ENTER;
    };

    cardFocus = function (event) {
      var temp_value = event.target.value;
      event.target.value = '';
      event.target.value = temp_value;
      betweenAmountId.readOnly = true;
      contactPhoneNumberId.readOnly = true;
    };

    cardBlur = function () {
      betweenAmountId.readOnly = false;
      contactPhoneNumberId.readOnly = false;
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
      if (event.keyCode === input_codes.ENTER) {
        if (device.platform !== 'BrowserStand')
          cordova.plugins.Keyboard.close();
      }
    };

    cardOwnerFunction = function () {
      if (JSON.parse(localStorage.getItem('click_client_loginInfo')))
        sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      phoneNumber = localStorage.getItem('click_client_phoneNumber');
      if (modeOfApp.onlineMode) {
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
                console.error(error)
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
      }
    };

    checkForIcons = function () {
      //Check for bank icon
      if (JSON.parse(localStorage.getItem('click_client_issuer_list'))) {
        if (scope.issuerList !== JSON.parse(localStorage.getItem('click_client_issuer_list')))
          scope.issuerList = JSON.parse(localStorage.getItem('click_client_issuer_list'));

        var currentIssuer = {};

        processingIconFound = false;
        bankIconFound = false;
        scope.bankIdentified = false;
        scope.p2pStatusOfBank = false;
        scope.issuerList.forEach(function (issuer) {
          processingIdInInput = cardInputId.value.replace(/\s/g, '').substring(0, parseInt(issuer.prefix_length));
          if (issuer.prefix === processingIdInInput) {
            scope.processingImage = issuer.url;
            if (device.platform == 'iOS') {
              processingIconId.style.display = 'block';
            }
            processingIconFound = true;
            currentIssuer = issuer;
            scope.procType = issuer.prefix;
          }
        });

        if (processingIconFound) {
          bankIdInInput = cardInputId.value.replace(/\s/g, '').substring(parseInt(currentIssuer.code_start) - 1,
            parseInt(currentIssuer.code_start) + parseInt(currentIssuer.code_length) - 1);
          currentIssuer.item.forEach(function (bank) {
            if (bank.code === bankIdInInput) {
              scope.bank = bank;
              scope.bankImage = bank.image;
              if (device.platform == 'iOS') {
                bankIconId.style.display = 'block';
              }
              bankIconFound = true;
              scope.minLimit = parseInt(bank.p2p_min_limit);
              scope.maxLimit = parseInt(bank.p2p_max_limit);
              scope.taxPercent = parseInt(bank.p2p_percent);
              scope.bankIdentified = true;
              scope.p2pStatusOfBank = parseInt(bank.p2p_status);
              scope.nameOfBank = bank.bank_name;

              var url_splitted = bank.card_background_url.toString().split("/");
              var background_file_name = url_splitted[url_splitted.length - 1];
              cardDesignId.src = scope.local_card_background_dir + background_file_name;

              checkImageExists(cardDesignId.src, function (exists) {
                if (exists) {

                  if (device.platform != 'iOS') {
                    if (cardDesignId.className.indexOf('transfer-new-card-design-appear') === -1) {
                      cardDesignId.classList.add('transfer-new-card-design-appear');
                      cardInputFieldsId.classList.add('transfer-new-card-input-fields-reduce');
                      if (bank.font_color) {
                        cardInputFieldsId.style.color = 'rgb(' + bank.font_color + ')';
                      }
                    }
                  }
                } else {
                  console.log('image does not exist');
                }
              });
            }
          });
        }

        if (processingIconFound === false) {
          scope.processingImage = '';
          processingIconId.style.display = 'none';
        }
        if (bankIconFound === false) {
          scope.bankImage = '';
          bankIconId.style.display = 'none';

          if (device.platform != 'iOS') {
            if (cardDesignId.className.indexOf('transfer-new-card-design-appear') !== -1) {
              cardDesignId.classList.remove('transfer-new-card-design-appear');
              cardInputFieldsId.classList.remove('transfer-new-card-input-fields-reduce');
              cardInputFieldsId.style.color = '';
            }
          }
        }
      }
    };

    checkCardNumberLength = function () {
      if (cardInputId.value.replace(/\s/g, '').length === 16) {
        scope.showBottomButton = true;
        cardInputId.blur();
        cardSuggestions.style.display = 'none';
        cardContainer.style.background = '';
        cardInputContainer.style.border = '';
//        cardInputContainer.style.top = '';
        cardOwnerFunction();
      } else {
        scope.showBottomButton = false;
        cardSuggestions.style.display = 'block';
        cardContainer.style.background = 'linear-gradient(to top, white, rgba(255, 255, 255, 0) 50%), ' +
          'url(resources/icons/ViewTransfer/transfer_card.png)';
        cardContainer.style.background += '-webkit-linear-gradient(bottom, white, rgba(255, 255, 255, 0) 50%), ' +
          'url(resources/icons/ViewTransfer/transfer_card.png)';
        cardContainer.style.backgroundSize = '102%';
        cardContainer.style.backgroundRepeat = 'no-repeat';
        cardContainer.style.backgroundPosition = 'center';
//        cardInputContainer.style.top = '' + 133 * widthK + 'px';
        cardOwnerId.style.display = 'none';
        scope.cardOwner = '';
      }
      if ((scope.cardSuggestionsArray && scope.cardSuggestionsArray < 1) || cardInputId.value.length === 0) {
        cardSuggestions.style.display = 'none';
        cardContainer.style.background = '';
        cardInputContainer.style.border = '';
//        cardInputContainer.style.top = '';
      }
      scope.parent.update();
      scope.update();
    };

    onPasteTriggerCard = function () {
      onPasteCard = true;
    };

    cardSuggestionTouchStart = function () {
      scope.parent.transitionRunning = true;
      event.preventDefault();
      event.stopPropagation();
      transferCardTouchStartX = event.changedTouches[0].pageX;
      transferCardTouchStartY = event.changedTouches[0].pageY;
    };

    cardSuggestionTouchEnd = function (suggestionCard) {
      scope.parent.transitionRunning = false;
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

    //Go to next step
    onTouchStartOfNextCard = function (button) {

      scope.parent.transitionRunning = true;
      button.style.webkitTransform = 'scale(0.7)';

      event.preventDefault();
      event.stopPropagation();

      transferCardTouchStartX = event.changedTouches[0].pageX;
      transferCardTouchStartY = event.changedTouches[0].pageY;
    };
    onTouchEndOfNextCard = function (button) {

      scope.parent.transitionRunning = false;
      button.style.webkitTransform = 'scale(1)';

      event.preventDefault();
      event.stopPropagation();

      transferCardTouchEndX = event.changedTouches[0].pageX;
      transferCardTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(transferCardTouchStartX - transferCardTouchEndX) <= 20
        && Math.abs(transferCardTouchStartY - transferCardTouchEndY) <= 20) {
        if (scope.issuerList.length === 0 && !modeOfApp.demoVersion && !modeOfApp.offlineMode) {
          cardInputId.blur();
          scope.errorNote = 'Подождите, данные для обработки информации еще не прогрузились';

          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote,
            pathtosettings: scope.pathToSettings,
            permissionerror: scope.permissionError,
          });
          scope.update();
          return;
        }
        if (scope.p2pStatusOfBank === 0) {
          cardInputId.blur();
          scope.errorNote = 'Карта "' + scope.nameOfBank + '" банка временно недоступна для перевода средств';
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote,
            pathtosettings: scope.pathToSettings,
            permissionerror: scope.permissionError,
          });
          scope.update();
          return;
        }
        checkForIcons();
        params = {
          transferType: 'card',
          cardNumber: cardInputId.value,
          cardOwner: scope.cardOwner,
          taxPercent: scope.taxPercent,
          minLimit: scope.minLimit,
          maxLimit: scope.maxLimit,
          cardsarray: scope.cardsarray,
          cardcounter: scope.cardCounter,
          idcardfrommycards: scope.idCardFromMyCards,
          receiverbank: scope.bank,
          proctype: scope.procType,
        };
        riotTags.innerHTML = "<view-transfer-submit>";
        riot.mount('view-transfer-submit', params);
      }
    };

    checkImageExists = function (url, callback) {
      var img = new Image();
      img.onload = function () {
        callback(true);
      };
      img.onerror = function () {
        callback(false);
      };
      img.src = url;
    };

  </script>
</component-transfer-to-card>