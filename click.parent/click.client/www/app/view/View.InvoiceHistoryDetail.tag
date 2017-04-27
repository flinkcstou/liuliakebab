<view-invoice-history-detail>

  <div class="invoice-history-detail-title-container">
    <div class="page-title invoice-history-detail-title">
      <p class="name-title">
        {(opts.is_p2p)?(languages.ViewInvoiceHistoryDetailTransferTitle):(languages.ViewInvoiceHistoryDetailPaymentTitle)}</p>
      <div id="backButton" ontouchstart="goToBack()" class="invoice-history-detail-general-back-button"></div>
    </div>

    <div
        class="invoice-history-detail-icon {invoice-history-detail-payment-icon: !opts.is_p2p, invoice-history-detail-transfer-icon: opts.is_p2p}">
    </div>
    <p class="invoice-history-detail-title-part-one">
      {(opts.is_p2p)?(languages.ViewInvoiceHistoryDetailTransferToNumberLabel):(languages.ViewInvoiceHistoryDetailPaymentToNumberLabel)}</p>

    <p class="invoice-history-detail-title-phone-number">
      {(opts.is_p2p)?("+"):("")} {opts.inParameter}</p>
  </div>

  <div class="invoice-history-detail-container" if="{opts.is_p2p}">
    <div class="invoice-history-detail-invoice-container">
      <p class="invoice-history-detail-invoice-title">{languages.ViewInvoiceHistoryDetailTransferAmountLabel}</p>
      <p class="invoice-history-detail-sum">{opts.amount} сум</p>
    </div>
    <div class="invoice-history-detail-invoice-container">
      <p class="invoice-history-detail-invoice-title">{languages.ViewInvoiceHistoryDetailTransferCommissionLabel}</p>
      <p class="invoice-history-detail-number">{opts.commission} сум</p>
    </div>
    <div class="invoice-history-detail-invoice-container">
      <p class="invoice-history-detail-invoice-title">{languages.ViewInvoiceHistoryDetailTransferCodeLabel}</p>
      <p class="invoice-history-detail-data">{opts.transferCode}</p>
    </div>
    <div class="invoice-history-detail-invoice-container">
      <p class="invoice-history-detail-invoice-title">{languages.ViewInvoiceHistoryDetailTransferNumberLabel}</p>
      <p class="invoice-history-detail-data">{opts.invoice_id}</p>
    </div>
    <div class="invoice-history-detail-invoice-container">
      <p class="invoice-history-detail-invoice-title">{languages.ViewInvoiceHistoryDetailTransferDateLabel}</p>
      <p class="invoice-history-detail-data">{opts.time} {opts.date}</p>
    </div>
    <div class="invoice-history-detail-invoice-container">
      <p class="invoice-history-detail-invoice-title">{languages.ViewInvoiceHistoryDetailTransferStatusLabel}</p>
      <p class="invoice-history-detail-status {invoice-history-detail-status-wait: opts.status == 'Ожидание',
                                               invoice-history-detail-status-deleted: opts.status == 'Удален',
                                               invoice-history-detail-status-success: opts.status == 'Успешно проведен'}">
        {opts.status}</p>
    </div>

    <div class="invoice-history-detail-cover invoice-history-detail-cover-transfer"></div>

  </div>

  <div class="invoice-history-detail-container" if="{!opts.is_p2p}">
    <div class="invoice-history-detail-invoice-container">
      <p class="invoice-history-detail-invoice-title">{languages.ViewInvoiceHistoryDetailPaymentAmountLabel}</p>
      <p class="invoice-history-detail-sum">{opts.amount} сум</p>
    </div>
    <div class="invoice-history-detail-invoice-container">
      <p class="invoice-history-detail-invoice-title">{languages.ViewInvoiceHistoryDetailPaymentNumberLabel}</p>
      <p class="invoice-history-detail-data">{opts.invoice_id}</p>
    </div>
    <div class="invoice-history-detail-invoice-container">
      <p class="invoice-history-detail-invoice-title">{languages.ViewInvoiceHistoryDetailPaymentDateLabel}</p>
      <p class="invoice-history-detail-data">{opts.time} {opts.date}</p>
    </div>
    <div class="invoice-history-detail-invoice-container">
      <p class="invoice-history-detail-invoice-title">{languages.ViewInvoiceHistoryDetailPaymentStatusLabel}</p>
      <p class="invoice-history-detail-status {invoice-history-detail-status-wait: opts.status == 'Ожидание',
                                               invoice-history-detail-status-deleted: opts.status == 'Удален',
                                               invoice-history-detail-status-success: opts.status == 'Успешно проведен'}">
        {opts.status}</p>
    </div>

    <div class="invoice-history-detail-cover invoice-history-detail-cover-payment"></div>

  </div>

  <script>

    var scope = this;

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
      scope.unmount()
    }

  </script>

</view-invoice-history-detail>