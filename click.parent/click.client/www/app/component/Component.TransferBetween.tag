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
    <p if="{!showPlaceHolderError && !modeOfApp.offlineMode}" class="transfer-new-between-input-commission">
      {window.languages.ViewTransferTwoTax} {tax}
      {window.languages.Currency}</p>
  </div>

  <div id="cardFromId"
       class="transfer-new-card-from">
    <p class="transfer-new-between-from-text-field">{window.languages.ViewPayTransferBetweenCardsFrom}</p>
    <component-transfer-card-carousel-top
      carouselid="1"
      style="position: relative;
      right:{16 * widthK}px;
      top:{16 * widthK}px">
    </component-transfer-card-carousel-top>
  </div>

  <div class="transfer-new-between-cards-arrow">
  </div>

  <div id="cardToId"
       class="transfer-new-card-to">
    <p class="transfer-new-between-from-text-field">{window.languages.ViewPayTransferBetweenCardsTo}</p>
    <component-transfer-card-carousel-bottom
    carouselid="2"
    style="position: relative;
      right:{16 * widthK}px;
      top:{11 * widthK}px">
    </component-transfer-card-carousel-bottom>
  </div>
  <button if="{showBottomButton}"
          id="bottomButtonId"
          class="transfer-new-submit-button-container"
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
  scope.maskOne = /[0-9]/g;
  scope.maskTwo = /[0-9' ']/g;
  scope.showBottomButton = false;

  if (JSON.parse(localStorage.getItem("click_client_p2p_all_bank_list"))) {
    scope.allBankList = JSON.parse(localStorage.getItem("click_client_p2p_all_bank_list"));
  }

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
    if (betweenAmountId.value.length === 1 && betweenAmountId.value[0] === 0) {
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

    if (scope.sumForTransfer)
      scope.tax = scope.sumForTransfer * scope.taxPercent / 100;
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
    scope.update()
  };

  scope.cardChangedTop = cardChangedTop = function (cardNumber) {
    for (var i in scope.cardsarray) {
      if (scope.cardsarray[i].countCard === cardNumber) {
        scope.chosenCardTop = scope.cardsarray[i];
      }
    }
  };

  scope.cardChangedBottom = cardChangedBottom = function (cardNumber) {
    for (var i in scope.cardsarray) {
      if (scope.cardsarray[i].countCard === cardNumber) {
        scope.chosenCardBottom = scope.cardsarray[i];

        var codeOfBank = cardInputId.value.replace(/\s/g, '').substring(3, 6);
        var checkOfCode = false;
        var statusOfBankToP2P = false;
        var nameOfBank = '';

        var bankList = JSON.parse(localStorage.getItem('click_client_p2p_all_bank_list'));
        var percentOfBank = 0;
        var minOfBank = 0;
        var maxOfBank = 0;
//        if (bankList) {
//          for (var i = 0; i < bankList.length; i++) {
//            if (codeOfBank === bankList[i].code) {
//              checkOfCode = true;
//              nameOfBank = bankList[i].bank_name;
//              if (bankList[i].p2p_status === 1) {
//                statusOfBankToP2P = true
//              }
//              minOfBank = bankList[i].p2p_min_limit;
//              maxOfBank = bankList[i].p2p_max_limit;
//              percentOfBank = bankList[i].p2p_percent;
//              break;
//            }
//            else {
//              checkOfCode = false;
//            }
//          }
//        }
//        else {
//          cardInputId.blur();
//          scope.errorNote = 'Подождите, данные для обработки информации еще не прогрузились';
//
//          window.common.alert.show("componentAlertId", {
//            parent: scope,
//            clickpinerror: scope.clickPinError,
//            errornote: scope.errorNote,
//            pathtosettings: scope.pathToSettings,
//            permissionerror: scope.permissionError,
//          });
//
//          scope.update();
//          return;
//        }
//        if (!checkOfCode) {
//          cardInputId.blur();
//          scope.errorNote = 'Неверный номер карты';
//
//          window.common.alert.show("componentAlertId", {
//            parent: scope,
//            clickpinerror: scope.clickPinError,
//            errornote: scope.errorNote,
//            pathtosettings: scope.pathToSettings,
//            permissionerror: scope.permissionError,
//          });
//          scope.update();
//          return;
//        }
//
//        if (!statusOfBankToP2P) {
//          cardInputId.blur();
//          scope.errorNote = 'Карта "' + nameOfBank + '" банка временно недоступна для перевода средств';
//          window.common.alert.show("componentAlertId", {
//            parent: scope,
//            clickpinerror: scope.clickPinError,
//            errornote: scope.errorNote,
//            pathtosettings: scope.pathToSettings,
//            permissionerror: scope.permissionError,
//          });
//          scope.update();
//          return;
//        }
      }
    }
  };



  </script>
</component-transfer-between>