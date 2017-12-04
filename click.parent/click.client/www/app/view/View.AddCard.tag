<view-add-card class="riot-tags-main-container">

  <div class="add-card-page-title">
    <p class="add-card-name-title">{titleName}</p>
    <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchend="goToBack()"
         class="add-card-back-button"></div>
  </div>

  <div class="view-add-card">
    <p class="add-card-text-field">{window.languages.ViewAddCardNameTitle}</p>
    <div hidden if="{!modeOfApp.offlineMode}" class="add-card-card-name-input-part-container">
      <input maxlength="25" class="add-card-card-name-input-part"/>
    </div>


    <div class="add-card-card-field">
      <div id="processingIconId" class="add-card-uzcard-icon" style="background-image: url({processingImage});"></div>
      <p class="add-card-card-text add-card-card-number-text">{window.languages.ViewAddCardNumberTitle}</p>
      <div id="cardNumberInput" class="add-card-card-number">
        <input type="tel" onpaste="boxOnePaste()" onkeyup="boxOneKeyUp()"
               onkeydown="boxOneKeyDown()" autofocus="true" oninput="boxOneChange()"
               id="boxOne"
               class="add-card-card-number-box add-card-card-number-box-one">
        </input>
      </div>

      <p id="cardDateInputTitleId" class="add-card-card-text add-card-card-text-date">
        {window.languages.ViewAddCardDateTitle}</p>
      <div id="cardDateInputId" class="add-card-card-date" type="text">
        <input type="tel" onkeyup="boxDateKeyUp()" maxlength="5" id="boxDate"
               class="add-card-card-date-box">
        </input>
      </div>

      <div id="bankIconId" class="add-card-bankIcon" style="background-image: url({bankImage});"></div>
    </div>


    <div hidden if="{!modeOfApp.offlineMode}" class="add-card-main-card-field">
      <p class="add-card-main-card-text">{window.languages.ViewAddCardDoMainTitle}</p>
      <div id="doMainId" class="add-card-main-card-icon" ontouchend="doMainCardTouchEnd()"></div>
    </div>


    <button if="{showBottomButton}"
            id="bottomButtonId"
            class="transfer-new-button-container"
            style="bottom: {window.bottomButtonBottom};"
            ontouchstart="createCardTouchStart(this.id)"
            ontouchend="createCardTouchEnd(this.id)">
      {window.languages.ViewAddCardAddBtnText}
    </button>

  </div>

  <script>
    var scope = this;
    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    var sessionKey = info.session_key;
    var dateOrPin = '';
    var cardNumber = '';
    var createButtonStartX,
      createButtonEndX,
      createButtonStartY,
      createButtonEndY;
    var mainPageToReturn = 'view-main-page',
      pageToReturnTwo = 'view-add-card';
    var answerFromServer = false;
    var onPaste = false;
    var canFormatNumber = true;
    var stars = '';
    var pinCodeOfBank = '';
    var boxCursorPositionSelectionStart,
      boxCursorPositionSelectionEnd,
      oldValueOfBoxNumber;
    var bankIconFound = false;
    var processingIconFound = false;
    var bankId = '';
    var processingId = '';
    var isUzcard = false;
    var newCardWithoutSpace = '';
    scope.titleName = window.languages.ViewAddCardTitle;
    scope.doMainCard = false;
    scope.bankImage = '';
    scope.processingImage = '';
    scope.allBankList = [];
    if (localStorage.getItem('click_client_loginInfo')) {
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
      scope.processingTypes = loginInfo.card_prefixes;
    }
    scope.showBottomButton = false;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view !== 'view-add-card') {
      history.arrayOfHistory.push(
        {
          "view": 'view-add-card',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    if (loginInfo)
      if (!localStorage.getItem("click_client_p2p_bank_list") || loginInfo.update_bank_list) {
        if (modeOfApp.onlineMode)
          window.api.call({
            method: 'p2p.bank.list',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber
            },
            scope: this,

            onSuccess: function (result) {
              if (result[0][0].error === 0) {
                var bankListAvailable = [];
                for (var i in result[1]) {
                  if (result[1][i].p2p_status === 1)
                    bankListAvailable.push(result[1][i]);
                }
                if (localStorage.getItem('click_client_p2p_all_bank_list') !== JSON.stringify(result[1])) {
                  localStorage.setItem('click_client_p2p_bank_list', JSON.stringify(bankListAvailable));
                  localStorage.setItem('click_client_p2p_all_bank_list', JSON.stringify(result[1]));
                  scope.allBankList = result[1];
                }
              }
              else {
                scope.errorNote = result[0][0].error_note;

                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: scope.clickPinError,
                  errornote: scope.errorNote,
                  pathtosettings: scope.pathToSettings,
                  permissionerror: scope.permissionError
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

    if (JSON.parse(localStorage.getItem("click_client_p2p_all_bank_list"))) {
      scope.allBankList = JSON.parse(localStorage.getItem("click_client_p2p_all_bank_list"));

    }


    doMainCardTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      if (!scope.doMainCard) {
        scope.doMainCard = true;
        doMainId.style.backgroundImage = 'url(resources/icons/ViewService/checked.png)';
      }
      else {
        scope.doMainCard = false;
        doMainId.style.backgroundImage = 'url(resources/icons/ViewService/unchecked.png)';
      }
    };


    updateResultComponent = function (showResult, stepAmount, viewPage, status, text) {
      console.log("OPEN RESULT COMPONENT");

      if (showResult) {

        window.common.alert.updateView("componentResultId", {
          parent: scope,
          resulttext: text,
          viewpage: viewPage
        });
      } else {

        window.common.alert.hide("componentResultId");
      }
      scope.stepAmount = stepAmount;
      updateIcon(status, null, null, text, stepAmount, viewPage);
    };

    closeResultComponent = function () {
      console.log("CLOSE RESULT COMPONENT");
      window.common.alert.hide("componentResultId");
      scope.update();
    };

    initResultComponent = function () {
      console.log("INIT RESULT COMPONENT");
      window.common.alert.updateView("componentResultId", {
        parent: scope
      });
      scope.update();
    };


    createCardTouchStart = function (id) {

      createButtonStartX = event.changedTouches[0].pageX;
      createButtonStartY = event.changedTouches[0].pageY;

      document.getElementById(id).style.webkitTransform = 'scale(0.8)'
    };


    createCardTouchEnd = function (id) {
      event.preventDefault();
      event.stopPropagation();

      createButtonEndX = event.changedTouches[0].pageX;
      createButtonEndY = event.changedTouches[0].pageY;

      document.getElementById(id).style.webkitTransform = 'scale(1)';

      if (Math.abs(createButtonStartX - createButtonEndX) <= 20 && Math.abs(createButtonStartY - createButtonEndY) <= 20) {

        boxOne.blur();
        boxDate.blur();


        cardNumber = inputVerification.spaceDeleter(boxOne.value);
        dateOrPin = boxDate.value;

        console.log(cardNumber, dateOrPin);


        if (modeOfApp.offlineMode) {
          phonedialer.dial(
            "*880*0*" + cardNumber + '*' + dateOrPin + "%23",
            function (err) {
              if (err === "empty") {
                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: false,
                  errornote: "Unknown phone number"
                });
                scope.update();
              }
              else console.log("Dialer Error:" + err);
            },
            function (success) {
            }
          );
          return
        }


        initResultComponent();

        window.api.call({
          method: 'card.add',
          input: {
            phone_num: phoneNumber,
            card_number: cardNumber,
            card_data: dateOrPin,
            session_key: sessionKey
          },

          scope: this,

          onSuccess: function (result) {

            answerFromServer = true;
            if (result[0][0].error == 0) {
              console.log("CARD ADD", result);

              if (result[0][0].registered == 1) {
                viewMainPage.addFirstCardBool = false;
                var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
                localStorage.removeItem('cardNumber');
                localStorage.removeItem('click_client_countCard');
//                if (!loginInfo.default_account || loginInfo.default_account == 0) {
                if (result[0][0].default_account) {
                  loginInfo.default_account = result[0][0].default_account;
                  localStorage.setItem("click_client_loginInfo", JSON.stringify(loginInfo));
                  console.log("DEFAULT was set", loginInfo.default_account, localStorage.getItem("click_client_loginInfo"));
                }

                updateResultComponent(true, null, mainPageToReturn, 'success', result[0][0].error_note);

              } else if (result[0][0].registered == -1) {

                updateResultComponent(true, null, pageToReturnTwo, 'unsuccess', result[0][0].error_note);

              } else if (result[0][0].registered == 0) {
                window.common.alert.updateView("componentResultId", {
                  parent: scope,
                  resulttext: result[0][0].error_note,
                  viewpage: 'view-add-card'
                });
                scope.repeat = true;
                scope.checkId = result[0][0].check_id;
                updateIcon('waiting', scope.repeat, 'view-add-card');
                scope.update();

              }

            }
            else {
              updateResultComponent(true, null, mainPageToReturn, 'unsuccess', result[0][0].error_note);
            }
          },

          onFail: function (api_status, api_status_message, data) {
            updateResultComponent(true, null, mainPageToReturn, 'unsuccess', api_status_message);
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        }, 20000);

        setTimeout(function () {
          if (!answerFromServer) {
            updateResultComponent(true, null, mainPageToReturn, 'waiting', window.languages.WaitingTimeExpiredText);

            return
          }
        }, 20000)
      }

    };

    scope.cardAddCheck = cardAddCheck = function () {

      console.log(" scope.checkId=", scope.checkId);

      window.api.call({
        method: 'card.add.check',
        input: {
          phone_num: phoneNumber,
          session_key: sessionKey,
          check_id: scope.checkId
        },

        scope: this,

        onSuccess: function (result) {

          answerFromServer = true;
          if (result[0][0].error === 0) {
            console.log("CARD ADD CHECK", result);

            if (result[0][0].registered === 1) {
              viewMainPage.addFirstCardBool = false;
              localStorage.removeItem('cardNumber');
              localStorage.removeItem('click_client_countCard');
              var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
              if (!loginInfo.default_account || loginInfo.default_account === 0) {
                loginInfo.default_account = result[0][0].default_account;
                localStorage.setItem("click_client_loginInfo", JSON.stringify(loginInfo));
                console.log("DEFAULT was set", loginInfo.default_account, localStorage.getItem("click_client_loginInfo"));
              }
              updateResultComponent(true, null, mainPageToReturn, 'success', result[0][0].error_note);
            } else if (result[0][0].registered === -1) {

              updateResultComponent(true, null, pageToReturnTwo, 'unsuccess', result[0][0].error_note);

            } else if (result[0][0].registered === 0) {
              window.common.alert.updateView("componentResultId", {
                parent: scope,
                resulttext: result[0][0].error_note,
                viewpage: 'view-add-card'
              });
              scope.checkStatus = true;
              scope.checkId = result[0][0].check_id;
              updateIcon('waiting', scope.checkStatus, 'view-add-card');
              scope.update();
            }

          }
          else {
            updateResultComponent(true, null, mainPageToReturn, 'unsuccess', result[0][0].error_note);
          }
        },

        onFail: function (api_status, api_status_message, data) {
          updateResultComponent(true, null, mainPageToReturn, 'unsuccess', api_status_message);
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

    };


    checkForIconsAddCard = function () {

      //Check for processing icon

      processingIdInInput = boxOne.value.replace(/\s/g, '').substring(0, 4);
      if (processingId !== processingIdInInput) {
        processingId = processingIdInInput;
        processingIconFound = false;
        ///PROCESSING ICON

        scope.processingTypes.forEach(function (element) {

          console.log(processingId.substring(0, Number(element.prefix_length)), element.prefix);

          if (element.prefix == processingId.substring(0, Number(element.prefix_length))) {
            scope.processingImage = element.url;
            processingIconId.style.display = 'block';
            processingIconFound = true;
            isUzcard = element.prefix == "860";
          }
        });


        if (processingIconFound === false) {
          processingId = '';
          scope.processingImage = '';
          isUzcard = false;
          processingIconId.style.display = 'none';
        }
      }

      //Check for bank icon
      if (isUzcard) {
        bankIdInInput = boxOne.value.replace(/\s/g, '').substring(3, 6);
        if (bankId !== bankIdInInput) {
          bankId = bankIdInInput;
          bankIconFound = false;
          scope.allBankList.forEach(function (element) {
            if (element.code === bankId) {
              scope.bankImage = element.image;
              bankIconId.style.display = 'block';
              bankIconFound = true;
            }
          });
          if (bankIconFound === false) {
            bankId = '';
            scope.bankImage = '';
            bankIconId.style.display = 'none';
          }
        }
        if (boxOne.value.replace(/\s/g, '').length < 6) {
          bankId = '';
          scope.bankImage = '';
          bankIconId.style.display = 'none';
        }
      }

    };

    checkCardNumberLength = function () {

      if (boxOne.value.replace(/\s/g, '').length === 16 && boxDate.value.replace(/\s/g, '').length === 5) {
        scope.showBottomButton = true;
        boxOne.blur();
        boxDate.blur();
      } else {
        scope.showBottomButton = false;
      }
      scope.update();
    };

    boxOneChange = function () {
      event.preventDefault();
      event.stopPropagation();

      if (onPaste) {
        newCardWithoutSpace = inputVerification.spaceDeleter(event.target.value);
        boxOne.value = inputVerification.cardVerification(newCardWithoutSpace);
        onPaste = false;
      }

      checkForIconsAddCard();
      checkCardNumberLength();
      scope.update();
    }

    boxOnePaste = function () {
      onPaste = true;
    };


    boxOneKeyUp = function () {
      event.preventDefault();
      event.stopPropagation();

      boxCursorPositionSelectionStart = boxOne.selectionStart;
      boxCursorPositionSelectionEnd = boxOne.selectionEnd;
      oldValueOfBoxNumber = boxOne.value;


      if (boxOne.value.length <= 19 && (event.keyCode !== input_codes.BACKSPACE_CODE && event.keyCode !== input_codes.NEXT)) {
        boxOne.value = inputVerification.cardVerification(boxOne.value);

        if ((oldValueOfBoxNumber.length !== boxOne.value.length && inputVerification.spaceDeleter(oldValueOfBoxNumber) === inputVerification.spaceDeleter(boxOne.value)) ||
          boxCursorPositionSelectionStart % 5 === 4 && inputVerification.spaceDeleter(oldValueOfBoxNumber) !== inputVerification.spaceDeleter(boxOne.value)) {
          boxOne.selectionStart = boxCursorPositionSelectionStart + 1
          boxOne.selectionEnd = boxCursorPositionSelectionEnd + 1
        }
        else {
          boxOne.selectionStart = boxCursorPositionSelectionStart;
          boxOne.selectionEnd = boxCursorPositionSelectionEnd;
        }
      }

      if (boxOne.value.length === 19) {
        boxDate.autofocus
        boxDate.focus()
      }

      checkForIconsAddCard();
      checkCardNumberLength();
      scope.update();

    };


    boxOneKeyDown = function () {

      if (boxOne.value.length >= 19 && event.keyCode !== input_codes.BACKSPACE_CODE && event.keyCode !== input_codes.NEXT) {
        boxOne.value = event.target.value.substring(0, event.target.value.length - 1);
      }

    };

    boxDateKeyUp = function () {

      if (event.keyCode !== input_codes.BACKSPACE_CODE) {
        boxDate.value = inputVerification.dateVerification(boxDate.value)
      }

      checkCardNumberLength();
    };


    boxPinKeyUp = function () {

      if (event.keyCode !== 8 && pinCodeOfBank.length < 4) {
        pinCodeOfBank += event.key;
        console.log('pinCodeOfBank', pinCodeOfBank);
        stars += '*';
        boxPin.value = stars
      }
      else {
        if (event.keyCode === 8) {
          stars = stars.substring(0, stars.length - 1);
          pinCodeOfBank = pinCodeOfBank.substring(0, pinCodeOfBank.length - 1);
          boxPin.value = stars
        }
      }

      event.preventDefault()
    };


    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown();
      scope.unmount();
    };


    this.on('mount', function () {
      if (device.platform === 'iOS') {
        boxOne.autofocus;
        boxOne.focus()
      }
      else {
        setTimeout(function () {
          boxOne.focus()
        }, 0)
      }
    })


  </script>
</view-add-card>