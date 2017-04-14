<component-notification id="notificationPushId"
                        class="component-notification {component-notification-show: show, component-notification-set-transition: setTransition}">

  <div class="component-notification-icon"></div>
  <p class="component-notification-text">{notificationText}</p>

  <div class="component-notification-buttons-container">
    <p class="component-notification-button-cancel" ontouchend="onTouchEndNotificationDecline()"
       ontouchstart="onTouchStartNotificationDecline()">
      ЗАКРЫТЬ</p>
    <p class="component-notification-button-accept" ontouchend="onTouchEndNotificationAccept()"
       ontouchstart="onTouchStartNotificationAccept()">
      ДЕТАЛИ</p>
  </div>


  <script>
    var scope = this;

    scope.show = false;
    scope.setTransition = false;
    console.log("ASDASDASASDASDASDASDASDASDADASDASDADS1111");
    scope.notificationText = "";
    scope.notificationAction = "";

    var numberOfMessage = 0;

    setTimeout(function () {

      scope.setTransition = true;
      riot.update();
    }, 1000);

    if (device.platform != 'BrowserStand') {
      window.FirebasePlugin.onNotificationOpen(function (notification) {
        console.log("PUSH NOTIFICATION OBJECT", notification);
        ++numberOfMessage;

        scope.notificationText = notification.body;
        scope.notificationAction = notification.action;
        scope.notificationElementId = notification.notify_id;
        scope.show = true;

        riot.update();

        window.FirebasePlugin.setBadgeNumber(numberOfMessage);

      }, function (error) {
        console.error(error);
      });
    }

    onTouchEndNotificationAccept = function () {
    };
    onTouchEndNotificationDecline = function () {
    };

    onTouchStartNotificationDecline = function () {

      scope.show = false;
      scope.notificationText = "";
      riot.update();
    };

    onTouchStartNotificationAccept = function () {

      scope.show = false;
      scope.notificationText = "";
      riot.update();

      if (scope.notificationAction == "invoice") {


        getInvoiceFunction(scope.notificationElementId);
      }

      if (scope.notificationAction == "card.add") {


        onComponentCreated();
      }

      if (scope.notificationAction == "payment") {

        getPaymentList(scope.notificationElementId);
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

                    return;
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

    getPaymentList = function (paymentId) {

      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = loginInfo.session_key;

      scope.paymentsMap = {};
      scope.paymentDates = [];
      scope.paymentsList = [];
      window.api.call({
        method: 'get.payment.list',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber
        },
        scope: this,

        onSuccess: function (result) {
          console.log(result)
          console.log(result[0][0])
          if (result[0][0].error == 0) {
            console.log('PAYMENTLIST=', result[1]);
            for (var i in result[1]) {

              if (result[1][i].payment_id == paymentId) {

                console.log("service report for=", result[1][i]);
                riotTags.innerHTML = "<view-report-service>";
                riot.mount("view-report-service", result[1][i]);
                return;
              }
            }
          }
          else {

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