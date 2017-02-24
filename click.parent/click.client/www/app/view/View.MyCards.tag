<view-my-cards class="view-my-cards">
  <div class="page-title">
    <p class="name-title">{titleName}</p>
    <div id="backButton" ontouchend="touchStartTitle()"
         class="{back-button: backbuttoncheck}">
    </div>
    <div id="rightButton" type="button" class="{settings-button: rightbuttoncheck}" ontouchend="editCard()"></div>
  </div>

  <div class="my-cards-carousel">
    <component-card-carousel>
    </component-card-carousel>
  </div>

  <div class="my-cards-button-container">
    <div class="my-cards-button-field my-cards-button-field-transfer" ontouchend="goToTransferView()">
      <div class="my-cards-button-icon my-cards-button-icon-transfer">
      </div>

      <div class="my-cards-button-label">{window.languages.ViewMyCardTransfer}
      </div>
    </div>

    <div class="my-cards-button-field my-cards-button-field-payment">
      <div class="my-cards-button-icon my-cards-button-icon-payment">
      </div>

      <div class="my-cards-button-label" ontouchend="goToPayView()">{window.languages.ViewMyCardPay}
      </div>
    </div>

    <div class="my-cards-button-field my-cards-button-field-report">
      <div class="my-cards-button-icon my-cards-button-icon-report">
      </div>

      <div class="my-cards-button-label" style="border: none;">{window.languages.ViewMyCardReports}
      </div>
    </div>
  </div>

  <div class="my-cards-button-block-card">
    <div class="my-cards-button-icon my-cards-button-icon-block"></div>
    <div class="my-cards-button-block-card-label">{window.languages.ViewMyCardBlock}</div>
  </div>

  <div class="my-cards-last-operations">
    <div class="my-cards-last-operations-container-label">
      <p class="my-cards-last-operations-label">{window.languages.ViewMyCardLastOperations}</p>

      <div id="lastOperationContainerId" class="my-cards-last-operations-container">
        <div class="my-cards-last-operations-info" each="{i in arrayOfOperationsByAccount}"
             style="top: {i.count*top}px">
          <div class="my-cards-operation-amount">- {i.amount}</div>
          <div class="my-cards-operation-currency">{i.lang_amount_currency}</div>
          <div class="my-cards-firm-name">{i.service_name}</div>
          <div class="my-cards-operation-date">{i.created}</div>
        </div>
      </div>

    </div>


  </div>


  <script>
    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-my-cards') {
      history.arrayOfHistory.push(
        {
          "view": 'view-my-cards',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    touchStartTitle = function () {
      if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view == 'view-card-edit') {
        history.arrayOfHistory.pop();
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
      }
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    }

    editCard = function () {
      console.log("card for edit=", scope.card);
      event.preventDefault();
      event.stopPropagation();
      riotTags.innerHTML = "<view-card-edit>";
      riot.mount('view-card-edit', [scope.card]);
    }


    var scope = this,
      sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key,
      phoneNumber = localStorage.getItem('click_client_phoneNumber');


    if (opts[0]) {
      scope.cardId = opts[0];
      console.log('scope.cardId', scope.cardId)
    }


    scope.top = 160 * widthK;
    viewMyCards.check = true;
    viewMainPage.myCards = true;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;
    scope.cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));


    this.titleName = window.languages.ViewMyCardTitleName;


    scope.card = scope.cardsArray[scope.cardId];
    console.log('scope.cardId', scope.cardId)
    console.log('scope.cardsArray', scope.cardsArray)


    scope.arrayOfOperationsByAccount = [];

    scope.cardInformation = cardInformation = function (cardIdFromCarousel) {

      history.arrayOfHistory[history.arrayOfHistory.length - 1].params[0] = cardIdFromCarousel;
      history.arrayOfHistory[history.arrayOfHistory.length - 1].view = 'view-my-cards';
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

      scope.card = scope.cardsArray[cardIdFromCarousel];
      scope.arrayOfOperationsByAccount = [];
      riot.update()
      console.log(scope.card)

      window.api.call({
        method: 'get.payments.by.account',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          account_id: scope.card.card_id
        },

        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            if (result[1][0]) {
              var j = 0;
              for (var i in result[1]) {
                if (result[1][i].account_id == scope.card.card_id && result[1][i].state == 0) {
                  result[1][i].count = j;
                  result[1][i].amount = result[1][i].amount.toString();

                  if (result[1][i].amount.length == 7) {
                    result[1][i].amount = result[1][i].amount.substring(0, 1) + ' ' +
                      result[1][i].amount.substring(1, 4) + ' ' + result[1][i].amount.substring(4, result[1][i].amount.length)

                  }

                  if (result[1][i].amount.length == 6) {
                    result[1][i].amount = result[1][i].amount.substring(0, 3) + ' ' +
                      result[1][i].amount.substring(3, result[1][i].amount.length)

                  }

                  if (result[1][i].amount.length == 5) {
                    result[1][i].amount = result[1][i].amount.substring(0, 2) + ' ' +
                      result[1][i].amount.substring(2, result[1][i].amount.length)

                  }

                  if (result[1][i].amount.length == 4) {
                    result[1][i].amount = result[1][i].amount.substring(0, 1) + ' ' +
                      result[1][i].amount.substring(1, result[1][i].amount.length)

                  }

                  j++;
                  scope.arrayOfOperationsByAccount.push(result[1][i]);
                }
              }
              this.lastOperationContainerId.style.height = j * 160 * widthK + 'px';
              riot.update(scope.arrayOfOperationsByAccount)
              console.log('scope.arrayOfOperationsByAccount', scope.arrayOfOperationsByAccount)
            }
          }
          else
            alert(result[0][0].error_note)

        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }

    scope.cardInformation(scope.cardId);

    goToPayView = function () {
      for (var i in scope.cardsArray) {
        if (scope.cardsArray[i].card_id == scope.card.card_id) {
          scope.cardsArray[i].chosenCard = true;
        }
        else
          scope.cardsArray[i].chosenCard = false;
      }
      localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsArray));

      event.preventDefault();
      event.stopPropagation();


      if (scope.card.access == 2) {
        riotTags.innerHTML = "<view-pay>";
        riot.mount('view-pay');
      }
      else alert('Извининте, вы не можете произвести оплату с этой карты')
    }

    goToTransferView = function () {
      for (var i in scope.cardsArray) {
        if (scope.cardsArray[i].card_id == scope.card.card_id && scope.cardsArray[i].access == 2) {
          scope.cardsArray[i].chosenCard = true;
        }
        else
          scope.cardsArray[i].chosenCard = false;
      }
      localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsArray));

      event.preventDefault();
      event.stopPropagation();

      console.log(scope.card)
      if (scope.card.access == 2) {
        riotTags.innerHTML = "<view-transfer>";
        riot.mount('view-transfer');
      }
      else alert('Извининте, вы не можете произвести перевод с этой карты')
    }

  </script>
</view-my-cards>