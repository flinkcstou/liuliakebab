<component-bank-operations>
  <div class="bank-operations">
    <div class="top-operations-buttons">
      <div class="bank-operation-button bank-operation-button-pay" ontouchstart="goToPayView()">
        <div class="bank-operation-icon operation-pay-icon">
        </div>
      </div>
      <label class="bank-operation-label bank-operation-label-pay">{window.languages.ComponentBankOperationsPay}</label>

      <div class="bank-operation-button bank-operation-button-transfer" ontouchstart="goToTransferView()">
        <div class="bank-operation-icon operation-transfer-icon">
        </div>
      </div>
      <label class="bank-operation-label bank-operation-label-transfer">{window.languages.ComponentBankOperationsTransfer}</label>

      <div class="bank-operation-button bank-operation-button-autopay" ontouchstart="goToAutoPayView()">
        <div class="bank-operation-icon operation-autopay-icon">
        </div>
      </div>
      <label
        class="bank-operation-label bank-operation-label-autopay">{window.languages.ComponentBankOperationsAutoPay}</label>
    </div>

  </div>

  <script>

    var scope = this;
    goToPayView = function (e) {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-pay>";
      riot.mount('view-pay');
    }

    goToTransferView = function (e) {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-transfer>";
      riot.mount('view-transfer');
    }

    goToAutoPayView = function (e) {
      event.preventDefault();
      event.stopPropagation();
//      return
      riotTags.innerHTML = "<view-add-card>";
      riot.mount('view-add-card');
    }
  </script>
</component-bank-operations>