<view-transfer-stepthree class="riot-tags-main-container">
  <div class="transfer-page-title">
    <p class="transfer-name-title">{titleName}</p>
    <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
         ontouchend="goToBackEnd()"
         class="{transfer-back-button: backbuttoncheck}"></div>
    <div id="rightButton" type="button" class="{transfer-i-button: rightbuttoncheck}"></div>
  </div>

  <div class="transferthree-body-container">
    <div class="transferthree-menus-container">
      <p id="cardLabelId" class="transferthree-menu-name-label">{window.languages.ViewTransferThreeMenuTitle}</p>
    </div>
    <component-pincards clean="{true}"></component-pincards>

    <button id="nextButtonId" class="transferthree-next-button-inner-container"
            ontouchstart="goToTransferFourTouchStart()"
            ontouchend="goToTransferFourTouchEnd()">
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


    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

    goToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(0.7)'

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    goToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(1)'

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown()
        scope.unmount()
      }
    };

    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = false;

    var goToTransferFourTouchStartX, goToTransferFourTouchStartY, goToTransferFourTouchEndX, goToTransferFourTouchEndY;

    goToTransferFourTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      nextButtonId.style.webkitTransform = 'scale(0.8)'

      goToTransferFourTouchStartX = event.changedTouches[0].pageX
      goToTransferFourTouchStartY = event.changedTouches[0].pageY
    }


    goToTransferFourTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      nextButtonId.style.webkitTransform = 'scale(1)'

      goToTransferFourTouchEndX = event.changedTouches[0].pageX
      goToTransferFourTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(goToTransferFourTouchStartX - goToTransferFourTouchEndX) <= 20 && Math.abs(goToTransferFourTouchStartY - goToTransferFourTouchEndY) <= 20) {
        var cards = JSON.parse(localStorage.getItem('click_client_cards'));

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

        console.log("getAccountCardSum", cardSumFromPinCards, "opts", parseInt(opts[1].sum))
        if (cardSumFromPinCards && cardSumFromPinCards < parseInt(opts[1].sum)) {
          console.log(cardSumFromPinCards, opts[1].sum)
          scope.clickPinError = false;
          scope.errorNote = "На выбранной карте недостаточно средств";
          scope.showError = true;
          scope.update();
          return;
        }

        if (checkChosenCard) {
          arrayForTransfer.push(chosenCard)
          riotTags.innerHTML = "<view-transfer-stepfour>";
          riot.mount('view-transfer-stepfour', [arrayForTransfer, opts[3], owner]);

          scope.unmount()
        }
        else {
          scope.clickPinError = false;
          scope.errorNote = ('Выберите карту');
          scope.showError = true;
          scope.update();
        }
      }
    }


  </script>
</view-transfer-stepthree>
