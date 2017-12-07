<view-mycard-list>
  <div class="view-mycard-list riot-tags-main-container">
    <div class="page-title">
      <p class="name-title">{titleName}</p>
      <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()"
           class="back-button">
      </div>
      <div id="myCardListButtonAddId" role="button" aria-label="{window.languages.ViewMyCardListVoiceOverAddCard}"
           class="mycardlist-add-button" ontouchstart="addCardTouchStart()"
           ontouchend="addCardTouchEnd()"></div>
    </div>

    <div class="mycardlist-container">
      <div class="mycardlist-card" each="{i in sortedCards}" id="{i.card_id}"
           style="background-image: url({i.card_background_url}); color: rgb({i.font_color});"
           ontouchstart="goToCardPageTouchStart(this.id)" ontouchend="goToCardPageTouchEnd({i.card_id}, this.id)">

        <div class="mycardlist-card-bank-name"></div>
        <div class="mycardlist-card-salary-title">{i.name}</div>

        <div if="{!modeOfApp.offlineMode}" class="mycardlist-card-balance-currency-container">
          <p class="mycardlist-card-balance">{i.salary}</p>
          <p class="mycardlist-card-currency">{i.currency}</p>
        </div>

        <div class="mycardlist-card-number">
          <div class="mycardlist-card-number-part-one">{i.numberPartOne}</div>
          <div class="mycardlist-card-number-middle-two">{i.numberMiddleTwo}</div>
          <p class="mycardlist-number-stars">** ****</p>
          <div class="mycardlist-card-number-part-two">{i.numberPartTwo}</div>
        </div>
      </div>
    </div>

  </div>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewMyCardListTitleName;
    viewMainPage.atMainPage = false;
    var goBackButtonStartX,
      goBackButtonEndX,
      goBackButtonStartY,
      goBackButtonEndY;
    scope.sortedCards = [];

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view !== 'view-mycard-list') {
      history.arrayOfHistory.push(
        {
          "view": 'view-mycard-list',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    scope.cardsArray = localStorage.getItem("click_client_cards") ? JSON.parse(localStorage.getItem("click_client_cards")) : [];

    for (var i in scope.cardsArray) {
      scope.sortedCards[scope.cardsArray[i].countCard - 1] = scope.cardsArray[i];
    }

    console.log('CARDS', scope.cardsArray)
    console.log('CARDS sorted', scope.sortedCards)
    scope.update();

    goToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(0.7)';

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    goToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(1)';

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown();
        scope.unmount()
      }
    };

    var goToCardTouchStartX, goToCardTouchStartY, goToCardTouchEndX, goToCardTouchEndY;
    goToCardPageTouchStart = function (id) {

      goToCardTouchStartX = event.changedTouches[0].pageX;
      goToCardTouchStartY = event.changedTouches[0].pageY;

    };

    goToCardPageTouchEnd = function (cardId, id) {
      if (modeOfApp.offlineMode) return;

      goToCardTouchEndX = event.changedTouches[0].pageX;
      goToCardTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(goToCardTouchStartX - goToCardTouchEndX) <= 20 && Math.abs(goToCardTouchStartY - goToCardTouchEndY) <= 20) {

        document.getElementById(id).style.webkitTransform = 'scale(0.9)';

        setTimeout(function () {

          document.getElementById(id).style.webkitTransform = 'scale(1)';

          console.log('cardId', cardId);
          for (var i in scope.cardsArray) {
            if (scope.cardsArray[i] == scope.cardsArray[cardId]) {
              scope.cardsArray[cardId].chosenCard = true;
              console.log('scope.cardsArray[cardId]', scope.cardsArray[cardId]);
              console.log('scope.cardsArray[i]', scope.cardsArray[i]);
              localStorage.setItem('cardNumber', scope.cardsArray[cardId].countCard);
            }
            else
              scope.cardsArray[cardId].chosenCard = false;
          }

          scope.update();

          riotTags.innerHTML = "<view-my-cards>";
          riot.mount('view-my-cards', [cardId]);

          scope.unmount()
        }, 50)
      }
    };

    var addTouchStartX, addTouchStartY, addTouchEndX, addTouchEndY;

    addCardTouchStart = function () {

      event.preventDefault();
      event.stopPropagation();

      myCardListButtonAddId.style.webkitTransform = 'scale(0.7)';

      addTouchStartX = event.changedTouches[0].pageX;
      addTouchStartY = event.changedTouches[0].pageY;

    };

    addCardTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      myCardListButtonAddId.style.webkitTransform = 'scale(1)';

      addTouchEndX = event.changedTouches[0].pageX;
      addTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(addTouchStartX - addTouchEndX) <= 20 && Math.abs(addTouchStartY - addTouchEndY) <= 20) {

        if (modeOfApp.demoVersion) {
          var question = window.languages.DemoModeConstraintText;
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });

          scope.update();
          return
        }

        riotTags.innerHTML = "<view-add-card>";
        riot.mount('view-add-card');

        scope.unmount()
      }
    }


  </script>
</view-mycard-list>
