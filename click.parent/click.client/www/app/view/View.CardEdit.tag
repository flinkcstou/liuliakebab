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
      <input id="cardNameInputID" class="card-edit-input" value="{defaultName}"/>
    </div>
    <div class="card-edit-makemain-container" ontouchend="MakeMainCheck()">
      <p class="card-edit-makemain-text">Сделать основной</p>
      <div id="makeMainCheckId" class="card-edit-makemain-check"></div>
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

    var scope = this;

    touchStartTitle = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    };

    if (opts[0]) {
      scope.card = opts[0];
      console.log('scope.card from opt', scope.card);
      this.defaultName = scope.card.name;
    }

    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;
    scope.cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));

    saveEdit = function () {

      sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      phoneNumber = localStorage.getItem('click_client_phoneNumber');
      newCardName = cardNameInputID.value;
      console.log("old name=", scope.card.name);
      console.log("new name=", newCardName);
      console.log("card id=", scope.card.card_id);

      if (scope.card.name != newCardName) {
        console.log("going to change name");
        window.api.call({
          method: 'settings.account.name',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            account_id: scope.card.card_id,
            name: newCardName
          },
          scope: this,

          onSuccess: function (result) {
            console.log(result);
            console.log(result[0][0]);
            if (result[0][0].error == 0) {
              alert("Изменения сохранены");
//              riotTags.innerHTML = "<view-registration-device>";
//              riot.mount('view-registration-device');
            }
            else {
              alert(result[0][0].error_note);
            }

          },
          onFail: function (api_status, api_status_message, data) {
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });
      }
      if (isMain) {
        console.log("is main");
        window.api.call({
          method: 'settings.change.default.account',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            account_id: scope.card.card_id
          },
          scope: this,

          onSuccess: function (result) {
            console.log(result);
            console.log(result[0][0]);
            if (result[0][0].error == 0) {
              alert("Карта сохранена как дефолтная");
            }
            else {
              alert(result[0][0].error_note);
            }
          },
          onFail: function (api_status, api_status_message, data) {
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });
      }

      riotTags.innerHTML = "<view-my-cards>";
      riot.mount("view-my-cards", [scope.card.card_id]);
    };

    var k = 0, isMain = false;
    MakeMainCheck = function () {
      k++;
      if (k % 2 == 1) {
        makeMainCheckId.style.backgroundImage = "url(resources/icons/ViewService/checked.png)";
        isMain = true;
      } else {
        makeMainCheckId.style.backgroundImage = "url(resources/icons/ViewService/unchecked.png)";
        isMain = false;
      }

    }


  </script>
</view-card-edit>