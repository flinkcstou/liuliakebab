<component-bank-operations>
    <div class="bank-operations">
        <div class="top-operations-buttons">
            <div class="bank-operation-button bank-operation-button-pay" ontouchend="goToPayView()">
                <div class="bank-operation-icon operation-pay-icon">
                    <label class="bank-operation-label">{window.languages.ComponentBankOperationsPay}</label>
                </div>
            </div>

            <div class="bank-operation-button bank-operation-button-transfer" ontouchend="goToTransferView()">
                <div class="bank-operation-icon operation-transfer-icon">
                    <label class="bank-operation-label">{window.languages.ComponentBankOperationsTransfer}</label>
                </div>
            </div>

            <div class="bank-operation-button bank-operation-button-autopay" ontouchend="goToAutoPayView()">
                <div class="bank-operation-icon operation-autopay-icon">
                    <label class="bank-operation-label">{window.languages.ComponentBankOperationsAutoPay}</label>
                </div>
            </div>
        </div>

    </div>

    <script>

        var scope = this;
        goToPayView = function (e) {
            event.preventDefault();
            event.stopPropagation();

            this.riotTags.innerHTML = "<view-pay>";
            riot.mount('view-pay');
        }

        goToTransferView = function (e) {
            event.preventDefault();
            event.stopPropagation();

            this.riotTags.innerHTML = "<view-transfer>";
            riot.mount('view-transfer');
        }

        goToAutoPayView = function (e) {
            event.preventDefault();
            event.stopPropagation();

            this.riotTags.innerHTML = "<view-auto-pay>";
            riot.mount('view-auto-pay');
        }
    </script>
</component-bank-operations>