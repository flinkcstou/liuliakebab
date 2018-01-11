<view-transfer-submit class="riot-tags-main-container">
  <div class="transfer-page-title">
    <p class="transfer-name-title">{window.languages.ViewPayTransferNewSubmitTitle}</p>
    <div id="backButton" ontouchend="goToBackFromTransferTouchEnd()" ontouchstart="goToBackFromTransferTouchStart()"
         class="transfer-back-button" role="button" aria-label="{window.languages.Back}">
    </div>
    <div if="{modeOfApp.onlineMode}" id="rightButton" role="button"
         aria-label="{window.languages.ViewBankListTitleName}" type="button"
         class="transfer-i-button"
         ontouchend="openBanksListPageTouchEnd()" ontouchstart="openBanksListPageTouchStart()">
    </div>
  </div>

  <div class="transfer-body-container">
    <div if="{showReceiver}" class="transfer-new-submit-receiver-container">
      <p class="transfer-new-submit-receiver-label">
        {window.languages.ViewPayTransferNewSubmitRecieverLabel}
        {receiverTitle}
      </p>
    </div>
    <div class="transfer-new-between-amount-field">
      <p class="transfer-new-between-text-field">{window.languages.ViewTransferDetailTitleSum}</p>
      <input id="submitAmountId"
             class="transfer-new-between-amount-input"
             type="tel"
             pattern="\d*"
             maxlength="14"
             onfocus="amountFocus()"
             onmouseup="amountMouseUp()"
             onblur="amountOnBlur()"
             onkeyup="amountKeyUp()"
             oninput="amountKeyUp()">
      <p if="{showPlaceHolderError && maxLimit && minLimit}"
         id="placeHolderSumId"
         style="color: red;"
         class="transfer-new-between-input-commission">
        {placeHolderText}
      </p>
      <p if="{!showPlaceHolderError && !modeOfApp.offlineMode  && showCommission}"
         class="transfer-new-between-input-commission">
        {window.languages.ViewTransferTwoTax} {tax}
        {window.languages.Currency}</p>
    </div>
    <div id="cardFromId"
         class="transfer-new-card-from">
      <p if="{!modeOfApp.offlineMode}" class="transfer-new-between-from-text-field">
        {window.languages.ViewPayTransferBetweenCardsFrom}</p>
      <p if="{noCards}" class="transfer-new-submit-no-cards">{window.languages.ViewTransferSubmitNoCards}</p>
      <component-transfer-card-carousel-top
        if="{!noCards && !modeOfApp.offlineMode}"
        id="cardCarouselTopId"
        carouselid="1"
        cardnumber="{cardNumberFromMain}"
        cardsarray="{cardsarray}"
        cardcounter="{cardCounter}"
        usefor="p2p"
        style="position: relative;
        top:{16 * widthK}px">
      </component-transfer-card-carousel-top>
    </div>

    <button if="{showBottomButton}"
            id="bottomButtonSubmitId"
            class="transfer-new-submit-button-container"
            style="bottom: {window.bottomButtonBottom}"
            ontouchstart="onTouchStartOfSubmit(this)"
            ontouchend="onTouchEndOfSubmit(this)">
      <div id="bottomButtonIcon"
           class="transfer-new-submit-button-icon">
      </div>
      <p class="transfer-new-submit-button-text">
        {window.languages.ViewPayTransferNewSubmitTransfer}
      </p>
    </button>
  </div>
  <code-confirm id="blockCodeConfirmId" class="code-confirm">
    <div class="code-confirm-title-container">
      <p class="code-confirm-title-name">{window.languages.ComponentCodeConfirmTitle}</p>
      <div class="code-confirm-cancel-icon" role="button" aria-label="{window.languages.Close}"
           ontouchend="closeSecretCodePage()"></div>
    </div>
    <div class="code-confirm-code-container">
      <input readonly value="{secretCode}" class="code-confirm-code-text"/>
      <p class="code-confirm-message-text">{window.languages.ComponentCodeConfirmMessageText}</p>

      <button class="code-confirm-button-enter" ontouchend="closeSecretCodePage()">
        {window.languages.ComponentCodeConfirmOk}
      </button>
    </div>
  </code-confirm>

  <div hidden="{!showComponent}" id="componentBankListId" class="component-bank-list">
    <div class="page-title" style="border: none;">
      <p class="component-banklist-name-title">{window.languages.ViewBankListTitleName}</p>
      <div id="closeBankListButtonId" type="button" class="component-banklist-close-button"
           ontouchend="closeComponentBankListTouchEnd()" ontouchstart="closeComponentBankListTouchStart()"></div>
    </div>
    <img src="resources/gifs/1x1.gif" width="1" height="1">
    <div id="bankListContainerId" class="component-banklist-container" onscroll="bankListTouchMove()">
      <div class="component-banklist-card-flipper" each="{i in bankList}" ontouchstart="flipCardTouchStart()"
           ontouchend="flipCardTouchEnd(this)">

        <div class="component-banklist-card-front">
          <div class="component-banklist-bank-rotate"></div>
          <div class="component-banklist-bank-logo-front" style="background-image: url({i.image});"></div>
        </div>

        <div class="component-banklist-card-back">
          <div class="component-banklist-bank-logo" style="background-image: url({i.image});"></div>
          <div class="component-banklist-bank-rotate"></div>
          <div class="component-banklist-bank-limit-container">
            <div class="component-banklist-bank-limit-receipt-container">
              <div class="component-banklist-bank-arrow-down"></div>
              <div class="component-banklist-bank-limit-currency-receipt">
                {i.p2p_receipt_max_limit_text}
              </div>
              <div class="component-banklist-bank-limit-receipt">{window.languages.ViewBankListReceiveLimitText}</div>
            </div>

            <div class="component-banklist-bank-limit-transfer-container">
              <div class="component-banklist-bank-arrow-up"></div>
              <div class="component-banklist-bank-limit-currency-transfer">
                {i.p2p_max_limit_text}
              </div>
              <div class="component-banklist-bank-limit-transfer">{window.languages.ViewBankListTransferLimitText}</div>
            </div>
          </div>
          <div hidden="{!i.public_offer}" class="component-banklist-public-offer-container"
               ontouchend="openPublicOffer(&quot;{i.public_offer}&quot;)" id="{i.code}">
            <div class="component-banklist-public-offer-link">{window.languages.ViewBankListPublicOfferText}</div>
            <div class="component-banklist-public-offer-arrow"></div>
          </div>
        </div>

      </div>
    </div>
  </div>
  <script>

    var scope = this;
    var transferSubmitTouchStartX,
      transferSubmitTouchStartY,
      transferSubmitTouchEndX,
      transferSubmitTouchEndY;
    scope.clickPinError = false;
    scope.showComponent = false;
    scope.allBankList = [];
    scope.cardsarray = {};
    scope.chosenCard;
    scope.showBottomButton = false;
    scope.receiver = '';
    scope.receiverTitle = '';
    scope.transferType = '';
    scope.maxLimit = 99999999999;
    scope.minLimit = 5000;
    scope.sumForTransfer = 0;
    scope.tax = 0;
    scope.taxPercent = 0;
    scope.maskOne = /[0-9]/g;
    scope.maskTwo = /[0-9' ']/g;
    scope.stepAmount = 3;
    scope.showPlaceHolderError = false;
    scope.showCommission = false;
    scope.noCards = false;
    scope.cardNumberFromMain = 1;
    scope.showReceiver = true;
    var counter = 0;
    var pageToReturnIfError = 'view-main-page';
    var timeOutTimer = 0;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view !== 'view-transfer-submit') {
      history.arrayOfHistory.push(
        {
          "view": 'view-transfer-submit',
          "params": opts,
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    if (JSON.parse(localStorage.getItem("click_client_p2p_all_bank_list"))) {
      scope.allBankList = JSON.parse(localStorage.getItem("click_client_p2p_all_bank_list"));
    }

    if (localStorage.getItem('settings_block_payAndTransfer'))
      scope.payTransferBlocked = JSON.parse(localStorage.getItem('settings_block_payAndTransfer'));


    scope.on('mount', function () {

      if (opts && JSON.stringify(opts) !== '{}') {
        console.log('opts in submit', opts);
        if (opts.transferType === 'card') {
          scope.receiver = opts.cardNumber.replace(/\s/g, '');
          scope.receiverTitle = opts.cardOwner;
          scope.taxPercent = opts.taxPercent;
          scope.maxLimit = opts.maxLimit;
          scope.minLimit = opts.minLimit;
          scope.transferType = 1;
          if (opts.receiverbank) {
            scope.receiverBank = opts.receiverbank;
          } else {
            scope.receiverBank = {};
            scope.receiverBank.p2p_min_limit = 5000;
            scope.receiverBank.p2p_max_limit = 99999999999;
          }
          if (opts.proctype) {
            scope.receiverBank.procType = opts.proctype;
          } else {
            scope.receiverBank.procType = '';
          }
          if (modeOfApp.offlineMode) {
            scope.showReceiver = false;
          }
        }
        if (opts.transferType === 'contact') {
          scope.receiver = opts.phoneNumber.replace(/\s/g, '');
          scope.receiverTitle = '+998 ' + inputVerification.telVerificationWithSpace(inputVerification.telVerification(opts.phoneNumber));
          scope.taxPercent = opts.taxPercent;
          scope.maxLimit = opts.maxLimit;
          scope.minLimit = opts.minLimit;
          scope.transferType = 2;
        }
        if (opts.cardsarray) {
          scope.cardsarray = opts.cardsarray;
        }
        if (opts.idcardfrommycards !== -1) {
          scope.idCardFromMyCards = opts.idcardfrommycards;
          scope.cardNumberFromMain = scope.cardsarray[scope.idCardFromMyCards].countCard;
        }
        if (opts.cardcounter) {
          scope.cardCounter = opts.cardcounter;
        }
        console.log('scope in submit after mount', JSON.stringify(scope.maxLimit));
      }
      setTimeout(function () {
        submitAmountId.focus();
      }, 0);
      scope.update();
    });
    {
      amountMouseUp = function () {
        event.preventDefault();
        event.stopPropagation();
        if (submitAmountId.value.match(scope.maskOne) !== null
          && submitAmountId.value.match(scope.maskOne).length !== null) {
          submitAmountId.selectionStart = submitAmountId.value.match(scope.maskTwo).length;
          submitAmountId.selectionEnd = submitAmountId.value.match(scope.maskTwo).length;
        } else {
          submitAmountId.selectionStart = 0;
          submitAmountId.selectionEnd = 0;
        }
      };

      amountOnBlur = function () {
        event.preventDefault();
        event.stopPropagation();

        if (submitAmountId.value.length === 0) {
          submitAmountId.value = 0;
        }
      };

      amountFocus = function () {
        event.preventDefault();
        event.stopPropagation();
        if (submitAmountId.value.length === 1 && submitAmountId.value[0] === '0') {
          submitAmountId.value = '';
        }
      };

      amountKeyUp = function () {
        if (submitAmountId.value.length === 1) {
          submitAmountId.value = window.amountTransform(submitAmountId.value.toString());
        }

        if (event.keyCode === 8) {
          scope.sumForTransfer = scope.sumForTransfer.substring(0, scope.sumForTransfer.length - 1);
        }

        if (submitAmountId.value.match(scope.maskTwo) !== null && submitAmountId.value.match(scope.maskTwo).length !== null) {

          submitAmountId.value = submitAmountId.value.substring(0, event.target.value.match(scope.maskTwo).length);
          submitAmountId.selectionStart = submitAmountId.value.match(scope.maskTwo).length;
          submitAmountId.selectionEnd = submitAmountId.value.match(scope.maskTwo).length;

          scope.sumForTransfer = submitAmountId.value.substring(0, submitAmountId.value.match(scope.maskTwo).length);
          scope.sumForTransfer = scope.sumForTransfer.replace(new RegExp(' ', 'g'), '');

          submitAmountId.value = window.amountTransform(scope.sumForTransfer.toString());
          submitAmountId.selectionStart = submitAmountId.value.match(scope.maskTwo).length;
          submitAmountId.selectionEnd = submitAmountId.value.match(scope.maskTwo).length;

        } else {
          submitAmountId.selectionStart = 0;
          submitAmountId.selectionEnd = 0;
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
        if (scope.noCards) {
          scope.showBottomButton = false;
        }

        if (submitAmountId.value.length === 0) {
          scope.showPlaceHolderError = false;
          scope.showCommission = false;
        }
        console.log(JSON.stringify(scope.maxLimit));
        scope.update();
        if (event.keyCode === input_codes.ENTER){
          if (device.platform !== 'BrowserStand')
            cordova.plugins.Keyboard.close();
        }
      };
    }

    checkLimits = function (cardNumber) {
      //Check for limit of chosen card
      if (JSON.parse(localStorage.getItem('click_client_issuer_list'))) {
        if (scope.issuerList !== JSON.parse(localStorage.getItem('click_client_issuer_list')))
          scope.issuerList = JSON.parse(localStorage.getItem('click_client_issuer_list'));

        var currentIssuer = {};
        var issuerPercent = 0;
        var issuerMinLimit = 5000;
        var issuerMaxLimit = 99999999999;

        processingFound = false;
        scope.issuerList.forEach(function (issuer) {
          processingIdInInput = cardNumber.replace(/\s/g, '').substring(0, parseInt(issuer.prefix_length));
          if (issuer.prefix === processingIdInInput) {
            processingFound = true;
            currentIssuer = issuer;
            issuerProcType = currentIssuer.prefix;
          }
        });

        if (processingFound) {
          bankIdInInput = cardNumber.replace(/\s/g, '').substring(parseInt(currentIssuer.code_start) - 1,
            parseInt(currentIssuer.code_start) + parseInt(currentIssuer.code_length) - 1);
          currentIssuer.item.forEach(function (bank) {
            if (bank.code === bankIdInInput) {
              issuerMinLimit = parseInt(bank.p2p_min_limit);
              issuerMaxLimit = parseInt(bank.p2p_send_once_max_limit);
              issuerPercent = parseInt(bank.p2p_percent);
              issuerInBankLimit = parseInt(bank.p2p_in_bank_limit);
              if (scope.transferType === 1) {
                console.log(JSON.stringify(scope.maxLimit));
                scope.taxPercent = issuerPercent;
                scope.receiverBank.p2p_min_limit = parseInt(scope.receiverBank.p2p_min_limit);
                scope.receiverBank.p2p_receipt_once_max_limit = parseInt(scope.receiverBank.p2p_receipt_once_max_limit);
                scope.receiverBank.p2p_min_limit = parseInt(scope.receiverBank.p2p_min_limit);
                if (scope.receiverBank.p2p_receipt_once_max_limit === 0)
                  scope.receiverBank.p2p_receipt_once_max_limit = 99999999999;
                if (issuerMaxLimit === 0)
                  issuerMaxLimit = 99999999999;
                if (issuerMaxLimit > scope.receiverBank.p2p_receipt_once_max_limit){
                  scope.maxLimit = scope.receiverBank.p2p_receipt_once_max_limit;
                } else {
                  scope.maxLimit = issuerMaxLimit;
                }
                console.log(JSON.stringify(scope.maxLimit),
                  JSON.stringify(scope.receiverBank.p2p_receipt_once_max_limit),
                  JSON.stringify(issuerMaxLimit));
                if (issuerMinLimit > scope.receiverBank.p2p_min_limit){
                  scope.minLimit = issuerMinLimit;
                } else {
                  scope.minLimit = scope.receiverBank.p2p_min_limit;
                }
                console.log('inbank', JSON.stringify(issuerInBankLimit));
                if (issuerInBankLimit === 0) {
                  if (issuerProcType === scope.receiverBank.procType) {
                    if (bank.code === scope.receiverBank.code) {
                      scope.maxLimit = 99999999999;
                      console.log('maxLimit by inbank', JSON.stringify(scope.maxLimit));
                    }
                  }
                }
                if (scope.sumForTransfer > 0) {
                  scope.showBottomButton = true;
                  scope.showPlaceHolderError = false;
                  scope.showCommission = false;
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
                  scope.tax = scope.sumForTransfer * scope.taxPercent / 100;
                  scope.showCommission = true;
                } else {
                  scope.tax = 0
                }
              }
              if (scope.transferType === 2) {
                scope.maxLimit = issuerMaxLimit;
                scope.minLimit = issuerMinLimit;
                if (scope.sumForTransfer > 0) {
                  scope.showBottomButton = true;
                  scope.showPlaceHolderError = false;
                  scope.showCommission = false;
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
                  scope.tax = scope.sumForTransfer * scope.taxPercent / 100;
                  scope.showCommission = true;
                }
              }
            }
          });
        }
      }
      scope.update();
    };

    scope.cardChangedTop = cardChangedTop = function (cardNumber) {
      for (var i in scope.cardsarray) {
        if (scope.cardsarray[i].countCard === cardNumber) {
          scope.chosenCard = scope.cardsarray[i];
          checkLimits(scope.chosenCard.numberPartOne + scope.chosenCard.numberMiddleTwo);
        }
      }
      if (scope.chosenCard === undefined) {
        scope.noCards = true;
      }
      scope.update();
    };

    onTouchStartOfSubmit = function (button) {

      button.style.webkitTransform = 'scale(0.7)';

      event.preventDefault();
      event.stopPropagation();

      transferSubmitTouchStartX = event.changedTouches[0].pageX;
      transferSubmitTouchStartY = event.changedTouches[0].pageY;
    };

    onTouchEndOfSubmit = function (button) {

      button.style.webkitTransform = 'scale(1)';

      event.preventDefault();
      event.stopPropagation();

      transferSubmitTouchEndX = event.changedTouches[0].pageX;
      transferSubmitTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(transferSubmitTouchStartX - transferSubmitTouchEndX) <= 20
        && Math.abs(transferSubmitTouchStartY - transferSubmitTouchEndY) <= 20) {
        submitAmountId.blur();
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

        if (modeOfApp.offlineMode) {
          transferViaUssd();
          return;
        }

        if (scope.chosenCard && parseInt(scope.chosenCard.salaryOriginal) < (parseInt(scope.sumForTransfer) + scope.tax)) {
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
        if (scope.chosenCard === undefined) {
          scope.clickPinError = false;
          scope.errorNote = "Выберите карту списания";
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote
          });
          scope.update();
          return;
        }
        if (scope.payTransferBlocked && JSON.parse(sessionStorage.getItem('payTransferConfirmed')) !== true) {
          optsForPinCode = {
            fromPinCode: true,
            receiver: scope.receiver,
            receiverTitle: scope.receiverTitle,
            taxPercent: scope.taxPercent,
            maxLimit: scope.maxLimit,
            minLimit: scope.minLimit,
            transferType: scope.transferType,
            sumForTransfer: scope.sumForTransfer,
            chosenCard: scope.chosenCard,
          };
          riotTags.innerHTML = "<view-pin-code>";
          riot.mount('view-pin-code', ['view-transfer-submit', optsForPinCode]);
          return
        }

        transfer();
      }
    };

    //send request to API
    transfer = function () {

      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      scope.transactionId = parseInt(Date.now() / 1000);

      initResultComponent();
      window.api.call({
        method: 'p2p.payment',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          account_id: scope.chosenCard.card_id,
          receiver_data: scope.receiver,
          amount: parseInt(scope.sumForTransfer),
          type: scope.transferType,
          transaction_id: scope.transactionId
        },
        scope: this,
        onSuccess: function (result) {
          if (result[0][0].error === 0) {
            if (result[1])
              if (result[1][0]) {
                if (result[1][0].secret_code && scope.transferType === 2) {
                  console.log('Clearing timer onSuccess', timeOutTimer);
                  window.clearTimeout(timeOutTimer);
                  closeResultComponent();
                  blockCodeConfirmId.style.display = 'block';
                  scope.secretCode = result[1][0].secret_code;
                  window.updateBalanceGlobalFunction();
                  scope.update();
                }
                if (result[1][0].secret_code === 0) {
                  setTimeout(function () {
                    checkTransferStatus(result[1][0].payment_id);
                  }, 2000);
                }
              }
          }
          else {
            console.log('Clearing timer onSuccess', timeOutTimer);
            window.clearTimeout(timeOutTimer);
            updateResultComponent(true, null, pageToReturnIfError, 'unsuccess', result[0][0].error_note)
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.log('Clearing timer onFail', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          updateResultComponent(true, null, pageToReturnIfError, 'unsuccess', api_status_message);
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onTimeOut: function () {
          timeOutTimer = setTimeout(function () {
            window.api.forceClose();
            updateResultComponent(true, null, pageToReturnIfError, 'waiting', window.languages.WaitingTimeExpiredText);
          }, 30000);
          console.log('creating timeOut', timeOutTimer);
        },
        onEmergencyStop: function () {
          console.log('Clearing timer emergencyStop', timeOutTimer);
          window.clearTimeout(timeOutTimer);
        }
      });

    };

    //send USSD request to API
    transferViaUssd = function () {
      if (scope.transferType === 2) {
        phonedialer.dial(
          "*880*3*" + scope.receiver + "*" + parseInt(scope.sumForTransfer) + "%23",
          function (err) {
            if (err === "empty") {
              scope.clickPinError = false;
              scope.errorNote = ("Unknown phone number");

              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: scope.clickPinError,
                errornote: scope.errorNote
              });
              scope.update();
            }
            else console.error("Dialer Error:" + err);
          },
          function (success) {
            console.error('success', success)
            console.error("*880*3*" + scope.receiver + "*" + parseInt(scope.sumForTransfer) + "%23")
          }
        );
        return;
      }
      if (scope.transferType === 1) {
        phonedialer.dial(
          "*880*" + scope.receiver + "*" + parseInt(scope.sumForTransfer) + "%23",
          function (err) {
            if (err == "empty") {
              scope.clickPinError = false;
              scope.errorNote = ("Unknown phone number");

              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: scope.clickPinError,
                errornote: scope.errorNote
              });

              scope.update();
            }
            else console.error("Dialer Error:" + err);
          },
          function (success) {
            console.error('success', success)
            console.error("*880*" + scope.receiver + "*" + parseInt(scope.sumForTransfer) + "%23")
          }
        );
      }
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
              console.log('Clearing timer onFail', timeOutTimer);
              window.clearTimeout(timeOutTimer);

              window.languages.tempText = JSON.stringify(result[1][0].error);
              scope.errorMessageFromTransfer = result[1][0].error;
              updateResultComponent(true, scope.stepAmount, null, 'unsuccess', result[1][0].error);
            } else if (result[1][0].state === 2) {
              console.log('Clearing timer onSuccess', timeOutTimer);
              window.clearTimeout(timeOutTimer);
              window.updateBalanceGlobalFunction();
              updateResultComponent(true, scope.stepAmount, null, 'success', window.languages.ComponentSuccessMessage);
              if (scope.transferType === 1)
                transferFindCards(scope.receiver, scope.receiverTitle);
            } else if (result[1][0].state === 1) {
              counter++;

              if (counter < 5) {
                setTimeout(function () {
                  checkTransferStatus(result[1][0].payment_id);
                }, 2000);
              } else {
                console.log('Clearing timer onSuccess', timeOutTimer);
                window.clearTimeout(timeOutTimer);
                updateResultComponent(true, scope.stepAmount, null, 'waiting', window.languages.ComponentInProcessingPartOne);
              }
            }
            window.api.spinnerOn = false;
          }
          else {
            console.log('Clearing timer onSuccess', timeOutTimer);
            window.clearTimeout(timeOutTimer);
            updateResultComponent(true, scope.stepAmount, null, 'unsuccess', result[0][0].error);
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.log('Clearing timer onFail', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          updateResultComponent(true, scope.stepAmount, null, 'unsuccess', api_status_message);
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onEmergencyStop: function () {
          console.log('Clearing timer emergencyStop', timeOutTimer);
          window.clearTimeout(timeOutTimer);
        }
      }, 30000);
    };

    transferFindCards = function (saveCard, saveCardOwner) {

      var transferCards = [];
      var codeOfBank = saveCard.replace(/\s/g, '').substring(3, 6);
      var card = {};
      card.image = '';
      card.name = '';
      card.cardNumber = '';
      card.owner = {};
      if (saveCardOwner)
        card.owner.firstName = saveCardOwner;
      card.owner.secondName = '';
      var bankList = JSON.parse(localStorage.getItem('click_client_p2p_bank_list'));
      if (JSON.parse(localStorage.getItem('p2pTransferCards'))) {
        transferCards = JSON.parse(localStorage.getItem('p2pTransferCards'));
        for (var j = 0; j < transferCards.length; j++) {
          if (transferCards[j].cardNumber === saveCard) {
            transferCards.splice(j, 1);
            localStorage.setItem('p2pTransferCards', JSON.stringify(transferCards));
          }
        }
      }

      for (var i = 0; i < bankList.length; i++) {
        if (codeOfBank === bankList[i].code) {
          if (JSON.parse(localStorage.getItem('p2pTransferCards'))) {
            transferCards = JSON.parse(localStorage.getItem('p2pTransferCards'));
            card.image = bankList[i].image;
            card.name = bankList[i].name;
            card.cardNumber = saveCard;
            transferCards.unshift(card);
            localStorage.setItem('p2pTransferCards', JSON.stringify(transferCards));
          }
          else {
            card.image = bankList[i].image;
            card.name = bankList[i].name;
            card.cardNumber = saveCard;
            transferCards.unshift(card);
            localStorage.setItem('p2pTransferCards', JSON.stringify(transferCards));
          }
        }
      }
    };

    // Functions for result component
    {
      updateResultComponent = function (showResult, stepAmount, viewPage, status, text) {
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
    }

    closeSecretCodePage = function () {
      blockCodeConfirmId.style.display = 'none';
      window.common.alert.show("componentInProcessingId", {
        parent: scope,
        operationmessagepartone: window.languages.ComponentInProcessingPartOneForTransfer,
        operationmessageparttwo: window.languages.ComponentInProcessingPartTwoForTransfer,
        step_amount: 2,
      });
    };

    if (scope.payTransferBlocked && JSON.parse(sessionStorage.getItem('payTransferConfirmed')) === true) {
      if (opts.fromPinCode === true) {
        scope.receiver = opts.receiver;
        scope.receiverTitle = opts.receiverTitle;
        scope.taxPercent = opts.taxPercent;
        scope.maxLimit = opts.maxLimit;
        scope.minLimit = opts.minLimit;
        scope.transferType = opts.transferType;
        scope.sumForTransfer = opts.sumForTransfer;
        scope.chosenCard = opts.chosenCard;

        transfer();
      }
      sessionStorage.setItem('payTransferConfirmed', null);
    }


    //Info about banks
    {
      var openBankListTouchStartX, openBankListTouchStartY, openBankListTouchEndX, openBankListTouchEndY;
      openBanksListPageTouchStart = function () {
        event.preventDefault();
        event.stopPropagation();

        rightButton.style.webkitTransform = 'scale(0.8)';

        openBankListTouchStartX = event.changedTouches[0].pageX;
        openBankListTouchStartY = event.changedTouches[0].pageY;
      };

      bankListTouchMove = function () {
        event.preventDefault();
        event.stopPropagation();
      };

      openBanksListPageTouchEnd = function () {

        submitAmountId.blur();

        event.preventDefault();
        event.stopPropagation();

        rightButton.style.webkitTransform = 'scale(1)';

        openBankListTouchEndX = event.changedTouches[0].pageX;
        openBankListTouchEndY = event.changedTouches[0].pageY;

        if (Math.abs(openBankListTouchStartX - openBankListTouchEndX) <= 20 && Math.abs(openBankListTouchStartY - openBankListTouchEndY) <= 20) {

          if (modeOfApp.offlineMode)return;

          if (modeOfApp.demoVersion) {
            var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
            scope.errorNote = question;
            scope.confirmType = 'local';

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

          if (JSON.parse(localStorage.getItem("click_client_p2p_bank_list"))) {
            scope.bankList = JSON.parse(localStorage.getItem("click_client_p2p_bank_list"));
          }
          scope.showComponent = true;
          window.checkShowingComponent = scope;
          scope.update();
        }
      };

      var closeBankListTouchStartX, closeBankListTouchStartY, closeBankListTouchEndX, closeBankListTouchEndY;

      closeComponentBankListTouchStart = function () {
        event.preventDefault();
        event.stopPropagation();

        closeBankListButtonId.style.webkitTransform = 'scale(0.8)';

        closeBankListTouchStartX = event.changedTouches[0].pageX;
        closeBankListTouchStartY = event.changedTouches[0].pageY;
      };

      closeComponentBankListTouchEnd = function () {
        event.preventDefault();
        event.stopPropagation();

        closeBankListButtonId.style.webkitTransform = 'scale(1)';

        closeBankListTouchEndX = event.changedTouches[0].pageX;
        closeBankListTouchEndY = event.changedTouches[0].pageY;

        if (Math.abs(closeBankListTouchStartX - closeBankListTouchEndX) <= 20 && Math.abs(closeBankListTouchStartY - closeBankListTouchEndY) <= 20) {
          bankListContainerId.scrollTop = 0;
          scope.showComponent = false;
          window.checkShowingComponent = null;
          scope.update()
        }
      };

      var flipCardTouchStartX, flipCardTouchStartY, flipCardTouchEndX, flipCardTouchEndY, pointerInOffer = false;

      flipCardTouchStart = function () {
        flipCardTouchStartX = event.changedTouches[0].pageX;
        flipCardTouchStartY = event.changedTouches[0].pageY;
      };

      flipCardTouchEnd = function (object) {
        flipCardTouchEndX = event.changedTouches[0].pageX;
        flipCardTouchEndY = event.changedTouches[0].pageY;

        var publicOfferContainer = object.getElementsByClassName("component-banklist-public-offer-container")[0];
        var publicOfferId = publicOfferContainer.id;
        var publicOfferRect = document.getElementById(publicOfferId).getBoundingClientRect();
        var publicOfferHidden = publicOfferContainer.hidden;

        if (Math.abs(flipCardTouchStartX - flipCardTouchEndX) <= 20 &&
          Math.abs(flipCardTouchStartY - flipCardTouchEndY) <= 20 && !pointerInOffer) {

          var rotated = object.style.webkitTransform;
          if (device.platform == 'Android')
            rotated = object.style.transform;
          if (rotated === "rotateY(-180deg)") {
            if (!publicOfferHidden) {
              if (publicOfferRect.top > flipCardTouchEndY) {
                if (device.platform == 'Android')
                  object.style.transform = "rotateY(0deg)";
                else
                  object.style.webkitTransform = "rotateY(0deg)";
              }
            }
            else {
              if (device.platform == 'Android')
                object.style.transform = "rotateY(0deg)";
              else
                object.style.webkitTransform = "rotateY(0deg)";
            }
          }
          else {
            if (device.platform == 'Android')
              object.style.transform = "rotateY(-180deg)";
            else
              object.style.webkitTransform = "rotateY(-180deg)";
          }
        }
      };

      openPublicOffer = function (LinkToPublicOffer) {
        console.log("Link to Offer", LinkToPublicOffer);
        window.open(LinkToPublicOffer, '_system', 'location=no');
      }
    }

    //Go back from transfer
    {
      var goToBackTransferTouchStartX, goToBackTransferTouchStartY,
        goToBackTransferTouchEndX, goToBackTransferTouchEndY;

      goToBackFromTransferTouchStart = function () {
        event.preventDefault();
        event.stopPropagation();

        backButton.style.webkitTransform = 'scale(0.8)';

        goToBackTransferTouchStartX = event.changedTouches[0].pageX;
        goToBackTransferTouchStartY = event.changedTouches[0].pageY;
      };

      goToBackFromTransferTouchEnd = function () {
        event.preventDefault();
        event.stopPropagation();

        backButton.style.webkitTransform = 'scale(1)';

        goToBackTransferTouchEndX = event.changedTouches[0].pageX;
        goToBackTransferTouchEndY = event.changedTouches[0].pageY;
        onBackParams.opts = opts;

        if (Math.abs(goToBackTransferTouchStartX - goToBackTransferTouchEndX) <= 20 && Math.abs(goToBackTransferTouchStartY - goToBackTransferTouchEndY) <= 20) {
          onBackKeyDown();
          scope.unmount();
        }
      }
    }

  </script>
</view-transfer-submit>
