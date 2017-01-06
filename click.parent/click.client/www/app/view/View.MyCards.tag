<view-my-cards class="view-my-cards">
  <component-page-title title="{titleName}" backbutton="{backbuttoncheck}" rightbutton="{rightbuttoncheck}">
  </component-page-title>
  <div class="my-cards-carousel">
    <component-card-carousel>
    </component-card-carousel>
  </div>

  <div class="my-cards-button-container">
    <div class="my-cards-button-field my-cards-button-field-transfer">
      <div class="my-cards-button-icon my-cards-button-icon-transfer">
      </div>

      <div class="my-cards-button-label">Переводы с карты на карту
      </div>
    </div>

    <div class="my-cards-button-field my-cards-button-field-payment">
      <div class="my-cards-button-icon my-cards-button-icon-payment">
      </div>

      <div class="my-cards-button-label">Оплата с карты
      </div>
    </div>

    <div class="my-cards-button-field my-cards-button-field-report">
      <div class="my-cards-button-icon my-cards-button-icon-report">
      </div>

      <div class="my-cards-button-label">Отчеты по карте
      </div>
    </div>
  </div>

  <div class="my-cards-button-block-card">
    <div class="my-cards-button-block-card-label">Заблокировать карту</div>
  </div>

  <div class="my-cards-last-operations">
    <div class="my-cards-last-operations-container-label">
      <p class="my-cards-last-operations-label">Последние операции</p>

      <div id="lastOperationContainerId" class="my-cards-last-operations-container">
        <div class="my-cards-last-operations-info" each="{i in arrayOfOperationsByAccount}" style="top: {i.count* top}px">
          <div class="my-cards-operation-amount">- {i.amount}</div>
          <div class="my-cards-operation-currency">сум</div>
          <div class="my-cards-operation-date">{i.created}</div>
        </div>
      </div>

    </div>


  </div>


  <script>
    var scope = this;
    scope.top = 160 * widthK;

    console.log('get card number ', localStorage.getItem("cardNumber"))
    history.arrayOfHistory.push('view-my-cards');
    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

    scope.indexOfCard = JSON.parse(localStorage.getItem('cardNumber'));

    viewMyCards.check = true;
    viewMainPage.myCards = true;

    console.log(opts.backbuttoncheck);

    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;
    scope.cardsArray = JSON.parse(localStorage.getItem('cards'));

    this.titleName = 'ЗАРПЛАТНАЯ КАРТА';
    var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    var accountId = JSON.parse(localStorage.getItem('click_client_loginInfo')).default_account;
    scope.card = JSON.parse(localStorage.getItem('click_client_cards'))[scope.indexOfCard];
    console.log("CARD AAAAAAA A ", scope.card)

    scope.arrayOfOperationsByAccount = [];

    viewMyCards.cardInformation = function () {

      scope.card = JSON.parse(localStorage.getItem('click_client_cards'))[scope.indexOfCard];
      scope.arrayOfOperationsByAccount = [];
      console.log()
      riot.update()
      console.log("CARD AAAAAAAssSS A ", scope.card)

      window.api.call({
        method: 'get.payments.by.account',
        input : {
          session_key: sessionKey,
          phone_num  : phoneNumber,
          account_id : scope.card.card_id
        },

        scope: this,

        onSuccess: function (result) {
          console.log('result[1]', result[1]);
          if (result[0][0].error == 0)
            if (result[1][0])
              var j = 0;
          for (var i in result[1]) {
            console.log('ACCOUNT ID ', result[1][i].account_id, 'CARD ID ', scope.card.card_id);
            if (result[1][i].account_id == scope.card.card_id) {
              result[1][i].count = j;
              j++;
              scope.arrayOfOperationsByAccount.push(result[1][i]);
            }
          }
          scope.lastOperationContainerId.style.height = j * 160 * widthK + 'px';
          riot.update(scope.arrayOfOperationsByAccount)

          console.log('arratdasas', scope.arrayOfOperationsByAccount)
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }

    window.api.call({
      method: 'get.service.parameters.list',
      input : {
        session_key: sessionKey,
        phone_num  : phoneNumber,
        service_id : accountId
      },

      scope: this,

      onSuccess: function (result) {
        console.log("result ", result);
      },

      onFail: function (api_status, api_status_message, data) {
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    });

    viewMyCards.cardInformation();

  </script>
</view-my-cards>