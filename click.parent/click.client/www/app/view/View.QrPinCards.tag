<view-qr-pincards class="view-service-pincards riot-tags-main-container">

  <div class="qr-pay-page-title" style="border-style: none;">
    <p class="qr-servicepage-title  {qr-servicepage-qr-title: !opts.location}">{titleName}</p>
    <p class="qr-servicepage-category-field">{categoryName}</p>
    <div ontouchend="touchStartTitle()"
         class="qr-servicepage-button-back" role="button" aria-label="{window.languages.Back}">
    </div>
    <div type="button" class="qr-servicepage-service-icon"
         style="background-image: url({serviceIcon})"></div>
  </div>

  <div class="qr-pincard-body-container">
    <div class="qr-pincard-payfrom-container">
      <p class="qr-pincard-payfrom-field">{window.languages.ViewServicePinCardPayFromField}</p></div>

    <component-pincards clean="{true}" friendhelpbool="{friendHelpBool}" useFor="payment"></component-pincards>
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

      <button class="qr-pincard-button-enter"
              ontouchend="goToQrPayConfirmView()">
        {window.languages.ViewServicePageEnterLabel}
      </button>

    </div>
  </div>

  <script>

    console.log('OPTS', opts);

    window.saveHistory('view-qr-pincards', opts);

    var scope = this;

    touchStartTitle = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
      scope.unmount()
    };

    this.titleName = opts.name;
    this.serviceIcon = opts.image;
    this.categoryName = opts.location ? opts.category_name : "";


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

        scope.unmount()
      } else {
        for (var i in cardsArray) {
          if (cardsArray[i].chosenCard && cardsArray[i].access == 2) {
            scope.chosencardId = cardsArray[i].card_id;
            scope.checked = true;
            event.preventDefault();
            event.stopPropagation();

            var cardSumFromPinCards = scope.tags['component-pincards'].getAccountCardSum();

            if (cardSumFromPinCards && cardSumFromPinCards < parseInt(opts.qrSum)) {
              console.log(cardSumFromPinCards, opts.qrSum)
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

            this.riotTags.innerHTML = "<view-qr-pay-confirm>";
            riot.mount('view-qr-pay-confirm', [true, scope.chosencardId, opts]);
            scope.unmount()
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

    friendHelp = function () {
      viewServicePinCards.friendHelpPaymentMode = true;
      viewServicePinCards.chosenFriendForHelp = null;
      event.preventDefault();
      event.stopPropagation();
      this.riotTags.innerHTML = "<view-friend-help-settings>";
      riot.mount('view-friend-help-settings', {from: "view-qr"});
//      scope.unmount()
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
</view-qr-pincards>
