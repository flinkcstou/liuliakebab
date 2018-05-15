<component-bank-operations-new>
  <div class="bank-operations">
    <div class="top-operations-buttons">
      <div class="bank-operations-containers"
           style="border-right: 1px solid #e8e8e8;
           width: {window.innerWidth/3 - 1}px">
        <div class="bank-operation-button bank-operation-button-pay" role="button"
             aria-label="{window.languages.ComponentBankOperationsPay}" ontouchstart="goToPayViewStart()"
             ontouchend="goToPayViewEnd()">
          <div id="payButtonId" class="bank-operation-icon operation-pay-icon">
          </div>
        </div>
        <label
          class="bank-operation-label bank-operation-label-pay">{window.languages.ComponentBankOperationsPay}</label>
      </div>
      <div class="bank-operations-containers" style="width:{(window.innerWidth/3) - 1}px">
        <div class="bank-operation-button bank-operation-button-transfer" role="button"
             aria-label="{window.languages.ComponentBankOperationsTransfer}" ontouchstart="goToTransferViewStart()"
             ontouchend="goToTransferViewEnd()">
          <div id="transferButtonId" class="bank-operation-icon operation-transfer-icon">
          </div>
        </div>
        <label class="bank-operation-label bank-operation-label-transfer">{window.languages.ComponentBankOperationsTransfer}</label>
      </div>
      <div class="bank-operations-containers"
           style="border-left: 1px solid #e8e8e8;
           width: {(window.innerWidth / 3) - 1}px">
        <div if="{!modeOfApp.offlineMode}" class="bank-operation-button bank-operation-button-qr" role="button"
             aria-label="{window.languages.ComponentBankOperationsQr}" ontouchstart="goToInPlacePayStart()"
             ontouchend="goToInPlacePayEnd()">
          <div id="qrButtonId" class="bank-operation-icon operation-qr-icon">
          </div>
        </div>

        <div if="{modeOfApp.offlineMode}" class="bank-operation-button bank-operation-button-qr" role="button"
             aria-label="{window.languages.ComponentBankOperationsQr}" ontouchstart="goToQrStart()"
             ontouchend="goToQrEnd()">
          <div id="qrButtonId" class="bank-operation-icon operation-qr-icon">
          </div>
        </div>

        <label if="{!modeOfApp.offlineMode}"
               class="bank-operation-label bank-operation-label-inplace-pay">{window.languages.ComponentBankOperationsInPlacePay}</label>
        <label if="{modeOfApp.offlineMode}"
               class="bank-operation-label bank-operation-label-qr">{window.languages.ComponentBankOperationsQr}</label>
      </div>
    </div>

  </div>

  <div if="{window.checkShowingComponent != null}" class="iFrame-container">
    <div class="iFrame-toolbar-container">
      <p class="iFrame-title">QR сканер</p>
      <div id="iFrameBackButton" ontouchstart="hideIFrameStart(this.id)" ontouchend="hideIFrameEnd(this.id)"
           class="iFrame-back-button">
      </div>
    </div>
    <iframe id="iFrameExternalUrlId" class="iFrame-main" frameborder="0"></iframe>
  </div>

  <script>

    var closeIFrameStartX, closeIFrameEndX, closeIFrameStartY, closeIFrameEndY;
    qrScaner.qrInited = false;
    var scope = this;
    var payStartX, payEndX, payStartY, payEndY;
    var transferStartX, transferEndX, transferStartY, transferEndY;
    var autoPayStartX, autoPayEndX, autoPayStartY, autoPayEndY;
    var qrPayStartX, qrPayEndX, qrPayStartY, qrPayEndY;
    scope.showIFrame = false;

    hideIFrameStart = function (id) {
      closeIFrameStartX = event.changedTouches[0].pageX;
      closeIFrameStartY = event.changedTouches[0].pageY;

      document.getElementById(id).style.webkitTransform = 'scale(0.8)'
    };

    hideIFrameEnd = function (id) {
      closeIFrameEndX = event.changedTouches[0].pageX;
      closeIFrameEndY = event.changedTouches[0].pageY;

      document.getElementById(id).style.webkitTransform = 'scale(1)';

      if (Math.abs(closeIFrameStartX - closeIFrameEndX) <= 20 && Math.abs(closeIFrameStartY - closeIFrameEndY) <= 20) {
        window.checkShowingComponent = null;
        riot.update()
      }

    };

    scope.updateOperations = function () {
      scope.update();
    };

    goToPayViewStart = function (e) {
      event.preventDefault();
      event.stopPropagation();

      payButtonId.style.webkitTransform = 'scale(0.7)';

      payStartX = event.changedTouches[0].pageX;
      payStartY = event.changedTouches[0].pageY;
    };

    goToPayViewEnd = function (e) {
      event.preventDefault();
      event.stopPropagation();

      payButtonId.style.webkitTransform = 'scale(1)';

      payEndX = event.changedTouches[0].pageX;
      payEndY = event.changedTouches[0].pageY;

      if (Math.abs(payStartX - payEndX) <= 20 && Math.abs(payStartY - payEndY) <= 20) {
        riotTags.innerHTML = "<view-pay>";
        riot.mount('view-pay', {mode: 'USUAL'});
      }
      else return
    };

    goToTransferViewStart = function (e) {
      event.preventDefault();
      event.stopPropagation();

      transferButtonId.style.webkitTransform = 'scale(0.7)';

      transferStartX = event.changedTouches[0].pageX;
      transferStartY = event.changedTouches[0].pageY;

    };

    goToTransferViewEnd = function () {
      transferEndX = event.changedTouches[0].pageX;
      transferEndY = event.changedTouches[0].pageY;

      transferButtonId.style.webkitTransform = 'scale(1)';

      if (Math.abs(transferStartX - transferEndX) <= 20 && Math.abs(transferStartY - transferEndY) <= 20) {
        riotTags.innerHTML = "<view-transfer-new>";
        riot.mount('view-transfer-new');
      }
      else return;
    };

    goToAutoPayViewStart = function (e) {
      event.preventDefault();
      event.stopPropagation();

      qrButtonId.style.webkitTransform = 'scale(0.7)';

      autoPayStartX = event.changedTouches[0].pageX;
      autoPayStartY = event.changedTouches[0].pageY;

    };

    goToAutoPayViewEnd = function (e) {
      event.preventDefault();
      event.stopPropagation();

      qrButtonId.style.webkitTransform = 'scale(1)';

      autoPayEndX = event.changedTouches[0].pageX;
      autoPayEndY = event.changedTouches[0].pageY;

      if (Math.abs(autoPayStartX - autoPayEndX) <= 20 && Math.abs(autoPayStartY - autoPayEndY) <= 20) {
        if (modeOfApp.demoVersion) {
          var question = window.languages.DemoModeConstraintText;
          scope.errorNote = question;
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote
          });

          scope.update();
          return
        }

        if (modeOfApp.onlineMode) {

          riotTags.innerHTML = "<view-auto-pay>";
          riot.mount('view-auto-pay');
        } else {

          scope.clickPinError = false;
          scope.errorNote = "Раздел автоплатежей доступен только в онлайн режиме";
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote
          });
          scope.update();
        }
      }
    };

    goToInPlacePayStart = function (e) {
      event.preventDefault();
      event.stopPropagation();

      qrButtonId.style.webkitTransform = 'scale(0.7)';

      qrPayStartX = event.changedTouches[0].pageX;
      qrPayStartY = event.changedTouches[0].pageY;

    };

    goToInPlacePayEnd = function (e) {
      event.preventDefault();
      event.stopPropagation();

      qrButtonId.style.webkitTransform = 'scale(1)';

      qrPayEndX = event.changedTouches[0].pageX;
      qrPayEndY = event.changedTouches[0].pageY;

      if (Math.abs(qrPayStartX - qrPayEndX) <= 20 && Math.abs(qrPayStartY - qrPayEndY) <= 20) {
        if (modeOfApp.demoVersion) {
          var question = window.languages.DemoModeConstraintText;
          scope.errorNote = question;
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote
          });

          scope.update();
          return
        }

        closeMenu();
        riotTags.innerHTML = "<view-inplace-pay-category>";
        riot.mount('view-inplace-pay-category');
      }
    };

    goToQrStart = function (e) {
      event.preventDefault();
      event.stopPropagation();

      qrButtonId.style.webkitTransform = 'scale(0.7)';

      qrPayStartX = event.changedTouches[0].pageX;
      qrPayStartY = event.changedTouches[0].pageY;

    };

    goToQrEnd = function (e) {
      event.preventDefault();
      event.stopPropagation();

      qrButtonId.style.webkitTransform = 'scale(1)';

      qrPayEndX = event.changedTouches[0].pageX;
      qrPayEndY = event.changedTouches[0].pageY;

      if (Math.abs(qrPayStartX - qrPayEndX) <= 20 && Math.abs(qrPayStartY - qrPayEndY) <= 20 && !qrScaner.qrInited) {

        if (modeOfApp.demoVersion) {
          var question = window.languages.DemoModeConstraintText;
          scope.errorNote = question;
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote
          });

          scope.update();
          return
        }

        if (device.platform != 'BrowserStand') {
          qrScaner.qrInited = true;
          console.log("qrScaner.qrInited =", qrScaner.qrInited);

          qrCodeScanner(scope);
        }
        else {
          var phoneNumber = localStorage.getItem("click_client_phoneNumber");
          var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
          var sessionKey = info.session_key;

          if (!modeOfApp.offlineMode) {
            window.api.call({
              method: 'get.indoor.service',
              input: {
                phone_num: phoneNumber,
                session_key: sessionKey,
                service_id: 1234

              },

              scope: this,

              onSuccess: function (result) {
                if (result[0][0].error == 0) {
                  if (result[1]) {
                    if (result[1][0]) {
                      closeMenu();
                      riotTags.innerHTML = "<view-qr>";
                      riot.mount('view-qr', result[1][0]);
                    }
                  }
                  console.log("QR PAY", result);
                }
                else {

                  scope.clickPinError = false;
                  scope.errorNote = result[0][0].error_note;

                  window.common.alert.show("componentAlertId", {
                    parent: scope,
                    clickpinerror: scope.clickPinError,
                    errornote: scope.errorNote
                  });
                  scope.update();
                }
              },

              onFail: function (api_status, api_status_message, data) {
                console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                console.error(data);
              }
            });
          }
        }

      }
    }

  </script>
</component-bank-operations-new>