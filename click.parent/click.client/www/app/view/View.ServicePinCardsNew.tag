<view-service-pincards-new class="view-service-pincards riot-tags-main-container">

  <div class="pay-page-title" style="border-style: none;">
    <p class="{servicepage-title :opts.mode!='ADDAUTOPAY', autopay-method-page-title:opts.mode=='ADDAUTOPAY'}">
      {(opts.mode=='ADDAUTOPAY')?(window.languages.ViewAutoPayTitleName):("")}
      {titleName}</p>
    <p class="servicepage-category-field">{(opts.mode=='ADDAUTOPAY')?
      (autoPayTypeText):(categoryName)}</p>
    <div id="pinCardBackButtonId" role="button" aria-label="{window.languages.Back}" ontouchend="touchStartTitle()"
         ontouchstart="onTouchStartOfBack()"
         class="{servicepage-button-back:opts.mode!='ADDAUTOPAY', autopay-method-back-button:opts.mode=='ADDAUTOPAY'}">
    </div>
    <div type="button" class="servicepage-service-icon" if="{opts.mode=='ADDAUTOPAY'}"
         style="background-image: url({serviceIcon})"></div>
  </div>

  <div class="pincard-body-container">
    <div class="pincard-payfrom-container">
      <p class="pincard-payfrom-field">{window.languages.ViewServicePinCardPayFromField}</p></div>

    <component-pincards clean="{!friendHelpBool}" useFor="payment"></component-pincards>
    <div class="pincard-bottom-container">

      <div class="pincard-friend-help-container" if="{!friendHelpBool && opts.mode!='ADDAUTOPAY'}"
           ontouchend="friendHelp()">
        <div class="pincard-friend-help-icon"></div>
        <div class="pincard-friend-help-text">{window.languages.ViewServicePinCardHelpText}</div>
      </div>


      <div class="pincard-chosen-friend-container" if="{friendHelpBool && opts.mode!='ADDAUTOPAY'}">
        <div class="pincard-friend-help-text-two">{window.languages.ViewServicePinCardHelpText}</div>
        <div class="pincard-chosen-friend-inner-container">
          <div class="pincard-chosen-friend-photo" style="background-image: url({photo})">
            {firstLetterOfName}
          </div>
          <div class="pincard-chosen-friend-text-container">
            <div class="pincard-chosen-friend-text-one">{fName} {lName}</div>
            <div class="pincard-chosen-friend-text-two">+{phoneNumber.substring(0, 3) + ' ' +
              inputVerification.telVerificationWithSpace(phoneNumber.substring(3, phoneNumber.length))}
            </div>
          </div>

          <div class="pincard-chosen-friend-edit-icon"
               ontouchend="friendHelp()"></div>
          <div class="pincard-chosen-friend-radio-icon" ontouchstart="friendRadioTouchStart()"
               ontouchend="friendRadioTouchEnd()"></div>

        </div>
      </div>

      <button id="enterPinCardButtonId" class="pincard-button-enter" ontouchstart="onTouchStartOfEnterCard()"
              ontouchend="goToPayConfirmView()">{window.languages.ViewServicePageEnterLabel}
      </button>

    </div>
  </div>

  <component-tour view="friendhelp"></component-tour>

  <script>

    window.saveHistory('view-service-pincards-new', opts);

    var scope = this;

    var backStartY, backStartX, backEndY, backEndX;

    console.log("OPTS in ServicePinCards", opts)

    scope.onTouchStartOfBack = onTouchStartOfBack = function () {
      event.stopPropagation();

      pinCardBackButtonId.style.webkitTransform = 'scale(0.7)'

      backStartY = event.changedTouches[0].pageY;
      backStartX = event.changedTouches[0].pageX;
    };

    touchStartTitle = function () {
      event.stopPropagation();

      pinCardBackButtonId.style.webkitTransform = 'scale(1)'

      backEndY = event.changedTouches[0].pageY;
      backEndX = event.changedTouches[0].pageX;

      if (Math.abs(backStartY - backEndY) <= 20 && Math.abs(backStartX - backEndX) <= 20) {
        event.preventDefault();
        event.stopPropagation();
        onBackParams.opts = JSON.parse(JSON.stringify(opts));
        onBackKeyDown();
        scope.unmount()
      }
    };

    this.on('mount', function () {

      if (JSON.parse(localStorage.getItem("tour_data")) && !JSON.parse(localStorage.getItem("tour_data")).friendhelp) {
        componentTourId.style.display = "block";
        if (device.platform != 'BrowserStand')
          StatusBar.backgroundColorByHexString("#004663");
      }
    });

    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.categoryNamesMap = (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) ? (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) : (offlineCategoryNamesMap);
    console.log("servicesMap=", scope.servicesMap);
    scope.service = scope.servicesMap[opts.chosenServiceId][0];
    this.titleName = scope.service.name;
    this.serviceIcon = scope.service.image;
    this.categoryName = scope.categoryNamesMap[scope.service.category_id].name;
    onBackParams.opts = JSON.parse(JSON.stringify(opts));


    if (opts.mode == 'ADDAUTOPAY') {
      scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
      this.autoPayTypeText = scope.autoPayData.title;
      console.log("autoPayType=", this.autoPayTypeText);
    }

    var enterCardStartY, enterCardStartX, enterCardEndY, enterCardEndX;

    scope.onTouchStartOfEnterCard = onTouchStartOfEnterCard = function () {
      event.stopPropagation();

      enterPinCardButtonId.style.webkitTransform = 'scale(0.8)'

      enterCardStartY = event.changedTouches[0].pageY;
      enterCardStartX = event.changedTouches[0].pageX;
    };


    var friendRadioStartY, friendRadioStartX, friendRadioEndY, friendRadioEndX;

    friendRadioTouchStart = function () {
      event.stopPropagation();

      friendRadioStartY = event.changedTouches[0].pageY;
      friendRadioStartX = event.changedTouches[0].pageX;
    }

    friendRadioTouchEnd = function () {
      event.stopPropagation();

      friendRadioEndY = event.changedTouches[0].pageY;
      friendRadioEndX = event.changedTouches[0].pageX;

      if (Math.abs(friendRadioStartY - friendRadioEndY) <= 20 && Math.abs(friendRadioStartX - friendRadioEndX) <= 20) {
        viewServicePinCards.friendHelpPaymentMode = false;
        scope.friendHelpBool = false;
        scope.tags["component-pincards"].cleanChosenCards();
        scope.update(scope.friendHelpBool);
      }

    }


    goToPayConfirmView = function () {

      event.stopPropagation();

      enterPinCardButtonId.style.webkitTransform = 'scale(1)'

      enterCardEndY = event.changedTouches[0].pageY;
      enterCardEndX = event.changedTouches[0].pageX;

      if (Math.abs(enterCardStartY - enterCardEndY) <= 20 && Math.abs(enterCardStartX - enterCardEndX) <= 20) {

        var cardSumFromPinCards = scope.tags['component-pincards'].getAccountCardSum();
        console.log(cardSumFromPinCards, opts.amountText)
        var cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
        scope.update()
        var sumEnough = opts.cost ? (cardSumFromPinCards < parseInt(opts.amountText) * opts.cost) : (cardSumFromPinCards < parseInt(opts.amountText));
        console.log("sunEnough=", sumEnough)
        if (cardSumFromPinCards && sumEnough && opts.mode != 'ADDAUTOPAY') {
          console.log(cardSumFromPinCards, opts.amountText)
          scope.clickPinError = false;
          scope.errorNote = "На выбранной карте недостаточно средств";

          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote,
          });
          riot.update();
          return;
        }
        cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
        console.log("cardsArray=", cardsArray);
        console.log("BOOL=", scope.friendHelpBool);
        if (scope.friendHelpBool) {
          opts.payByCard = false;
          opts.chosenFriendForHelp = opts.chosenFriendForHelp ? opts.chosenFriendForHelp : viewServicePinCards.chosenFriendForHelp;
          scope.checked = true;
          event.preventDefault();
          event.stopPropagation();
          onBackParams.opts = JSON.parse(JSON.stringify(opts));
          this.riotTags.innerHTML = "<view-pay-confirm-new>";
          riot.mount('view-pay-confirm-new', opts);
          scope.unmount()
        } else {
          for (var i in cardsArray) {
            if (cardsArray[i].chosenCard && cardsArray[i].access == 2) {
              opts.chosenCardId = cardsArray[i].card_id;
              opts.payByCard = true;
              scope.checked = true;
              event.preventDefault();
              event.stopPropagation();
              onBackParams.opts = JSON.parse(JSON.stringify(opts));
              this.riotTags.innerHTML = "<view-pay-confirm-new>";
              riot.mount('view-pay-confirm-new', opts);
              scope.unmount();
            }
          }
        }
        if (!scope.checked) {
          scope.clickPinError = false;
          scope.errorNote = "Выберите карту для оплаты";

          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote,
          });

          scope.update();
          return;
        }
      }
    };

    friendHelp = function () {

      if (modeOfApp.demoVersion) {
        var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
//        confirm(question)
        scope.confirmNote = question;
        scope.confirmType = 'local';

        window.common.alert.show("componentConfirmId", {
          "confirmnote": scope.confirmNote,
          "confirmtype": scope.confirmType,
          parent: scope,
        });

        scope.result = function (bool) {
          if (bool) {
            localStorage.clear();
            window.location = 'index.html'
            scope.unmount()
            return
          }
        };
        scope.update();
        return
      }

      viewServicePinCards.friendHelpPaymentMode = true;
//      viewServicePinCards.chosenFriendForHelp = null;
//      opts.chosenFriendForHelp = null;
      event.preventDefault();
      event.stopPropagation();
      onBackParams.opts = JSON.parse(JSON.stringify(opts));
      this.riotTags.innerHTML = "<view-friend-help-settings>";
      riot.mount('view-friend-help-settings', opts);
      scope.unmount()
    };

    if (viewServicePinCards.friendHelpPaymentMode && viewServicePinCards.chosenFriendForHelp) {
//    if (opts.chosenFriendForHelp) {
//      console.log("AAA");
      scope.friendHelpBool = true;
      scope.firstLetterOfName = viewServicePinCards.chosenFriendForHelp.firstLetterOfName;
      scope.fName = viewServicePinCards.chosenFriendForHelp.name;
      scope.phoneNumber = viewServicePinCards.chosenFriendForHelp.number;
      scope.photo = viewServicePinCards.chosenFriendForHelp.photo;

      scope.update();
    } else {
//      console.log("BBB");
      scope.friendHelpBool = false;
    }

    refreshFunction = function (bool) {
      scope.friendHelpBool = bool;
      scope.update(scope.friendHelpBool);
    }

  </script>
</view-service-pincards-new>
