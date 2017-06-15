<view-add-card class="riot-tags-main-container">

  <div class="add-card-page-title">
    <p class="add-card-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()" class="add-card-back-button"></div>
  </div>

  <div class="view-add-card">
    <p hidden if="{!modeOfApp.offlineMode}" class="add-card-text-field">{window.languages.ViewAddCardNameTitle}</p>
    <div hidden if="{!modeOfApp.offlineMode}" class="add-card-card-name-input-part-container">
      <input maxlength="25" class="add-card-card-name-input-part"/>
    </div>
    <div class="add-card-card-field">
      <div class="add-card-uzcard-icon"></div>
      <p class="add-card-card-text add-card-card-number-text">{window.languages.ViewAddCardNumberTitle}</p>
      <div id="cardNumberInput" class="add-card-card-number">
        <input type="tel" onkeyup="boxOneKeyUp()" onkeydown="boxOneKeyDown()" autofocus="true"
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

    <button class="view-add-next-button"
            ontouchend="createCardTouchEnd()">добавить
    </button>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}" viewpage="{viewPage}"></component-alert>

  <script>
    var scope = this;
    scope.showError = false;

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

    var dateOrPin = '';
    var cardNumber = ''
    createCardTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      boxOne.blur()

      cardNumber = inputVerification.spaceDeleter(boxOne.value)

      if (cardNumber.substring(0, 4) == '8600') {
        dateOrPin = boxDate.value;
      }
      else {
        dateOrPin = pinCodeOfBank;
      }

      console.log(cardNumber, dateOrPin)


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

      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = info.session_key;

      window.api.call({
        method: 'card.add',
        input: {
          phone_num: phoneNumber,
          card_number: cardNumber,
          card_data: dateOrPin,
          session_key: sessionKey,

        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            console.log("CARD ADD", result);

            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            scope.viewPage = 'view-main-page'
            scope.update();
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            scope.viewPage = ''
            scope.update();
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

    }

    boxOneKeyUp = function () {
      event.preventDefault()
      event.stopPropagation()

      if (boxOne.value.length == 19)
        boxDate.focus()

      if (boxOne.value.length <= 19 && (event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT))
        boxOne.value = inputVerification.cardVerification(boxOne.value);

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