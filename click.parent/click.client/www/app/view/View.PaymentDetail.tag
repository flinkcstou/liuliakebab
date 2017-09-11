<view-payment-detail class="view-payment-detail riot-tags-main-container">

  <div class="transfer-to-card-title-container">
    <div class="page-title account-detail-page-title">
      <p class="name-title">{window.languages.ViewPaymentDetailTitle + opts.invoiceId}</p>
      <div id="paymentDetailBackButtonId" role="button" aria-label="{window.languages.Back}"
           ontouchstart="paymentDetailGoToBackStart()"
           ontouchend="paymentDetailGoToBackEnd()" class="settings-general-back-button"></div>
    </div>

    <div class="payment-detail-payment-icon"></div>
    <p class="transfer-to-card-transfer-title-part-one">
      {window.languages.ViewPaymentDetailTitleOne}</p>

    <p class="transfer-to-card-transfer-title-part-two">
      {(opts.is_friend_help)?(window.languages.ViewPaymentDetailTitleTwo):(window.languages.ViewPaymentDetailTitleTwoIfNotFriendsHelp
      + " " + opts.serviceName)}</p>

    <p class="transfer-to-card-transfer-title-phone" if="{opts.is_friend_help}">
      +{opts.phoneNumber}</p>

  </div>

  <div class="transfer-to-card-container">

    <div class="payment-detail-payment-container">
      <p class="payment-detail-title">{window.languages.ViewPaymentDetailTitleSum}</p>
      <p class="payment-detail-sum">{opts.amount} сум</p>
    </div>
    <div class="payment-detail-payment-container">
      <p class="payment-detail-title">{window.languages.ViewPaymentDetailTitlePayFor} {opts.serviceName}:</p>
      <p class="payment-detail-number">{opts.accountNumber}</p>
    </div>
    <div class="payment-detail-payment-container">
      <p class="payment-detail-title">{window.languages.ViewPaymentDetailTitlePayFrom}</p>
    </div>

    <component-pincards paymentdetail="{true}" clean="{true}"></component-pincards>

    <div class="account-detail-cover"></div>

    <div class="account-detail-buttons-container">
      <button id="paymentAcceptButtonId" class="account-detail-button-accept"
              ontouchend="paymentDetailOnTouchEndAccept()"
              ontouchstart="paymentDetailOnTouchStartAccept()">
        {window.languages.ViewAccountDetailTitlePay}
      </button>
      <button id="paymentCancelButtonId" class="account-detail-button-cancel"
              ontouchend="paymentDetailOnTouchEndDecline()"
              ontouchstart="paymentDetailOnTouchStartDecline()">
        {window.languages.ViewAccountDetailTitleDecline}
      </button>
    </div>
  </div>


  <component-success id="componentSuccessId"
                     operationmessage="{window.languages.ComponentSuccessMessageForPay}"
                     viewpage="{viewPage}" step_amount="{}" close_action="{goToBack}"></component-success>
  <component-unsuccess id="componentUnsuccessId"
                       operationmessagepartone="{window.languages.ComponentUnsuccessMessagePart1}"
                       operationmessageparttwo="{window.languages.ComponentUnsuccessMessagePart2}"
                       operationmessagepartthree="{errorMessageFromTransfer}"
                       step_amount="{1}"></component-unsuccess>
  <component-in-processing id="componentInProcessingId" viewpage="{viewPage}"
                           operationmessagepartone="{window.languages.ComponentInProcessingPartOneForPay}"
                           operationmessageparttwo="{window.languages.ComponentInProcessingPartTwo}"
                           step_amount="{0}"></component-in-processing>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this,
      touchStartDeclineX,
      touchStartDeclineY,
      touchEndDeclineX,
      touchEndDeclineY,
      touchStartAcceptX,
      touchStartAcceptY,
      touchEndAcceptX,
      touchEndAcceptY;

    scope.showError = false;
    //    scope.titleName = window.languages.ViewPaymentDetailTitle + scope.opts.invoiceId;

    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

    paymentDetailGoToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      paymentDetailBackButtonId.style.webkitTransform = 'scale(0.7)'

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    paymentDetailGoToBackEnd = function (doNotPrevent) {

      if (!doNotPrevent) {
        event.preventDefault();
        event.stopPropagation();

        paymentDetailBackButtonId.style.webkitTransform = 'scale(1)'

        goBackButtonEndX = event.changedTouches[0].pageX;
        goBackButtonEndY = event.changedTouches[0].pageY;
      }

      if ((Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) || doNotPrevent) {
        onBackKeyDown()
      }
    };

    paymentDetailOnTouchStartDecline = function () {

      paymentCancelButtonId.style.webkitTransform = 'scale(0.8)'

      touchStartDeclineX = event.changedTouches[0].pageX;
      touchStartDeclineY = event.changedTouches[0].pageY;
    };

    paymentDetailOnTouchEndDecline = function () {

      paymentCancelButtonId.style.webkitTransform = 'scale(1)'

      touchEndDeclineX = event.changedTouches[0].pageX;
      touchEndDeclineY = event.changedTouches[0].pageY;

      if (Math.abs(touchEndDeclineX - touchStartDeclineX) <= 20 &&
        Math.abs(touchEndDeclineY - touchStartDeclineY) <= 20) {

        var phoneNumber = localStorage.getItem("click_client_phoneNumber");
        var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
        var sessionKey = loginInfo.session_key;
        console.log('scope.parent.invoiceList', scope)

        if (scope.parent) {
          for (var i in scope.parent.invoiceList) {
            if (scope.parent.invoiceList[i].invoice_id == scope.opts.invoiceId) {
              scope.parent.invoiceList[i].deleted = true;
//            alert('TRUE')
            }
          }
        }
        scope.update();

        if (device.platform != 'BrowserStand') {
          var options = {dimBackground: true};

          SpinnerPlugin.activityStart(languages.Downloading, options, function () {
            console.log("Started");
          }, function () {
            console.log("closed");
          });
        }
        window.api.call({
          method: 'invoice.action',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            invoice_id: scope.opts.invoiceId,
            action: invoiceActions.DECLINE
          },
          scope: this,
          onSuccess: function (result) {

            console.log("result of invoice payment decline", result);

            if (result[0][0].error == 0) {
              paymentDetailGoToBackEnd(true);
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
      }
    };

    paymentDetailOnTouchStartAccept = function () {

      paymentAcceptButtonId.style.webkitTransform = 'scale(0.8)'

      touchStartAcceptX = event.changedTouches[0].pageX;
      touchStartAcceptY = event.changedTouches[0].pageY;
    };

    paymentDetailOnTouchEndAccept = function () {

      paymentAcceptButtonId.style.webkitTransform = 'scale(1)'

      touchEndAcceptX = event.changedTouches[0].pageX;
      touchEndAcceptY = event.changedTouches[0].pageY;

      if (Math.abs(touchEndAcceptX - touchStartAcceptX) < 20 &&
        Math.abs(touchEndAcceptY - touchStartAcceptY) < 20) {

        var phoneNumber = localStorage.getItem("click_client_phoneNumber");
        var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
        var sessionKey = loginInfo.session_key;

        var accountId = scope.tags["component-pincards"].getAccountCardId();

        console.log("Account ID for accepting the payment invoice", accountId);

        if (accountId == undefined) {

          scope.showError = true;
          scope.errorNote = window.languages.ViewPaymentDetailCardNotChosen;
          scope.clickPinError = false;

          scope.update();

          return;
        }

        if (!accountId && accountId != 0) {

          scope.showError = true;
          scope.errorNote = window.languages.ViewPaymentDetailCardNotChosen;
          scope.clickPinError = false;

          scope.update();

          return;
        }

        if (device.platform != 'BrowserStand') {
          var options = {dimBackground: true};

          SpinnerPlugin.activityStart(languages.Downloading, options, function () {
            console.log("Started");
          }, function () {
            console.log("closed");
          });
        }

        window.api.call({
          method: 'invoice.action',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            invoice_id: scope.opts.invoiceId,
            action: invoiceActions.ACCEPT,
            account_id: accountId
          },
          scope: this,
          onSuccess: function (result) {

            console.log("result of invoice payment accept", result);

            if (result[0][0].error == 0) {


              if (device.platform != 'BrowserStand') {
                var options = {dimBackground: true};

                SpinnerPlugin.activityStart(languages.Downloading, options, function () {
                  console.log("Started");
                }, function () {
                  console.log("closed");
                });
              }

              setTimeout(function () {
                checkPaymentStatus(result[1][0].payment_id);
              }, 2000);

            }
            else {
              componentUnsuccessId.style.display = 'block';
              history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - 1)
              console.log(history.arrayOfHistory)
              sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

              scope.viewPage = 'main-page'
              scope.update()
            }
          },

          onFail: function (api_status, api_status_message, data) {
            componentUnsuccessId.style.display = 'block';
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });
      }
    };

    var statusCheckCounter = 0;

    function checkPaymentStatus(payment_id) {

      console.log("check payment status");
      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = loginInfo.session_key;

      window.api.call({
        method: 'get.payment',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          payment_id: payment_id
        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0 && result[1][0]) {

            window.checkShowingComponent = null;

            console.log("result of get.payment success=", result);
            if (result[1][0].state == -1) {

              componentUnsuccessId.style.display = 'block';
              history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - 1)
              console.log(history.arrayOfHistory)
              sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

              scope.viewPage = 'main-page'
              scope.errorMessageFromTransfer = result[1][0].error;
              scope.update()


            } else if (result[1][0].state == 2) {
              window.updateBalanceGlobalFunction();

              componentSuccessId.style.display = 'block';

              history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - 1)
              console.log(history.arrayOfHistory)
              sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

              scope.viewPage = 'view-report'
              scope.update()

            } else if (result[1][0].state == 1) {

              statusCheckCounter++;

              if (statusCheckCounter < 5) {

                if (device.platform != 'BrowserStand') {
                  var options = {dimBackground: true};

                  SpinnerPlugin.activityStart(languages.Downloading, options, function () {
                    console.log("Started");
                  }, function () {
                    console.log("closed");
                  });
                }

                setTimeout(function () {
                  checkPaymentStatus(result[1][0].payment_id);
                }, 2000);

              } else {
                if (device.platform != 'BrowserStand') {
                  SpinnerPlugin.activityStop();
                }

                componentInProcessingId.style.display = 'block';
                history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - 1)
                console.log(history.arrayOfHistory)
                sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

                scope.viewPage = 'main-page'
                scope.update();

              }

            }

          }
          else {
            console.log("result of GET.PAYMENT in else", result);
            if (device.platform != 'BrowserStand') {
              SpinnerPlugin.activityStop();
            }
            componentUnsuccessId.style.display = 'block';
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }


  </script>
</view-payment-detail>
