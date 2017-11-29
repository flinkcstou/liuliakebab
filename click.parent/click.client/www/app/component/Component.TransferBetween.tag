<component-transfer-between>
  <div class="transfer-new-between-amount-field">
    <p class="transfer-new-between-text-field">{window.languages.ViewTransferDetailTitleSum}</p>
    <input id="betweenAmountId"
           class="transfer-new-between-amount-input"
           type="tel"
           pattern="\d*"
           maxlength="14"
           onfocus="amountFocus()"
           onmouseup="amountMouseUp()"
           onblur="amountOnBlur()"
           onkeyup="amountKeyUp()"
           oninput="amountKeyUp()">>
    <p if="{showPlaceHolderError && maxLimit && minLimit}"
       id="placeHolderSumId"
       style="color: red;"
       class="transfer-new-between-input-commission">
      {placeHolderText}
    </p>
    <p if="{!showPlaceHolderError && !modeOfApp.offlineMode && showCommission}" class="transfer-new-between-input-commission">
      {window.languages.ViewTransferTwoTax} {tax}
      {window.languages.Currency}</p>
  </div>

  <div id="cardFromId"
       class="transfer-new-card-from"
       ontouchstart="blurInput()">
    <p class="transfer-new-between-from-text-field">{window.languages.ViewPayTransferBetweenCardsFrom}</p>
    <component-transfer-card-carousel-top
      carouselid="1"
      usefor="p2p"
      style="position: relative;
      top:{11 * heightK}px">
    </component-transfer-card-carousel-top>
  </div>

  <div class="transfer-new-between-cards-arrow">
  </div>

  <div id="cardToId"
       class="transfer-new-card-to"
       ontouchstart="blurInput()">
    <p class="transfer-new-between-from-text-field">{window.languages.ViewPayTransferBetweenCardsTo}</p>
    <component-transfer-card-carousel-bottom
      carouselid="2"
      cardnumber="2"
      usefor="p2p"
      style="position: relative;
      top:{11 * heightK}px">
    </component-transfer-card-carousel-bottom>
  </div>
  <button if="{showBottomButton}"
          id="bottomButtonId"
          class="transfer-new-submit-button-container"
          style="bottom: {window.bottomButtonBottom};"
          ontouchstart="onTouchStartOfSubmit()"
          ontouchend="onTouchEndOfSubmit()">
    <div id="bottomButtonIcon"
         class="transfer-new-submit-button-icon">
    </div>
    <p class="transfer-new-submit-button-text">
      {window.languages.ViewPayTransferNewSubmitTransfer}
    </p>
  </button>
  <script>
    var scope = this;
    var transferBetweenTouchStartX,
      transferBetweenTouchStartY,
      transferBetweenTouchEndX,
      transferBetweenTouchEndY;
    scope.clickPinError = false;
    scope.showComponent = false;
    scope.cardNumberTop = 0;
    scope.cardNumberBottom = 0;
    scope.chosenCard;
    scope.maxLimit = 99999999999;
    scope.minLimit = 5000;
    scope.stepAmount = 3;
    scope.tax = 0;
    scope.taxPercent = 0;
    scope.sumForTransfer = 0;
    scope.maskOne = /[0-9]/g;
    scope.maskTwo = /[0-9' ']/g;
    scope.showBottomButton = false;
    scope.statusOfBankToP2PTop = false;
    scope.statusOfBankToP2PBottom = false;
    scope.showPlaceHolderError = false;
    scope.showCommission = false;
    var counter = 0;

    if (localStorage.getItem('click_client_cards')) {
      scope.cardsarray = JSON.parse(localStorage.getItem('click_client_cards'));
    }

    amountMouseUp = function () {
      event.preventDefault()
      event.stopPropagation()
      if (betweenAmountId.value.match(scope.maskOne) !== null
        && betweenAmountId.value.match(scope.maskOne).length !== null) {
        betweenAmountId.selectionStart = betweenAmountId.value.match(scope.maskTwo).length;
        betweenAmountId.selectionEnd = betweenAmountId.value.match(scope.maskTwo).length;
      } else {
        betweenAmountId.selectionStart = 0;
        betweenAmountId.selectionEnd = 0;
      }
    };

    amountOnBlur = function () {
      event.preventDefault();
      event.stopPropagation();

      if (betweenAmountId.value.length === 0) {
        betweenAmountId.value = 0;
      }
    };

    amountFocus = function () {
      event.preventDefault();
      event.stopPropagation();
      if (betweenAmountId.value.length === 1 && betweenAmountId.value[0] === '0') {
        betweenAmountId.value = '';
      }
    };

    amountKeyUp = function () {
      if (betweenAmountId.value.length === 1) {
        betweenAmountId.value = window.amountTransform(betweenAmountId.value.toString());
      }

      if (event.keyCode === 8) {
        scope.sumForTransfer = scope.sumForTransfer.substring(0, scope.sumForTransfer.length - 1);
      }

      if (betweenAmountId.value.match(scope.maskTwo) !== null && betweenAmountId.value.match(scope.maskTwo).length !== null) {

        betweenAmountId.value = betweenAmountId.value.substring(0, event.target.value.match(scope.maskTwo).length);
        betweenAmountId.selectionStart = betweenAmountId.value.match(scope.maskTwo).length;
        betweenAmountId.selectionEnd = betweenAmountId.value.match(scope.maskTwo).length;

        scope.sumForTransfer = betweenAmountId.value.substring(0, betweenAmountId.value.match(scope.maskTwo).length);
        scope.sumForTransfer = scope.sumForTransfer.replace(new RegExp(' ', 'g'), '');

        betweenAmountId.value = window.amountTransform(scope.sumForTransfer.toString());
        betweenAmountId.selectionStart = betweenAmountId.value.match(scope.maskTwo).length;
        betweenAmountId.selectionEnd = betweenAmountId.value.match(scope.maskTwo).length;

      } else {
        betweenAmountId.selectionStart = 0;
        betweenAmountId.selectionEnd = 0;
      }

      if (scope.sumForTransfer) {
        scope.tax = scope.sumForTransfer * scope.taxPercent / 100;
        scope.showCommission = true;
      }
      else {
        scope.tax = 0
      }

      scope.showPlaceHolderError = false;
      scope.showBottomButton = true;

      if (scope.sumForTransfer > scope.maxLimit) {
        scope.placeHolderText = 'Максимальная сумма ' + window.amountTransform(scope.maxLimit);
        scope.showPlaceHolderError = true;
        scope.showBottomButton = false;
      }
      if (scope.sumForTransfer < scope.minLimit) {
        scope.placeHolderText = "Минимальная сумма " + window.amountTransform(scope.minLimit);
        scope.showPlaceHolderError = true;
        scope.showBottomButton = false;
      }
      console.log(scope);
      scope.update();
    };

    scope.cardChangedTop = cardChangedTop = function (cardNumber) {
      for (var i in scope.cardsarray) {
        if (scope.cardsarray[i].countCard === cardNumber) {
          scope.chosenCardTop = scope.cardsarray[i];

          var codeOfBankTop = scope.chosenCardTop.numberPartOne.substring(3, 4) + scope.chosenCardTop.numberMiddleTwo;
          for (var i = 0; i < scope.parent.allBankList.length; i++) {
            if (codeOfBankTop === scope.parent.allBankList[i].code) {
              if (scope.parent.allBankList[i].p2p_status === 1) {
                scope.statusOfBankToP2PTop = true;
              }
              scope.nameOfBankTop = scope.parent.allBankList[i].bank_name;
              break;
            }
          }
          if (scope.sumForTransfer)
            scope.tax = scope.sumForTransfer * scope.taxPercent / 100;
          else {
            scope.tax = 0
          }
        }
      }
      scope.update();
    };

    scope.cardChangedBottom = cardChangedBottom = function (cardNumber) {
      for (var i in scope.cardsarray) {
        if (scope.cardsarray[i].countCard === cardNumber) {
          scope.chosenCardBottom = scope.cardsarray[i];

          var codeOfBankBottom = scope.chosenCardBottom.numberPartOne.substring(3, 4) + scope.chosenCardBottom.numberMiddleTwo;
          for (var i = 0; i < scope.parent.allBankList.length; i++) {
            if (codeOfBankBottom === scope.parent.allBankList[i].code) {
              if (scope.parent.allBankList[i].p2p_status === 1) {
                scope.statusOfBankToP2PBottom = true;
              }
              scope.minLimit = scope.parent.allBankList[i].p2p_min_limit;
              scope.maxLimit = scope.parent.allBankList[i].p2p_max_limit;
              scope.taxPercent = scope.parent.allBankList[i].p2p_percent;
              scope.nameOfBankBottom = scope.parent.allBankList[i].bank_name;
              break;
            }
          }

          if (scope.sumForTransfer) {
            scope.showBottomButton = true;
            scope.tax = scope.sumForTransfer * scope.taxPercent / 100;
            if (scope.sumForTransfer > scope.maxLimit) {
              scope.placeHolderText = 'Максимальная сумма ' + window.amountTransform(scope.maxLimit);
              scope.showPlaceHolderError = true;
              scope.showBottomButton = false;
            }
            if (scope.sumForTransfer < scope.minLimit) {
              scope.placeHolderText = "Минимальная сумма " + window.amountTransform(scope.minLimit);
              scope.showPlaceHolderError = true;
              scope.showBottomButton = false;
            }
          }
          else {
            scope.tax = 0
          }
        }
      }
      scope.update();
    };

    blurInput = function () {
      betweenAmountId.blur();
    };

    onTouchStartOfSubmit = function () {

      bottomButtonId.style.webkitTransform = 'scale(0.7)';

      event.preventDefault();
      event.stopPropagation();

      transferBetweenTouchStartX = event.changedTouches[0].pageX;
      transferBetweenTouchStartY = event.changedTouches[0].pageY;
    };

    onTouchEndOfSubmit = function () {

      bottomButtonId.style.webkitTransform = 'scale(1)';

      event.preventDefault();
      event.stopPropagation();

      transferBetweenTouchEndX = event.changedTouches[0].pageX;
      transferBetweenTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(transferBetweenTouchStartX - transferBetweenTouchEndX) <= 20
        && Math.abs(transferBetweenTouchStartY - transferBetweenTouchEndY) <= 20) {
        betweenAmountId.blur();
        if (modeOfApp.demoVersion) {
          scope.errorNote = 'Внимание! Для совершения данного действия необходимо авторизоваться!';
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errorcode: scope.errorCode,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote,
          });
          scope.update();
          return;
        }
        if (scope.chosenCardTop && parseInt(scope.chosenCardTop.salaryOriginal) < (parseInt(scope.sumForTransfer) + scope.tax)) {
          scope.clickPinError = false;
          scope.errorNote = "На выбранной карте недостаточно средств";
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote
          });
          scope.update();
          return;
        }
        if (!scope.statusOfBankToP2PTop) {
          scope.errorNote = 'Карта "' + scope.nameOfBankTop + '" банка временно недоступна для перевода средств';
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
        if (!scope.statusOfBankToP2PBottom) {
          scope.errorNote = 'Карта "' + scope.nameOfBankBottom + '" банка временно недоступна для перевода средств';
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
        transferBetween();
      }
    };

    transferBetween  = function () {

      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      scope.transactionId = parseInt(Date.now() / 1000);

      initResultComponent();
      window.api.call({
        method: 'p2p.account',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          account_id_from: scope.chosenCardTop.card_id,
          account_id_to: scope.chosenCardBottom.card_id,
          amount: parseInt(scope.sumForTransfer),
          transaction_id: scope.transactionId
        },
        scope: this,
        onSuccess: function (result) {
          if (result[0][0].error === 0) {
            if (result[1])
              if (result[1][0]) {
                answerFromServer = true;
                setTimeout(function () {
                  checkTransferStatus(result[1][0].payment_id);
                }, 2000);
              }
          }
          else {
            updateResultComponent(true, null, pageToReturnIfError, 'unsuccess', result[0][0].error_note)
          }
        },

        onFail: function (api_status, api_status_message, data) {
          updateResultComponent(true, null, pageToReturnIfError, 'unsuccess', api_status_message);
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

      setTimeout(function () {
        if (!answerFromServer) {
          updateResultComponent(true, null, pageToReturnIfError, 'waiting', window.languages.WaitingTimeExpiredText);
          return;
        }
      }, 30000)
    };

    checkTransferStatus = function (payment_id) {
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      window.api.call({
        method: 'get.payment',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          payment_id: payment_id
        },
        scope: this,
        onSuccess: function (result) {
          if (result[0][0].error === 0 && result[1][0]) {
            if (result[1][0].state === -1) {
              answerFromServer = true;

              window.languages.tempText = JSON.stringify(result[1][0].error);
              scope.errorMessageFromTransfer = result[1][0].error;
              updateResultComponent(true, scope.stepAmount, null, 'unsuccess', result[1][0].error);
            } else if (result[1][0].state === 2) {
              answerFromServer = true;
              window.updateBalanceGlobalFunction();
              updateResultComponent(true, scope.stepAmount, null, 'success', window.languages.ComponentSuccessMessage);
            } else if (result[1][0].state === 1) {
              counter++;

              if (counter < 5) {
                setTimeout(function () {
                  checkTransferStatus(result[1][0].payment_id);
                }, 2000);
              } else {
                answerFromServer = true;
                updateResultComponent(true, scope.stepAmount, null, 'waiting', window.languages.ComponentInProcessingPartOne);
              }
            }
            window.api.spinnerOn = false;
          }
          else {
            answerFromServer = true;
            updateResultComponent(true, scope.stepAmount, null, 'unsuccess', result[0][0].error);
          }
        },

        onFail: function (api_status, api_status_message, data) {
          answerFromServer = true;
          updateResultComponent(true, scope.stepAmount, null, 'unsuccess', api_status_message);
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    };

    updateResultComponent = function (showResult, stepAmount, viewPage, status, text) {
      console.log("OPEN RESULT COMPONENT");
      scope.stepAmount = stepAmount;
      scope.viewPage = viewPage;
      scope.resultText = text;

      if (showResult) {
        window.common.alert.updateView("componentResultId", {
          parent: scope,
          resulttext: scope.resultText,
          viewpage: scope.viewPage,
          step_amount: scope.stepAmount
        });
      } else {
        window.common.alert.hide("componentResultId");
      }
      updateIcon(status, null, null, text, stepAmount, scope.viewPage);
    };

    closeResultComponent = function () {
      window.common.alert.hide("componentResultId");
      scope.update();
    };

    initResultComponent = function () {
      window.common.alert.updateView("componentResultId", {
        parent: scope
      });
      scope.update();
    };


  </script>
</component-transfer-between>