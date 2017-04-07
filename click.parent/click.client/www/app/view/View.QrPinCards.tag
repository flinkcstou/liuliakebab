<view-qr-pincards class="view-service-pincards">

  <div class="qr-pay-page-title" style="border-style: none;">
    <p class="qr-servicepage-title">{titleName}</p>
    <p class="qr-servicepage-category-field">{categoryName}</p>
    <div ontouchend="touchStartTitle()"
         class="qr-servicepage-button-back">
    </div>
    <div type="button" class="qr-servicepage-service-icon"
         style="background-image: url({serviceIcon})"></div>
  </div>

  <div class="qr-pincard-body-container">
    <div class="qr-pincard-payfrom-container">
      <p class="qr-pincard-payfrom-field">{window.languages.ViewServicePinCardPayFromField}</p></div>

    <component-pincards friendhelpbool="{friendHelpBool}"></component-pincards>
    <div class="qr-pincard-bottom-container">

      <div class="qr-pincard-friend-help-container" if="{!friendHelpBool}" ontouchend="friendHelp()">
        <div class="qr-pincard-friend-help-icon"></div>
        <div class="qr-pincard-friend-help-text">{window.languages.ViewServicePinCardHelpText}</div>
      </div>


      <div class="qr-pincard-chosen-friend-container" if="{friendHelpBool}">
        <div class="qr-pincard-friend-help-text-two">{window.languages.ViewServicePinCardHelpText}</div>
        <div class="qr-pincard-chosen-friend-inner-container"
             ontouchend="firstSuggestionBlock()">
          <div class="qr-pincard-chosen-friend-photo" style="background-image: url({photo})">
            {firstLetterOfName}
          </div>
          <div class="qr-pincard-chosen-friend-text-container">
            <div class="qr-pincard-chosen-friend-text-one">{fName} {lName}</div>
          </div>
          <div class="qr-pincard-chosen-friend-text-two">{phoneNumber}</div>
        </div>
        <div class="qr-pincard-friend-change-text" ontouchend="friendHelp()">Изменить</div>
      </div>

      <div class="qr-pincard-button-enter"
           ontouchend="goToQrPayConfirmView()">
        {window.languages.ViewServicePageEnterLabel}
      </div>

    </div>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>


    console.log('OPTS', opts);


    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-qr-pincards') {
      history.arrayOfHistory.push(
        {
          "view": 'view-qr-pincards',
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

    this.titleName = opts.name
    this.serviceIcon = opts.image

    this.categoryName = opts.name


    goToQrPayConfirmView = function () {
      event.preventDefault();
      event.stopPropagation();

      cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
      console.log("cardsArray=", cardsArray);
      console.log("BOOL=", scope.friendHelpBool);
      if (scope.friendHelpBool) {
        scope.checked = true;
        event.preventDefault();
        event.stopPropagation();
        this.riotTags.innerHTML = "<view-qr-pay-confirm>";
        riot.mount('view-qr-pay-confirm', [false, viewServicePinCards.chosenFriendForHelp, opts]);
      } else {
        for (var i in cardsArray) {
          if (cardsArray[i].chosenCard && cardsArray[i].access == 2) {
            scope.chosencardId = cardsArray[i].card_id;
            scope.checked = true;
            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-qr-pay-confirm>";
            riot.mount('view-qr-pay-confirm', [true, scope.chosencardId, opts]);
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
      console.log("AAA");
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
</view-qr-pincards>
