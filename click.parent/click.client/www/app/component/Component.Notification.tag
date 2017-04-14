<component-notification id="notificationPushId"
                        class="component-notification {component-notification-show: show}">

  <div class="component-notification-icon"></div>
  <p class="component-notification-text">{notificationText}</p>

  <div class="component-notification-buttons-container">
    <p class="component-notification-button-cancel" ontouchend="onTouchEndDecline()"
       ontouchstart="onTouchStartDecline()">
      ЗАКРЫТЬ</p>
    <p class="component-notification-button-accept" ontouchend="onTouchEndAccept()"
       ontouchstart="onTouchStartAccept()">
      ДЕТАЛИ</p>
  </div>


  <script>
    var scope = this;

    scope.show = false;
    scope.notificationText = "";
    scope.notificationAction = "";

    var numberOfMessage = 0;
    window.FirebasePlugin.onNotificationOpen(function (notification) {
      console.log("PUSH NOTIFICATION OBJECT", notification);
      ++numberOfMessage;

      scope.notificationText = notification.body;
      scope.notificationAction = notification.action;
      scope.show = true;

      riot.update();

      window.FirebasePlugin.setBadgeNumber(numberOfMessage);

    }, function (error) {
      console.error(error);
    });

    onTouchStartDecline = function () {

      scope.show = false;
      scope.notificationText = "";
      riot.update();
    };

    onTouchStartAccept = function () {

      scope.show = false;
      scope.notificationText = "";
      riot.update();

      if (scope.notificationAction == "invoice") {


//        riot.mount();
      }
    };

    getInvoiceFunction = function (invoiceId) {

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
                console.log('invoice', result[1])

                var invoice = {};
                for (var i = 0; i < result[1].length; i++) {

                  if (invoiceId == result[1][i].invoice_id) {

                    invoice = result[1][i];

                    var params;

                    if (invoice.is_p2p) {

                      params = {

                        phoneNumber: invoice.parameter,
                        amount: invoice.amount,
                        invoiceId: invoice.invoice_id,
                        time: invoice.time,
                        date: invoice.date
                      };

                      history.arrayOfHistory.push({view: "view-transfer-detail"});
                      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
                      riotTags.innerHTML = "<view-transfer-detail>";
                      riot.mount('view-transfer-detail', params);
                    } else {

                      params = {

                        amount: invoice.amount,
                        invoiceId: invoice.invoice_id,
                        phoneNumber: invoice.merchant_phone,
                        accountNumber: invoice.parameter,
                        serviceName: invoice.service_name
                      };

                      history.arrayOfHistory.push({view: "view-payment-detail"});
                      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
                      riotTags.innerHTML = "<view-payment-detail>";
                      riot.mount('view-payment-detail', params);
                    }
                  }
                }

                console.log("Invoice", invoice);
              }
              else {

              }
            }
          }
          else {
//            scope.clickPinError = false;
//            scope.errorNote = result[0][0].error_note;
//            scope.showError = true;
//            riot.update();
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    };

  </script>
</component-notification>