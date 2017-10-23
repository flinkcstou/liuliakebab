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
    }
    scope.sessionKey = ''
    scope.phoneNumber = ''
    scope.accountId = ''

    componentDeleteCard.getInformation = function (sessionKey, phoneNumber, accountId) {
      scope.sessionKey = sessionKey
      scope.phoneNumber = phoneNumber
      scope.accountId = accountId
    }

    componentDeleteCard.deleteCard = function () {

      window.api.call({
        method: 'account.remove',
        input: {
          session_key: scope.sessionKey,
          phone_num: scope.phoneNumber,
          account_id: scope.accountId,
        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            componentSuccessId.style.display = 'block';
//            scope.parent.clickPinError = false;
//            scope.parent.errorNote = 'Карта успешно удалена';
//            scope.parent.showError = true;
//            scope.parent.cardDelete = true;
            riot.update();
            var cardNumber = JSON.parse(localStorage.getItem("cardNumber"));

            cardNumber = (cardNumber - 1 >= 0) ? (cardNumber - 1) : (0);
            localStorage.setItem("cardNumber", cardNumber);
            deleteCardComponentId.style.display = 'none';
//              updateCard();
            return;
          }
          else {
            scope.parent.clickPinError = false;
            scope.parent.errorNote = result[0][0].error_note;
            scope.parent.showError = true;
            deleteCardComponentId.style.display = "none"
            riot.update();
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    }


  </script>
</component-delete-card>