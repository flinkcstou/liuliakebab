<view-mycard-list>
  <div class="view-mycard-list">
    <div class="page-title">
      <p class="name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToMainPage()"
           class="back-button">
      </div>
      <div class="mycardlist-add-button" ontouchend="addCardTouchEnd()"></div>
    </div>

    <div class="mycardlist-container">
      <div class="mycardlist-card" each="{i in cardsArray}"
           style="background-image: url({i.card_background_url}); color: rgb({i.font_color});"
           ontouchend="goToCardPage({i.card_id})">

        <div class="mycardlist-card-bank-name"></div>
        <div class="mycardlist-card-salary-title">{i.name}</div>

        <div class="mycardlist-card-balance-currency-container">
          <p class="mycardlist-card-balance">{i.salary}</p>
          <p class="mycardlist-card-currency">{i.currency}</p>
        </div>

        <div class="mycardlist-card-number">
          <div class="mycardlist-card-number-part-one">{i.numberPartOne}</div>
          <p class="mycardlist-number-stars">**** ****</p>
          <div class="mycardlist-card-number-part-two">{i.numberPartTwo}</div>
        </div>
      </div>
    </div>

  </div>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewMyCardListTitleName;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-mycard-list') {
      history.arrayOfHistory.push(
        {
          "view": 'view-mycard-list',
          "params": ''
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    scope.cardsArray = JSON.parse(localStorage.getItem("click_client_cards"));
    riot.update(scope.cardsArray);

    goToMainPage = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown();
    }

    goToCardPage = function (cardId) {
      event.preventDefault();
      event.stopPropagation();
      console.log('cardId', cardId)
      for (var i in scope.cardsArray) {
        if (scope.cardsArray[i] == scope.cardsArray[cardId]) {
          scope.cardsArray[cardId].chosenCard = true;
          console.log('scope.cardsArray[cardId]', scope.cardsArray[cardId])
          console.log('scope.cardsArray[i]', scope.cardsArray[i])
          localStorage.setItem('cardNumber', scope.cardsArray[cardId].countCard);
        }
        else
          scope.cardsArray[cardId].chosenCard = false;
      }

      riot.update(scope.cardsArray);

      riotTags.innerHTML = "<view-my-cards>";
      riot.mount('view-my-cards', [cardId]);
    }

    addCardTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-add-card>";
      riot.mount('view-add-card');
    }


  </script>
</view-mycard-list>
