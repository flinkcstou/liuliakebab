<view-card-edit class="view-my-cards">
  <div class="page-title">
    <p class="name-title">{window.languages.ViewCardEditTitleName}</p>
    <div id="backButton" ontouchend="touchStartTitle()"
         class="{back-button: backbuttoncheck}">
    </div>
    <div id="rightButton" type="button" class="{settings-button: rightbuttoncheck}" ontouchend="editCard()"></div>
  </div>
  <div class="card-edit-body-container">
    <div class="card-edit-field">
      <p class="card-edit-text-field">Название карты</p>
      <input class="card-edit-input"/>
    </div>
    <div class="card-edit-makemain-container">
      <p class="card-edit-makemain-text">Сделать основной</p>
      <div class="card-edit-makemain-check"></div>
    </div>
  </div>


  <script>
    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-card-edit') {
      history.arrayOfHistory.push(
        {
          "view": 'view-card-edit',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    touchStartTitle = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    }

    editCard = function () {
      console.log("Hello world");
    }

    var scope = this,
      sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key,
      phoneNumber = localStorage.getItem('click_client_phoneNumber');


    if (opts[0]) {
      scope.cardId = opts[0];
      console.log('scope.cardId', scope.cardId)
    }


    scope.top = 160 * widthK;
    viewMyCards.check = true;
    viewMainPage.myCards = true;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;
    scope.cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));


    scope.card = scope.cardsArray[scope.cardId];
    console.log('scope.cardId', scope.cardId)
    console.log('scope.cardsArray', scope.cardsArray)


  </script>
</view-card-edit>