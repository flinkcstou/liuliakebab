<view-payment-detail>
  <div>

    <div class="transfer-to-card-title-container">
      <div class="page-title account-detail-page-title">
        <p class="name-title">{titleName}</p>
        <div id="backButton" ontouchstart="goToBack()" class="settings-general-back-button"></div>
      </div>

      <div class="payment-detail-payment-icon"></div>
      <p class="transfer-to-card-transfer-title-part-one">
        {window.languages.ViewPaymentDetailTitleOne}</p>

      <p class="transfer-to-card-transfer-title-part-two">
        {window.languages.ViewPaymentDetailTitleTwo}</p>

      <p class="transfer-to-card-transfer-title-phone">
        +{opts.phoneNumber}</p>

    </div>

    <div class="transfer-to-card-container">

      <div class="payment-detail-payment-container">
        <p class="payment-detail-title">{window.languages.ViewPaymentDetailTitleSum}</p>
        <p class="payment-detail-sum">{opts.amount} сум</p>
      </div>
      <div class="payment-detail-payment-container">
        <p class="payment-detail-title">{window.languages.ViewPaymentDetailTitlePayFor} {opts.serviceName}:</p>
        <p class="payment-detail-number">+{opts.phoneNumber}</p>
      </div>
      <div class="payment-detail-payment-container">
        <p class="payment-detail-title">{window.languages.ViewPaymentDetailTitlePayFrom}</p>
      </div>

      <component-pincards paymentdetail="true"></component-pincards>

      <div class="account-detail-cover"></div>

      <div class="account-detail-buttons-container">
        <p class="account-detail-button-accept">{window.languages.ViewAccountDetailTitlePay}</p>
        <p class="account-detail-button-cancel">{window.languages.ViewAccountDetailTitleDecline}</p>
      </div>
    </div>


  </div>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewPaymentDetailTitle + opts.invoiceId;

    this.on('mount', function () {

    })

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-transfer-to-card') {
      history.arrayOfHistory.push(
          {
            "view": 'view-transfer-to-card',
            "params": ''
          }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }


    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
//      console.log("BACK")
      onBackKeyDown()
    };


  </script>
</view-payment-detail>
