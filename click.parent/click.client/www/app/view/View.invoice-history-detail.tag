<view-invoice-history-detail>

  <div class="invoice-history-detail-title-container">
    <div class="page-title invoice-history-detail-title">
      <p class="name-title">
        {(opts.is_p2p)?(languages.ViewInvoiceHistoryDetailTransferTitle):(languages.ViewInvoiceHistoryDetailPaymentTitle)}
        {opts.invoice_id}</p>
      <div id="backButton" ontouchstart="goToBack()" class="settings-general-back-button"></div>
    </div>

    <div
        class="invoice-history-detail-icon {invoice-history-detail-payment-icon: !opts.is_p2p, invoice-history-detail-transfer-icon: opts.is_p2p}">
    </div>
    <p class="invoice-history-detail-title-part-one">
      {(opts.is_p2p)?(languages.ViewInvoiceHistoryDetailTransferToNumberLabel):(languages.ViewInvoiceHistoryDetailPaymentToNumberLabel)}</p>

    <p class="invoice-history-detail-title-phone-number">
      + {opts.phoneNumber} 998 90 359 39 57</p>
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

  <script>

    var scope = this;

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    }

  </script>

</view-invoice-history-detail>