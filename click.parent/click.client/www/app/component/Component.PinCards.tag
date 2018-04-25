<component-pincards>

  <div
    class="pincard-allcards-container {changed-height-for-payment-detail: opts.paymentdetail,
                                        transfer-on-card-pincard-all-cards-container: opts.transferoncard,
                                        changed-height-for-filter-account: opts.filteraccount}">
    <div class="pincard-card-container" each="{i in cardsArray}"
         ontouchend="chooseCardTouchEnd(this.id)"
         ontouchstart="chooseCardTouchStart()"
         id="{i.card_id}" if="{i.access == 2}">
      <div class="pincard-card-logo-container"
           style="background-image: url({i.url})"></div>
      <div class="pincard-card-info-container">
        <p class="pincard-card-info-text-one">{i.name}</p>
        <p if="{i.salaryOriginal > 0}" class="pincard-card-info-text-two" if="{i.salaryOriginal>0}">{i.salary}<span class="pincard-card-balance-fractional">{i.salary_fractional}</span>
          {i.currency}</p>
        <p class="pincard-card-info-text-two" style="color: #EB604D"
           if="{i.salaryOriginal<=0 && !modeOfflineMode.check}">
          0 {i.currency}</p>
        <p class="pincard-card-info-text-three">{i.numberPartOne} **** {i.numberPartTwo}</p>
      </div>
      <div id="check{i.card_id}"
           class="{pincard-card-uncheckmark: 'check'+i.card_id != checkedId, pincard-card-checkmark: 'check'+i.card_id == checkedId}">
      </div>
      <div class="title-bottom-border">
      </div>
    </div>

  </div>

  <script>
    var scope = this;

    scope.cardsArray = localStorage.getItem('click_client_cards') ? JSON.parse(localStorage.getItem('click_client_cards')) : [];
    checkCardPermissionAndBalance();

    scope.checked = false;
    scope.cardId = undefined;
    scope.cardSum = 0;
    scope.index = -1;
    var pinCardtouchStartY, pinCardtouchEndY;

    scope.on("mount", function () {
      for (var i in scope.cardsArray) {
        if (scope.cardsArray[i].chosenCard == true && scope.cardsArray[i].access == 2) {
          scope.cardId = scope.cardsArray[i].card_id;
          scope.cardName = scope.cardsArray[i].name;
          scope.cardSum = scope.cardsArray[i].salaryOriginal
        }
      }
    });

    if (viewServicePinCards.friendHelpPaymentMode && viewServicePinCards.chosenFriendForHelp) {

      for (var i in scope.cardsArray) {
        if (scope.cardsArray[i].chosenCard == true && scope.cardsArray[i].access == 2) {
          scope.cardsArray[i].chosenCard = false;
        }
      }
    }
    else {
      for (var i in scope.cardsArray) {
        if (scope.cardsArray[i].chosenCard == true && scope.cardsArray[i].access == 2) {
          scope.checkedId = "check" + scope.cardsArray[i].card_id;
        }
      }
    }


    chooseCardTouchStart = function () {
      pinCardtouchStartY = event.changedTouches[0].pageY;
    };


    chooseCardTouchEnd = function (id) {
      event.preventDefault();
      event.stopPropagation();

      scope.cardId = id;

      pinCardtouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(pinCardtouchStartY - pinCardtouchEndY) < 20) {

        scope.checkedId = "check" + id;

        if (viewServicePinCards.friendHelpPaymentMode && viewServicePinCards.chosenFriendForHelp) {
          scope.parent.refreshFunction(false);
          viewServicePinCards.friendHelpPaymentMode = false;
          viewServicePinCards.chosenFriendForHelp = null;
        }


        for (var i in scope.cardsArray) {
          if (scope.cardsArray[i].card_id == id && scope.cardsArray[i].access == 2) {
            scope.cardsArray[i].chosenCard = true;
            scope.cardName = scope.cardsArray[i].name;
            scope.cardSum = scope.cardsArray[i].salaryOriginal
          }
          else
            scope.cardsArray[i].chosenCard = false;
        }

        localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsArray));
        scope.update(scope.cardsArray)
      }
      else return

    };

    scope.cleanChosenCards = function () {

      scope.checkedId = '';
      var checkChosenCard = false;
      var indexOfCard = 0;

      for (var i in scope.cardsArray) {

        if (!scope.cardsArray[i].default_account) {
          if (scope.cardsArray[i].chosenCard) {
            scope.cardsArray[i].chosenCard = true;
            scope.cardName = scope.cardsArray[i].name;
            scope.cardSum = scope.cardsArray[i].salaryOriginal
            scope.checkedId = "check" + scope.cardsArray[i].card_id;
            checkChosenCard = true;
          }
        }
        else {
          indexOfCard = i;
        }
      }

      if (!checkChosenCard && scope.cardsArray[indexOfCard]) {
        scope.cardsArray[indexOfCard].chosenCard = true;
        scope.cardName = scope.cardsArray[indexOfCard].name;
        scope.cardSum = scope.cardsArray[indexOfCard].salaryOriginal;
        scope.checkedId = "check" + scope.cardsArray[indexOfCard].card_id;
      }

      localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsArray));
      riot.update();
    };


    if (scope.opts.clean && viewMainPage.myCards !== true && scope.cardsArray.length > 0) {
      scope.cleanChosenCards();
    }

    scope.getAccountCardId = function () {

      return scope.cardId;
    };

    scope.getAccountCardName = function () {

      return scope.cardName;
    };

    scope.getAccountCardSum = function () {

      return scope.cardSum;
    };

    function checkCardPermissionAndBalance() {
      for (var i in scope.cardsArray) {
        scope.cardsArray[i].permission = false;
        if (scope.opts.usefor == "p2p" && scope.cardsArray[i].p2p_allowed == 1) {
          scope.cardsArray[i].permission = true;
        }
        if (scope.opts.usefor == "payment" && scope.cardsArray[i].payment_allowed == 1) {
          scope.cardsArray[i].permission = true;
        }

        //cards with error balance is not allowed
        if (scope.cardsArray[i].salary === null){
          scope.cardsArray[i].permission = false;
        }

        if (scope.opts.usefor == "all") {
          scope.cardsArray[i].permission = true;
        }

        if (scope.cardsArray[i].permission == false) {
          delete scope.cardsArray[i];
        }
      }
    }

  </script>
</component-pincards>