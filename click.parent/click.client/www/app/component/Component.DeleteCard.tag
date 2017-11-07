<component-delete-card id="deleteCardComponentId" class="component-delete">
  <div class="delete-delete-icon"></div>
  <p class="delete-operation-confirm-message">{window.languages.ComponentDeleteText}</p>

  <div class="delete-buttons-container">
    <p id="delButtonId" class="delete-button-accept" ontouchstart="deleteCardTouchStart()"
       ontouchend="deleteCardTouchEnd()">{window.languages.ComponentDeleteTextYes}</p>
    <p id="cancelDelButtonId" class="delete-button-cancel" ontouchstart="cancelDeleteCardTouchStart()"
       ontouchend="cancelDeleteCardTouchEnd()">{window.languages.ComponentDeleteTextNo}</p>
  </div>

  <script>
    var scope = this;
    scope.parent.showError = false;

    console.log('scope.parent DELETE', scope.parent)

    var delButtonStartX, delButtonEndX, delButtonStartY, delButtonEndY;

    deleteCardTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      delButtonId.style.webkitTransform = 'scale(0.7)'

      delButtonStartX = event.changedTouches[0].pageX;
      delButtonStartY = event.changedTouches[0].pageY;


    }

    deleteCardTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      delButtonId.style.webkitTransform = 'scale(1)'

      delButtonEndX = event.changedTouches[0].pageX;
      delButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(delButtonStartX - delButtonEndX) <= 20 && Math.abs(delButtonStartY - delButtonEndY) <= 20) {

        componentDeleteCard.deleteCard();
      }
    }

    var cancelButtonStartX, cancelButtonEndX, cancelButtonStartY, cancelButtonEndY;

    cancelDeleteCardTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      cancelDelButtonId.style.webkitTransform = 'scale(0.7)'

      cancelButtonStartX = event.changedTouches[0].pageX;
      cancelButtonStartY = event.changedTouches[0].pageY;


    }

    cancelDeleteCardTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      cancelDelButtonId.style.webkitTransform = 'scale(1)'

      cancelButtonEndX = event.changedTouches[0].pageX;
      cancelButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(cancelButtonStartX - cancelButtonEndX) <= 20 && Math.abs(cancelButtonStartY - cancelButtonEndY) <= 20) {

        deleteCardComponentId.style.display = 'none'
      }
    };
    scope.sessionKey = '';
    scope.phoneNumber = '';
    scope.accountId = '';

    componentDeleteCard.getInformation = function (sessionKey, phoneNumber, accountId) {
      scope.sessionKey = sessionKey;
      scope.phoneNumber = phoneNumber;
      scope.accountId = accountId;
    };

    componentDeleteCard.deleteCard = function () {

      window.api.call({
        method: 'account.remove',
        input: {
          session_key: scope.sessionKey,
          phone_num: scope.phoneNumber,
          account_id: scope.accountId
        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error === 0) {

            var cardNumber = JSON.parse(localStorage.getItem("cardNumber"));
            var countCard = JSON.parse(localStorage.getItem("click_client_countCard"));
            var cards = JSON.parse(localStorage.getItem("click_client_cards"));
            var isDefault = false;
            var hasDefault = false;

            cardNumber = (cardNumber - 1 >= 0) ? (cardNumber - 1) : (0);
            countCard = (countCard - 1 >= 0) ? (countCard - 1) : (0);
            localStorage.setItem("cardNumber", JSON.stringify(cardNumber));
            localStorage.setItem("click_client_countCard", JSON.stringify(countCard));


            console.log("acc id=", scope.accountId)
            console.log("cards before=", cards);
            for (var i in cards) {
              if (cards[i].card_id == scope.accountId) {
                console.log("xascdeswcfe");
                if (cards[i].default_account)
                  isDefault = true;
                delete cards[scope.accountId];
                localStorage.setItem('click_client_cards', JSON.stringify(cards));
              } else if (cards[i].default_account) hasDefault = true;

            }

            console.log("cards after=", cards);
            console.log("keys size", Object.keys(cards).length);

            if ((!isDefault && hasDefault) || Object.keys(cards).length === 0) {
              console.log("First condition");
              scope.parent.viewPage = "view-main-page";
              riot.update();
              componentSuccessId.style.display = 'block';
              deleteCardComponentId.style.display = 'none';

            } else {
              if (Object.keys(cards).length === 1) {
                console.log("Second condition");
                componentDeleteCard.setDefaultAccount(cards);

              } else {
                console.log("Third condition");
                riotTags.innerHTML = "<view-default-account>";
                riot.mount('view-default-account');
              }
            }

          }
          else {
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
      })
    };


    componentDeleteCard.setDefaultAccount = function (cards) {

      var accountId = cards[Object.keys(cards)[0]].card_id;

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


  </script>
</component-delete-card>