<view-invoice-list>

  <div class="invoice-list-page-title">
    <p class="invoice-list-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()" class="invoice-list-back-button">

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
    </div>
    <div id="invoiceListInvoicesId" class="invoice-list-invoices-holder" ontouchmove="invoiceListInvoicesTouchMove()">
      <div each="{invoice in invoiceList}" title="{JSON.stringify(invoice)}" class="invoice-list-invoice"
           ontouchend="goToInvoiceHistoryDetailTouchEnd(this.title)"
           ontouchstart="goToInvoiceHistoryDetailTouchStart()">
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
            {invoice.parameter||invoice.cntrg_info_param2}</p>
          <p class="invoice-list-invoice-service-name" if="{invoice.is_p2p == 0}">{invoice.service_name}</p>
        </div>
        <p class="invoice-list-invoice-date">{invoice.date} {invoice.time}</p>
      </div>
    </div>
  </div>

  <view-transfer-detail hidden="{!showComponentTransfer || !showComponent}"></view-transfer-detail>
  <view-payment-detail hidden="{!showComponentPayment || !showComponent}"></view-payment-detail>
  <view-invoice-history-detail hidden="{!showComponentHistory || !showComponent}"></view-invoice-history-detail>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>

    var scope = this,
      goToInvoiceHistoryDetailTouchStartX,
      goToInvoiceHistoryDetailTouchEndX,
      goToInvoiceHistoryDetailTouchStartY,
      goToInvoiceHistoryDetailTouchEndY;

    componentMenu.check = false;

    scope.showError = false;
    scope.invoiceList = [];
    scope.titleName = languages.ViewInvoiceListTitle;
    scope.toUser = opts.toUser;

    console.log("TO USER", scope.toUser, opts.toUser);

    var invoiceListPageNumber = 1;

    scope.showComponentTransfer = false;
    scope.showComponentPayment = false;
    scope.showComponentHistory = false;
    scope.showComponent = false;

    invoiceListInvoicesTouchMove = function () {

      if ((invoiceListInvoicesId.scrollHeight - invoiceListInvoicesId.scrollTop) == invoiceListInvoicesId.offsetHeight) {
        console.log(scope.toUser)
        if (scope.toUser) {
          console.log("ASDQQQ");
          invoiceListPageNumber++;
          getInvoiceListToUser()
        }
        else {
          console.log("ASDQQQ");
          invoiceListPageNumber++;
          getInvoiceListFromUser()
        }
      }
    }

    scope.invoiceList = [];

    getInvoiceListToUser = function () {
      console.log("ASDQQQ");

      if (!scope.toUser)scope.invoiceList = [];
      scope.toUser = true;
      scope.update();

      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = loginInfo.session_key;

      if (device.platform != 'BrowserStand') {
        var options = {dimBackground: true};

        SpinnerPlugin.activityStart(languages.Downloading, options, function () {
          console.log("Started");
        }, function () {
          console.log("closed");
        });
      }

      window.api.call({
        method: 'invoice.list',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          page_number: parseInt(invoiceListPageNumber),
        },
        scope: this,
        onSuccess: function (result) {

          if (result[0][0].error == 0) {
            if (result[1]) {
              if (result[1][0]) {
                console.log('invoice to user', result[1])

                for (var i = 0; i < result[1].length; i++) {

                  try {
                    result[1][i].amount = window.amountTransform(result[1][i].amount.toString());
                  } catch (error) {

                    console.log(error);
                  }

                  scope.invoiceList.push(result[1][i]);
                }

                scope.update(scope.invoiceList);

                localStorage.setItem('click_client_invoice_list', JSON.stringify(scope.invoiceList));
              }
            }
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            scope.update();
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    };

    getInvoiceListFromUser = function () {
      console.log("QWE")

      if (scope.toUser)scope.invoiceList = [];
      scope.toUser = false;
      scope.update();

      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = loginInfo.session_key;

      if (device.platform != 'BrowserStand') {
        var options = {dimBackground: true};

        SpinnerPlugin.activityStart(languages.Downloading, options, function () {
          console.log("Started");
        }, function () {
          console.log("closed");
        });
      }

      window.api.call({
        method: 'invoice.history',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          page_number: parseInt(invoiceListPageNumber)
        },
        scope: this,
        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            if (result[1]) {
              if (result[1][0]) {
                console.log('invoice from user', result[1])

                for (var i = 0; i < result[1].length; i++) {

                  try {
                    result[1][i].amount = window.amountTransform(result[1][i].amount.toString());
                  } catch (error) {

                    console.log(error);
                  }
                  result[1][i].deleted = false;
                  scope.invoiceList.push(result[1][i]);
                }

                scope.update(scope.invoiceList);
//                localStorage.setItem('click_client_invoice_list', JSON.stringify(scope.invoiceList));
              }
            }
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            scope.update();
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    };

    if (scope.toUser) {

      getInvoiceListToUser();
    } else {

      getInvoiceListFromUser();
    }

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
      scope.unmount()
    };

    goToInvoiceHistoryDetailTouchEnd = function (invoice) {

      goToInvoiceHistoryDetailTouchEndX = event.changedTouches[0].pageX;
      goToInvoiceHistoryDetailTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(goToInvoiceHistoryDetailTouchEndX - goToInvoiceHistoryDetailTouchStartX) < 20 &&
        Math.abs(goToInvoiceHistoryDetailTouchEndY - goToInvoiceHistoryDetailTouchStartY) < 20) {
        scope.showComponentPayment = false;
        scope.showComponentHistory = false;
        scope.showComponentTransfer = false;

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

          scope.showComponent = true;
          scope.showComponentHistory = true;
          scope.tags['view-invoice-history-detail'].opts = params
          window.checkShowingComponent = scope.tags['view-invoice-history-detail'];

          scope.update();

//          history.arrayOfHistory.push({view: "view-invoice-history-detail"});
//          sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
//          riotTags.innerHTML = "<view-invoice-history-detail>";
//          riot.mount("view-invoice-history-detail", params);

//          scope.unmount()
        } else {


          if (invoice.is_p2p) {
            console.log("TRANSFER")

            params = {

              phoneNumber: invoice.parameter,
              amount: invoice.amount,
              invoiceId: invoice.invoice_id,
              time: invoice.time,
              date: invoice.date
            };

            console.log('PARAMS IN INVOICE LIST', params)

            scope.showComponent = true;
            scope.showComponentTransfer = true;
            scope.tags['view-transfer-detail'].opts = params
            console.log("scope.tags['view-transfer-detail'].opts", scope.tags['view-transfer-detail'].opts)
            window.checkShowingComponent = scope.tags['view-transfer-detail'];
            riot.update();

//            history.arrayOfHistory.push({view: "view-transfer-detail"});
//            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
//            riotTags.innerHTML = "<view-transfer-detail>";
//            riot.mount('view-transfer-detail', params);
//
//            scope.unmount()
          } else {

            console.log("PAYMENT")

            params = {

              amount: invoice.amount,
              invoiceId: invoice.invoice_id,
              phoneNumber: invoice.merchant_phone,
              accountNumber: invoice.parameter,
              serviceName: invoice.service_name,
              is_friend_help: invoice.is_friend_help
            };

            console.log("PAYMENT PARAMS", params)

            scope.showComponent = true;
            scope.showComponentPayment = true;
            scope.tags['view-payment-detail'].opts = params
            window.checkShowingComponent = scope.tags['view-payment-detail'];
            riot.update();

//            history.arrayOfHistory.push({view: "view-payment-detail"});
//            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
//            riotTags.innerHTML = "<view-payment-detail>";
//            riot.mount('view-payment-detail', params);
//
//            this.unmount()
          }
        }
      }
    };

    goToInvoiceHistoryDetailTouchStart = function () {

      goToInvoiceHistoryDetailTouchStartX = event.changedTouches[0].pageX;
      goToInvoiceHistoryDetailTouchStartY = event.changedTouches[0].pageY;
    };

  </script>
</view-invoice-list>