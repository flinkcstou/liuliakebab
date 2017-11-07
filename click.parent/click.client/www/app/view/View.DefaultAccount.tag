<view-default-account class="view-service-pincards riot-tags-main-container">

  <div class="pay-page-title" style="border-style: none;">
    <p class="servicepage-title">
      {window.languages.ViewDefaultAccountTitle}</p>
  </div>

  <div class="pincard-body-container">
    <div class="pincard-payfrom-container">
      <p class="pincard-payfrom-field">{window.languages.ViewDefaultAccountSubTitle}</p></div>

    <component-pincards clean="{true}" useFor="payment"></component-pincards>
    <div class="pincard-bottom-container">

      <button id="enterPinCardButtonId" class="pincard-button-enter" ontouchstart="chooseDefaultTouchStart()"
              ontouchend="chooseDefaultTouchEnd()">{window.languages.ViewDefaultAccountChooseButtonText}
      </button>

    </div>
  </div>

  <component-alert if="{showError}" errornote="{errorNote}" viewpage="{viewPage}"></component-alert>

  <component-success id="componentSuccessId"
                     operationmessage="{window.languages.ViewDefaultAccountSuccessText}"
                     viewpage="{viewPage}"></component-success>


  <script>

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view !== 'view-default-account') {
      history.arrayOfHistory.push(
        {
          "view": 'view-default-account',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    var scope = this;
    scope.showError = false;

    var enterCardStartY, enterCardStartX, enterCardEndY, enterCardEndX;

    scope.chooseDefaultTouchStart = chooseDefaultTouchStart = function () {
      event.stopPropagation();

      enterPinCardButtonId.style.webkitTransform = 'scale(0.8)'

      enterCardStartY = event.changedTouches[0].pageY;
      enterCardStartX = event.changedTouches[0].pageX;
    };


    chooseDefaultTouchEnd = function () {

      event.stopPropagation();

      enterPinCardButtonId.style.webkitTransform = 'scale(1)';

      enterCardEndY = event.changedTouches[0].pageY;
      enterCardEndX = event.changedTouches[0].pageX;

      if (Math.abs(enterCardStartY - enterCardEndY) <= 20 && Math.abs(enterCardStartX - enterCardEndX) <= 20) {

        var cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
        scope.update();
        console.log("cardsArray=", cardsArray);
        var accountId;

        for (var i in cardsArray)
          if (cardsArray[i].chosenCard && cardsArray[i].access == 2) {
            accountId = cardsArray[i].card_id;
          }


        if (accountId) {

          var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
          var phoneNumber = localStorage.getItem('click_client_phoneNumber');

          window.api.call({
            method: 'settings.change.default.account',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber,
              account_id: accountId
            },
            scope: this,

            onSuccess: function (result) {
              if (result[0][0].error == 0 && result[1][0]) {
                var j = 2;
                for (var i in cards) {
                  if (cards[i].card_id == result[1][0].default_account_id) {
                    cards[i].default_account = true;
                    cards[i].countCard = 1;
                  }
                  else {
                    cards[i].default_account = false;
                    cards[i].countCard = j++;
                  }
                }
                console.log("cards after default was set", cards);
                localStorage.setItem('click_client_cards', JSON.stringify(cards));
                scope.viewPage = "view-main-page";
                riot.update();
                componentSuccessId.style.display = 'block';
                return;

              }
              else if (result[0][0].error != 0) {
                scope.clickPinError = false;
                scope.errorNote = result[0][0].error_note;
                scope.showError = true;
                riot.update();
              }
            },
            onFail: function (api_status, api_status_message, data) {
              scope.clickPinError = false;
              scope.errorNote = api_status_message;
              scope.showError = true;
              scope.viewPage = "view-main-page";
              riot.update();
              console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
              console.error(data);
            }
          });
        } else {

        }


      }
    };


  </script>
</view-default-account>
