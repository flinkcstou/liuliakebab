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
           ontouchstart="transferTypeTouchStart(this.id)">
        <div id="contactIconId"
             class="transfer-new-menu-contact-icon">
        </div>
        <p id="contactLabelId" class="transfer-new-menu-label-contact">
          {window.languages.ViewPayTransferNewContactName}</p>
      </div>
      <div id="card" class="transfer-new-menu-item"
           ontouchend="transferTypeTouchEnd(this.id)"
           ontouchstart="transferTypeTouchStart(this.id)">
        <div id="cardIconId" class="transfer-new-menu-card-icon">
        </div>
        <p id="cardLabelId" class="transfer-new-menu-label-card">
          {window.languages.ViewPayTransferNewCardName}</p>
      </div>
      <div id="between" class="transfer-new-menu-item"
           ontouchend="transferTypeTouchEnd(this.id)"
           ontouchstart="transferTypeTouchStart(this.id)">
        <div id="betweenIconId" class="transfer-new-menu-between-icon">
        </div>
        <p id="betweenLabelId" class="transfer-new-menu-label-between">
          {window.languages.ViewPayTransferNewBetweenName}</p>
      </div>
    </div>
    <div id="transferTypeCarousel"
         class="transfer-new-type-carousel"
         ontouchend="endTouchTransferTypeCarousel(this)"
         ontouchmove="moveTouchTransferTypeCarousel(this)"
         ontouchstart="startTouchTransferTypeCarousel()">
      <div id="transferType">
        <component-transfer-to-contact
          class="transfer-new-form-container"
          cardsarray="{cardsarray}"
          cardcounter="{cardCounter}"
          idcardfrommycards="{idCardFromMyCards}"
          id="contactForm">
        </component-transfer-to-contact>

        <component-transfer-to-card
          style="left: 100%"
          class="transfer-new-form-container"
          cardsarray="{cardsarray}"
          cardcounter="{cardCounter}"
          idcardfrommycards="{idCardFromMyCards}"
          id="cardForm">
        </component-transfer-to-card>

        <component-transfer-between
          style="left: 200%"
          class="transfer-new-form-container"
          cardsarray="{cardsarray}"
          cardcounter="{cardCounter}"
          idcardfrommycards="{idCardFromMyCards}"
          id="betweenForm">
        </component-transfer-between>
      </div>
    </div>

  </div>

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
    scope.idCardFromMyCards = -1;
    scope.cardsarray = [];
    scope.cardCounter = 0;
    scope.leftTransferType = 0;
    scope.deltaTransferType = 0;
    scope.transferTypeNumber = 0;
    scope.transferTypeCount = 2;
    scope.transitionRunning = false;
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
        console.log('opts in new transfers', opts);
        if (opts.transferType && opts.transferType === 'contact') {
          changeIconTransferByContact();
          scope.transferTypeNumber = 0;
          contactPhoneNumberId.value = inputVerification.telVerificationWithSpace(opts.phoneNumber.substr(3, opts.phoneNumber.length));
          contactPhoneBlurAndChange();
        }
        if (opts.transferType && opts.transferType === 'card') {
          console.log('open transfers to card')
          changeIconTransferByCard();
          scope.transferTypeNumber = 1;
          cardInputId.value = opts.cardNumber;
          cardBlurAndChange();
        }
        if (opts.idCardFromMyCards) {
          scope.idCardFromMyCards = opts.idCardFromMyCards;
          changeIconTransferByContact();
        }
        document.getElementById("transferType").style.transition = '0s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById("transferType").style.webkitTransition = '0s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById("transferType").style.transform = "translate3d(" + (-scope.transferTypeNumber * 720) * widthK + 'px' + ", 0, 0)";
        document.getElementById("transferType").style.webkitTransform = "translate3d(" + (-scope.transferTypeNumber * 720) * widthK + 'px' + ", 0, 0)";
      }
      else {
        if (JSON.parse(localStorage.getItem("tour_data")) && !JSON.parse(localStorage.getItem("tour_data")).transfer) {
          setTimeout(function () {
            cardInputId.blur();
            contactPhoneNumberId.blur();
            betweenAmountId.blur();
          }, 1);
          componentTourId.style.display = "block";
          scope.tourClosed = false;
          if (device.platform !== 'BrowserStand')
            StatusBar.backgroundColorByHexString("#004663");
        }
        else {
          changeIconTransferByContact();
          setTimeout(function () {
            contactPhoneNumberId.focus();
          }, 100);
        }
      }

      if (modeOfApp.offlineMode) {
        between.style.display = 'none';
        betweenForm.style.display = 'none';
        scope.transferTypeCount--;
        card.style.width = '50%';
        contact.style.width = '50%';
      }
      if (localStorage.getItem('click_client_countCard')) {
        scope.countCard = JSON.parse(localStorage.getItem('click_client_countCard'));
        if (scope.countCard < 3) {
          between.style.display = 'none';
          betweenForm.style.display = 'none';
          scope.transferTypeCount--;
          card.style.width = '50%';
          contact.style.width = '50%';
        }
      }
      if (localStorage.getItem('click_client_cards')) {
        scope.cardsarray = JSON.parse(localStorage.getItem('click_client_cards'));
        for (var i in scope.cardsarray) {
          if (scope.cardsarray[i].p2p_allowed == 0 || scope.cardsarray[i].access != 2) {
            delete scope.cardsarray[i];
          } else {
            scope.cardCounter++;
            scope.cardsarray[i].countCard = scope.cardCounter;
          }
        }
        if (scope.cardCounter < 2) {
          between.style.display = 'none';
          betweenForm.style.display = 'none';
          scope.transferTypeCount--;
          card.style.width = '50%';
          contact.style.width = '50%';
        }
      }
      transferType.addEventListener("webkitTransitionEnd", transitionEnd, true);
      transferType.addEventListener("webkitTransitionRun", transitionRun, true);
      transferType.addEventListener("webkitTransitionStart", transitionStart, true);
      scope.update();
    });

    {
      transitionEnd = function () {
        console.log('transitionEnd', scope.transferTypeNumber);
        if (scope.transferTypeNumber === 0) {
          changeIconTransferByContact();
          setTimeout(function () {
            contactPhoneNumberId.focus();
          }, 0);
        }
        if (scope.transferTypeNumber === 1) {
          changeIconTransferByCard();
          setTimeout(function () {
            cardInputId.focus();
          }, 0);
        }
        if (scope.transferTypeNumber === 2) {
          changeIconTransferByBetween();
          setTimeout(function () {
            betweenAmountId.focus();
          }, 0);
        }
        scope.transitionRunning = false;
      };
      transitionRun = function () {
        console.log('transitionRun');
      };
      transitionStart = function () {
        console.log('transitionStart');
        scope.transitionRunning = true;
      };

      //Choose transfer type
      startTouchTransferTypeCarousel = function () {
        transferTouchStartX = event.changedTouches[0].pageX;
        scope.leftTransferType = -((720 * scope.transferTypeNumber) * widthK) - transferTouchStartX;
        scope.deltaTransferType = scope.leftTransferType;
      };

      moveTouchTransferTypeCarousel = function (id) {
        console.log(id.childNodes[1].id);
        contactPhoneNumberId.blur();
        cardInputId.blur();
        betweenAmountId.blur();
        document.getElementById(id.childNodes[1].id).style.transition = '0s';
        document.getElementById(id.childNodes[1].id).style.webkitTransition = '0s';
        document.getElementById(id.childNodes[1].id).style.transform = "translate3d(" + (event.changedTouches[0].pageX + scope.deltaTransferType) + 'px' + ", 0, 0)";
        document.getElementById(id.childNodes[1].id).style.webkitTransform = "translate3d(" + (event.changedTouches[0].pageX + scope.deltaTransferType) + 'px' + ", 0, 0)";
      };

      endTouchTransferTypeCarousel = function (id) {
        transferTouchEndX = event.changedTouches[0].pageX;
        if (Math.abs(transferTouchStartX - transferTouchEndX) > 20) {
          transitionStart();
          changePositionTransferTypeCarousel(id.childNodes[1].id);
        }
      };

      changePositionTransferTypeCarousel = function (id) {
        if (transferTouchEndX < transferTouchStartX && scope.transferTypeNumber < scope.transferTypeCount) {
          console.log('if #1');
          ++scope.transferTypeNumber;
          document.getElementById(id).style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
          document.getElementById(id).style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
          document.getElementById(id).style.transform = "translate3d(" + (-scope.transferTypeNumber * 720) * widthK + 'px' + ", 0, 0)";
          document.getElementById(id).style.webkitTransform = "translate3d(" + (-scope.transferTypeNumber * 720) * widthK + 'px' + ", 0, 0)";
        }

        if (transferTouchEndX < transferTouchStartX && scope.transferTypeNumber >= scope.transferTypeCount) {
          console.log('if #2');
          document.getElementById(id).style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
          document.getElementById(id).style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
          document.getElementById(id).style.transform = "translate3d(" + (-scope.transferTypeNumber * 720) * widthK + 'px' + ", 0, 0)";
          document.getElementById(id).style.webkitTransform = "translate3d(" + (-scope.transferTypeNumber * 720) * widthK + 'px' + ", 0, 0)";
        }

        if (transferTouchEndX > transferTouchStartX && scope.transferTypeNumber > 0) {
          console.log('if #3');
          --scope.transferTypeNumber;
          document.getElementById(id).style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
          document.getElementById(id).style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
          document.getElementById(id).style.transform = "translate3d(" + (-scope.transferTypeNumber * 720) * widthK + 'px' + ", 0, 0)";
          document.getElementById(id).style.webkitTransform = "translate3d(" + (-scope.transferTypeNumber * 720) * widthK + 'px' + ", 0, 0)";
        }

        if (transferTouchEndX > transferTouchStartX && scope.transferTypeNumber === 0) {
          console.log('if #4');
          document.getElementById(id).style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
          document.getElementById(id).style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
          document.getElementById(id).style.transform = "translate3d(" + (-scope.transferTypeNumber * 720) * widthK + 'px' + ", 0, 0)";
          document.getElementById(id).style.webkitTransform = "translate3d(" + (-scope.transferTypeNumber * 720) * widthK + 'px' + ", 0, 0)";
        }
        scope.update();
      };

      transferTypeTouchStart = function (id) {
        event.preventDefault();
        event.stopPropagation();
        if (device.platform != 'BrowserStand')
          cordova.plugins.Keyboard.close();
        setTimeout(function () {
          contactPhoneNumberId.blur();
          cardInputId.blur();
          betweenAmountId.blur();
        }, 0);

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
            changeIconTransferByContact();
            scope.transferTypeNumber = 0;
            setTimeout(function () {
              if (scope.transferTypeNumber === 0 && !scope.transitionRunning)
                contactPhoneNumberId.focus();
            }, 500);
          }
          if (id === 'card') {
            changeIconTransferByCard();
            scope.transferTypeNumber = 1;
            setTimeout(function () {
              if (scope.transferTypeNumber === 1 && !scope.transitionRunning)
                cardInputId.focus();
            }, 500);
          }
          if (id === 'between') {
            changeIconTransferByBetween();
            scope.transferTypeNumber = 2;
            setTimeout(function () {
              if (scope.transferTypeNumber === 2 && !scope.transitionRunning)
                betweenAmountId.focus();
            }, 500);
          }
          document.getElementById("transferType").style.transition = '0s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
          document.getElementById("transferType").style.webkitTransition = '0s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
          document.getElementById("transferType").style.transform = "translate3d(" + (-scope.transferTypeNumber * 720) * widthK + 'px' + ", 0, 0)";
          document.getElementById("transferType").style.webkitTransform = "translate3d(" + (-scope.transferTypeNumber * 720) * widthK + 'px' + ", 0, 0)";
        }
      };

      //Make all labels and icons grey
      makeAllGrey = function () {
        if (device.platform != 'BrowserStand')
          cordova.plugins.Keyboard.close();
        setTimeout(function () {
          contactPhoneNumberId.blur();
          cardInputId.blur();
          betweenAmountId.blur();
        }, 0);
        contactLabelId.style.color = "#989898";
        cardLabelId.style.color = "#989898";
        betweenLabelId.style.color = "#989898";
        contactIconId.style.backgroundImage = 'url(resources/icons/ViewTransfer/touser2.png)';
        cardIconId.style.backgroundImage = 'url(resources/icons/ViewTransfer/tofriend2.png)';
        betweenIconId.style.backgroundImage = 'url(resources/icons/ViewTransfer/toown2.png)';
      };

      //change icon transfer by contact
      changeIconTransferByContact = function () {
        makeAllGrey();
        checkPhoneNumberLength();
        contactLabelId.style.color = "black";
        contactIconId.style.backgroundImage = 'url(resources/icons/ViewTransfer/touser1.png)';
      };

      //change icon transfer by card
      changeIconTransferByCard = function () {
        makeAllGrey();
        checkCardNumberLength();
        cardLabelId.style.color = "black";
        cardIconId.style.backgroundImage = 'url(resources/icons/ViewTransfer/tofriend1.png)';
      };

      //change icon transfer by between
      changeIconTransferByBetween = function () {
        makeAllGrey();
        betweenLabelId.style.color = "black";
        betweenIconId.style.backgroundImage = 'url(resources/icons/ViewTransfer/toown1.png)';
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
      changeIconTransferByContact();
      setTimeout(function () {
        contactPhoneNumberId.focus();
      }, 100);
    };

  </script>
</view-transfer-new>
