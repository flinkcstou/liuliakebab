<view-add-card class="riot-tags-main-container">

  <div class="page-title">
    <p class="name-title">{titleName}</p>
    <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchend="goToBack()"
         class="back-button"></div>
    <div class="title-bottom-border">
    </div>
  </div>

  <div class="view-add-card">
    <p class="add-card-text-field">{window.languages.ViewAddCardNameTitle}</p>
    <div hidden if="{!modeOfApp.offlineMode}" class="add-card-card-name-input-part-container">
      <input maxlength="25" class="add-card-card-name-input-part"/>
    </div>


    <div class="add-card-card-field">
      <img id="cardDesignId" class="add-card-card-design">
      <div id="cardInputFieldsId" class="add-card-card-input-fields">
        <div id="processingIconId" class="add-card-uzcard-icon" style="background-image: url({processingImage});"></div>
        <p class="add-card-card-text add-card-card-number-text">{window.languages.ViewAddCardNumberTitle}</p>
        <div id="cardNumberInput" class="add-card-card-number">
          <input id="boxOne"
                 type="tel"
                 value="8600 "
                 onpaste="boxOnePaste()"
                 onkeyup="boxOneKeyUp()"
                 onkeydown="boxOneKeyDown()"
                 autofocus="true"
                 oninput="boxOneChange()"
                 onfocus="var temp_value=this.value; this.value=''; this.value=temp_value"
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
    </div>


    <div hidden if="{!modeOfApp.offlineMode}" class="add-card-main-card-field">
      <p class="add-card-main-card-text">{window.languages.ViewAddCardDoMainTitle}</p>
      <div id="doMainId" class="add-card-main-card-icon" ontouchend="doMainCardTouchEnd()"></div>
    </div>


    <button if="{showBottomButton}"
            id="bottomButtonId"
            class="bottom-button-container"
            style="bottom: {window.bottomButtonBottom};"
            ontouchstart="createCardTouchStart(this.id)"
            ontouchend="createCardTouchEnd(this.id)">
      {window.languages.ViewAddCardAddBtnText}
    </button>

  </div>

  <script>
    var scope = this;
    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var dateOrPin = '';
    var cardNumber = '';
    var createButtonStartX,
      createButtonEndX,
      createButtonStartY,
      createButtonEndY;
    var mainPageToReturn = 'view-main-page',
      pageToReturnTwo = 'view-add-card';
    var timeOutTimer = 0;
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
    scope.local_card_background_dir = 'resources/icons/cards/';
    if (localStorage.getItem('click_client_loginInfo')) {
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
      scope.processingTypes = loginInfo.card_prefixes;
    }
    scope.showBottomButton = false;
    viewMainPage.atMainPage = false;

    window.saveHistory('view-add-card', opts);

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

            console.log('Clearing timer onSuccess', timeOutTimer);
            window.clearTimeout(timeOutTimer);
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
            console.log('Clearing timer onFail', timeOutTimer);
            window.clearTimeout(timeOutTimer);
            updateResultComponent(true, null, mainPageToReturn, 'unsuccess', api_status_message);
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          },
          onTimeOut: function () {
            timeOutTimer = setTimeout(function () {
              window.writeLog({
                reason: 'Timeout',
                method: 'card.add',
              });
              updateResultComponent(true, null, mainPageToReturn, 'waiting', window.languages.WaitingTimeExpiredText);
            }, 20000)
          },
          onEmergencyStop: function () {
            console.log('Clearing timer emergencyStop', timeOutTimer);
            window.clearTimeout(timeOutTimer);
          }
        }, 20000);
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

          console.log('Clearing timer onSuccess', timeOutTimer);
          window.clearTimeout(timeOutTimer);
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
          console.log('Clearing timer onSuccess', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          updateResultComponent(true, null, mainPageToReturn, 'unsuccess', api_status_message);
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

    };


    checkForIconsAddCard = function () {

      if (JSON.parse(localStorage.getItem('click_client_issuer_list'))) {
        if (scope.issuerList !== JSON.parse(localStorage.getItem('click_client_issuer_list')))
          scope.issuerList = JSON.parse(localStorage.getItem('click_client_issuer_list'));
        var currentIssuer = {};
        processingIconFound = false;
        bankIconFound = false;
        scope.issuerList.forEach(function (issuer) {
          processingIdInInput = boxOne.value.replace(/\s/g, '').substring(0, parseInt(issuer.prefix_length));
          if (issuer.prefix === processingIdInInput) {
            scope.processingImage = issuer.url;
            if (device.platform == 'iOS') {
              processingIconId.style.display = 'block';
            }
            processingIconFound = true;
            currentIssuer = issuer;
          }
        });
        if (processingIconFound) {
          bankIdInInput = boxOne.value.replace(/\s/g, '').substring(parseInt(currentIssuer.code_start) - 1,
            parseInt(currentIssuer.code_start) + parseInt(currentIssuer.code_length) - 1);
          currentIssuer.item.forEach(function (bank) {
            if (bank.code === bankIdInInput) {
              scope.bankImage = bank.image;
              if (device.platform == 'iOS') {
                bankIconId.style.display = 'block';
              }
              bankIconFound = true;
              var url_splitted = bank.card_background_url.toString().split("/");
              var background_file_name = url_splitted[url_splitted.length - 1];
              cardDesignId.src = scope.local_card_background_dir + background_file_name;
              console.log(scope.local_card_background_dir + background_file_name);
              checkImageExists(cardDesignId.src, function (exists) {
                if (exists) {

                  if (device.platform != 'iOS') {
                    if (cardDesignId.className.indexOf('add-card-card-design-appear') === -1) {
                      cardDesignId.classList.add('add-card-card-design-appear');
                      cardInputFieldsId.classList.add('add-card-card-input-fields-reduce');
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
            if (cardDesignId.className.indexOf('add-card-card-design-appear') !== -1) {
              cardDesignId.classList.remove('add-card-card-design-appear');
              cardInputFieldsId.classList.remove('add-card-card-input-fields-reduce');
              cardInputFieldsId.style.color = '';
            }
          }
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
    });

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
</view-add-card>