<view-card-edit class="view-my-cards">
  <div class="page-title">
    <p class="name-title">{window.languages.ViewCardEditTitleName}</p>
    <div id="backButton" ontouchend="touchStartTitle()"
         class="{back-button: backbuttoncheck}">
    </div>
    <div id="rightButton" type="button" class="{check-button: rightbuttoncheck}" ontouchend="saveEdit()"></div>
  </div>
  <div class="card-edit-body-container">
    <div class="card-edit-field">
      <p class="card-edit-text-field">Название карты</p>
      <input class="card-edit-input" value="{defaultName}"/>
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

    saveEdit = function () {
      console.log("Done!");
    }

    var scope = this,
      sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key,
      phoneNumber = localStorage.getItem('click_client_phoneNumber');


    if (opts[0]) {
      scope.card = opts[0];
      console.log('scope.card from opt', scope.card)
      this.defaultName = scope.card.name;
    }

    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;
    scope.cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));


  </script>
</view-card-edit>