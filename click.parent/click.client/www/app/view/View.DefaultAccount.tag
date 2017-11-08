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

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>
  <component-confirm if="{confirmShowBool}" confirmnote="{confirmNote}"
                     confirmtype="{confirmType}"></component-confirm>


  <script>

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-default-account') {
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
        scope.update()

        cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
        console.log("cardsArray=", cardsArray);

//
//        for (var i in cardsArray) {
//          if (cardsArray[i].chosenCard && cardsArray[i].access == 2) {
//            opts.chosenCardId = cardsArray[i].card_id;
//            opts.payByCard = true;
//            scope.checked = true;
//            event.preventDefault();
//            event.stopPropagation();
//            onBackParams.opts = JSON.parse(JSON.stringify(opts));
//            this.riotTags.innerHTML = "<view-pay-confirm-new>";
//            riot.mount('view-pay-confirm-new', opts);
//            scope.unmount();
//          }
//        }

        window.api.call({
          method: 'settings.change.default.account',
          input: {
            session_key: scope.sessionKey,
            phone_num: scope.phoneNumber,
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
              scope.parent.viewPage = "view-main-page";
              riot.update();
              componentSuccessId.style.display = 'block';
              deleteCardComponentId.style.display = 'none';
              return;

            }
            else if (result[0][0].error != 0) {
              scope.parent.clickPinError = false;
              scope.parent.errorNote = result[0][0].error_note;
              scope.parent.showError = true;
              deleteCardComponentId.style.display = "none";
              riot.update();
            }
          },
          onFail: function (api_status, api_status_message, data) {
            scope.parent.clickPinError = false;
            scope.parent.errorNote = api_status_message;
            scope.parent.showError = true;
            deleteCardComponentId.style.display = "none";
            riot.update();
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });


      }
    };

    refreshFunction = function (bool) {
      scope.friendHelpBool = bool;
      scope.update(scope.friendHelpBool);
    }

  </script>
</view-default-account>
