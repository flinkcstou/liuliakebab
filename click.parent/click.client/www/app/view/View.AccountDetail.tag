<view-account-detail>
  <div>
    <div class="account-detail-title-container">

      <div class="page-title account-detail-page-title">
        <p class="name-title">{titleName}</p>
        <div id="backButton" ontouchend="goToBack()" class="settings-general-back-button"></div>
      </div>
      <div class="account-detail-transfer-icon"></div>
      <p class="account-detail-transfer-icon-title-part-one">
        {window.languages.ViewAccountDetailTransferIconTitleOne}</p>

      <p class="account-detail-transfer-icon-title-part-two">
        {window.languages.ViewAccountDetailTransferIconTitleTwo}</p>

      <p class="account-detail-transfer-icon-title-phone">
        +99890974322344</p>

    </div>

    <div class="account-detail-container">
      <div class="account-detail-payment-container">
        <p class="account-detail-title">{window.languages.ViewAccountDetailTitleSum}</p>
        <p class="account-detail-sum">115 000 сум</p>
      </div>
      <div class="account-detail-payment-container">
        <p class="account-detail-title">{window.languages.ViewAccountDetailTitlePayFor}</p>
        <p class="account-detail-pay-for">6497 9863</p>
      </div>

      <div class="account-detail-payment-pay-from-container">
        <p class="account-detail-title">{window.languages.ViewAccountDetailTitlePayFrom}</p>
      </div>

      <component-pincards></component-pincards>

      <div class="account-detail-buttons-container">
        <p class="account-detail-button-accept">ПРИНЯТЬ</p>
        <p class="account-detail-button-cancel">ОТКЛОНИТЬ</p>
      </div>

    </div>

  </div>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewTransferDetailTitle;

    this.on('mount', function () {

    })

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-account-detail') {
      history.arrayOfHistory.push(
        {
          "view": 'view-account-detail',
          "params": ''
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }


    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    };


  </script>
</view-account-detail>
