<view-transfer-new class="riot-tags-main-container">
  <div class="transfer-page-title">
    <p class="transfer-name-title">{window.languages.ViewPayTransferNewTitle}</p>
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
    <div id="menuContainerId" class="transfer-new-menu-container">
      <div id="contact" class="transfer-new-menu-item"
           ontouchend="transferTypeTouchEnd(this.id)"
           ontouchstart="transferTypeTouchStart(this.id)"
           activated="false">
        <div id="contactIconId"
             class="transfer-new-menu-contact-icon">
        </div>
        <p id="contactLabelId" class="transfer-new-menu-label-contact">
          {window.languages.ViewPayTransferNewContactName}</p>
      </div>
      <div id="card" class="transfer-new-menu-item"
           ontouchend="transferTypeTouchEnd(this.id)"
           ontouchstart="transferTypeTouchStart(this.id)"
           activated="false">
        <div id="cardIconId" class="transfer-new-menu-card-icon">
        </div>
        <p id="cardLabelId" class="transfer-new-menu-label-card">
          {window.languages.ViewPayTransferNewCardName}</p>
      </div>
      <div id="between" class="transfer-new-menu-item"
           ontouchend="transferTypeTouchEnd(this.id)"
           ontouchstart="transferTypeTouchStart(this.id)"
           activated="false">
        <div id="betweenIconId" class="transfer-new-menu-between-icon">
        </div>
        <p id="betweenLabelId" class="transfer-new-menu-label-between">
          {window.languages.ViewPayTransferNewBetweenName}</p>
      </div>
    </div>
    <component-transfer-to-contact
      style="display: none"
      class="transfer-new-form-container"
      id="contactForm">
    </component-transfer-to-contact>

    <component-transfer-to-card
      style="display: none"
      class="transfer-new-form-container"
      id="cardForm">
    </component-transfer-to-card>

    <component-transfer-between
      style="display: none"
      class="transfer-new-form-container"
      id="betweenForm">
    </component-transfer-between>

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

  <component-tour view="transfer" focusfield="{true}"></component-tour>
  <script>

    var scope = this;
    var transferTouchStartX,
      transferTouchStartY,
      transferTouchEndX,
      transferTouchEndY;

    scope.tourClosed = true;
    scope.clickPinError = false;
    scope.showComponent = false;
    scope.allBankList = [];
    scope.activatedType = '';
    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view !== 'view-transfer-new') {
      history.arrayOfHistory.push(
        {
          "view": 'view-transfer-new',
          "params": opts,
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }
    if (localStorage.getItem('click_client_loginInfo')) {
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
    }

    var phoneNumber = localStorage.getItem('click_client_phoneNumber');

    scope.on('mount', function () {
      if (opts && JSON.stringify(opts) !== '{}') {
        if (opts.transferType && opts.transferType === 'contact'){
          showTransferByContact();
          contactPhoneNumberId.value = inputVerification.telVerificationWithSpace(opts.phoneNumber.substr(3, opts.phoneNumber.length));
          contactPhoneBlurAndChange();
        }
        if (opts.transferType && opts.transferType === 'card'){
          showTransferByCard();
          cardInputId.value = opts.cardNumber;
          cardBlurAndChange();
        }
      }
      else {
        showTransferByContact();
      }
      if (JSON.parse(localStorage.getItem("tour_data")) && !JSON.parse(localStorage.getItem("tour_data")).transfer) {
        contactPhoneNumberId.blur();
        componentTourId.style.display = "block";
        scope.tourClosed = false;
        if (device.platform !== 'BrowserStand')
          StatusBar.backgroundColorByHexString("#004663");
      }

      if (localStorage.getItem('click_client_countCard')) {
        scope.countCard = JSON.parse(localStorage.getItem('click_client_countCard'));
        if (scope.countCard < 3){
          between.style.display = 'none';
          card.style.width = '50%';
          contact.style.width = '50%';
          console.log('small amount of cards');
        }
      }
    });
    {
      //Choose transfer type
      transferTypeTouchStart = function (id) {
        event.preventDefault();
        event.stopPropagation();

        document.getElementById(id).style.webkitTransform = 'scale(0.7)';

        transferTouchStartX = event.changedTouches[0].pageX;
        transferTouchStartY = event.changedTouches[0].pageY;
      };
      transferTypeTouchEnd = function (id) {
        event.preventDefault();
        event.stopPropagation();

        document.getElementById(id).style.webkitTransform = 'scale(1)';

        transferTouchEndX = event.changedTouches[0].pageX;
        transferTouchEndY = event.changedTouches[0].pageY;

        if (Math.abs(transferTouchStartX - transferTouchEndX) <= 20
          && Math.abs(transferTouchStartY - transferTouchEndY) <= 20) {
          makeAllGrey();
          if (id === 'contact') {
            showTransferByContact();
          }
          if (id === 'card') {
            showTransferByCard();
          }
          if (id === 'between') {
            showTransferByBetween();
          }
        }
      };

      //Make all labels and icons grey
      makeAllGrey = function () {
        contactLabelId.style.color = "#989898";
        cardLabelId.style.color = "#989898";
        betweenLabelId.style.color = "#989898";
        if (contact.getAttribute('activated') === 'true') {
          contactIconId.style.backgroundImage = 'url(resources/icons/ViewTransfer/touser2.png)';
          contact.setAttribute('activated', false);
        }
        if (card.getAttribute('activated') === 'true') {
          cardIconId.style.backgroundImage = 'url(resources/icons/ViewTransfer/tofriend2.png)';
          card.setAttribute('activated', false);
        }
        if (between.getAttribute('activated') === 'true') {
          betweenIconId.style.backgroundImage = 'url(resources/icons/ViewTransfer/toown2.png)';
          between.setAttribute('activated', false);
        }
        contactForm.style.display = "none";
        cardForm.style.display = "none";
        betweenForm.style.display = "none";
      };

      //Open transfer by contact
      showTransferByContact = function () {
        if (contact.getAttribute('activated') === 'false') {
          makeAllGrey();
          checkPhoneNumberLength();
          contactForm.style.display = "block";
          contactLabelId.style.color = "black";
          contactIconId.style.backgroundImage = 'url(resources/icons/ViewTransfer/touser1.png)';
          contact.setAttribute('activated', true);
          scope.activatedType = 'contact';
          setTimeout(function () {
            contactPhoneNumberId.autofocus = true;
            contactPhoneNumberId.focus();
          }, 0);
          scope.update();
        }
      };

      //Open transfer by card
      showTransferByCard = function () {
        if (card.getAttribute('activated') === 'false') {
          makeAllGrey();
          checkCardNumberLength();
          cardForm.style.display = "block";
          cardLabelId.style.color = "black";
          cardIconId.style.backgroundImage = 'url(resources/icons/ViewTransfer/tofriend1.png)';
          card.setAttribute('activated', true);
          scope.activatedType = 'card';
          setTimeout(function () {
            cardInputId.autofocus = true;
            cardInputId.focus();
          }, 0);
          scope.update();
        }
      };

      //Open transfer by between
      showTransferByBetween = function () {
        if (between.getAttribute('activated') === 'false') {
          makeAllGrey();
          betweenForm.style.display = "block";
          betweenLabelId.style.color = "black";
          betweenIconId.style.backgroundImage = 'url(resources/icons/ViewTransfer/toown1.png)';
          between.setAttribute('activated', true);
          scope.activatedType = 'between';
          setTimeout(function () {
            betweenAmountId.autofocus = true;
            betweenAmountId.focus();
          }, 0);
          scope.update();
        }
      };
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

        cardInputId.blur();
        contactPhoneNumberId.blur();
        betweenAmountId.blur();

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

      if (JSON.parse(localStorage.getItem("click_client_p2p_all_bank_list"))) {
        scope.allBankList = JSON.parse(localStorage.getItem("click_client_p2p_all_bank_list"));
      }

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

        if (Math.abs(goToBackTransferTouchStartX - goToBackTransferTouchEndX) <= 20 && Math.abs(goToBackTransferTouchStartY - goToBackTransferTouchEndY) <= 20) {
          onBackKeyDown();
          scope.unmount();
        }
      }
    }

    //Tour processing
    scope.focusFieldAfterTourClosed = focusFieldAfterTourClosed = function () {
      scope.tourClosed = true;
      setTimeout(function () {
        contactPhoneNumberId.autofocus = true;
        contactPhoneNumberId.focus();
      }, 0)
    };

  </script>
</view-transfer-new>
