<view-service-pincards-new class="view-service-pincards riot-tags-main-container">

  <div class="pay-page-title" style="border-style: none;">
    <p class="{servicepage-title :opts.mode!='ADDAUTOPAY', autopay-method-page-title:opts.mode=='ADDAUTOPAY'}">
      {(opts.mode=='ADDAUTOPAY')?(window.languages.ViewAutoPayTitleName):("")}
      {titleName}</p>
    <p class="servicepage-category-field">{(opts.mode=='ADDAUTOPAY')?
      (autoPayTypeText):(categoryName)}</p>
    <div ontouchend="touchStartTitle()"
         class="{servicepage-button-back:opts.mode!='ADDAUTOPAY', autopay-method-back-button:opts.mode=='ADDAUTOPAY'}">
    </div>
    <div type="button" class="servicepage-service-icon" if="{opts.mode=='ADDAUTOPAY'}"
         style="background-image: url({serviceIcon})"></div>
  </div>

  <div class="pincard-body-container">
    <div class="pincard-payfrom-container">
      <p class="pincard-payfrom-field">{window.languages.ViewServicePinCardPayFromField}</p></div>

    <component-pincards clean="{true}"></component-pincards>
    <div class="pincard-bottom-container">

      <div class="pincard-friend-help-container" if="{!friendHelpBool && opts.mode!='ADDAUTOPAY'}"
           ontouchend="friendHelp()">
        <div class="pincard-friend-help-icon"></div>
        <div class="pincard-friend-help-text">{window.languages.ViewServicePinCardHelpText}</div>
      </div>


      <div class="pincard-chosen-friend-container" if="{friendHelpBool && opts.mode!='ADDAUTOPAY'}">
        <div class="pincard-friend-help-text-two">{window.languages.ViewServicePinCardHelpText}</div>
        <div class="pincard-chosen-friend-inner-container"
             ontouchend="firstSuggestionBlock()">
          <div class="pincard-chosen-friend-photo" style="background-image: url({photo})">
            {firstLetterOfName}
          </div>
          <div class="pincard-chosen-friend-text-container">
            <div class="pincard-chosen-friend-text-one">{fName} {lName}</div>
          </div>
          <div class="pincard-chosen-friend-text-two">+{phoneNumber}</div>
        </div>
        <div class="pincard-friend-change-text" ontouchend="friendHelp()">Изменить</div>
      </div>

      <button class="pincard-button-enter"
              ontouchend="goToPayConfirmView()">{window.languages.ViewServicePageEnterLabel}
      </button>

    </div>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>
  <component-confirm if="{confirmShowBool}" confirmnote="{confirmNote}"
                     confirmtype="{confirmType}"></component-confirm>

  <component-tour view="friendhelp"></component-tour>

  <script>


    console.log('OPTS in PINCARDS NEW ', opts);


    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-service-pincards-new') {
      history.arrayOfHistory.push(
        {
          "view": 'view-service-pincards-new',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    var scope = this;
    scope.showError = false;
    touchStartTitle = function () {
      event.preventDefault();
      event.stopPropagation();
      if (opts.mode == 'USUAL')
        onBackKeyDownWithParams(opts, 1);
      else
        onBackKeyDown();
      scope.unmount()
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


    if (opts.mode == 'ADDAUTOPAY') {
      scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
      this.autoPayTypeText = scope.autoPayData.title;
      console.log("autoPayType=", this.autoPayTypeText);
    }


    goToPayConfirmView = function () {

      var cardSumFromPinCards = scope.tags['component-pincards'].getAccountCardSum();
      console.log(cardSumFromPinCards, opts.amountText)
      var cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
      scope.update()
      if (cardSumFromPinCards && cardSumFromPinCards < parseInt(opts.amountText)) {
        console.log(cardSumFromPinCards, opts.amountText)
        scope.clickPinError = false;
        scope.errorNote = "На выбранной карте недостаточно средств";
        scope.showError = true;
        riot.update();
        return;
      }
      cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
      console.log("cardsArray=", cardsArray);
      console.log("BOOL=", scope.friendHelpBool);
      if (scope.friendHelpBool) {
        opts.payByCard = false;
        opts.chosenFriendForHelp = viewServicePinCards.chosenFriendForHelp;
        scope.checked = true;
        event.preventDefault();
        event.stopPropagation();
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
            this.riotTags.innerHTML = "<view-pay-confirm-new>";
            riot.mount('view-pay-confirm-new', opts);
            scope.unmount();
          }
        }
      }
      if (!scope.checked) {
        scope.clickPinError = false;
        scope.errorNote = "Выберите карту для оплаты";
        scope.showError = true;
        scope.update();
        return;
      }
    };

    friendHelp = function () {

      if (modeOfApp.demoVersion) {
        var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
//        confirm(question)
        scope.confirmShowBool = true;
        scope.confirmNote = question;
        scope.confirmType = 'local';
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
      viewServicePinCards.chosenFriendForHelp = null;
      event.preventDefault();
      event.stopPropagation();
      this.riotTags.innerHTML = "<view-friend-help-settings>";
      riot.mount('view-friend-help-settings', opts);
      scope.unmount()
    };

    if (viewServicePinCards.friendHelpPaymentMode && viewServicePinCards.chosenFriendForHelp) {
//      console.log("AAA");
      scope.friendHelpBool = true;
      if (viewServicePinCards.chosenFriendForHelp) {
        scope.firstLetterOfName = viewServicePinCards.chosenFriendForHelp.firstLetterOfName;
        scope.fName = viewServicePinCards.chosenFriendForHelp.name;
        scope.phoneNumber = viewServicePinCards.chosenFriendForHelp.number;
        scope.photo = viewServicePinCards.chosenFriendForHelp.photo;
      }
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
