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
      {(opts.is_friend_help)? window.languages.ViewPaymentDetailTitleFriendHelpOne :
      window.languages.ViewPaymentDetailTitleOne}</p>

    <p class="transfer-to-card-transfer-title-part-two">
      {(opts.is_friend_help)?(window.languages.ViewPaymentDetailTitleFriendHelpTwo):(window.languages.ViewPaymentDetailTitleTwoIfNotFriendsHelp
      + " " + opts.serviceName)}</p>

    <p class="transfer-to-card-transfer-title-phone" if="{opts.is_friend_help}">{opts.friend_name?opts.friend_name:
      ('+'+opts.phoneNumber)}</p>

  </div>

  <div class="transfer-to-card-container">

    <div class="payment-detail-payment-container">
      <p class="payment-detail-title">{window.languages.ViewPaymentDetailTitleSum}</p>
      <p if="{opts.commission_percent}" class="payment-detail-commission">
        {window.languages.ViewTransferTwoTax} {commission_amount}
        {window.languages.Currency}</p>
      <p class="payment-detail-sum">{opts.amount} сум</p>
    </div>
    <div class="payment-detail-payment-container-pay-from">
      <p class="payment-detail-title-pay-from">{window.languages.ViewPaymentDetailTitlePayFrom}</p>
    </div>

    <component-pincards paymentdetail="{true}" clean="{true}" useFor="payment"></component-pincards>

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

    scope.commission_amount = scope.opts.amount * scope.opts.commission_percent / 100;
    scope.errorCode = 0;

    var pageToReturnIfError = 'view-main-page', pageToReturnIfSuccess = 'view-main-page';
    var paymentSuccessStep = 1, paymentWaitingStep = 1;
    var timeOutTimer = 0;
    //    scope.titleName = window.languages.ViewPaymentDetailTitle + scope.opts.invoiceId;

    console.log("OPTS Payment Detail", opts)

    updateResultComponent = function (showResult, stepAmount, viewPage, status, text) {
      console.log("OPEN RESULT COMPONENT");
//      scope.showResult = showResult;

      scope.stepAmount = stepAmount;
      scope.viewPage = viewPage;
      scope.resultText = text;

      if (showResult) {
        window.common.alert.updateView("componentResultId", {
          parent: scope,
          resulttext: scope.resultText,
          viewpage: scope.viewPage,
          step_amount: scope.stepAmount,
        });
      } else {
        window.common.alert.hide("componentResultId");
      }
      updateIcon(status, null, null, text, stepAmount, scope.viewPage);
    };

    closeResultComponent = function () {
      scope.showResult = false;
      window.common.alert.hide("componentResultId");
      scope.update();
    };

    initResultComponent = function () {

      window.common.alert.updateView("componentResultId", {
        parent: scope,
        resulttext: scope.resultText,
        viewpage: scope.viewPage,
        step_amount: scope.stepAmount,
      });
      scope.update();
    };

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

        paymentDetailBackButtonId.style.webkitTransform = 'scale(1)';

        goBackButtonEndX = event.changedTouches[0].pageX;
        goBackButtonEndY = event.changedTouches[0].pageY;
      }

      if ((Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) || doNotPrevent) {
        onBackKeyDown()
      }
    };

    paymentDetailOnTouchStartDecline = function () {

      paymentCancelButtonId.style.webkitTransform = 'scale(0.8)';

      touchStartDeclineX = event.changedTouches[0].pageX;
      touchStartDeclineY = event.changedTouches[0].pageY;
    };

    paymentDetailOnTouchEndDecline = function () {

      paymentCancelButtonId.style.webkitTransform = 'scale(1)';

      touchEndDeclineX = event.changedTouches[0].pageX;
      touchEndDeclineY = event.changedTouches[0].pageY;

      if (Math.abs(touchEndDeclineX - touchStartDeclineX) <= 20 &&
        Math.abs(touchEndDeclineY - touchStartDeclineY) <= 20) {

        var phoneNumber = localStorage.getItem("click_client_phoneNumber");
        var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
        var sessionKey = loginInfo.session_key;

        if (scope.parent) {
          for (var i in scope.parent.invoiceList) {
            if (scope.parent.invoiceList[i].invoice_id == scope.opts.invoiceId) {
              scope.parent.invoiceList[i].deleted = true;
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
            console.log('Clearing timer onSuccess',timeOutTimer);
            window.clearTimeout(timeOutTimer);

            if (result[0][0].error == 0) {
              paymentDetailGoToBackEnd(true);
            }
            else {
              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: false,
                errornote: result[0][0].error_note,
                errorcode: scope.errorCode,
                viewpage: 'view-main-page'
              });
            }
          },

          onFail: function (api_status, api_status_message, data) {
            console.log('Clearing timer onFail',timeOutTimer);
            window.clearTimeout(timeOutTimer);
            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: false,
              errornote: api_status_message,
              errorcode: scope.errorCode,
              viewpage: 'view-main-page'
            });
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          },
          onTimeOut: function () {
            timeOutTimer = setTimeout(function () {
              window.writeLog({
                reason: 'Timeout',
                method:'invoice.action',
              });
                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: false,
                  errornote: window.languages.WaitingTimeExpiredText,
                  errorcode: scope.errorCode,
                  viewpage: 'view-main-page'
                });
                window.stopSpinner();
            }, 30000);
            console.log('creating timeOut', timeOutTimer);
          },
          onEmergencyStop: function(){
            console.log('Clearing timer emergencyStop',timeOutTimer);
            window.clearTimeout(timeOutTimer);
          }
        }, 30000);
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

        if (accountId == undefined) {
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: false,
            errornote: window.languages.ViewPaymentDetailCardNotChosen,
            errorcode: scope.errorCode
          });
          return;
        }

        if (!accountId && accountId != 0) {

          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: false,
            errornote: window.languages.ViewPaymentDetailCardNotChosen,
            errorcode: scope.errorCode
          });
          return;
        }

        initResultComponent();
        window.api.call({
          method: 'invoice.action',
          stopSpinner: false,
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
              setTimeout(function () {
                checkPaymentStatus(result[1][0].payment_id);
              }, 2000);
            }
            else {
              console.log('Clearing timer onSuccess',timeOutTimer);
              window.clearTimeout(timeOutTimer);

              history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - 1)
              console.log(history.arrayOfHistory)
              sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

              updateResultComponent(true, null, pageToReturnIfError, 'unsuccess', result[0][0].error_note);
            }
          },

          onFail: function (api_status, api_status_message, data) {
            console.log('Clearing timer onFail',timeOutTimer);
            window.clearTimeout(timeOutTimer);
            updateResultComponent(true, null, pageToReturnIfError, 'unsuccess', api_status_message);
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          },
          onTimeOut: function () {
            timeOutTimer = setTimeout(function () {
              window.writeLog({
                reason: 'Timeout',
                method:'invoice.action',
              });
                updateResultComponent(true, null, pageToReturnIfError, 'waiting', window.languages.WaitingTimeExpiredText);
            }, 40000);
            console.log('creating timeOut', timeOutTimer);
          },
          onEmergencyStop: function(){
            console.log('Clearing timer emergencyStop',timeOutTimer);
            window.clearTimeout(timeOutTimer);
          }
        }, 40000);
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
        stopSpinner: false,
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
              console.log('Clearing timer onSuccess',timeOutTimer);
              window.clearTimeout(timeOutTimer);

              history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - 1);
              console.log(history.arrayOfHistory);
              sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
              updateResultComponent(true, null, pageToReturnIfError, 'unsuccess', result[1][0].error);

            } else if (result[1][0].state == 2) {
              console.log('Clearing timer onSuccess',timeOutTimer);
              window.clearTimeout(timeOutTimer);

              window.updateBalanceGlobalFunction();
              history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - 1);
              console.log(history.arrayOfHistory);
              sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
              updateResultComponent(true, null, pageToReturnIfSuccess, 'success', window.languages.ComponentSuccessMessageForPay);

            } else if (result[1][0].state == 1) {

              statusCheckCounter++;
              if (statusCheckCounter < 5) {
                setTimeout(function () {
                  checkPaymentStatus(result[1][0].payment_id);
                }, 2000);
              } else {
                console.log('Clearing timer onSuccess',timeOutTimer);
                window.clearTimeout(timeOutTimer);

                history.arrayOfHistory = history.arrayOfHistory.slice(0, history.arrayOfHistory.length - 1);
                console.log(history.arrayOfHistory);
                sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
                updateResultComponent(true, null, pageToReturnIfSuccess, 'waiting', window.languages.ComponentInProcessingPartOneForPay);
              }
            }
          }
          else {
            console.log('Clearing timer onSuccess',timeOutTimer);
            window.clearTimeout(timeOutTimer);
            updateResultComponent(true, null, pageToReturnIfError, 'unsuccess', result[1][0].error);
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.log('Clearing timer onFail',timeOutTimer);
          window.clearTimeout(timeOutTimer);

          updateResultComponent(true, null, pageToReturnIfError, 'unsuccess', api_status_message);
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onEmergencyStop: function(){
          console.log('Clearing timer emergencyStop',timeOutTimer);
          window.clearTimeout(timeOutTimer);
        }
      });
    }


  </script>
</view-payment-detail>
