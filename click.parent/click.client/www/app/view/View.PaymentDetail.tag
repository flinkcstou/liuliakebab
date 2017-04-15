<view-payment-detail>
  <div>

    <div class="transfer-to-card-title-container">
      <div class="page-title account-detail-page-title">
        <p class="name-title">{titleName}</p>
        <div id="backButton" ontouchstart="goToBack()" class="settings-general-back-button"></div>
      </div>

      <div class="payment-detail-payment-icon"></div>
      <p class="transfer-to-card-transfer-title-part-one">
        {window.languages.ViewPaymentDetailTitleOne}</p>

      <p class="transfer-to-card-transfer-title-part-two">
        {window.languages.ViewPaymentDetailTitleTwo}</p>

      <p class="transfer-to-card-transfer-title-phone">
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

      <component-pincards paymentdetail="true"></component-pincards>

      <div class="account-detail-cover"></div>

      <div class="account-detail-buttons-container">
        <button class="account-detail-button-accept" ontouchend="onTouchEndAccept()"
                ontouchstart="onTouchStartAccept()">
          {window.languages.ViewAccountDetailTitlePay}
        </button>
        <button class="account-detail-button-cancel" ontouchend="onTouchEndDecline()"
                ontouchstart="onTouchStartDecline()">
          {window.languages.ViewAccountDetailTitleDecline}
        </button>
      </div>
    </div>


    <component-success id="componentSuccessId"
                       operationmessage="{window.languages.ComponentSuccessMessageForPay}"
                       viewpage="{undefined}" step_amount="{0}" close_action="{goToBack}"></component-success>
    <component-unsuccess id="componentUnsuccessId"
                         operationmessagepartone="{window.languages.ComponentUnsuccessMessagePart1}"
                         operationmessageparttwo="{window.languages.ComponentUnsuccessMessagePart2}"
                         operationmessagepartthree="{errorMessageFromTransfer}"></component-unsuccess>

    <component-alert if="{showError}" clickpinerror="{clickPinError}"
                     errornote="{errorNote}"></component-alert>

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

    scope.showError = false;
    scope.titleName = window.languages.ViewPaymentDetailTitle + opts.invoiceId;

    goToBack = function (doNotPrevent) {

      if (!doNotPrevent) {

        event.preventDefault();
        event.stopPropagation();
//      console.log("BACK")
      }
      onBackKeyDown()
    };

    onTouchStartDecline = function () {

      touchStartDeclineX = event.changedTouches[0].pageX;
      touchStartDeclineY = event.changedTouches[0].pageY;
    };

    onTouchEndDecline = function () {

      touchEndDeclineX = event.changedTouches[0].pageX;
      touchEndDeclineY = event.changedTouches[0].pageY;

      if (Math.abs(touchEndDeclineX - touchStartDeclineX) < 20 &&
          Math.abs(touchEndDeclineY - touchStartDeclineY) < 20) {

        var phoneNumber = localStorage.getItem("click_client_phoneNumber");
        var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
        var sessionKey = loginInfo.session_key;

        window.api.call({
          method: 'invoice.action',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            invoice_id: opts.invoiceId,
            action: invoiceActions.DECLINE
          },
          scope: this,
          onSuccess: function (result) {

            console.log("result of invoice payment decline", result);

            if (result[0][0].error == 0) {
              goToBack(true);
            }
            else {
              scope.clickPinError = false;
              scope.errorNote = result[0][0].error_note;
              scope.showError = true;
              riot.update();
            }
          },

          onFail: function (api_status, api_status_message, data) {
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });
      }
    };

    onTouchStartAccept = function () {

      touchStartAcceptX = event.changedTouches[0].pageX;
      touchStartAcceptY = event.changedTouches[0].pageY;
    };

    onTouchEndAccept = function () {

      touchEndAcceptX = event.changedTouches[0].pageX;
      touchEndAcceptY = event.changedTouches[0].pageY;

      if (Math.abs(touchEndAcceptX - touchStartAcceptX) < 20 &&
          Math.abs(touchEndAcceptY - touchStartAcceptY) < 20) {

        var phoneNumber = localStorage.getItem("click_client_phoneNumber");
        var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
        var sessionKey = loginInfo.session_key;
        var accountId = scope.tags["component-pincards"].getAccountCardId();

        console.log("Account ID for accepting the payment invoice", accountId);

        if (accountId == undefined) return;

        window.api.call({
          method: 'invoice.action',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            invoice_id: opts.invoiceId,
            action: invoiceActions.ACCEPT,
            account_id: accountId
          },
          scope: this,
          onSuccess: function (result) {

            console.log("result of invoice payment accept", result);

            if (result[0][0].error == 0) {
              componentSuccessId.style.display = 'block';
            }
            else {
              componentUnsuccessId.style.display = 'block';
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


  </script>
</view-payment-detail>
