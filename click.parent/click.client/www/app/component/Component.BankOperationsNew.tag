<component-bank-operations>
  <div class="bank-operations">
    <div class="top-operations-buttons">
      <div class="bank-operation-button bank-operation-button-pay" role="button"
           aria-label="{window.languages.ComponentBankOperationsPay}" ontouchstart="goToPayViewStart()"
           ontouchend="goToPayViewEnd()">
        <div id="payButtonId" class="bank-operation-icon operation-pay-icon">
        </div>
      </div>
      <label class="bank-operation-label bank-operation-label-pay">{window.languages.ComponentBankOperationsPay}</label>

      <div class="bank-operation-button bank-operation-button-transfer" role="button"
           aria-label="{window.languages.ComponentBankOperationsTransfer}" ontouchstart="goToTransferViewStart()"
           ontouchend="goToTransferViewEnd()">
        <div id="transferButtonId" class="bank-operation-icon operation-transfer-icon">
        </div>
      </div>
      <label class="bank-operation-label bank-operation-label-transfer">{window.languages.ComponentBankOperationsTransfer}</label>

      <div hidden class="bank-operation-button bank-operation-button-autopay" ontouchstart="goToAutoPayViewStart()"
           ontouchend="goToAutoPayViewEnd()">
        <div class="bank-operation-icon operation-autopay-icon">
        </div>
      </div>
      <label hidden
             class="bank-operation-label bank-operation-label-autopay">{window.languages.ComponentBankOperationsAutoPay}</label>

      <div class="bank-operation-button bank-operation-button-qr" role="button"
           aria-label="{window.languages.ComponentBankOperationsQr}" ontouchstart="goToInPlacePayStart()"
           ontouchend="goToInPlacePayEnd()">
        <div id="qrButtonId" class="bank-operation-icon operation-qr-icon">
        </div>
      </div>
      <label
        class="bank-operation-label bank-operation-label-qr">{window.languages.ComponentBankOperationsInPlacePay}</label>
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

    hideIFrameStart = function (id) {
      closeIFrameStartX = event.changedTouches[0].pageX;
      closeIFrameStartY = event.changedTouches[0].pageY;

      document.getElementById(id).style.webkitTransform = 'scale(0.8)'
    };

    hideIFrameEnd = function (id) {
      closeIFrameEndX = event.changedTouches[0].pageX;
      closeIFrameEndY = event.changedTouches[0].pageY;

      document.getElementById(id).style.webkitTransform = 'scale(1)'

      if (Math.abs(closeIFrameStartX - closeIFrameEndX) <= 20 && Math.abs(closeIFrameStartY - closeIFrameEndY) <= 20) {
        console.log('qweweeee')
        window.checkShowingComponent = null;
        riot.update()
      }

    };

    var scope = this;
    var payStartX, payEndX, payStartY, payEndY;

    scope.showIFrame = false;

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
        riot.mount('view-pay');
//        scope.unmount()
      }
      else return
    };

    var transferStartX, transferEndX, transferStartY, transferEndY;
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
//        scope.unmount()
      }
      else return;
    };

    var autoPayStartX, autoPayEndX, autoPayStartY, autoPayEndY;
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
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!';
          scope.errorNote = question;
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote
          });
//        confirm(question)
//          scope.confirmShowBool = true;
//          scope.confirmNote = question;
//          scope.confirmType = 'local';
//          scope.result = function (bool) {
//            if (bool) {
//              localStorage.clear();
//              window.location = 'index.html'
//              scope.unmount()
//              return
//            }
//            else{
//              scope.confirmShowBool = false;
//              return
//            }
//          };
          scope.update();

          return
        }

        if (modeOfApp.onlineMode) {

          riotTags.innerHTML = "<view-auto-pay>";
          riot.mount('view-auto-pay');
//        scope.unmount();
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

    var qrPayStartX, qrPayEndX, qrPayStartY, qrPayEndY;

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
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!';
          scope.errorNote = question;
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote
          });
//        confirm(question)
//          scope.confirmShowBool = true;
//          scope.confirmNote = question;
//          scope.confirmType = 'local';
//          scope.result = function (bool) {
//            if (bool) {
//              localStorage.clear();
//              window.location = 'index.html'
//              scope.unmount()
//              return
//            }
//            else{
//              scope.confirmShowBool = false;
//              return
//            }
//          };
          scope.update();

          return
        }

        closeMenu();
        riotTags.innerHTML = "<view-inplace-pay>";
        riot.mount('view-inplace-pay');
      }
    }

  </script>
</component-bank-operations>