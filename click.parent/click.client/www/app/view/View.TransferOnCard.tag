<view-transfer-on-card class="view-transfer-on-card riot-tags-main-container">

  <div class="view-transfer-on-card-title-container">
    <p class="view-transfer-on-card-title-text-part-one">{languages.ViewTransferOnCardTitleTextPartOne}</p>
    <p class="view-transfer-on-card-title-text-part-two-sum">{opts.amount} сум</p>
    <p class="view-transfer-on-card-title-text-part-three">{languages.ViewTransferOnCardTitleTextPartTwo}</p>
  </div>

  <div id="backButton" ontouchstart="goToBackStart()" ontouchend="goToBackEnd()"
       class="view-transfer-on-card-back-button"></div>

  <div class="view-transfer-on-card-content-container">

    <component-pincards clean="{true}" transferoncard="true" useFor="p2p"></component-pincards>

    <button id="acceptTransferOnCardButtonId" class="transfer-on-card-ok-button"
            ontouchend="transferOnCardOnTouchEndAccept()"
            ontouchstart="transferOnCardOnTouchStartAccept()">
      {languages.ViewTransferOnCardAcceptButtonText}
    </button>

  </div>

  <component-success id="componentSuccessId"
                     operationmessage="{window.languages.ComponentSuccessMessage}"
                     viewpage="{'view-invoice-list'}" step_amount="{0}"></component-success>
  <component-unsuccess id="componentUnsuccessId"
                       viewpage="{'view-invoice-list'}"
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
      touchEndAcceptY,
      transferOnCardCheckAnswer;

    scope.success = false;
    scope.fail = false;

    console.log('opts.amount', scope.opts)

    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

    goToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      if (backButton)
        backButton.style.webkitTransform = 'scale(0.7)'

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    goToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      if (backButton)
        backButton.style.webkitTransform = 'scale(1)'

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown()
        scope.unmount()
      }
    };

    transferOnCardOnTouchStartAccept = function () {

      acceptTransferOnCardButtonId.style.webkitTransform = 'scale(0.8)'

      touchStartAcceptX = event.changedTouches[0].pageX;
      touchStartAcceptY = event.changedTouches[0].pageY;
    };

    transferOnCardOnTouchEndAccept = function () {

      acceptTransferOnCardButtonId.style.webkitTransform = 'scale(1)'

      touchEndAcceptX = event.changedTouches[0].pageX;
      touchEndAcceptY = event.changedTouches[0].pageY;

      if (Math.abs(touchEndAcceptX - touchStartAcceptX) < 20 &&
        Math.abs(touchEndAcceptY - touchStartAcceptY) < 20) {

        var phoneNumber = localStorage.getItem("click_client_phoneNumber");
        var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
        var sessionKey = loginInfo.session_key;
        var accountId = scope.tags["component-pincards"].getAccountCardId();

        console.log("Account ID and SECRET_KEY for accepting the TRANSFER INVOICE", accountId, scope.opts.secret_key);

        if (accountId == undefined) {

          scope.showError = true;
          scope.errorNote = window.languages.ViewTransferOnCardCardNotChosen;
          scope.clickPinError = false;

          scope.update();

          return;
        }

        if (!accountId && accountId != 0) {

          scope.showError = true;
          scope.errorNote = window.languages.ViewTransferOnCardCardNotChosen;
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

        transferOnCardCheckAnswer = false;

        window.api.call({
          method: 'invoice.action',
          stopSpinner: false,
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            invoice_id: scope.opts.invoiceId,
            action: invoiceActions.ACCEPT,
            account_id: accountId,
            secret_key: scope.opts.secret_key
          },
          scope: this,
          onSuccess: function (result) {
            transferOnCardCheckAnswer = true;

            if (device.platform != 'BrowserStand') {
              console.log("Spinner Stop View Transfer On Card 154");
              SpinnerPlugin.activityStop();
            }

            console.log("result of invoice transfer accept", result);

            if (result[0][0].error == 0) {

              componentSuccessId.style.display = 'block';
              window.updateBalanceGlobalFunction();

//              for (var i in scope.parent.invoiceList) {
////          console.log("scope.parent.invoiceList[i]", scope.parent.invoiceList[i])
//                if (scope.parent.invoiceList[i].invoice_id == scope.opts.invoiceId) {
//                  scope.parent.invoiceList[i].deleted = true;
////            console.log("QWEQW")
////            alert('TRUE')
//                }
//              }
//              riot.update(scope.parent.invoiceList);
            }
            else {

              scope.errorMessageFromTransfer = result[0][0].error_note;
              scope.update();
              componentUnsuccessId.style.display = 'block';
//              alert(result[0][0].error_note);
            }
          },

          onFail: function (api_status, api_status_message, data) {
            transferOnCardCheckAnswer = true;

            componentUnsuccessId.style.display = 'block';

            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });

        if (!transferOnCardCheckAnswer) {
          console.log("wwww")
          setTimeout(function () {
            if (!transferOnCardCheckAnswer) {
              scope.showError = true;
              scope.errorNote = "Сервис временно недоступен";
              scope.stepAmount = 1;
              scope.clickPinError = false;
              scope.update();
              if (device.platform != 'BrowserStand') {
                console.log("Spinner Stop View Transfer On Card 204");
                SpinnerPlugin.activityStop();
              }
            }
          }, 10000);
        }

      }
    };

  </script>

</view-transfer-on-card>