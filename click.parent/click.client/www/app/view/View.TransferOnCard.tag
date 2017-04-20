<view-transfer-on-card>

  <div class="view-transfer-on-card-title-container">
    <p class="view-transfer-on-card-title-text-part-one">{languages.ViewTransferOnCardTitleTextPartOne}</p>
    <p class="view-transfer-on-card-title-text-part-two-sum">{opts.amount} сум</p>
    <p class="view-transfer-on-card-title-text-part-three">{languages.ViewTransferOnCardTitleTextPartTwo}</p>
  </div>

  <div class="view-transfer-on-card-content-container">

    <component-pincards transferoncard="true" clean="{true}"></component-pincards>

    <button class="transfer-on-card-ok-button" ontouchend="onTouchEndAccept()" ontouchstart="onTouchStartAccept()">
      {languages.ViewTransferOnCardAcceptButtonText}
    </button>

  </div>

  <component-success id="componentSuccessId"
                     operationmessage="{window.languages.ComponentSuccessMessage}"
                     viewpage="{undefined}" step_amount="{0}" close_action="{goToBack}"></component-success>
  <component-unsuccess id="componentUnsuccessId"
                       operationmessagepartone="{window.languages.ComponentUnsuccessMessagePart1}"
                       operationmessageparttwo="{window.languages.ComponentUnsuccessMessagePart2}"
                       operationmessagepartthree="{errorMessageFromTransfer}"></component-unsuccess>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>

    var scope = this,
        touchStartAcceptX,
        touchStartAcceptY,
        touchEndAcceptX,
        touchEndAcceptY;

    scope.success = false;
    scope.fail = false;

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

        console.log("Account ID and SECRET_KEY for accepting the TRANSFER INVOICE", accountId, opts.secret_key);

        if (accountId == undefined) {

          scope.showError = true;
          scope.errorNote = window.languages.ViewTransferOnCardCardNotChosen;
          scope.clickPinError = false;

          riot.update();

          return;
        }

        if (!accountId && accountId != 0) {

          scope.showError = true;
          scope.errorNote = window.languages.ViewTransferOnCardCardNotChosen;
          scope.clickPinError = false;

          riot.update();

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
            invoice_id: opts.invoiceId,
            action: invoiceActions.ACCEPT,
            account_id: accountId,
            secret_key: opts.secret_key
          },
          scope: this,
          onSuccess: function (result) {

            console.log("result of invoice transfer accept", result);

            if (result[0][0].error == 0) {
              componentSuccessId.style.display = 'block';
            }
            else {

              componentUnsuccessId.style.display = 'block';
//              alert(result[0][0].error_note);
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

</view-transfer-on-card>