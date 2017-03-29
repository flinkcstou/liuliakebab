<component-delete-card id="deleteCardComponentId" class="component-delete">
  <div class="delete-delete-icon"></div>
  <p class="delete-operation-confirm-message">{window.languages.ComponentDeleteText}</p>

  <div class="delete-buttons-container">
    <p class="delete-button-accept" ontouchend="deleteCardTouchEnd()">{window.languages.ComponentDeleteTextYes}</p>
    <p class="delete-button-cancel" ontouchend="cancelDeleteCardTouchEnd()">{window.languages.ComponentDeleteTextNo}</p>
  </div>

  <script>
    var scope = this;

    closeSuccessMessageForm = function () {
      event.preventDefault();
      event.stopPropagation();
      componentSuccessId.style.display = 'none';
      history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - 3)
      console.log(history.arrayOfHistory)
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

      console.log('viewpage', opts.viewpage)


      riotTags.innerHTML = "<" + opts.viewpage + ">";
      riot.mount(opts.viewpage);
    }

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
            alert('Карта успешно удалена')
            deleteCardComponentId.style.display = 'none'
//              updateCard();
            return
          }
          else {
            alert(result[0][0].error_note)
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