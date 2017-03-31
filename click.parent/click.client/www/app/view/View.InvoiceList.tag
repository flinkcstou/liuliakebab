<view-invoice-list>

  <div class="invoice-list-page-title">
    <p class="invoice-list-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()" class="invoice-list-back-button">

    </div>
  </div>

  <div class="invoice-list-content-holder">
    <div class="invoice-list-nav-buttons-holder">
      <div class="invoice-list-nav-button-to-user" ontouchend="getInvoiceListToUser()">
        <img class="invoice-list-nav-buttons-icon" src="asd">
        <p class="invoice-list-nav-buttons-title {invoice-list-nav-button-not-selected: !toUser}">
          {languages.ViewInvoiceListToUser}</p>
      </div>
      <div class="invoice-list-nav-button-from-user" ontouchend="getInvoiceListFromUser()">
        <img class="invoice-list-nav-buttons-icon" src="asd">
        <p class="invoice-list-nav-buttons-title {invoice-list-nav-button-not-selected: toUser}">
          {languages.ViewInvoiceListFromUser}</p>
      </div>
    </div>
    <div class="invoice-list-invoices-holder">
      <div each="{invoice in invoiceList}" class="invoice-list-invoice">
        <div
            class="invoice-list-invoice-sum-holder {invoice-list-invoice-is-p2p: invoice.is_p2p == 1 && toUser, invoice-list-invoice-is-not-p2p: invoice.is_p2p == 0 || !toUser}">
          <mark class="invoice-list-invoice-sum-sym">сум</mark>
          <p class="invoice-list-invoice-sum">{invoice.amount}</p>
        </div>
        <p class="invoice-list-from-whom-label invoice-list-invoice-is-not-p2p" if="{invoice.is_p2p == 0}">
          {languages.ViewInvoiceListInvoiceIsNot2P2}</p>
        <p class="invoice-list-from-whom-label invoice-list-invoice-is-p2p" if="{invoice.is_p2p == 1 && toUser}">
          {languages.ViewInvoiceListInvoiceIsP2PToUser}</p>
        <p class="invoice-list-from-whom-label invoice-list-invoice-is-not-p2p" if="{invoice.is_p2p == 1 && !toUser}">
          {languages.ViewInvoiceListInvoiceIsP2PFromUser}</p>
        <div class="invoice-list-invoice-phone-number-holder">
          <p class="invoice-list-invoice-service-name" if="{invoice.is_p2p == 0}">{invoice.service_name}&nbsp;</p>
          <p class="invoice-list-invoice-phone-number">+ {invoice.parameter||invoice.cntrg_info_param2}</p>
        </div>
        <p class="invoice-list-invoice-date">{invoice.date} {invoice.time}</p>
      </div>
    </div>
  </div>

  <script>

    var scope = this;

    scope.invoiceList = [];
    scope.titleName = languages.ViewInvoiceListTitle;
    scope.toUser = true;

    getInvoiceListToUser = function () {

      scope.invoiceList = [];
      scope.toUser = true;
      riot.update();

      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = loginInfo.session_key;

      window.api.call({
        method: 'invoice.list',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber
        },
        scope: this,
        onSuccess: function (result) {

          if (result[0][0].error == 0) {
            if (result[1]) {
              if (result[1][0]) {
                console.log('invoice to user', result[1])

                for (var i = 0; i < result[1].length; i++) {
                  scope.invoiceList.push(result[1][i]);
                }

                riot.update(scope.invoiceList);
                localStorage.setItem('click_client_invoice_list', JSON.stringify(scope.invoiceList));
              }
            }
          }
          else {
            alert(result[0][0].error_note);
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    };

    getInvoiceListFromUser = function () {

      scope.invoiceList = [];
      scope.toUser = false;
      riot.update();

      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = loginInfo.session_key;

      window.api.call({
        method: 'invoice.history',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber
        },
        scope: this,
        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            if (result[1]) {
              if (result[1][0]) {
                console.log('invoice from user', result[1])

                for (var i = 0; i < result[1].length; i++) {
                  scope.invoiceList.push(result[1][i]);
                }

                riot.update(scope.invoiceList);
//                localStorage.setItem('click_client_invoice_list', JSON.stringify(scope.invoiceList));
              }
            }
          }
          else {
            alert(result[0][0].error_note);
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    };

    getInvoiceListToUser();

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    }

  </script>
</view-invoice-list>