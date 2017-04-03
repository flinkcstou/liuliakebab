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
        <p class="transfer-detail-button-accept">{window.languages.ViewTransferDetailTitleAccept}</p>
        <p class="transfer-detail-button-cancel" ontouchend="onTouchEndDecline()" ontouchstart="onTouchStartDecline()">
          {window.languages.ViewTransferDetailTitleDecline}</p>
      </div>

    </div>

  </div>

  <script>
    var scope = this,
        touchStartDeclineX,
        touchEndDeclineX,
        touchStartDeclineY,
        touchEndDeclineY;

    scope.titleName = window.languages.ViewTransferDetailTitle;

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
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

            console.log("result of invoice transfer decline", result);

            if (result[0][0].error == 0) {
              goToBack();
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
      }
    };

  </script>
</view-transfer-detail>
