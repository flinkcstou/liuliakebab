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
    <div class="transfer-new-submit-receiver-container">
      <p class="transfer-new-submit-receiver-label">
        {window.languages.ViewPayTransferNewSubmitRecieverLabel}
        {receiver}
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
      <p if="{showPlaceHolderError && maxLimit && minLimit}" id="placeHolderSumId" class="transfer-new-between-input-commission">{placeHolderText}</p>
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

    <button if="{showBottomButton}"
            id="bottomButtonId"
            class="transfer-new-button-container"
            ontouchstart="onTouchStartOfNext()"
            ontouchend="onTouchEndOfNext()">
      {buttonText}
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
  <script>

    var scope = this;
    scope.titleName = window.languages.ViewPayTransferNewTitle;
    scope.buttonText = window.languages.ViewPayTransferNewContinue;
    scope.clickPinError = false;
    scope.showComponent = false;
    scope.allBankList = [];
    scope.showBottomButton = false;
    scope.receiver = '';
    scope.maxLimit;
    scope.minLimit;
    scope.tax = 0;
    scope.taxPercent = 0;
    scope.cardNumberTop = 0;
    scope.maskOne = /[0-9]/g;
    scope.maskTwo = /[0-9' ']/g;
    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view !== 'view-transfer-card-submit') {
      console.log("opts on saving history", opts);
      history.arrayOfHistory.push(
        {
          "view": 'view-transfer-card-submit',
          "params": opts,
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    if (JSON.parse(localStorage.getItem("click_client_p2p_all_bank_list"))) {
      scope.allBankList = JSON.parse(localStorage.getItem("click_client_p2p_all_bank_list"));
    }

    scope.on('mount', function () {
      console.log("opts on mount cardSubmit", opts);
      if (opts){
        if (opts.transferType === 'contact'){
          scope.receiver = opts.phoneNumber;
          scope.taxPercent = opts.taxPercent;
        }
        if (opts.transferType === 'card'){
          scope.receiver = opts.cardOwner;
          scope.taxPercent = opts.taxPercent;
          scope.maxLimit = opts.maxLimit;
          scope.minLimit = opts.minLimit;
        }
      }
    });
    {
      amountMouseUp = function () {
        event.preventDefault()
        event.stopPropagation()
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
          submitAmountIdValueId.value = 0;
        }
      };

      amountFocus = function () {
        event.preventDefault();
        event.stopPropagation();
        if (submitAmountId.value.length === 1 && submitAmountId.value[0] === 0) {
          submitAmountId.value = '';
        }
      };

      amountKeyUp = function () {
        console.log(scope);
        if (submitAmountId.value.length === 1) {
          submitAmountId.value = window.amountTransform(submitAmountId.value.toString());
        }

        if (event.keyCode === 8) {
          sumForTransfer = sumForTransfer.substring(0, sumForTransfer.length - 1);
        }

        if (submitAmountId.value.match(scope.maskTwo) !== null && submitAmountId.value.match(scope.maskTwo).length !== null) {

          submitAmountId.value = submitAmountId.value.substring(0, event.target.value.match(scope.maskTwo).length);
          submitAmountId.selectionStart = submitAmountId.value.match(scope.maskTwo).length;
          submitAmountId.selectionEnd = submitAmountId.value.match(scope.maskTwo).length;

          sumForTransfer = submitAmountId.value.substring(0, submitAmountId.value.match(scope.maskTwo).length);
          sumForTransfer = sumForTransfer.replace(new RegExp(' ', 'g'), '');

          submitAmountId.value = window.amountTransform(sumForTransfer.toString());
          submitAmountId.selectionStart = submitAmountId.value.match(scope.maskTwo).length;
          submitAmountId.selectionEnd = submitAmountId.value.match(scope.maskTwo).length;

        } else {
          submitAmountId.selectionStart = 0;
          submitAmountId.selectionEnd = 0;
        }

        if (sumForTransfer)
          scope.tax = sumForTransfer * scope.taxPercent / 100;
        else {
          scope.tax = 0
        }

        scope.showPlaceHolderError = false;

        if (scope.cardNumberTop !== 0){

        }

        if (sumForTransfer > scope.maxLimit) {
          scope.placeHolderText = 'Максимальная сумма ' + window.amountTransform(scope.maxLimit)
          scope.showPlaceHolderError = true;
        }
        if (sumForTransfer < scope.minLimit) {
          scope.placeHolderText = "Минимальная сумма " + window.amountTransform(scope.minLimit)
          scope.showPlaceHolderError = true;
        }
        scope.update()
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
        onBackParams.opts = opts;

        if (Math.abs(goToBackTransferTouchStartX - goToBackTransferTouchEndX) <= 20 && Math.abs(goToBackTransferTouchStartY - goToBackTransferTouchEndY) <= 20) {
          onBackKeyDown();
          scope.unmount();
        }
      }
    }

  </script>
</view-transfer-submit>
