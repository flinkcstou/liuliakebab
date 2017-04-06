<view-qr-pincards class="view-service-pincards">

  <div class="pay-page-title" style="border-style: none;">
    <p class="servicepage-title">{titleName}</p>
    <p class="servicepage-category-field">{categoryName}</p>
    <div ontouchend="touchStartTitle()"
         class="servicepage-button-back">
    </div>
    <div type="button" class="servicepage-service-icon"
         style="background-image: url({serviceIcon})"></div>
  </div>

  <div class="pincard-body-container">
    <div class="pincard-payfrom-container">
      <p class="pincard-payfrom-field">{window.languages.ViewServicePinCardPayFromField}</p></div>

    <component-pincards></component-pincards>
    <div class="pincard-bottom-container">

      <div class="pincard-friend-help-container" if="{!friendHelpBool}" ontouchend="friendHelp()">
        <div class="pincard-friend-help-icon"></div>
        <div class="pincard-friend-help-text">{window.languages.ViewServicePinCardHelpText}</div>
      </div>


      <div class="pincard-chosen-friend-container" if="{friendHelpBool}">
        <div class="pincard-friend-help-text-two">{window.languages.ViewServicePinCardHelpText}</div>
        <div class="pincard-chosen-friend-inner-container"
             ontouchend="firstSuggestionBlock()">
          <div class="pincard-chosen-friend-photo" style="background-image: url({photo})">
            {firstLetterOfName}
          </div>
          <div class="pincard-chosen-friend-text-container">
            <div class="pincard-chosen-friend-text-one">{fName} {lName}</div>
          </div>
          <div class="pincard-chosen-friend-text-two">{phoneNumber}</div>
        </div>
        <div class="pincard-friend-change-text" ontouchend="friendHelp()">Изменить</div>
      </div>

      <div class="pincard-button-enter"
           ontouchend="goToPayConfirmView()">
        <div class="pincard-button-enter-label">{window.languages.ViewServicePageEnterLabel}</div>
      </div>

    </div>
  </div>
  <component-alert clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>
  <script>


    console.log('OPTS', opts);
    var arrayForTransfer = [];
    arrayForTransfer.push(opts[0]);
    arrayForTransfer.push(opts[1]);
    arrayForTransfer.push(opts[2]);
    arrayForTransfer.push(opts[3]);
    arrayForTransfer.push(opts[4]);
    arrayForTransfer.push(opts[5]);
    arrayForTransfer.push(opts[6]);
    arrayForTransfer.push(opts[7]);
    console.log(arrayForTransfer);

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
    touchStartTitle = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    };

    scope.servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
    scope.service = scope.servicesMap[viewPay.chosenServiceId][0];
    scope.categoryNamesMap = JSON.parse(localStorage.getItem("click_client_categoryNamesMap"));


    this.titleName = scope.service.name;
    this.serviceIcon = scope.service.image;

    this.categoryName = scope.categoryNamesMap[scope.service.category_id].name;


    goToPayConfirmView = function () {
      cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
      console.log("cardsArray=", cardsArray);
      for (var i in cardsArray) {
        if (cardsArray[i].chosenCard && cardsArray[i].access == 2) {
          scope.chosencardId = cardsArray[i].card_id;
          scope.checked = true;
          break;
        }
      }
      if (!scope.checked) {
        scope.clickPinError = false;
        scope.errorNote = "Выберите карту для оплаты";
        riot.update();
        componentAlertId.style.display = 'block';
        return;
      }
      event.preventDefault();
      event.stopPropagation();
      this.riotTags.innerHTML = "<view-pay-confirm>";
      riot.mount('view-pay-confirm', [arrayForTransfer, scope.chosencardId]);
    }

    friendHelp = function () {
      viewServicePinCards.friendHelpPaymentMode = true;
      event.preventDefault();
      event.stopPropagation();
      this.riotTags.innerHTML = "<view-friend-help-settings>";
      riot.mount('view-friend-help-settings');
    }

    if (viewServicePinCards.friendHelpPaymentMode) {
      console.log("AAA");
      scope.friendHelpBool = true;
      if (viewServicePinCards.chosenFriendForHelp) {
        scope.firstLetterOfName = viewServicePinCards.chosenFriendForHelp.firstLetterOfName;
        scope.fName = viewServicePinCards.chosenFriendForHelp.name;
        scope.phoneNumber = viewServicePinCards.chosenFriendForHelp.number;
        scope.photo = viewServicePinCards.chosenFriendForHelp.photo;
      }
    } else {
      console.log("BBB");
      scope.friendHelpBool = false;
    }


  </script>
</view-qr-pincards>
