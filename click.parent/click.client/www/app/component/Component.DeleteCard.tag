<component-delete-card id="deleteCardComponentId" class="component-delete">
  <div class="delete-delete-icon"></div>
  <p class="delete-operation-confirm-message">{window.languages.ComponentDeleteText}</p>

  <div class="delete-buttons-container">
    <p class="delete-button-accept" ontouchend="deleteCardTouchEnd()">{window.languages.ComponentDeleteTextYes}</p>
    <p class="delete-button-cancel" ontouchend="cancelDeleteCardTouchEnd()">{window.languages.ComponentDeleteTextNo}</p>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this;
    scope.showError = false;

    deleteCardTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();
      componentDeleteCard.deleteCard();
    }

    cancelDeleteCardTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      deleteCardComponentId.style.display = 'none'
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
            scope.clickPinError = false;
            scope.errorNote = 'Карта успешно удалена';
            riot.update();
            componentAlertId.style.display = 'block';
            deleteCardComponentId.style.display = 'none'
//              updateCard();
            return
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
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