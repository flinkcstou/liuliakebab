<component-bank-operations>
  <div class="bank-operations">
    <div class="top-operations-buttons">
      <div class="bank-operation-button bank-operation-button-pay" ontouchstart="goToPayViewStart()"
           ontouchend="goToPayViewEnd()">
        <div class="bank-operation-icon operation-pay-icon">
        </div>
      </div>
      <label class="bank-operation-label bank-operation-label-pay">{window.languages.ComponentBankOperationsPay}</label>

      <div class="bank-operation-button bank-operation-button-transfer" ontouchstart="goToTransferViewStart()"
           ontouchend="goToTransferViewEnd()">
        <div class="bank-operation-icon operation-transfer-icon">
        </div>
      </div>
      <label class="bank-operation-label bank-operation-label-transfer">{window.languages.ComponentBankOperationsTransfer}</label>

      <div class="bank-operation-button bank-operation-button-autopay" ontouchstart="goToAutoPayViewStart()"
           ontouchend="goToAutoPayViewEnd()">
        <div class="bank-operation-icon operation-autopay-icon">
        </div>
      </div>
      <label
        class="bank-operation-label bank-operation-label-autopay">{window.languages.ComponentBankOperationsAutoPay}</label>
    </div>

  </div>

  <script>

    var scope = this;
    var payStartX, payEndX, payStartY, payEndY;

    goToPayViewStart = function (e) {
      event.preventDefault();
      event.stopPropagation();

      payStartX = event.changedTouches[0].pageX;
      payStartY = event.changedTouches[0].pageY;
    }

    goToPayViewEnd = function (e) {
      event.preventDefault();
      event.stopPropagation();

      payEndX = event.changedTouches[0].pageX;
      payEndY = event.changedTouches[0].pageY;

      if (Math.abs(payStartX - payEndX) <= 20 && Math.abs(payStartY - payEndY) <= 20) {
        riotTags.innerHTML = "<view-pay>";
        riot.mount('view-pay');
//        scope.unmount()
      }
      else return
    }

    var transferStartX, transferEndX, transferStartY, transferEndY;
    goToTransferViewStart = function (e) {
      event.preventDefault();
      event.stopPropagation();

      transferStartX = event.changedTouches[0].pageX;
      transferStartY = event.changedTouches[0].pageY;

    }

    goToTransferViewEnd = function () {
      transferEndX = event.changedTouches[0].pageX;
      transferEndY = event.changedTouches[0].pageY;

      if (Math.abs(transferStartX - transferEndX) <= 20 && Math.abs(transferStartY - transferEndY) <= 20) {
        riotTags.innerHTML = "<view-transfer>";
        riot.mount('view-transfer');
//        scope.unmount()
      }
      else return;
    }

    var autoPayStartX, autoPayEndX, autoPayStartY, autoPayEndY;
    goToAutoPayViewStart = function (e) {
      event.preventDefault();
      event.stopPropagation();

      autoPayStartX = event.changedTouches[0].pageX;
      autoPayStartY = event.changedTouches[0].pageY;

    }

    goToAutoPayViewEnd = function (e) {
      event.preventDefault();
      event.stopPropagation();

      autoPayEndX = event.changedTouches[0].pageX;
      autoPayEndY = event.changedTouches[0].pageY;

      if (Math.abs(autoPayStartX - autoPayEndX) <= 20 && Math.abs(autoPayStartY - autoPayEndY) <= 20) {
        riotTags.innerHTML = "<view-auto-pay>";
        riot.mount('view-auto-pay');
//        scope.unmount();
      }
    }

  </script>
</component-bank-operations>