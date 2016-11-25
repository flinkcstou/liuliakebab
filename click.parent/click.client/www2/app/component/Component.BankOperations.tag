<component-bank-operations>
  <div class="bank-operations">
    <div class="top-operations-buttons">
      <div class="bank-operation-button" ontouchend="goToPayView()">
        <div class="bank-operation-icon operation-pay-icon">
        </div>
        <div class="bank-operation-label">ОПЛАТА</div>
      </div>

      <div class="bank-operation-button" ontouchend="goToTransferView()">
        <div class="bank-operation-icon operation-transfer-icon">
        </div>
        <label class="bank-operation-label">ПЕРЕВОДЫ</label>
      </div>

      <div class="bank-operation-button" ontouchend="goToAutoPayView()">
        <div class="bank-operation-icon operation-autopay-icon">
        </div>
        <label class="bank-operation-label">АВТОПЛАТЕЖ</label>
      </div>
    </div>

    <div class="bottom-operations-buttons">
      <div class="bank-operation-button" ontouchend="goToMyFinanceView()">
        <div class="bank-operation-icon operation-myFinance-icon">
        </div>
        <label class="bank-operation-label">МОИ ФИНАНСЫ</label>
      </div>

      <div class="bank-operation-button" ontouchend="goToReportView()">
        <div class="bank-operation-icon operation-report-icon">
        </div>
        <label class="bank-operation-label">ОТЧЁТ</label>
      </div>
    </div>
  </div>

  <script>
    var scope = this;
    goToPayView = function(e)
    {
      document.getElementById('riotTags').innerHTML = "<view-pay></view-pay>";
      scope.unmount();
      riot.mount('view-pay');
    }

    goToTransferView = function(e)
    {
      document.getElementById('riotTags').innerHTML = "<view-transfer></view-transfer>";
      scope.unmount();
      riot.mount('view-transfer');
    }

    goToAutoPayView = function(e)
    {
      document.getElementById('riotTags').innerHTML = "<view-auto-pay></view-auto-pay>";
      scope.unmount();
      riot.mount('view-auto-pay');
    }

    goToMyFinanceView = function(e)
    {
      document.getElementById('riotTags').innerHTML = "<view-my-finance></view-my-finance>";
      scope.unmount();
      riot.mount('view-my-finance');
    }

    goToReportView = function(e)
    {
      document.getElementById('riotTags').innerHTML = "<view-report></view-report>";
      scope.unmount();
      riot.mount('view-report');
    }
  </script>
</component-bank-operations>