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
      var isMain = scope.card.default_account;
      this.on('mount', function () {
        if (isMain) {
          makeMainCheckId.style.backgroundImage = "url(resources/icons/ViewService/checked.png)";
        }
      });

      console.log("Initially isMain=", isMain);

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
              scope.cardsArray[scope.card.card_id].name = newCardName;
              console.log("name new=", scope.cardsArray[scope.card.card_id].name);
              if (isMain == scope.card.default_account) {
                localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsArray));
                onBackKeyDown();
              }
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
      } else {
        scope.noNameChange = true;
      }
      if (isMain != scope.card.default_account) {
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
              scope.cardsArray[scope.card.card_id].default_account = isMain;
              console.log("defaultBool new=", scope.cardsArray[scope.card.card_id].default_account);
              localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsArray));
              onBackKeyDown();
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
      } else {
        scope.noBoolChange = true;
      }

      if (scope.noNameChange && scope.noBoolChange) {
        console.log("no changes");
        onBackKeyDown();

      }
    };

    MakeMainCheck = function () {
      if (isMain) {
        console.log("false!!!");
        isMain = false;
        makeMainCheckId.style.backgroundImage = "url(resources/icons/ViewService/unchecked.png)";
      } else {
        console.log("true!!!");
        isMain = true;
        makeMainCheckId.style.backgroundImage = "url(resources/icons/ViewService/checked.png)";
      }

      riot.update(makeMainCheckId);
    }


  </script>
</view-card-edit>