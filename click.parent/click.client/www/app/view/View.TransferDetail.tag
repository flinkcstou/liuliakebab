<view-transfer-detail>
  <div>
    <div class="transfer-detail-title-container">

      <div class="page-title transfer-detail-page-title">
        <p class="name-title">{titleName}</p>
        <div id="backButton" ontouchend="goToBack()" class="settings-general-back-button"></div>
      </div>
      <div class="transfer-detail-transfer-icon"></div>
      <p class="transfer-detail-transfer-icon-title-part-one">
        {window.languages.ViewTransferDetailTransferIconTitleOne}</p>

      <p class="transfer-detail-transfer-icon-title-part-two">
        {window.languages.ViewTransferDetailTransferIconTitleTwo}</p>

      <p class="transfer-detail-transfer-icon-title-phone">
        +{opts.phoneNumber}</p>

    </div>

    <div class="transfer-detail-container">
      <div class="transfer-detail-transfer-container">
        <p class="transfer-detail-title">{window.languages.ViewTransferDetailTitleSum}</p>
        <p class="transfer-detail-sum">{opts.amount} сум</p>
      </div>
      <div class="transfer-detail-transfer-container">
        <p class="transfer-detail-title">{window.languages.ViewTransferDetailTitleNumber}</p>
        <p class="transfer-detail-number">{opts.invoiceId}</p>
      </div>
      <div class="transfer-detail-transfer-container">
        <p class="transfer-detail-title">{window.languages.ViewTransferDetailTitleDate}</p>
        <p class="transfer-detail-date">{opts.time} {opts.date}</p>
      </div>
      <div class="transfer-detail-transfer-container">
        <p class="transfer-detail-title">{window.languages.ViewTransferDetailTitleStatus}</p>
        <p class="transfer-detail-status">Ожидает подтверждения</p>
      </div>

      <div class="transfer-detail-cover"></div>

      <div class="transfer-detail-buttons-container">
        <button class="transfer-detail-button-accept" ontouchend="onTouchEndAccept()"
                ontouchstart="onTouchStartAccept()">
          {window.languages.ViewTransferDetailTitleAccept}
        </button>
        <button class="transfer-detail-button-cancel" ontouchend="onTouchEndDecline()"
                ontouchstart="onTouchStartDecline()">
          {window.languages.ViewTransferDetailTitleDecline}
        </button>
      </div>

    </div>

  </div>

  <code-confirm id="blockCodeConfirmId" class="transfer-detail-code-confirm" if="{showConfirmPanel}">

    <div class="transfer-detail-code-confirm-code-container">

      <p class="transfer-detail-code-confirm-message-text">{languages.ViewTransferDetailConfirmEnterCodeLabel}</p>
      <input id="secretCodeInput" class="transfer-detail-code-confirm-code-input" type="number"
             onkeydown="verifyInput(this)"
             autofocus/>
      <p class="transfer-detail-code-confirm-message-text-info">
        {languages.ViewTransferDetailConfirmShouldSendCodeLabelFirstPart} + {opts.phoneNumber}
        {languages.ViewTransferDetailConfirmShouldSendCodeLabelSecondPart}</p>
      <button class="transfer-detail-code-confirm-button-enter" ontouchend="onTouchEndAcceptSecretCode()"
              ontouchstart="onTouchStartAcceptSecretCode()">
        OK
      </button>
    </div>
  </code-confirm>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this,
        touchStartDeclineX,
        touchEndDeclineX,
        touchStartDeclineY,
        touchEndDeclineY,
        touchStartAcceptX,
        touchEndAcceptX,
        touchStartAcceptY,
        touchEndAcceptY,
        touchStartAcceptSecretCodeX,
        touchEndAcceptSecretCodeX,
        touchStartAcceptSecretCodeY,
        touchEndAcceptSecretCodeY;

    scope.titleName = window.languages.ViewTransferDetailTitle;
    scope.showConfirmPanel = false;
    scope.showError = false;

    goToBack = function (doNotPrevent) {

      if (!doNotPrevent) {

        event.preventDefault();
        event.stopPropagation();
      }
      onBackKeyDown()
    };

    verifyInput = function (input) {

      console.log(event);

      if (input.value.length >= 3 && event.keyCode != input_codes.BACKSPACE_CODE) {

        event.preventDefault();
        event.stopPropagation();
      }
    };

    onTouchStartAcceptSecretCode = function () {

      console.log("Secret Code For Confirmation", this.secretCodeInput.value);

      touchStartAcceptSecretCodeX = event.changedTouches[0].pageX;
      touchStartAcceptSecretCodeY = event.changedTouches[0].pageY;
    };

    onTouchEndAcceptSecretCode = function () {

      touchEndAcceptSecretCodeX = event.changedTouches[0].pageX;
      touchEndAcceptSecretCodeY = event.changedTouches[0].pageY;

      var secret_key = this.secretCodeInput.value;

      if (!secret_key) return;

      if (Math.abs(touchEndAcceptSecretCodeX - touchStartAcceptSecretCodeX) < 20 &&
          Math.abs(touchEndAcceptSecretCodeY - touchStartAcceptSecretCodeY) < 20) {

        params = {
          amount: opts.amount,
          secret_key: secret_key,
          invoiceId: opts.invoiceId
        };

        riotTags.innerHTML = "<view-transfer-on-card>";
        riot.mount("view-transfer-on-card", params);
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

        scope.showConfirmPanel = true;
        riot.update(scope.showConfirmPanel);
      }
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

            console.log("result of invoice transfer decline", result);

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

  </script>
</view-transfer-detail>
