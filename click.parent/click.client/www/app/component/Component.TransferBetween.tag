<component-transfer-between>
  <div id="amountField" class="transfer-new-between-amount-field"
       ontouchstart="betweenAmountFormTouchStart()"
       ontouchend="betweenAmountFormTouchEnd()">
    <p id="amountFieldTitle" class="transfer-new-between-text-field">{window.languages.ViewTransferDetailTitleSum}</p>
    <input id="betweenAmountId"
           class="transfer-new-between-amount-input"
           type="tel"
           pattern="\d*"
           maxlength="14"
           onfocus="amountFocus()"
           onmouseup="amountMouseUp()"
           onblur="amountOnBlur()"
           oninput="amountInput()">
    <p if="{showPlaceHolderError && maxLimit && minLimit}"
       id="placeHolderSumId"
       style="color: red;"
       class="transfer-new-between-input-commission">
      {placeHolderText}
    </p>
    <p if="{!showPlaceHolderError && !modeOfApp.offlineMode && showCommission}"
       class="transfer-new-between-input-commission">
      {window.languages.ViewTransferTwoTax} {tax}
      {window.languages.Currency}</p>
  </div>

  <div id="cardFromId"
       class="transfer-new-card-from"
       ontouchstart="blurInput()">
    <p class="transfer-new-between-from-text-field">{window.languages.ViewPayTransferBetweenCardsFrom}</p>
    <component-transfer-card-carousel-top
      carouselid="1"
      cardnumber="{cardNumberFromMain}"
      cardsarray="{cardsarray}"
      cardcounter="{cardCounter}"
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
      cardnumber="{cardNumberForBottom}"
      cardsarray="{cardsarray}"
      cardcounter="{cardCounter}"
      usefor="p2p"
      style="position: relative;
      top:{11 * heightK}px">
    </component-transfer-card-carousel-bottom>
  </div>
  <button hidden="{!showBottomButton}"
          id="bottomButtonBetweenId"
          style="bottom: {window.bottomButtonBottom}"
          class="transfer-new-submit-button-container"
          ontouchstart="onTouchStartOfSubmit(this)"
          ontouchend="onTouchEndOfSubmit(this)">
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
    scope.maxLimitTop = 99999999999;
    scope.maxLimitBottom = 99999999999;
    scope.minLimit = 5000;
    scope.minLimitTop = 5000;
    scope.minLimitBottom = 5000;
    scope.bankCodeTop = '';
    scope.bankCodeBottom = '';
    scope.procTypeTop = '';
    scope.procTypeBottom = '';
    scope.inBankLimitTop = 1;
    scope.inBankLimitBottom = 0;
    scope.stepAmount = 1;
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
    scope.cardNumberFromMain = 1;
    scope.idCardFromMyCards = -1;
    scope.cardNumberForBottom = 2;
    scope.cardCounter = 1;
    var counter = 0;
    var pageToReturnIfError = 'view-main-page';
    var timeOutTimer = 0;
    var options = {
      symbol: "",
      decimal: ".",
      thousand: " ",
      precision: 0,
      format: {
        pos: "%v",
        zero: ""
      }
    };

    scope.on('mount', function () {
      if (opts && JSON.stringify(opts) !== '{}') {
        if (opts.cardsarray) {
          scope.cardsarray = opts.cardsarray;
          console.log('cards array in between', scope.cardsarray);
        }
      }
      if (opts.idcardfrommycards !== -1) {
        scope.idCardFromMyCards = opts.idcardfrommycards;
        scope.cardNumberFromMain = scope.cardsarray[scope.idCardFromMyCards].countCard;
      }
      if (opts.cardcounter) {
        scope.cardCounter = opts.cardcounter;
        if (scope.cardNumberFromMain < scope.cardCounter) {
          scope.cardNumberForBottom = scope.cardNumberFromMain + 1;
        }
        else {
          scope.cardNumberForBottom = scope.cardNumberFromMain - 1;
        }
      }
      scope.update();
    });

    betweenAmountFormTouchStart = function () {
      scope.parent.transitionRunning = true;
    };

    betweenAmountFormTouchEnd = function () {
      event.stopPropagation();
      scope.parent.transitionRunning = false;
    };


    amountMouseUp = function () {
      event.preventDefault();
      event.stopPropagation();
    };

    amountOnBlur = function () {
      event.preventDefault();
      event.stopPropagation();
      contactPhoneNumberId.readOnly = false;
      cardInputId.readOnly = false;

      amountFieldTitle.style.color = 'gray';
      amountField.style.borderBottom = "" + 3 * widthK + "px solid #cbcbcb";
    };

    amountFocus = function () {
      event.preventDefault();
      event.stopPropagation();

      amountFieldTitle.style.color = '#01cfff';
      amountField.style.borderBottom = "" + 3 * widthK + "px solid #01cfff";

      contactPhoneNumberId.readOnly = true;
      cardInputId.readOnly = true;
    };

    amountInput = function () {

      var amountInput = accounting.formatMoney(betweenAmountId.value, options);

      var selectionStart = betweenAmountId.selectionStart,
        notVerifiedValue = betweenAmountId.value,
        delta;

      delta = notVerifiedValue.length - amountInput.length;

      selectionStart = selectionStart - delta;
      selectionStart = (selectionStart < 0) ? (0) : (selectionStart);

      betweenAmountId.value = amountInput;

      setTimeout(function() {
          betweenAmountId.selectionStart = selectionStart;
          betweenAmountId.selectionEnd = selectionStart;
        }, 0
      );

      scope.sumForTransfer = accounting.unformat(amountInput);

      if (scope.sumForTransfer) {
        scope.tax = scope.sumForTransfer * scope.taxPercent / 100;
        scope.showCommission = true;
      } else {
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

      if (betweenAmountId.value.length === 0) {
        scope.showBottomButton = false;
        scope.showPlaceHolderError = false;
        scope.showCommission = false;
      }
      scope.update();
      if (event.keyCode === input_codes.ENTER) {
        if (device.platform !== 'BrowserStand')
          cordova.plugins.Keyboard.close();
      }
    };

    scope.cardChangedTop = cardChangedTop = function (cardNumber) {
      console.log('top card changed');
      for (var i in scope.cardsarray) {
        if (scope.cardsarray[i].countCard === cardNumber) {
          scope.chosenCardTop = scope.cardsarray[i];

          var firstSixDigitsTop = scope.chosenCardTop.numberPartOne + scope.chosenCardTop.numberMiddleTwo;
          if (JSON.parse(localStorage.getItem('click_client_issuer_list'))) {
            if (scope.issuerList !== JSON.parse(localStorage.getItem('click_client_issuer_list')))
              scope.issuerList = JSON.parse(localStorage.getItem('click_client_issuer_list'));

            var currentIssuerTop = {};

            processingIconFoundTop = false;
            scope.statusOfBankToP2PTop = true;
            scope.issuerList.forEach(function (issuer) {
              processingIdInInputTop = firstSixDigitsTop.replace(/\s/g, '').substring(0, parseInt(issuer.prefix_length));
              if (issuer.prefix === processingIdInInputTop) {
                processingIconFoundTop = true;
                currentIssuerTop = issuer;
                scope.procTypeTop = issuer.prefix;
              }
            });

            if (processingIconFoundTop) {
              bankIdInInputTop = firstSixDigitsTop.replace(/\s/g, '').substring(parseInt(currentIssuerTop.code_start) - 1,
                parseInt(currentIssuerTop.code_start) + parseInt(currentIssuerTop.code_length) - 1);
              currentIssuerTop.item.forEach(function (bank) {
                if (bank.code === bankIdInInputTop) {
                  scope.minLimitTop = parseInt(bank.p2p_min_limit);
                  scope.maxLimitTop = parseInt(bank.p2p_send_once_max_limit);
                  if (scope.maxLimitTop === 0) {
                    scope.maxLimitTop = 99999999999;
                  }
                  scope.inBankLimitTop = parseInt(bank.p2p_in_bank_limit);
                  scope.bankCodeTop = bank.code;
                  if (scope.minLimitTop > scope.minLimitBottom) {
                    scope.minLimit = scope.minLimitTop;
                  } else {
                    scope.minLimit = scope.minLimitBottom;
                  }
                  if (scope.maxLimitTop > scope.maxLimitBottom) {
                    scope.maxLimit = scope.maxLimitBottom;
                  } else {
                    scope.maxLimit = scope.maxLimitTop;
                  }
                  if (bank.p2p_status == 1) {
                    scope.statusOfBankToP2PTop = true;
                  }
                  if (scope.inBankLimitTop === 0) {
                    if (scope.procTypeTop === scope.procTypeBottom) {
                      if (scope.bankCodeTop === scope.bankCodeBottom) {
                        scope.maxLimit = 99999999999;
                      }
                    }
                  }
                  scope.nameOfBankTop = bank.bank_name;
                }
              });
            }
          }

          if (scope.sumForTransfer) {
            scope.showBottomButton = true;
            scope.showPlaceHolderError = false;
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
      console.log(scope);
      scope.update();
    };

    scope.cardChangedBottom = cardChangedBottom = function (cardNumber) {
      console.log('bottom card changed');
      for (var i in scope.cardsarray) {
        if (scope.cardsarray[i].countCard === cardNumber) {
          scope.chosenCardBottom = scope.cardsarray[i];

          var firstSixDigits = scope.chosenCardBottom.numberPartOne + scope.chosenCardBottom.numberMiddleTwo;
          if (JSON.parse(localStorage.getItem('click_client_issuer_list'))) {
            if (scope.issuerList !== JSON.parse(localStorage.getItem('click_client_issuer_list')))
              scope.issuerList = JSON.parse(localStorage.getItem('click_client_issuer_list'));

            var currentIssuer = {};

            processingIconFound = false;
            scope.statusOfBankToP2PBottom = true;
            scope.issuerList.forEach(function (issuer) {
              processingIdInInput = firstSixDigits.replace(/\s/g, '').substring(0, parseInt(issuer.prefix_length));
              if (issuer.prefix === processingIdInInput) {
                processingIconFound = true;
                currentIssuer = issuer;
                scope.procTypeBottom = issuer.prefix;
              }
            });

            if (processingIconFound) {
              bankIdInInput = firstSixDigits.replace(/\s/g, '').substring(parseInt(currentIssuer.code_start) - 1,
                parseInt(currentIssuer.code_start) + parseInt(currentIssuer.code_length) - 1);
              currentIssuer.item.forEach(function (bank) {
                if (bank.code === bankIdInInput) {
                  scope.minLimitBottom = parseInt(bank.p2p_min_limit);
                  scope.maxLimitBottom = parseInt(bank.p2p_receipt_once_max_limit);
                  scope.inBankLimitBottom = parseInt(bank.p2p_in_bank_limit);
                  scope.bankCodeBottom = bank.code;
                  if (scope.maxLimitBottom === 0) {
                    scope.maxLimitBottom = 99999999999;
                  }
                  if (scope.minLimitTop > scope.minLimitBottom) {
                    scope.minLimit = scope.minLimitTop;
                  } else {
                    scope.minLimit = scope.minLimitBottom;
                  }
                  if (scope.maxLimitTop > scope.maxLimitBottom) {
                    scope.maxLimit = scope.maxLimitBottom;
                  } else {
                    scope.maxLimit = scope.maxLimitTop;
                  }
                  scope.taxPercent = parseInt(bank.p2p_percent);
                  if (bank.p2p_status == 1) {
                    scope.statusOfBankToP2PBottom = true;
                  }
                  if (scope.inBankLimitBottom === 0) {
                    if (scope.procTypeBottom === scope.procTypeTop) {
                      if (scope.bankCodeBottom === scope.bankCodeTop) {
                        scope.maxLimit = 99999999999;
                      }
                    }
                  }
                  scope.nameOfBankBottom = bank.bank_name;
                }
              });
            }
          }

          if (scope.sumForTransfer) {
            scope.showBottomButton = true;
            scope.showPlaceHolderError = false;
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
          console.log('currentBank', scope.nameOfBankBottom);
        }
      }
      scope.update();
    };

    blurInput = function () {
      betweenAmountId.blur();
    };

    onTouchStartOfSubmit = function (button) {

      scope.parent.transitionRunning = true;
      button.style.webkitTransform = 'scale(0.7)';

      event.preventDefault();
      event.stopPropagation();

      transferBetweenTouchStartX = event.changedTouches[0].pageX;
      transferBetweenTouchStartY = event.changedTouches[0].pageY;
    };

    onTouchEndOfSubmit = function (button) {

      scope.parent.transitionRunning = false;
      button.style.webkitTransform = 'scale(1)';

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

    transferBetween = function () {

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
                setTimeout(function () {
                  checkTransferStatus(result[1][0].payment_id);
                }, 2000);
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
            window.writeLog({
              reason: 'Timeout',
              method: 'p2p.account',
            });
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
              console.log('Clearing timer inCheckTransferStatus', timeOutTimer);
              window.clearTimeout(timeOutTimer);

              window.languages.tempText = JSON.stringify(result[1][0].error);
              scope.errorMessageFromTransfer = result[1][0].error;
              updateResultComponent(true, scope.stepAmount, null, 'unsuccess', result[1][0].error);
            } else if (result[1][0].state === 2) {
              console.log('Clearing timer inCheckTransferStatus', timeOutTimer);
              window.clearTimeout(timeOutTimer);
              window.updateBalanceGlobalFunction();
              updateResultComponent(true, scope.stepAmount, null, 'success', window.languages.ComponentSuccessMessage);
            } else if (result[1][0].state === 1) {
              counter++;

              if (counter < 5) {
                setTimeout(function () {
                  checkTransferStatus(result[1][0].payment_id);
                }, 2000);
              } else {
                console.log('Clearing timer inCheckTransferStatus', timeOutTimer);
                window.clearTimeout(timeOutTimer);
                updateResultComponent(true, scope.stepAmount, null, 'waiting', window.languages.ComponentInProcessingPartOne);
              }
            }
            window.api.spinnerOn = false;
          }
          else {
            console.log('Clearing timer inCheckTransferStatus', timeOutTimer);
            window.clearTimeout(timeOutTimer);
            updateResultComponent(true, scope.stepAmount, null, 'unsuccess', result[0][0].error);
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.log('Clearing timer inCheckTransferStatus', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          updateResultComponent(true, scope.stepAmount, null, 'unsuccess', api_status_message);
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onEmergencyStop: function () {
          console.log('Clearing timer emergencyStop', timeOutTimer);
          window.clearTimeout(timeOutTimer);
        }
      });
    };

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


  </script>
</component-transfer-between>