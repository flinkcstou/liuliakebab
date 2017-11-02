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
      <div class="add-card-uzcard-icon"></div>
      <p class="add-card-card-text add-card-card-number-text">{window.languages.ViewAddCardNumberTitle}</p>
      <div id="cardNumberInput" class="add-card-card-number">
        <input type="tel" onpaste="boxOnePaste()" onkeyup="boxOneKeyUp()"
               onkeydown="boxOneKeyDown()" autofocus="true"
               id="boxOne"
               class="add-card-card-number-box add-card-card-number-box-one">
        </input>
      </div>

      <p id="cardDateInputTitleId" class="add-card-card-text add-card-card-text-date">
        {window.languages.ViewAddCardDateTitle}</p>
      <div id="cardDateInputId" class="add-card-card-date" type="text">
        <input type="tel" onkeyup="boxDateKeyUp()" onkeydown="boxDateKeyDown()" maxlength="5" id="boxDate"
               class="add-card-card-date-box">
        </input>
      </div>

      <p style="display: none" id="cardPinInputTitleId" class="add-card-card-text add-card-card-text-pin">
        {window.languages.ViewAddCardPinTitle}</p>
      <div style="display: none" id="cardPinInputId" class="add-card-card-pin">
        <input oninput="boxPinKeyUp()" onkeyup="boxPinKeyUp()" type="tel" maxlength="4" id="boxPin"
               class="add-card-card-date-pin-box">
        </input>
      </div>
    </div>

    <div hidden if="{!modeOfApp.offlineMode}" class="add-card-main-card-field">
      <p class="add-card-main-card-text">{window.languages.ViewAddCardDoMainTitle}</p>
      <div id="doMainId" class="add-card-main-card-icon" ontouchend="doMainCardTouchEnd()"></div>
    </div>

    <button id="createCardButtonId" class="view-add-next-button"
            ontouchstart="createCardTouchStart(this.id)" ontouchend="createCardTouchEnd(this.id)">добавить
    </button>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}" viewpage="{viewPage}"></component-alert>

  <component-result if="{window.componentFlags.result}" result="{result}" resulttext="{resultText}"
                    viewpage="{viewPage}"></component-result>
  <script>
    var scope = this;
    scope.showError = false;
    scope.showResult = false;
    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    var sessionKey = info.session_key;

    var mainPageToReturn = 'view-main-page', pageToReturnTwo = 'view-add-card';

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-add-card') {
      history.arrayOfHistory.push(
        {
          "view": 'view-add-card',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }


    scope.doMainCard = false;
    componentFlags.result = false;

    doMainCardTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      if (!scope.doMainCard) {
        scope.doMainCard = true;
        doMainId.style.backgroundImage = 'url(resources/icons/ViewService/checked.png)';
      }
      else {
        scope.doMainCard = false;
        doMainId.style.backgroundImage = 'url(resources/icons/ViewService/unchecked.png)';
      }
    }


    updateResultComponent = function (showResult, stepAmount, viewPage, status, text) {
      console.log("OPEN RESULT COMPONENT");
      window.componentFlags.result = showResult;
//      scope.showResult = showResult;
      scope.stepAmount = stepAmount;
      scope.viewPage = viewPage;
      scope.resultText = text;
      updateIcon(status);
      scope.update();
    }

    closeResultComponent = function () {
      console.log("CLOSE RESULT COMPONENT");
      window.componentFlags.result = false;
      scope.showResult = false;
      scope.update();
    }

    initResultComponent = function () {
      console.log("INIT RESULT COMPONENT");
      window.componentFlags.result = true;
      scope.showResult = true;
      scope.update();
    }

    var dateOrPin = '';
    var cardNumber = '';

    var createButtonStartX, createButtonEndX, createButtonStartY, createButtonEndY;

    createCardTouchStart = function (id) {

      createButtonStartX = event.changedTouches[0].pageX;
      createButtonStartY = event.changedTouches[0].pageY;

      document.getElementById(id).style.webkitTransform = 'scale(0.8)'
    }


    createCardTouchEnd = function (id) {
      event.preventDefault()
      event.stopPropagation()

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
              if (err == "empty") {
                scope.clickPinError = false;
                scope.errorNote = ("Unknown phone number");
                scope.showError = true;
                scope.update();
              }
              else console.log("Dialer Error:" + err);
            },
            function (success) {
            }
          );
          return
        }


        var answerFromServer = false;

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
                if (!loginInfo.default_account || loginInfo.default_account == 0) {
                  loginInfo.default_account = result[0][0].default_account;
                  localStorage.setItem("click_client_loginInfo", JSON.stringify(loginInfo));
                  console.log("DEFAULT was set", loginInfo.default_account, localStorage.getItem("click_client_loginInfo"));
                }

                updateResultComponent(true, null, mainPageToReturn, 'success', result[0][0].error_note);

              } else if (result[0][0].registered == -1) {

                updateResultComponent(true, null, pageToReturnTwo, 'unsuccess', result[0][0].error_note);

              } else if (result[0][0].registered == 0) {
                scope.resultText = result[0][0].error_note;
                scope.showResult = true;
                scope.repeat = true;
                scope.checkId = result[0][0].check_id;
                updateIcon('waiting', scope.repeat, 'view-add-card');
                scope.viewPage = 'view-add-card';
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

        setTimeout(function () {
          if (!answerFromServer) {
            updateResultComponent(true, null, mainPageToReturn, 'waiting', window.languages.WaitingTimeExpiredText);

            return
          }
        }, 20000)
      }

    }

    scope.cardAddCheck = cardAddCheck = function () {

      console.log(" scope.checkId=", scope.checkId)

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
          if (result[0][0].error == 0) {
            console.log("CARD ADD CHECK", result);

            if (result[0][0].registered == 1) {
              viewMainPage.addFirstCardBool = false;
              localStorage.removeItem('cardNumber');
              localStorage.removeItem('click_client_countCard');
              var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
              if (!loginInfo.default_account || loginInfo.default_account == 0) {
                loginInfo.default_account = result[0][0].default_account;
                localStorage.setItem("click_client_loginInfo", JSON.stringify(loginInfo));
                console.log("DEFAULT was set", loginInfo.default_account, localStorage.getItem("click_client_loginInfo"));
              }
              updateResultComponent(true, null, mainPageToReturn, 'success', result[0][0].error_note);
            } else if (result[0][0].registered == -1) {

              updateResultComponent(true, null, pageToReturnTwo, 'unsuccess', result[0][0].error_note);

            } else if (result[0][0].registered == 0) {
              scope.resultText = result[0][0].error_note;
              scope.showResult = true;
              scope.checkStatus = true;
              scope.checkId = result[0][0].check_id;
              updateIcon('waiting', scope.checkStatus, 'view-add-card');
              scope.viewPage = 'view-add-card';
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

    }

    var onPaste = false;
    var canFormatNumber = true;

    boxOnePaste = function () {
      onPaste = true;
    }

    var boxCursorPositionSelectionStart, boxCursorPositionSelectionEnd, oldValueOfBoxNumber;
    boxOneKeyUp = function () {
      event.preventDefault()
      event.stopPropagation()

      boxCursorPositionSelectionStart = boxOne.selectionStart;
      boxCursorPositionSelectionEnd = boxOne.selectionEnd;
      oldValueOfBoxNumber = boxOne.value


      if (boxOne.value.length <= 19 && (event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT)) {
        boxOne.value = inputVerification.cardVerification(boxOne.value);

        if ((oldValueOfBoxNumber.length != boxOne.value.length && inputVerification.spaceDeleter(oldValueOfBoxNumber) == inputVerification.spaceDeleter(boxOne.value)) ||
          boxCursorPositionSelectionStart % 5 == 4 && inputVerification.spaceDeleter(oldValueOfBoxNumber) != inputVerification.spaceDeleter(boxOne.value)) {
          boxOne.selectionStart = boxCursorPositionSelectionStart + 1
          boxOne.selectionEnd = boxCursorPositionSelectionEnd + 1
        }
        else {
          boxOne.selectionStart = boxCursorPositionSelectionStart
          boxOne.selectionEnd = boxCursorPositionSelectionEnd
        }
      }

      if (boxOne.value.length == 19) {
        boxDate.autofocus
        boxDate.focus()
      }

    }


    boxOneKeyDown = function () {

      if (boxOne.value.length >= 19 && event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT) {
        boxOne.value = event.target.value.substring(0, event.target.value.length - 1);
      }

    }


    boxDateKeyDown = function () {

    }

    boxDateKeyUp = function () {

      if (event.keyCode != input_codes.BACKSPACE_CODE) {
        boxDate.value = inputVerification.dateVerification(boxDate.value)
      }
    }

    var stars = '';
    var pinCodeOfBank = '';
    boxPinKeyUp = function () {


      if (event.keyCode != 8 && pinCodeOfBank.length < 4) {
        pinCodeOfBank += event.key;
        console.log('pinCodeOfBank', pinCodeOfBank)
        stars += '*'
        boxPin.value = stars
      }
      else {
        if (event.keyCode == 8) {
          stars = stars.substring(0, stars.length - 1)
          pinCodeOfBank = pinCodeOfBank.substring(0, pinCodeOfBank.length - 1)
          boxPin.value = stars
        }
      }

      event.preventDefault()
    }

    scope.titleName = window.languages.ViewAddCardTitle;

    goToBack = function () {
      event.preventDefault()
      event.stopPropagation()
      onBackKeyDown()
      scope.unmount();
    }


    this.on('mount', function () {
      if (device.platform == 'iOS') {
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