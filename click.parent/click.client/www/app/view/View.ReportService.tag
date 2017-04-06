<view-report-service>
  <div>

    <div class="report-service-upper-container">

      <div class="page-title settings-general-page-title">
        <div id="backButton" ontouchend="goToBack()" class="settings-general-back-button"></div>
      </div>

      <img src="{icon}" id="serviceIconId"
           class="report-service-icon"/>

      <div class="report-service-upper-info-container">
        <div class="report-service-title">{serviceName}</div>
        <div class="report-service-payment-info-text">{window.languages.ViewReportServicePaymentNumber} {paymentNumber}
        </div>
        <div class="report-service-payment-info-text">{window.languages.ViewReportServicePaymentDate} {date}
        </div>
      </div>

    </div>

    <div class="report-service-body-container">
      <div class="report-service-data-container">
        <div class="report-service-phone-field">
          <p class="report-service-text-field">{firstFieldTitle}</p>
          <p class="report-service-phone-input">{firstFieldText}</p>
        </div>
        <div class="report-service-field">
          <p class="report-service-text-field">{window.languages.ViewReportServiceAmountOfPay}</p>
          <p class="report-service-phone-input">- {amountText} {currency}</p>
        </div>
        <div class="report-service-field">
          <p class="report-service-text-field">{window.languages.ViewReportServicePayWithCard}</p>
          <p class="report-service-phone-input">{amountTextCopy}</p>
        </div>
        <div class="report-service-field">
          <p class="report-service-text-field">{window.languages.ViewReportServiceStatus}</p>
          <p class="report-service-phone-input">{status}</p>
        </div>


      </div>

    </div>

  </div>

  <component-alert clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this;

    console.log("OPTS=", opts);
    if (opts[0]) {
      scope.icon = opts[0].image;
      scope.serviceName = opts[0].service_name;
      scope.paymentNumber = opts[0].payment_id;
      scope.amountText = opts[0].amount;
      scope.date = opts[0].created;
      scope.status = opts[0].status_note;
    }


    this.on('mount', function () {

    })


    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-report-service') {
      history.arrayOfHistory.push(
        {
          "view": 'view-report-service',
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
</view-report-service>
