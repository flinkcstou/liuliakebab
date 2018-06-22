<view-invoice-history-detail class="view-invoice-history riot-tags-main-container">

  <div class="invoice-history-detail-title-container">
    <div class="page-title">
      <p class="name-title">
        {(opts.is_p2p)?(languages.ViewInvoiceHistoryDetailTransferTitle):(languages.ViewInvoiceHistoryDetailPaymentTitle)}</p>
      <div id="backButton" role="button" aria-label="{window.languages.Back}"
           ontouchstart="invoiceHistoryGoToBackStart()" ontouchend="invoiceHistoryGoToBackEnd()"
           class="back-button"></div>
      <div class="title-bottom-border">
      </div>
    </div>

    <div
      class="invoice-history-detail-icon {invoice-history-detail-payment-icon: !opts.is_p2p, invoice-history-detail-transfer-icon: opts.is_p2p}">
    </div>
    <p class="invoice-history-detail-title-part-one">
      {opts.description}</p>

    <p class="invoice-history-detail-title-phone-number">
      {(opts.is_p2p)?("+"):("")} {opts.inParameter}</p>
    <div class="title-bottom-border">
    </div>
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
    <div if="{opts.transferCode}" class="invoice-history-detail-invoice-container">
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

  </div>

  <script>

    var scope = this;

    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

    invoiceHistoryGoToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(0.7)'

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    invoiceHistoryGoToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(1)'

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown()
      }
    };

  </script>

</view-invoice-history-detail>