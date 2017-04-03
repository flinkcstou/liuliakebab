<view-transfer-detail>
  <div>
    <div class="transfer-detail-title-container">

      <div class="page-title transfer-detail-page-title">
        <p class="name-title">{titleName}</p>
        <div id="backButton" ontouchend="goToBack()" class="settings-general-back-button"></div>
      </div>
      <div class="transfer-detail-transfer-icon"></div>
      <p class="transfer-detail-transfer-icon-title-part-one">
        {window.languages.ViewTransferDetailTransferIconTitleOne}</p>

      <p class="transfer-detail-transfer-icon-title-part-two">
        {window.languages.ViewTransferDetailTransferIconTitleTwo}</p>

      <p class="transfer-detail-transfer-icon-title-phone">
        +{opts.phoneNumber}</p>

    </div>

    <div class="transfer-detail-container">
      <div class="transfer-detail-transfer-container">
        <p class="transfer-detail-title">{window.languages.ViewTransferDetailTitleSum}</p>
        <p class="transfer-detail-sum">{opts.amount} сум</p>
      </div>
      <div class="transfer-detail-transfer-container">
        <p class="transfer-detail-title">{window.languages.ViewTransferDetailTitleNumber}</p>
        <p class="transfer-detail-number">{opts.invoiceId}</p>
      </div>
      <div class="transfer-detail-transfer-container">
        <p class="transfer-detail-title">{window.languages.ViewTransferDetailTitleDate}</p>
        <p class="transfer-detail-date">{opts.time} {opts.date}</p>
      </div>
      <div class="transfer-detail-transfer-container">
        <p class="transfer-detail-title">{window.languages.ViewTransferDetailTitleStatus}</p>
        <p class="transfer-detail-status">Ожидает подтверждения</p>
      </div>

      <div class="transfer-detail-cover"></div>

      <div class="transfer-detail-buttons-container">
        <p class="transfer-detail-button-accept">{window.languages.ViewTransferDetailTitleAccept}</p>
        <p class="transfer-detail-button-cancel">{window.languages.ViewTransferDetailTitleDecline}</p>
      </div>

    </div>

  </div>

  <script>
    var scope = this;
    scope.titleName = window.languages.ViewTransferDetailTitle;

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    };


  </script>
</view-transfer-detail>
