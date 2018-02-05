<view-card-edit class="view-my-cards riot-tags-main-container">
  <div class="page-title">
    <p class="name-title">{window.languages.ViewCardEditTitleName}</p>
    <div id="backButton" ontouchstart="goToBackStart()" ontouchend="goToBackEnd()"
         class="{back-button: backbuttoncheck}">
    </div>
    <div id="rightButton" type="button" class="{check-button: rightbuttoncheck}" ontouchstart="saveEditStart()"
         ontouchend="saveEditEnd()"></div>
  </div>
  <div class="card-edit-body-container">
    <div class="card-edit-field">
      <p class="card-edit-text-field">{window.languages.ViewCardEditCardNameText}</p>
      <input type="text" maxlength="25" id="cardNameInputID" class="card-edit-input"
             value="{defaultName}"/>
    </div>
    <div class="card-edit-makemain-container" if="{!onlyOneCard}" ontouchend="MakeMainCheck()">
      <p class="card-edit-makemain-text">{window.languages.ViewCardEditMakeMainText}</p>
      <div id="makeMainCheckId" class="card-edit-makemain-check"></div>
    </div>
  </div>

  <script>

    window.saveHistory('view-card-edit', opts);

    var scope = this;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;
    scope.cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
    var isMain;

    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

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
        scope.unmount();
      }
    };

    this.on('mount', function () {
      console.log("OPTS CARD", opts);
      if (opts[0]) {
        scope.card = opts[0];
        console.log('scope.card from opt', scope.card);
        this.defaultName = scope.card.name;
        if (Object.keys(scope.cardsArray).length < 2) {
          scope.onlyOneCard = true;
          scope.update();
        }
        else {
          scope.onlyOneCard = false;
          isMain = scope.card.default_account;
          scope.update();
        }
      }

      if (isMain) {
        makeMainCheckId.style.backgroundImage = "url(resources/icons/ViewService/checked.png)";
      }
    });

    var saveButtonStartX, saveButtonEndX, saveButtonStartY, saveButtonEndY;

    saveEditStart = function () {

      rightButton.style.webkitTransform = 'scale(0.7)'

      saveButtonStartX = event.changedTouches[0].pageX;
      saveButtonStartY = event.changedTouches[0].pageY;
    }

    saveEditEnd = function () {

      rightButton.style.webkitTransform = 'scale(1)'

      saveButtonEndX = event.changedTouches[0].pageX;
      saveButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(saveButtonStartX - saveButtonEndX) <= 20 && Math.abs(saveButtonStartY - saveButtonEndY) <= 20) {

        var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
        var phoneNumber = localStorage.getItem('click_client_phoneNumber');
        var newCardName = cardNameInputID.value;


        if (scope.card.name != newCardName) {

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

              if (result[0][0].error == 0) {
                scope.cardsArray[scope.card.card_id].name = newCardName;

                //TODO: CHANGED - COMMENTED
                if (isMain == scope.card.default_account || scope.onlyOneCard) {
                  localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsArray));
                  onBackKeyDown();
                }

                onBackKeyDown();

              }
              else {

                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: false,
                  errornote: result[0][0].error_note
                });
                scope.update();
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
        if (isMain != scope.card.default_account && !scope.onlyOneCard) {

          window.api.call({
            method: 'settings.change.default.account',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber,
              account_id: scope.card.card_id
            },
            scope: this,

            onSuccess: function (result) {

              if (result[0][0].error == 0 && result[1][0]) {
                var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
                var j = 2;
                for (var i in scope.cardsArray) {
                  if (scope.cardsArray[i].card_id == result[1][0].default_account_id) {
                    scope.cardsArray[i].default_account = true;
                    scope.cardsArray[i].countCard = 1;
                    scope.cardsArray[i].chosenCard = true;
                    loginInfo.default_account = result[1][0].default_account_id;

                  }
                  else {
                    scope.cardsArray[i].default_account = false;
                    scope.cardsArray[i].countCard = j++;
                    scope.cardsArray[i].chosenCard = false;
                  }
                }

                scope.cardsarrayTwo = {};
                for (var i = 1; i < Object.keys(scope.cardsArray).length + 1; i++) {
                  for (var k in scope.cardsArray) {
                    if (scope.cardsArray[k].countCard == i) {
                      scope.cardsarrayTwo[scope.cardsArray[k].card_id] = scope.cardsArray[k];

                    }
                  }
                }

                localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsarrayTwo));
                localStorage.setItem('click_client_loginInfo', JSON.stringify(loginInfo));
                onBackKeyDown();

              }
              else if (result[0][0].error != 0) {

                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: false,
                  errornote: result[0][0].error_note
                });
                scope.update();
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

          onBackKeyDown();

        }

        console.log('PARENT', scope)
      }
    };

    MakeMainCheck = function () {
      if (isMain) {

        isMain = false;
        makeMainCheckId.style.backgroundImage = "url(resources/icons/ViewService/unchecked.png)";
      } else {

        isMain = true;
        makeMainCheckId.style.backgroundImage = "url(resources/icons/ViewService/checked.png)";
      }

      scope.update();
    }


  </script>
</view-card-edit>