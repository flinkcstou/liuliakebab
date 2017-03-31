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

  <div class="invoice-history-detail-container" if="{opts.is_p2p}">
    <div class="invoice-history-detail-invoice-container">
      <p class="transfer-detail-title">{languages.ViewInvoiceHistoryDetailTransferAmountLabel}</p>
      <p class="transfer-detail-sum">1 500 000 сум</p>
    </div>
    <div class="invoice-history-detail-invoice-container">
      <p class="transfer-detail-title">{languages.ViewInvoiceHistoryDetailTransferCommissionLabel}</p>
      <p class="transfer-detail-number">15 000 сум</p>
    </div>
    <div class="invoice-history-detail-invoice-container">
      <p class="transfer-detail-title">{languages.ViewInvoiceHistoryDetailTransferCodeLabel}</p>
      <p class="transfer-detail-date">879</p>
    </div>
    <div class="invoice-history-detail-invoice-container">
      <p class="transfer-detail-title">{languages.ViewInvoiceHistoryDetailTransferNumberLabel}</p>
      <p class="transfer-detail-date">6497 9863</p>
    </div>
    <div class="invoice-history-detail-invoice-container">
      <p class="transfer-detail-title">{languages.ViewInvoiceHistoryDetailTransferDateLabel}</p>
      <p class="transfer-detail-date">12:38 01.03.2017</p>
    </div>
    <div class="invoice-history-detail-invoice-container">
      <p class="transfer-detail-title">{languages.ViewInvoiceHistoryDetailTransferStatusLabel}</p>
      <p class="transfer-detail-status">Успешно проведен</p>
    </div>

    <div class="transfer-detail-cover"></div>

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