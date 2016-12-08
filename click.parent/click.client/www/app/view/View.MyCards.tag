<view-my-cards>
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
    </div>

    <div class="my-cards-last-operations-info"></div>

  </div>


  <script>
    viewMyCards.check = true;
    viewMainPage.myCards = true;

    console.log(opts.backbuttoncheck);
    scope = this;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;
    scope.cardsArray = JSON.parse(localStorage.getItem('cards'));

    this.titleName = 'ЗАРПЛАТНАЯ КАРТА';
    var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    var accountId = JSON.parse(localStorage.getItem('click_client_loginInfo')).default_account;

    window.api.call({
      method: 'get.payments.by.account',
      input : {
        session_key: sessionKey,
        phone_num  : phoneNumber,
        account_id : accountId
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
  </script>
</view-my-cards>