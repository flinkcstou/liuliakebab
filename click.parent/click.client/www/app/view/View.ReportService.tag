<view-report-service>
  <div>

    <div class="report-service-upper-container">

      <div class="page-title settings-general-page-title">
        <div id="backButton" ontouchend="goToBack()" class="settings-general-back-button"></div>
      </div>

      <img src="{opts.image}" id="serviceIconId"
           class="report-service-icon"/>

      <div class="report-service-upper-info-container">
        <div class="report-service-title">{opts.service_name}</div>
        <div class="report-service-payment-info-text">{window.languages.ViewReportServicePaymentNumber}
          {amountTransform(opts.payment_id.toString())}
        </div>
        <div class="report-service-payment-info-text">{window.languages.ViewReportServicePaymentDate} {opts.created}
        </div>
      </div>

    </div>

    <div class="report-service-body-container">
      <div class="report-service-body-info-container">
        <div class="report-service-phone-field">
          <p class="report-service-text-field">{opts.parameter_name}</p>
          <p class="report-service-phone-input">{opts.cntrg_info_param2}</p>
        </div>
        <div class="report-service-field">
          <p class="report-service-text-field">{window.languages.ViewReportServiceAmountOfPay}</p>
          <p class="report-service-info-input report-service-info-input-amount">-
            {amountTransform(opts.amount.toString())} сум</p>
        </div>
        <div class="report-service-field">
          <p class="report-service-text-field">{window.languages.ViewReportServicePayWithCard}</p>
          <p class="report-service-info-input">{cardName}</p>
        </div>
        <div class="report-service-field report-service-last-field">
          <p class="report-service-text-field">{window.languages.ViewReportServiceStatus}</p>
          <p class="report-service-info-input {report-service-status-wait: opts.state == 1,
                                               report-service-status-error: opts.state == -1,
                                               report-service-status-success: opts.state == 0}">
            {opts.status_note}</p>
        </div>
      </div>

      <div class="report-service-data-button-info-container">
        <div class="report-service-button-info-container">
          <div class="report-service-button-icon report-service-button-favorites-icon"></div>
          <a class="report-service-button-action">{languages.ViewReportServiceAddToFavorites}</a>
        </div>
        <div class="report-service-button-info-container">
          <div class="report-service-button-icon report-service-button-auto-payment-icon"></div>
          <a class="report-service-button-action">{languages.ViewReportServiceAddToAutoPayment}</a>
        </div>
        <div class="report-service-button-info-container">
          <div class="report-service-button-icon report-service-button-support-icon"></div>
          <a class="report-service-button-action">{languages.ViewReportServiceGetSupportHelp}</a>
        </div>

        <button class="report-service-repeat-button">{languages.ViewReportServiceRepeatButtonLabel}</button>
      </div>

    </div>

  </div>

  <script>
    var scope = this;

    scope.cards = localStorage.getItem("click_client_cards");
    scope.cards = JSON.parse(scope.cards);
    scope.cardName = scope.cards[opts.account_id].name + " " + scope.cards[opts.account_id].numberPartOne + " **** **** " + scope.cards[opts.account_id].numberPartTwo;
    riot.update(scope.cardName);

    console.log("OPTS=", opts);

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-report-service') {
      history.arrayOfHistory.push(
          {
            "view": 'view-report-service',
            "params": opts
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
</view-report-service>
