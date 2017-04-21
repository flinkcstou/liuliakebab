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
        <p if="{i.salaryOriginal > 0}" class="pincard-card-info-text-two" if="{i.salaryOriginal>0}">{i.salary}
          {i.currency}</p>
        <p class="pincard-card-info-text-two" style="color: #EB604D"
           if="{i.salaryOriginal<=0 && !modeOfflineMode.check}">
          0 {i.currency}</p>
        <p class="pincard-card-info-text-three">{i.numberPartOne} **** {i.numberPartTwo}</p>
      </div>
      <div id="check{i.card_id}"
           class="{pincard-card-uncheckmark: 'check'+i.card_id != checkedId, pincard-card-checkmark:'check'+i.card_id == checkedId}">
      </div>
    </div>
  </div>

  <script>
    var scope = this;


    //    if (!viewTransfer.check) {
    scope.cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));

    //    else {
    //      scope.cardsArray = [];
    //      var cards = JSON.parse(localStorage.getItem('click_client_cards'));
    //      for (var j in cards) {
    //        if (cards[j].numberPartOne == '8600' && (parseInt(viewTransferStepTwo.sumWithoutSpace) <= parseInt(cards[j].salary.replace(/\s/g, '')))) {
    //          console.log(cards[j])
    //          scope.cardsArray.push(cards[j])
    //        }
    //      }
    //      riot.update()
    //    }
    scope.checked = false;
    scope.cardId = undefined;
    scope.cardSum = 0;
    scope.index = -1;
    console.log(' scope.cardsArray', scope.cardsArray)


    if (viewServicePinCards.friendHelpPaymentMode && viewServicePinCards.chosenFriendForHelp) {
      for (var i in scope.cardsArray) {
        if (scope.cardsArray[i].chosenCard == true && scope.cardsArray[i].access == 2) {
          scope.cardsArray[i].chosenCard = false;
        }
      }
      console.log("WWW");
    }
    else {
      for (var i in scope.cardsArray) {
        if (scope.cardsArray[i].chosenCard == true && scope.cardsArray[i].access == 2) {
          scope.checkedId = "check" + scope.cardsArray[i].card_id;
        }
      }
      console.log("QQQ");
    }
    var touchStartY;


    var touchEndY;
    //          scope.index = scope.cardsArray[i].card_id;
    //          scope.index = scope.cardsArray[i].card_id;


    scope.on("mount", function () {

      for (var i in scope.cardsArray) {
        if (scope.cardsArray[i].chosenCard == true && scope.cardsArray[i].access == 2) {
          scope.cardId = scope.cardsArray[i].card_id;
          scope.cardName = scope.cardsArray[i].name;
        }
      }
    });

    chooseCardTouchStart = function () {
      touchStartY = event.changedTouches[0].pageY;
    };


    chooseCardTouchEnd = function (id) {

      scope.cardId = id;

      touchEndY = event.changedTouches[0].pageY;

      if (Math.abs(touchStartY - touchEndY) < 20) {

//        if (opts.friendhelpbool) {
//          if (scope.index == id) {
//            scope.index = -1;
//            scope.checkedId = "";
//            riot.update(scope.checkedId);
//          } else {
//            scope.checkedId = "check" + id;
//            riot.update(scope.checkedId);
//            scope.index = id;
//          }
//
//
//          for (var i in scope.cardsArray) {
//            if (scope.cardsArray[i].card_id == id && scope.cardsArray[i].access == 2) {
//              if (scope.checkedId.length < 2)
//                scope.cardsArray[i].chosenCard = false;
//              else
//                scope.cardsArray[i].chosenCard = true;
//            }
//            else
//              scope.cardsArray[i].chosenCard = false;
//          }
//
//
//        } else {
        scope.checkedId = "check" + id;
        riot.update(scope.checkedId);

        if (viewServicePinCards.friendHelpPaymentMode && viewServicePinCards.chosenFriendForHelp) {
          this.parent.refreshFunction(false);
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
//        }


        localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsArray))
        riot.update(scope.cardsArray)
      }
      else return

    };

    scope.cleanChosenCards = function () {
      scope.checkedId = '';

      for (var i in scope.cardsArray) {

        scope.cardsArray[i].chosenCard = false;
      }

      localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsArray))
      riot.update();
    };

    console.log('OPTS PINCARDS', opts)
    if (opts.clean) {

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


  </script>
</component-pincards>