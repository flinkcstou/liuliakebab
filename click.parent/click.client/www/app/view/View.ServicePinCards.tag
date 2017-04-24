<view-service-pincards class="view-service-pincards">

  <div class="pay-page-title" style="border-style: none;">
    <p class="{servicepage-title :opts[8]!='ADDAUTOPAY', autopay-method-page-title:opts[8]=='ADDAUTOPAY'}">
      {(opts[8]=='ADDAUTOPAY')?(window.languages.ViewAutoPayTitleName):("")}
      {titleName}</p>
    <p class="servicepage-category-field">{(opts[8]=='ADDAUTOPAY')?
      (autoPayTypeText):(categoryName)}</p>
    <div ontouchend="touchStartTitle()"
         class="{servicepage-button-back:opts[8]!='ADDAUTOPAY', autopay-method-back-button:opts[8]=='ADDAUTOPAY'}">
    </div>
    <div type="button" class="servicepage-service-icon" if="{opts[8]=='ADDAUTOPAY'}"
         style="background-image: url({serviceIcon})"></div>
  </div>

  <div class="pincard-body-container">
    <div class="pincard-payfrom-container">
      <p class="pincard-payfrom-field">{window.languages.ViewServicePinCardPayFromField}</p></div>

    <component-pincards clean="{true}"></component-pincards>
    <div class="pincard-bottom-container">

      <div class="pincard-friend-help-container" if="{!friendHelpBool && opts[8]!='ADDAUTOPAY'}"
           ontouchend="friendHelp()">
        <div class="pincard-friend-help-icon"></div>
        <div class="pincard-friend-help-text">{window.languages.ViewServicePinCardHelpText}</div>
      </div>


      <div class="pincard-chosen-friend-container" if="{friendHelpBool && opts[8]!='ADDAUTOPAY'}">
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

  <script>


    console.log('OPTS', opts);
    var arrayForPay = [];
    arrayForPay.push(opts[0]);
    arrayForPay.push(opts[1]);
    arrayForPay.push(opts[2]);
    arrayForPay.push(opts[3]);
    arrayForPay.push(opts[4]);
    arrayForPay.push(opts[5]);
    arrayForPay.push(opts[6]);
    arrayForPay.push(opts[7]);
    //    8 - mode for titlename
    arrayForPay.push(opts[8]);
    console.log(arrayForPay);

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-service-pincards') {
      history.arrayOfHistory.push(
        {
          "view": 'view-service-pincards',
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
      onBackKeyDown()
    };

    scope.servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
    scope.service = scope.servicesMap[viewPay.chosenServiceId][0];
    scope.categoryNamesMap = JSON.parse(localStorage.getItem("click_client_categoryNamesMap"));

    if (opts[8] == 'ADDAUTOPAY') {
      this.autoPayTypeText = localStorage.getItem('autoPayType');
      console.log("autoPayType=", this.autoPayTypeText);
    }

    this.titleName = scope.service.name;
    this.serviceIcon = scope.service.image;
    this.categoryName = scope.categoryNamesMap[scope.service.category_id].name;


    goToPayConfirmView = function () {

      var cardSumFromPinCards = scope.tags['component-pincards'].getAccountCardSum();
      console.log(cardSumFromPinCards, arrayForPay[5].amountText)
      cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
      riot.update()
      if (cardSumFromPinCards && cardSumFromPinCards < parseInt(arrayForPay[5].amountText)) {
        console.log(cardSumFromPinCards, arrayForPay[5].amountText)
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
        scope.checked = true;
        event.preventDefault();
        event.stopPropagation();
        this.riotTags.innerHTML = "<view-pay-confirm>";
        riot.mount('view-pay-confirm', [arrayForPay, false, viewServicePinCards.chosenFriendForHelp]);
      } else {
        for (var i in cardsArray) {
          if (cardsArray[i].chosenCard && cardsArray[i].access == 2) {
            scope.chosencardId = cardsArray[i].card_id;
            scope.checked = true;
            event.preventDefault();
            event.stopPropagation();
            if (opts[8] == 'ADDAUTOPAY') {
              this.riotTags.innerHTML = "<view-autopay-name>";
              riot.mount('view-autopay-name', [arrayForPay, true, scope.chosencardId]);

            } else {
              this.riotTags.innerHTML = "<view-pay-confirm>";
              riot.mount('view-pay-confirm', [arrayForPay, true, scope.chosencardId]);
            }
          }
        }
      }
      if (!scope.checked) {
        scope.clickPinError = false;
        scope.errorNote = "Выберите карту для оплаты";
        scope.showError = true;
        riot.update();
        return;

      }

    }

    friendHelp = function () {
      viewServicePinCards.friendHelpPaymentMode = true;
      viewServicePinCards.chosenFriendForHelp = null;
      event.preventDefault();
      event.stopPropagation();
      this.riotTags.innerHTML = "<view-friend-help-settings>";
      riot.mount('view-friend-help-settings');
    }

    if (viewServicePinCards.friendHelpPaymentMode && viewServicePinCards.chosenFriendForHelp) {
//      console.log("AAA");
      scope.friendHelpBool = true;
      if (viewServicePinCards.chosenFriendForHelp) {
        scope.firstLetterOfName = viewServicePinCards.chosenFriendForHelp.firstLetterOfName;
        scope.fName = viewServicePinCards.chosenFriendForHelp.name;
        scope.phoneNumber = viewServicePinCards.chosenFriendForHelp.number;
        scope.photo = viewServicePinCards.chosenFriendForHelp.photo;
      }
      riot.update();
    } else {
//      console.log("BBB");
      scope.friendHelpBool = false;
    }

    refreshFunction = function (bool) {
      scope.friendHelpBool = bool;
      riot.update(scope.friendHelpBool);
    }

  </script>
</view-service-pincards>
