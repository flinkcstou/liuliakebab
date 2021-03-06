<view-account-detail>
  <div class="riot-tags-main-container">
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

      <div class="account-detail-cards-container">
        <component-pincards useFor="payment"></component-pincards>
        <div class="account-detail-buttons-container">
          <p class="account-detail-button-accept">{window.languages.ViewAccountDetailTitlePay}</p>
          <p class="account-detail-button-cancel">{window.languages.ViewAccountDetailTitleDecline}</p>
        </div>
      </div>

    </div>

  </div>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewAccountDetailTitle;

    window.saveHistory('view-account-detail', opts);

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
      scope.unmount()
    };


  </script>
</view-account-detail>
