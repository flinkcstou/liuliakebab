<view-invoice-list class="riot-tags-main-container">

  <div class="page-title">
    <p class="name-title">{titleName}</p>
    <div id="invoiceListBackButtonId" role="button" aria-label="{window.languages.Back}"
         ontouchstart="invoiceGoToBackStart()" ontouchend="invoiceGoToBackEnd()"
         class="back-button">
    </div>
    <div class="title-bottom-border">
    </div>
  </div>

  <div class="invoice-list-content-holder">
    <div class="invoice-list-nav-buttons-holder {invoice-list-invoices-in: toUser, invoice-list-invoices-out: !toUser}">
      <div class="invoice-list-nav-button-to-user" ontouchend="getInvoiceListToUser()">
        <img class="invoice-list-nav-buttons-icon"
             src="{(toUser)?('resources/icons/invoice/invoices_in_on.png'):('resources/icons/invoice/invoices_in_off.png')}">
        <p class="invoice-list-nav-buttons-title {invoice-list-nav-button-not-selected: !toUser}">
          {languages.ViewInvoiceListToUser}</p>
      </div>
      <div class="invoice-list-nav-button-from-user" ontouchend="getInvoiceListFromUser()">
        <img class="invoice-list-nav-buttons-icon"
             src="{(toUser)?('resources/icons/invoice/invoices_out_off.png'):('resources/icons/invoice/invoices_out_on.png')}">
        <p class="invoice-list-nav-buttons-title {invoice-list-nav-button-not-selected: toUser}">
          {languages.ViewInvoiceListFromUser}</p>
      </div>
      <div id="borderRightLineId" class="invoice-list-nav-buttons-border">
      </div>
    </div>
    <div id="invoiceListInvoicesId" class="invoice-list-invoices-holder" onscroll="invoiceListInvoicesTouchMove()"
         if="{invoiceListShow}">
      <div each="{invoice in invoiceList}" if="{!invoice.deleted}" title="{JSON.stringify(invoice)}"
           class="invoice-list-invoice"
           id="{invoice.invoice_id}"
           ontouchend="goToInvoiceHistoryDetailTouchEnd(this.title, this.id)"
           ontouchstart="goToInvoiceHistoryDetailTouchStart(this.id)">
        <div
          class="invoice-list-invoice-sum-holder {invoice-list-invoice-is-p2p: invoice.is_p2p == 1 && toUser, invoice-list-invoice-is-not-p2p: invoice.is_p2p == 0 || !toUser}">
          <mark class="invoice-list-invoice-sum-sym">сум</mark>
          <p class="invoice-list-invoice-sum">{invoice.amount}</p>
        </div>
        <p class="invoice-list-from-whom-label invoice-list-invoice-is-not-p2p" if="{invoice.is_p2p == 0 && toUser}">
          {languages.ViewInvoiceListInvoiceIsNot2P2ToUser}</p>
        <p class="invoice-list-from-whom-label invoice-list-invoice-is-not-p2p" if="{invoice.is_p2p == 0 && !toUser}">
          {languages.ViewInvoiceListInvoiceIsNot2P2FromUser}</p>
        <p class="invoice-list-from-whom-label invoice-list-invoice-is-p2p" if="{invoice.is_p2p == 1 && toUser}">
          {languages.ViewInvoiceListInvoiceIsP2PToUser}</p>
        <p class="invoice-list-from-whom-label invoice-list-invoice-is-not-p2p" if="{invoice.is_p2p == 1 && !toUser}">
          {languages.ViewInvoiceListInvoiceIsP2PFromUser}</p>
        <div class="invoice-list-invoice-phone-number-holder">
          <p class="invoice-list-invoice-phone-number">{(invoice.service_id == -4)?("+"):("")}
            {invoice.parameter||invoice.cntrg_info_param3}</p>
          <p class="invoice-list-invoice-service-name" if="{invoice.is_p2p == 0}">{invoice.service_name}</p>
        </div>
        <p class="invoice-list-invoice-date">{invoice.date} {invoice.time}</p>
      </div>
    </div>

    <div id="invoiceListInvoicesId" class="invoice-list-invoices-holder" onscroll="invoiceListInvoicesTouchMove()"
         if="{!invoiceListShow}">
      <div class="empty-list-upper-container">
        <div class="empty-list-upper-icon" if="{toUser}"
             style="background-image: url('resources/icons/invoice/to-user_empty.png');background-size: 69%;background-position-x: 50%;background-position-y: 19%;"></div>
        <div class="empty-list-upper-icon" if="{!toUser}"
             style="background-image: url('resources/icons/invoice/from-user_empty.png');background-size: 70%;background-position-x: 50%;background-position-y: 9%;"></div>
      </div>
      <div class="empty-list-lower-container">
        <p class="empty-list-lower-title-text" style="top: 1%;">{toUser? window.languages.ViewInvoiceInEmptyBodyText :
          window.languages.ViewInvoiceOutEmptyBodyText}</p>
      </div>

    </div>

  </div>

  <view-transfer-detail hidden="{!showComponentTransfer || !showComponent}"></view-transfer-detail>
  <view-payment-detail hidden="{!showComponentPayment || !showComponent}"></view-payment-detail>
  <view-invoice-history-detail hidden="{!showComponentHistory || !showComponent}"></view-invoice-history-detail>

  <component-tour view="invoice"></component-tour>

  <script>

    var scope = this,
      goToInvoiceHistoryDetailTouchStartX,
      goToInvoiceHistoryDetailTouchEndX,
      goToInvoiceHistoryDetailTouchStartY,
      goToInvoiceHistoryDetailTouchEndY;

    var invoiceListPageNumber = 1;

    scope.showComponentTransfer = false;
    scope.showComponentPayment = false;
    scope.showComponentHistory = false;
    scope.showComponent = false;
    var canDownloadInvoiceList = true;
    scope.invoiceListShow = true;

    componentMenu.check = false;

    scope.invoiceList = [];
    scope.titleName = languages.ViewInvoiceListTitle;
    if (opts.toUser)
      scope.toUser = opts.toUser;
    else {
      scope.toUser = true;
    }
    window.checkShowingComponent = null;

    console.log("TO USER", scope.toUser, opts.toUser);
    viewMainPage.atMainPage = false;
    console.log("viewMainPage.atMainPage =", viewMainPage.atMainPage);

    this.on('mount', function () {

      if (JSON.parse(localStorage.getItem("tour_data")) && !JSON.parse(localStorage.getItem("tour_data")).invoice) {
        componentTourId.style.display = "block";
        if (device.platform != 'BrowserStand')
          StatusBar.backgroundColorByHexString("#ffffff");
      }
    });


    invoiceListInvoicesTouchMove = function () {

      event.preventDefault();
      event.stopPropagation();


      if ((invoiceListInvoicesId.scrollHeight - invoiceListInvoicesId.scrollTop) == invoiceListInvoicesId.offsetHeight && canDownloadInvoiceList) {
        console.log(scope.toUser)
        if (scope.toUser) {
          invoiceListPageNumber++;
          getInvoiceListToUser()
        }
        else {
          invoiceListPageNumber++;
          getInvoiceListFromUser()
        }
      }
    };

    scope.invoiceList = [];

    getInvoiceListToUser = function () {

      if (!scope.toUser) {
        scope.oldInvoiceList = scope.invoiceList;
        scope.invoiceList = [];
        invoiceListPageNumber = 1;
        canDownloadInvoiceList = true;
        scope.invoiceListShow = true;
      }

//      scope.showComponent = false;
      scope.toUser = true;
      scope.update();

      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = loginInfo.session_key;
      var timeOutTimerToUser = 0;

      window.startSpinner();
      window.api.call({
        method: 'invoice.list',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          page_number: parseInt(invoiceListPageNumber),
        },
        scope: this,
        onSuccess: function (result) {
          console.log('Clearing timer onSuccess', timeOutTimerToUser);
          window.clearTimeout(timeOutTimerToUser);

          if (result[0][0].error == 0) {
            if (result[1]) {
              if (result[1].length == 0 && invoiceListPageNumber == 1) {
                canDownloadInvoiceList = false;
                scope.invoiceListShow = false;
                scope.update();
              }
              if (result[1][0]) {
                for (var i = 0; i < result[1].length; i++) {

                  try {
                    result[1][i].amount = window.amountTransform(result[1][i].amount.toString());
                  } catch (error) {
                    console.log(error);
                  }
                  result[1][i].deleted = false;
                  scope.invoiceList.push(result[1][i]);
                }
                scope.update();
                localStorage.setItem('click_client_invoice_list', JSON.stringify(scope.invoiceList));
              }
            }
            else {
              canDownloadInvoiceList = false;
            }
          }
          else {
            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: false,
              errornote: result[0][0].error_note
            });
            scope.update();
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onTimeOut: function () {
          timeOutTimerToUser = setTimeout(function () {
            window.writeLog({
              reason: 'Timeout',
              method: 'invoice.list'
            });
            window.stopSpinner();
            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: false,
              errornote: "Сервис временно недоступен"
            });
            scope.update();
          }, 10000);
          console.log('creating timeOutToUser', timeOutTimerToUser);
        },
        onEmergencyStop: function () {
          console.log('Clearing timer emergencyStop', timeOutTimerToUser);
          window.clearTimeout(timeOutTimerToUser);
        }
      }, 10000);

    };

    getInvoiceListFromUser = function () {
      console.log("QWE");

      if (scope.toUser) {
        scope.invoiceList = [];
        invoiceListPageNumber = 1;
        canDownloadInvoiceList = true;
        scope.invoiceListShow = true;
      }
//      scope.showComponent = false;
      scope.toUser = false;
      scope.update();

      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = loginInfo.session_key;
      var timeOutTimerFromUser = 0;

      window.startSpinner();

      window.api.call({
        method: 'invoice.history',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          page_number: parseInt(invoiceListPageNumber)
        },
        scope: this,
        onSuccess: function (result) {
          console.log('Clearing timer onSuccess', timeOutTimerFromUser);
          window.clearTimeout(timeOutTimerFromUser);
          if (result[0][0].error == 0) {
            if (result[1]) {
              if (result[1].length == 0 && invoiceListPageNumber == 1) {
                canDownloadInvoiceList = false;
                scope.invoiceListShow = false;
                scope.update();
              }
              if (result[1][0]) {
                for (var i = 0; i < result[1].length; i++) {

                  try {
                    result[1][i].amount = window.amountTransform(result[1][i].amount.toString());
                  } catch (error) {

                    console.log(error);
                  }
                  result[1][i].deleted = false;
                  scope.invoiceList.push(result[1][i]);
                }
                scope.update();
//                localStorage.setItem('click_client_invoice_list', JSON.stringify(scope.invoiceList));
              }
            }
          }
          else {
            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: false,
              errornote: result[0][0].error_note
            });
            scope.update();
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onTimeOut: function () {
          timeOutTimerFromUser = setTimeout(function () {
            window.writeLog({
              reason: 'Timeout',
              method: 'invoice.history'
            });
            window.stopSpinner();
            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: false,
              errornote: "Сервис временно недоступен"
            });
            scope.update();
          }, 10000);
          console.log('creating timeOutFromUser', timeOutTimerFromUser);
        },
        onEmergencyStop: function () {
          console.log('Clearing timer emergencyStop', timeOutTimerFromUser);
          window.clearTimeout(timeOutTimerFromUser);
        }
      }, 10000);

    };

    if (scope.toUser) {

      getInvoiceListToUser();
    } else {

      getInvoiceListFromUser();
    }

    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

    invoiceGoToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();
      console.log("BACK BACK");

      invoiceListBackButtonId.style.webkitTransform = 'scale(0.7)';

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    invoiceGoToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      invoiceListBackButtonId.style.webkitTransform = 'scale(1)';

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown();
        scope.unmount()
      }
    };

    goToInvoiceHistoryDetailTouchEnd = function (invoice, id) {

      event.preventDefault();
      event.stopPropagation();


      goToInvoiceHistoryDetailTouchEndX = event.changedTouches[0].pageX;
      goToInvoiceHistoryDetailTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(goToInvoiceHistoryDetailTouchEndX - goToInvoiceHistoryDetailTouchStartX) < 20 &&
        Math.abs(goToInvoiceHistoryDetailTouchEndY - goToInvoiceHistoryDetailTouchStartY) < 20) {
        document.getElementById(id).style.backgroundColor = 'rgba(231,231,231,0.5)';
        setTimeout(function () {
          document.getElementById(id).style.backgroundColor = 'transparent';
//          scope.showComponentPayment = false;
//          scope.showComponentTransfer = false;

          invoice = JSON.parse(invoice);
          console.log("Invoice for view.invoice-history-details", invoice);

          if (history.arrayOfHistory.length != 0) {

            if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view == 'view-invoice-list') {
              history.arrayOfHistory.pop();

              opts.toUser = scope.toUser;

              history.arrayOfHistory.push(
                {
                  "view": 'view-invoice-list',
                  "params": opts
                }
              );

              console.log("HISTORY ARRAY_OF_HISTORY", history.arrayOfHistory);

              sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
            }
          }
          else {

            opts.toUser = scope.toUser;

            history.arrayOfHistory.push(
              {
                "view": 'view-invoice-list',
                "params": opts
              }
            );

            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
          }

          var params = {};

          if (!scope.toUser) {

            params = {
              is_p2p: invoice.is_p2p,
              invoice_id: invoice.invoice_id,
              inParameter: invoice.cntrg_info_param2, //????
              amount: invoice.amount,
              commission: invoice.p2p_comission_amount,
              transferCode: invoice.p2p_secret_code,
              time: invoice.time,
              date: invoice.date,
              status: invoice.status_note
            };

            if (invoice.cntrg_info_param3)
              params.inParameter = invoice.cntrg_info_param3;

            scope.showComponent = true;
            scope.showComponentHistory = true;
            scope.tags['view-invoice-history-detail'].opts = params;
            window.checkShowingComponent = scope.tags['view-invoice-history-detail'];
            scope.update();

          } else {


            if (invoice.is_p2p) {
              console.log("TRANSFER");

              params = {

                phoneNumber: invoice.parameter,
                amount: invoice.amount,
                invoiceId: invoice.invoice_id,
                time: invoice.time,
                date: invoice.date
              };

              console.log('PARAMS IN INVOICE LIST', params);

              scope.showComponent = true;
              scope.showComponentTransfer = true;
              scope.tags['view-transfer-detail'].opts = params;
              console.log("scope.tags['view-transfer-detail'].opts", scope.tags['view-transfer-detail'].opts)
              window.checkShowingComponent = scope.tags['view-transfer-detail'];
              scope.update();

            } else {

              console.log("PAYMENT");

              params = {

                amount: invoice.amount,
                invoiceId: invoice.invoice_id,
                phoneNumber: invoice.merchant_phone,
                accountNumber: invoice.parameter,
                serviceName: invoice.service_name,
                is_friend_help: invoice.is_friend_help
              };

              console.log("PAYMENT PARAMS", params);

              scope.showComponent = true;
              scope.showComponentPayment = true;
              scope.tags['view-payment-detail'].opts = params;
              window.checkShowingComponent = scope.tags['view-payment-detail'];
              scope.update();

            }
          }
        }, 100);
      }
    };

    goToInvoiceHistoryDetailTouchStart = function (id) {

      goToInvoiceHistoryDetailTouchStartX = event.changedTouches[0].pageX;
      goToInvoiceHistoryDetailTouchStartY = event.changedTouches[0].pageY;
    };

  </script>
</view-invoice-list>