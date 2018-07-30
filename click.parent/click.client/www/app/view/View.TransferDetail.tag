<view-transfer-detail class="view-transfer-detail riot-tags-main-container">

  <div class="transfer-detail-title-container">

    <div class="page-title">
      <p class="name-title">{titleName}</p>
      <div id="transferDetailBackButtonId" role="button" aria-label="{window.languages.Back}"
           ontouchstart="goToBackStart()" ontouchend="goToBackEnd()"
           class="back-button"></div>
      <div class="title-bottom-border">
      </div>
    </div>
    <div class="transfer-detail-transfer-icon"></div>
    <p class="transfer-detail-transfer-icon-title-part-one">
      {opts.description}</p>

    <p class="transfer-detail-transfer-icon-title-phone">
      +{opts.phoneNumber ? (opts.phoneNumber.substring(0, 3) + ' ' +
      inputVerification.telVerificationWithSpace(opts.phoneNumber.substring(3, opts.phoneNumber.length))) :''}</p>
    <div class="title-bottom-border">
    </div>
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

    <div class="transfer-detail-buttons-container upper-shadow">
      <button id="acceptTransferButtonId" class="transfer-detail-button-accept"
              ontouchend="transferDetailOnTouchEndAccept()"
              ontouchstart="transferDetailOnTouchStartAccept()">
        {window.languages.ViewTransferDetailTitleAccept}
      </button>
      <button id="cancelTransferButtonId" class="transfer-detail-button-cancel"
              ontouchend="transferDetailOnTouchEndDecline()"
              ontouchstart="transferDetailOnTouchStartDecline()">
        {window.languages.ViewTransferDetailTitleDecline}
      </button>
    </div>

  </div>


  <code-confirm id="blockCodeConfirmId" class="transfer-detail-code-confirm" if="{showConfirmPanel}">
    <div class="code-confirm-title-container">
      <div class="code-confirm-cancel-icon" role="button" aria-label="{window.languages.Close}"
           ontouchend="closeSecretCodePage()"></div>
    </div>
    <div class="transfer-detail-code-confirm-code-container">

      <p class="transfer-detail-code-confirm-message-text">{languages.ViewTransferDetailConfirmEnterCodeLabel}</p>
      <input id="secretCodeInput" class="transfer-detail-code-confirm-code-input" type="tel"
             onkeydown="verifyInput(this)"
             autofocus/>
      <p class="transfer-detail-code-confirm-message-text-info">
        {languages.ViewTransferDetailConfirmShouldSendCodeLabelFirstPart} + {opts.phoneNumber}
        {languages.ViewTransferDetailConfirmShouldSendCodeLabelSecondPart}</p>
      <button id="confirmTransferButtonId" class="transfer-detail-code-confirm-button-enter"
              ontouchend="onTouchEndAcceptSecretCode()"
              ontouchstart="onTouchStartAcceptSecretCode()">
        OK
      </button>
    </div>
  </code-confirm>

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
    scope.showComponent = false;

    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

    closeSecretCodePage = function () {
      scope.showConfirmPanel = false;
      scope.update();

    };

    goToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      transferDetailBackButtonId.style.webkitTransform = 'scale(0.7)';

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    goToBackEnd = function (doNotPrevent) {

      if (!doNotPrevent) {
        event.preventDefault();
        event.stopPropagation();
        transferDetailBackButtonId.style.webkitTransform = 'scale(1)';

        goBackButtonEndX = event.changedTouches[0].pageX;
        goBackButtonEndY = event.changedTouches[0].pageY;
      }

      if ((Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) || doNotPrevent) {
        onBackKeyDown()
      }
    };

    verifyInput = function (input) {

      console.log(event);

      if (input.value.length >= 3 && event.keyCode != input_codes.BACKSPACE_CODE) {

        event.preventDefault();
        event.stopPropagation();
      }
    };

    onTouchStartAcceptSecretCode = function () {
      event.preventDefault();
      event.stopPropagation();

      confirmTransferButtonId.style.webkitTransform = 'scale(0.8)';

      console.log("Secret Code For Confirmation", this.secretCodeInput.value);

      touchStartAcceptSecretCodeX = event.changedTouches[0].pageX;
      touchStartAcceptSecretCodeY = event.changedTouches[0].pageY;
    };

    onTouchEndAcceptSecretCode = function () {
      event.preventDefault();
      event.stopPropagation();

      confirmTransferButtonId.style.webkitTransform = 'scale(1)';

      touchEndAcceptSecretCodeX = event.changedTouches[0].pageX;
      touchEndAcceptSecretCodeY = event.changedTouches[0].pageY;

      if (Math.abs(touchStartAcceptSecretCodeX - touchEndAcceptSecretCodeX) < 20 &&
        Math.abs(touchStartAcceptSecretCodeY - touchEndAcceptSecretCodeY) < 20) {

        var secret_key = this.secretCodeInput.value;

        if (!secret_key) {

          scope.errorNote = window.languages.ViewTransferDetailCodeNotEntered;
          scope.clickPinError = false;

          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote
          });

          scope.update();

          return;
        }

        if (Math.abs(touchEndAcceptSecretCodeX - touchStartAcceptSecretCodeX) < 20 &&
          Math.abs(touchEndAcceptSecretCodeY - touchStartAcceptSecretCodeY) < 20) {

          var params = {
            amount: scope.opts.amount,
            secret_key: secret_key,
            invoiceId: scope.opts.invoiceId
          };

          riotTags.innerHTML = "<view-transfer-on-card>";
          riot.mount("view-transfer-on-card", params);

//        scope.unmount()
        }
      }
    };

    transferDetailOnTouchStartAccept = function () {
      event.preventDefault();
      event.stopPropagation();

      acceptTransferButtonId.style.webkitTransform = 'scale(0.8)';

      touchStartAcceptX = event.changedTouches[0].pageX;
      touchStartAcceptY = event.changedTouches[0].pageY;
    };

    transferDetailOnTouchEndAccept = function () {
      event.preventDefault();
      event.stopPropagation();

      acceptTransferButtonId.style.webkitTransform = 'scale(1)';


      touchEndAcceptX = event.changedTouches[0].pageX;
      touchEndAcceptY = event.changedTouches[0].pageY;

      if (Math.abs(touchEndAcceptX - touchStartAcceptX) < 20 &&
        Math.abs(touchEndAcceptY - touchStartAcceptY) < 20) {

        scope.showConfirmPanel = true;
      }
      scope.update();
    };

    transferDetailOnTouchStartDecline = function () {
      event.preventDefault();
      event.stopPropagation();

      cancelTransferButtonId.style.webkitTransform = 'scale(0.8)';

      touchStartDeclineX = event.changedTouches[0].pageX;
      touchStartDeclineY = event.changedTouches[0].pageY;
    };

    transferDetailOnTouchEndDecline = function () {
      event.preventDefault();
      event.stopPropagation();

      cancelTransferButtonId.style.webkitTransform = 'scale(1)';


      touchEndDeclineX = event.changedTouches[0].pageX;
      touchEndDeclineY = event.changedTouches[0].pageY;

      if (Math.abs(touchEndDeclineX - touchStartDeclineX) < 20 &&
        Math.abs(touchEndDeclineY - touchStartDeclineY) < 20) {

        if (scope.parent) {
          for (var i in scope.parent.invoiceList) {

            if (scope.parent.invoiceList[i].invoice_id == scope.opts.invoiceId) {
              scope.parent.invoiceList[i].deleted = true;

            }
          }
          riot.update(scope.parent.invoiceList);
        }

        var phoneNumber = localStorage.getItem("click_client_phoneNumber");
        var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
        var sessionKey = loginInfo.session_key;

        window.startSpinner();

        window.api.call({
          method: 'invoice.action',
          stopSpinner: false,
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            invoice_id: scope.opts.invoiceId,
            action: invoiceActions.DECLINE
          },
          scope: this,
          onSuccess: function (result) {
            window.stopSpinner();

            console.log("result of invoice transfer decline", result);

            if (result[0][0].error == 0) {
              goToBackEnd(true);
            }
            else {
              scope.clickPinError = false;
              scope.errorNote = result[0][0].error_note;

              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: scope.clickPinError,
                errornote: scope.errorNote
              });

            }
          },

          onFail: function (api_status, api_status_message, data) {
            window.stopSpinner();

            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: false,
              errornote: api_status_message
            });

            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });
      }
    };

  </script>
</view-transfer-detail>
