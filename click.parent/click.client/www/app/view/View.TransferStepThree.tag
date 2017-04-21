<view-transfer-stepthree>
  <div class="transfer-page-title">
    <p class="transfer-name-title">{titleName}</p>
    <div id="backButton" ontouchstart="goToBack()" class="{transfer-back-button: backbuttoncheck}"></div>
    <div id="rightButton" type="button" class="{transfer-i-button: rightbuttoncheck}"></div>
  </div>

  <div class="transferthree-body-container">
    <div class="transferthree-menus-container">
      <p id="cardLabelId" class="transferthree-menu-name-label">{window.languages.ViewTransferThreeMenuTitle}</p>
    </div>
    <component-pincards></component-pincards>

    <button class="transferthree-next-button-inner-container" ontouchend="goToTransferFour()">
      {window.languages.ViewTransferThreeNext}
    </button>

  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this,
      arrayForTransfer = [],
      transferTitle,
      objectForTransfer = opts[0],
      checkChosenCard = false,
      chosenCard;
    console.log('OOOOPts', opts)

    if (opts[0].owner)
      var owner = opts[0].owner;

    console.log('STEP 3', opts)
    scope.showError = false;

    arrayForTransfer.push(opts[0])
    arrayForTransfer.push(opts[1])
    arrayForTransfer.push(opts[2])
    //    console.log(arrayForTransfer)


    if (objectForTransfer.type == 1) {
      transferTitle = objectForTransfer.name.substring(0, 4) + ' **** ' + objectForTransfer.name.substring(15, objectForTransfer.name.length)
    }
    else
      transferTitle = objectForTransfer.name;


    if (objectForTransfer.type == 2)
      this.titleName = window.languages.ViewTransferThreeTitle + ' +' + transferTitle;
    else
      this.titleName = window.languages.ViewTransferThreeTitle + ' ' + transferTitle;


    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-transfer-stepthree') {
      history.arrayOfHistory.push(
        {
          "view": 'view-transfer-stepthree',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }


    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    }

    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = false;


    goToTransferFour = function () {
      var cards = JSON.parse(localStorage.getItem('click_client_cards'));
      event.preventDefault()
      event.stopPropagation()
//      console.log(cards)
      for (var i in cards) {
        if (cards[i].chosenCard === true && cards[i].access == 2) {
//          console.log(cards[i])
          checkChosenCard = true;
          chosenCard = cards[i]
          break;
        }
      }

      var cardSumFromPinCards = scope.tags['component-pincards'].getAccountCardSum();

      console.log(cardSumFromPinCards, parseInt(opts[1].sum))
      if (cardSumFromPinCards && cardSumFromPinCards < parseInt(opts[1].sum)) {
        console.log(cardSumFromPinCards, opts[1].sum)
        scope.clickPinError = false;
        scope.errorNote = "На выбранной карте недостаточно средств";
        scope.showError = true;
        riot.update();
        return;
      }

      if (checkChosenCard) {
        arrayForTransfer.push(chosenCard)
        riotTags.innerHTML = "<view-transfer-stepfour>";
        riot.mount('view-transfer-stepfour', [arrayForTransfer, opts[3], owner]);
      }
      else {
        scope.clickPinError = false;
        scope.errorNote = ('Выберите карту');
        scope.showError = true;
        riot.update();
      }
    }


  </script>
</view-transfer-stepthree>
