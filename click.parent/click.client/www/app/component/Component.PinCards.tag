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
           class="{pincard-card-uncheckmark: 'check'+i.card_id != checkedId, pincard-card-checkmark: 'check'+i.card_id == checkedId}">
      </div>
    </div>

  </div>

  <script>
    var scope = this;

    //<div class="pincard-allcards-transparent-block"></div>
    //    if (!viewTransfer.check) {

    scope.cardsArray = localStorage.getItem('click_client_cards') ? JSON.parse(localStorage.getItem('click_client_cards')) : [];
    checkCardPermission();
    updateCardsArray = function () {
//      console.log("update cards array")
//      if (localStorage.getItem('click_client_cards')) {
//        scope.cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
//        console.log("cardsArray in pincards", scope.cardsArray);
//        checkCardPermission();
//        if (device.platform != 'BrowserStand') {
//          console.log("Spinner Stop View Pincard Comp 45");
//          SpinnerPlugin.activityStop();
//        }
//        console.log("Before update");
//        scope.update();
//        console.log("After update");
//      }
//      else
//        setTimeout(function () {
//          updateCardsArray();
//        }, 3000)
    }

    //    if (!localStorage.getItem('click_client_cards')) {
    //      if (device.platform != 'BrowserStand') {
    //        var options = {dimBackground: true};
    //
    //        SpinnerPlugin.activityStart(languages.Downloading, options, function () {
    //          console.log("Started");
    //        }, function () {
    //          console.log("closed");
    //        });
    //      }
    //
    ////      updateCardsArray();
    //    }


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
//    if (!scope.opts.clean) {
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
      event.preventDefault()
      event.stopPropagation()

      scope.cardId = id;

      pinCardtouchEndY = event.changedTouches[0].pageY;

      console.log('CARD ID', scope.cardId)
      console.log('pinCardtouchStartY - pinCardtouchEndY', pinCardtouchStartY - pinCardtouchEndY)

      if (Math.abs(pinCardtouchStartY - pinCardtouchEndY) < 20) {

        scope.checkedId = "check" + id;
        console.log('scope.checkedId', document.getElementById(scope.checkedId))
//        scope.update(scope.checkedId);

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
      console.log("198");
      scope.cleanChosenCards();
    }

    scope.getAccountCardId = function () {

      return scope.cardId;
    };

    scope.getAccountCardName = function () {

      return scope.cardName;
    };

    scope.getAccountCardSum = function () {
      console.log('sum', scope)

      return scope.cardSum;
    };

    function checkCardPermission() {
//        for (var i in scope.cardsArray) {
//            scope.cardsArray[i].permission = false;
//            if (scope.opts.usefor == "p2p" && scope.cardsArray[i].p2p_allowed == 1){
//                scope.cardsArray[i].permission = true;
//            }
//            if (scope.opts.usefor == "payment" && scope.cardsArray[i].payment_allowed == 1){
//                scope.cardsArray[i].permission = true;
//            }
//            if (scope.opts.usefor == "all"){
//                scope.cardsArray[i].permission = true;
//            }
//
//            if (scope.cardsArray[i].permission == false)
//            {
//                console.log("Cardsarray in permission check function:", scope.cardsArray);
//                delete scope.cardsArray[i];
//            }
//        }
    }

  </script>
</component-pincards>