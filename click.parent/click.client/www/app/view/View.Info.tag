<view-info class="view-info">
  <div class="view-info-title-container">
    <div class="view-info-back-button" ontouchend="onTouchEndBack()"></div>
  </div>

  <div class="view-info-balance-container">
    <p class="view-info-balance-label">{window.languages.ViewInfoBalanceTitle}</p>
    <div class="card-balance-currency-container">
      <p class="view-info-card-balance"></p>
      <p class="card-currency"></p>
    </div>
    <div class="view-info-bag-icon"></div>
    <div class="view-info-reload-icon"></div>
  </div>

  <div class="view-info-my-finance-container">
    <div class="view-info-my-finance-icon"></div>
    <div class="view-info-open-icon"></div>
    <p class="view-info-my-finance-title">{window.languages.ViewInfoMyFinanceTitle}</p>
  </div>

  <div class="view-info-reports-container">
    <div class="view-info-reports-icon"></div>
    <div class="view-info-open-icon"></div>
    <p class="view-info-reports-title">{window.languages.ViewInfoReportsTitle}</p>
  </div>

  <div class="view-info-operations-title"><p class="view-info-operations-label">{window.languages.ViewInfoLastOperations}</p></div>
  <div class="view-info-operations-container" each="{i in lastOperationContainer}">
    <div class="view-info-operations-icon">
      <div class="view-info-operation-info-container">
        <p class="view-info-operation-info-name"></p>
        <p class="view-info-operation-info-balance"></p>
        <p class="view-info-operation-info-number"></p>
        <p class="view-info-operation-info-date"></p>
      </div>
    </div>
  </div>

  <script>
    var scope = this;
    scope.lastOperationContainer = [];

    onTouchEndBack = function () {
      event.preventDefault();
      event.stopPropagation();

      this.riotTags.innerHTML = '<view-main-page>';
      riot.mount('view-main-page');

    }
    var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');

//    window.api.call({
//      method: 'get.payment.list',
//      input : {
//        session_key: sessionKey,
//        phone_num  : phoneNumber,
//      },
//
//      scope: this,
//
//      onSuccess: function (result) {
//        console.log('AWDAEQE')
//        console.log('result', result);
//
//      },
//
//      onFail: function (api_status, api_status_message, data) {
//        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
//        console.error(data);
//      }
//    });

  </script>
</view-info>