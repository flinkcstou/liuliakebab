<view-transfer-by-card class="riot-tags-main-container">
  <div class="transfer-page-title">
    <p class="transfer-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBackFromTransferByCardTouchEnd()" ontouchstart="goToBackFromTransferByCardTouchStart()"
         class="transfer-back-button" role="button" aria-label="{window.languages.Back}">
    </div>
    <div if="{modeOfApp.onlineMode}" id="rightButton" role="button"
         aria-label="{window.languages.ViewBankListTitleName}" type="button"
         class="transfer-i-button"
         ontouchend="openBanksListPageTouchEnd()" ontouchstart="openBanksListPageTouchStart()">
    </div>
  </div>

  <div class="transfer-body-container">
    <div id="cardInputFieldId" class="transfer-new-contact-body-container">
      <div class="transfer-contact-phone-field">
        <p class="transfer-contact-text-field">{window.languages.ViewPayTransferNewCardTextField}</p>
        <input
          id="cardInputId"
          class="transfer-card-number-input-part"
          type="tel"
          onpaste="onPasteTrigger()"
          oninput="cardPhoneBlurAndChange('onInput')"
          onchange="cardPhoneBlurAndChange()"
          onfocus="cardPhoneBlurAndChange()"
          onkeyup="cardOnKeyUp()"
          onkeydown="searchCard(this)"/>
      </div>
      <div hidden id="ownerCardDisplayId" class="transfer-card-owner-container">
        <p class="transfer-card-owner-title" style="display:inline">{window.languages.ViewPayTransferCardOwnerTitle}</p>
        <p class="transfer-card-owner-info">{cardOwner}</p>
      </div>
    </div>
    <button id="nextButtonId" class="transfer-next-button-inner-container"
            ontouchstart="goToTransferStepTwoTouchStart()"
            ontouchend="goToTransferStepTwoTouchEnd()">
      {window.languages.ViewPayTransferNext}
    </button>
  </div>

  <div hidden="{!showComponent}" id="componentBankListId" class="component-bank-list">
    <div class="page-title" style="border: none;">
      <p class="component-banklist-name-title">{window.languages.ViewBankListTitleName}</p>
      <div id="closeBankListButtonId" type="button" class="component-banklist-close-button"
           ontouchend="closeComponentBankListTouchEnd()" ontouchstart="closeComponentBankListTouchStart()"></div>
    </div>
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
  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"
                   pathtosettings="{pathToSettings}"
                   permissionerror="{permissionError}"></component-alert>

  <component-confirm if="{confirmShowBool}" confirmnote="{confirmNote}"
                     confirmtype="{confirmType}"></component-confirm>

  <component-tour view="transfer" focusfield="{true}"></component-tour>
  <script>

    viewTransfer.check = true;
    this.titleName = window.languages.ViewPayTransferByCardNumberTitle;
    var scope = this;
    scope.tourClosed = true;
    scope.clickPinError = false;
    scope.showError = false;
    scope.showComponent = false;
    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view !== 'view-transfer-by-card') {
      history.arrayOfHistory.push(
        {
          "view": 'view-transfer-by-card',
          "params": opts,
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
    }
    if (localStorage.getItem('click_client_loginInfo')) {
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
    }
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');

    this.on('mount', function () {
      if (JSON.parse(localStorage.getItem("tour_data")) && !JSON.parse(localStorage.getItem("tour_data")).transfer) {
        componentTourId.style.display = "block";
        scope.tourClosed = false;
        if (device.platform !== 'BrowserStand')
          StatusBar.backgroundColorByHexString("#004663");
      }
      nextButtonId.style.display = 'none';
    });

    //CardInput and card owner finder
    {
      var onPaste = false;
      var cardStopChanging = false;
      scope.cardOwner = '';

      onPasteTrigger = function () {
        onPaste = true;
      };
      contactPhoneBlurAndChange = function (from) {
        event.preventDefault();
        event.stopPropagation();
        scope.update();
      };
      cardPhoneBlurAndChange = function () {
        event.preventDefault();
        event.stopPropagation();

        if (onPaste) {
          var cardWithoutSpace = inputVerification.spaceDeleter(event.target.value)
          cardInputId.value = inputVerification.cardVerification(cardWithoutSpace)
          onPaste = false;
        }
        if (cardInputId.value.replace(/\s/g, '').length === 16) {
          cardOwnerFunction();
          nextButtonId.style.display = 'block';
        }
        else
          nextButtonId.style.display = 'none';
        scope.update();
      };
      cardOnKeyUp = function () {
        var arrayOfCards = [];

        if (cardStopChanging) {
          cardInputId.value = event.target.value.substring(0, event.target.value.length - 1);
        }

        cardCursorPositionSelectionStart = cardInputId.selectionStart;
        cardCursorPositionSelectionEnd = cardInputId.selectionEnd;
        cardOldValueOfNumber = cardInputId.value

        if (cardInputId.value.length <= 19
          && (event.keyCode !== input_codes.BACKSPACE_CODE
          && event.keyCode !== input_codes.NEXT)) {
          cardInputId.value = inputVerification.cardVerification(cardInputId.value);

          if (cardOldValueOfNumber.length !== cardInputId.value.length &&
            inputVerification.spaceDeleter(cardOldValueOfNumber) === inputVerification.spaceDeleter(cardInputId.value)) {
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

        if (cardInputId.value.replace(/\s/g, '').length === 16) {
          cardOwnerFunction();
          console.log(cardInputId.value.replace(/\s/g, '').length)
          nextButtonId.style.display = 'block';
          return;
        }
        else {
          nextButtonId.style.display = 'none';
          ownerCardDisplayId.style.display = 'none';

          if (cardInputId.value.length === 0) {
            return;
          }
        }

        checkCardForTransfer = true;
        event.preventDefault();
        event.stopPropagation();

        var countOfFound = 0;
        var check = false;

        if (event.keyCode !== 16 && event.keyCode !== 18)
          scope.searchWord = event.target.value.replace(/\s/g, '');

        scope.update()
      };
      cardOwnerFunction = function () {
        var phoneNumber = localStorage.getItem('click_client_phoneNumber');

        if (JSON.parse(localStorage.getItem('click_client_loginInfo')))
          var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;

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
                    ownerCardDisplayId.style.display = 'block'
                }
                scope.update()
              }
              catch (error) {
                console.log(error)
              }
            }
            else {
              scope.errorNote = result[0][0].error_note;
              scope.showError = true;
              scope.update();
            }
          },
          onFail: function (api_status, api_status_message, data) {
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });
      }
      searchCard = function (input) {

        checkPhoneForTransfer = false;
        checkCardForTransfer = true;

        cardStopChanging = input.value.length >= 19
          && event.keyCode !== input_codes.BACKSPACE_CODE
          && event.keyCode !== input_codes.NEXT;
      }
    }

    //Info about banks
    {
      var openBankListTouchStartX, openBankListTouchStartY, openBankListTouchEndX, openBankListTouchEndY;
      openBanksListPageTouchStart = function () {
        event.preventDefault();
        event.stopPropagation();

        rightButton.style.webkitTransform = 'scale(0.8)';

        openBankListTouchStartX = event.changedTouches[0].pageX
        openBankListTouchStartY = event.changedTouches[0].pageY
      }

      bankListTouchMove = function () {
        event.preventDefault();
        event.stopPropagation();
      }

      openBanksListPageTouchEnd = function () {
        event.preventDefault();
        event.stopPropagation();

        rightButton.style.webkitTransform = 'scale(1)';

        openBankListTouchEndX = event.changedTouches[0].pageX
        openBankListTouchEndY = event.changedTouches[0].pageY

        if (Math.abs(openBankListTouchStartX - openBankListTouchEndX) <= 20 && Math.abs(openBankListTouchStartY - openBankListTouchEndY) <= 20) {

          if (modeOfApp.offlineMode)return;

          if (modeOfApp.demoVersion) {
            var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
            scope.showError = true;
            scope.errorNote = question;
            scope.confirmType = 'local';
            scope.update();
            return;
          }

          if (JSON.parse(localStorage.getItem("click_client_p2p_bank_list"))) {
            scope.bankList = JSON.parse(localStorage.getItem("click_client_p2p_bank_list"));
          }
          scope.showComponent = true
          window.checkShowingComponent = scope;
          scope.update();
        }
      };

      if (loginInfo)
        if (!localStorage.getItem("click_client_p2p_bank_list") || loginInfo.update_bank_list) {
          if (modeOfApp.onlineMode)
            window.api.call({
              method: 'p2p.bank.list',
              input: {
                session_key: sessionKey,
                phone_num: phoneNumber,
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
                  }
                }
                else {
                  scope.errorNote = result[0][0].error_note;
                  scope.showError = true;
                  scope.update();
                }
              },

              onFail: function (api_status, api_status_message, data) {
                console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                console.error(data);
              }
            });
        }

      var closeBankListTouchStartX, closeBankListTouchStartY, closeBankListTouchEndX, closeBankListTouchEndY;

      closeComponentBankListTouchStart = function () {
        event.preventDefault();
        event.stopPropagation();

        closeBankListButtonId.style.webkitTransform = 'scale(0.8)'

        closeBankListTouchStartX = event.changedTouches[0].pageX
        closeBankListTouchStartY = event.changedTouches[0].pageY
      }

      closeComponentBankListTouchEnd = function () {
        event.preventDefault();
        event.stopPropagation();

        closeBankListButtonId.style.webkitTransform = 'scale(1)'

        closeBankListTouchEndX = event.changedTouches[0].pageX
        closeBankListTouchEndY = event.changedTouches[0].pageY

        if (Math.abs(closeBankListTouchStartX - closeBankListTouchEndX) <= 20 && Math.abs(closeBankListTouchStartY - closeBankListTouchEndY) <= 20) {
          bankListContainerId.scrollTop = 0;
          scope.showComponent = false;
          window.checkShowingComponent = null;
          scope.update()
        }
      }

      var flipCardTouchStartX, flipCardTouchStartY, flipCardTouchEndX, flipCardTouchEndY, pointerInOffer = false;

      flipCardTouchStart = function () {
        flipCardTouchStartX = event.changedTouches[0].pageX
        flipCardTouchStartY = event.changedTouches[0].pageY
      }

      flipCardTouchEnd = function (object) {
        flipCardTouchEndX = event.changedTouches[0].pageX
        flipCardTouchEndY = event.changedTouches[0].pageY

        var publicOfferContainer = object.getElementsByClassName("component-banklist-public-offer-container")[0];
        var publicOfferId = publicOfferContainer.id;
        var publicOfferRect = document.getElementById(publicOfferId).getBoundingClientRect();
        var publicOfferHidden = publicOfferContainer.hidden;

        if (Math.abs(flipCardTouchStartX - flipCardTouchEndX) <= 20 &&
          Math.abs(flipCardTouchStartY - flipCardTouchEndY) <= 20 && !pointerInOffer) {

          var rotated = object.style.transform;
          if (rotated === "rotateY(-180deg)") {
            if (!publicOfferHidden) {
              if (publicOfferRect.top > flipCardTouchEndY)
                object.style.transform = "rotateY(0deg)";
            }
            else {
              object.style.transform = "rotateY(0deg)";
            }
          }
          else
            object.style.transform = "rotateY(-180deg)";
        }
      }

      openPublicOffer = function (LinkToPublicOffer) {
        console.log("Link to Offer", LinkToPublicOffer);
        window.open(LinkToPublicOffer, '_system', 'location=no');
      }
    }

    //Go back from transfer
    {
      var goToBackTransferTouchStartX, goToBackTransferTouchStartY,
        goToBackTransferTouchEndX, goToBackTransferTouchEndY;

      goToBackFromTransferByCardTouchStart = function () {
        event.preventDefault();
        event.stopPropagation();

        backButton.style.webkitTransform = 'scale(0.8)'

        goToBackTransferTouchStartX = event.changedTouches[0].pageX
        goToBackTransferTouchStartY = event.changedTouches[0].pageY
      }

      goToBackFromTransferByCardTouchEnd = function () {
        event.preventDefault();
        event.stopPropagation();

        backButton.style.webkitTransform = 'scale(1)'

        goToBackTransferTouchEndX = event.changedTouches[0].pageX
        goToBackTransferTouchEndY = event.changedTouches[0].pageY

        if (Math.abs(goToBackTransferTouchStartX - goToBackTransferTouchEndX) <= 20 && Math.abs(goToBackTransferTouchStartY - goToBackTransferTouchEndY) <= 20) {
          onBackKeyDown();
          scope.unmount();
        }
      }
    }

  </script>
</view-transfer-by-card>
